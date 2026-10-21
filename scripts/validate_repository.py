"""Read-only structural checks; run from any directory with Python 3.11+."""
from pathlib import Path
import ast, csv, json, re, tomllib

root = Path(__file__).resolve().parents[1]
project = tomllib.loads((root / "pyproject.toml").read_text())
target = project["project"]["name"]
other = "sird" if target == "sicg" else "sicg"
files = [p for p in root.rglob("*") if p.is_file() and ".git" not in p.parts]
for path in files:
    if path.suffix == ".py":
        tree = ast.parse(path.read_text(encoding="utf-8"), filename=str(path))
        for node in ast.walk(tree):
            if isinstance(node, ast.ImportFrom) and node.level:
                base = path.parent
                for _ in range(node.level - 1): base = base.parent
                if node.module:
                    base = base.joinpath(*node.module.split("."))
                    assert base.with_suffix(".py").exists() or (base / "__init__.py").exists(), (path, node.module)
    if path != Path(__file__).resolve() and path.suffix in {".py", ".R", ".sl", ".yaml", ".tex", ".csv"}:
        text = path.read_text(encoding="utf-8-sig")
        assert not re.search(r"\b" + other + r"\b", text, re.I), ("Other target method", path)
        assert "code_infsamp" not in text and "SISL" not in text, path
    if path.suffix == ".csv":
        with path.open(encoding="utf-8-sig", newline="") as stream:
            rows = list(csv.DictReader(stream))
        assert all(row.get("Method", "").lower() != other for row in rows), path
for study in ("nutrition", "survival", "vccc"):
    exp = root / "experiments" / study
    for method in (target, "gain", "tabcsdi"):
        assert (exp / f"03_run_simulation_{method}.py").is_file()
    for method in ("mice", "rf", "mixgb", "raking"):
        assert (exp / f"03_run_simulation_{method}.R").is_file()
    assert (exp / "data" / "Config" / f"best_config_{target}.yaml").is_file()
    assert (exp / "simulations" / "results" / "results_TIMES.csv").is_file()
print(f"{target}: {len(files)} files checked; all Python parses, local package imports and comparator inventories passed.")
