# SIRD

Sample Imputation via Conditional Residual Denoising Diffusion Networks for regression inference under two-phase sampling.
This repository contains the method, simulation studies, a clinical case study,
ablation experiments and curated results for the SIRD paper.

## Layout

| Directory | Contents |
| --- | --- |
| `src/sird/` | Python implementation and hyperparameter tuner. |
| `experiments/nutrition/` | Nutrition simulations with Gaussian and binomial analysis models. |
| `experiments/survival/` | Cox model simulations with covariate error and combined outcome/covariate error. |
| `experiments/vccc/` | Vanderbilt Comprehensive Care Clinic case study. |
| `experiments/ablation/` | SIRD architecture, loss and imputation-uncertainty experiments. |
| `benchmarks/` | GAIN and TabCSDI implementations. |
| `R/` | Shared estimation, evaluation, tuning and table helpers. |

## Experiments

The numbered scripts within each study cover data preparation, validation sampling,
method runs, estimate extraction, summaries, figures and tables. The
`03_run_simulation_sird.py` script runs SIRD; other `03_run_simulation_*`
scripts run the comparators. Slurm submission scripts accompany the runners.
Each study retains its tuning scripts, selected configurations and sampling seeds.

Comparators include MICE-PMM, MICE-RF, mixgb, generalized raking, GAIN and TabCSDI,
with validated-data, unvalidated-data, complete-case and IPW analyses where implemented.
The nutrition study also retains its oracle runner.

## Installation

```bash
python -m pip install -e .
```

The analysis pipeline uses R; package setup scripts are provided within each study.
Run study scripts with that study directory as the working directory. Run ablation
scripts from `experiments/ablation`, and comparator tuning scripts from their own
subdirectories. Slurm resources and environment modules should be adapted to the
cluster; Python job scripts use `VIRTUAL_ENV_PATH` to locate the environment.

## Results

Each study's `simulations/results/` directory contains the available results for
SIRD and its comparators. Method rows and exported table columns are restricted
to this paper. Ablation results are retained with the ablation experiments.
See [result availability](docs/results.md) for the available exports and reproduction limits.

## License

MIT. See `LICENSE`.
