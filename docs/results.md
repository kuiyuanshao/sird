# Result availability

The curated exports were copied from the thesis code at commit `c572ae00ce6b32656c9337cc84dcf39a1eb0263d`.
Numeric values for retained methods are unchanged. Nutrition and VCCC summary
CSVs and runtime CSVs for all three studies are included. Survival has exported
LaTeX tables and runtime CSVs, but no per-covariate summary CSV in the source checkout.

Exported LaTeX tables retain the original pooled values for SIRD and the
comparators. Ranking colours were removed when filtering columns; the table
generation scripts recompute rankings from the paper's method set on a new run.
Captions are generic descriptions awaiting final manuscript wording.

Existing joint-method figures are not copied, because they contain a method outside
this paper. Their plotting scripts are adapted to the retained methods. The included
`09_plot_available_results.R` scripts generate summary and runtime figures directly
from the included CSVs; these are distinct from replicate-level boxplots.

Replicate-level combined estimates and imputed datasets are absent from the source
checkout, so the original distribution figures and nutrition/survival table-generation
steps need regenerated intermediate results. The nutrition generator additionally
requires four parameter files absent from the source checkout: `multiNorm.RData`,
`logiReg.RData`, `calibrCoeff.RData` and `outPar.RData`.

Clinical records and fitted checkpoints are not included. The source provenance and
file mapping are recorded in `migration_manifest.json` in this directory.

The selected R comparator configurations (`best_config_mice.rds`,
`best_config_rf.rds` and `best_config_mixgb.rds`) are also absent for all three
studies. The corresponding tuning scripts are retained and can recreate these
files when the required study inputs are available; the original selected values
cannot be recovered from the exports alone.

## Verification

Run `python scripts/validate_repository.py` and `Rscript scripts/check_r_syntax.R .`
from the repository root for structural and syntax checks. These checks do not
run the training or simulation pipeline.
