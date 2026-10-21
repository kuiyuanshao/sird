# Results and reproducibility files

The repository includes generation parameters, sampling seeds, selected Python and
R comparator configurations, tuning exports, per-replicate regression estimates,
confidence intervals, runtime records, summary tables and the available figures.
These files were restored from the original thesis archive. The provenance and
checksums are recorded in `external_restore_manifest.json`.

All result objects and tables are restricted to SIRD and the traditional
comparators. Retained estimates are unchanged; only rows belonging to the excluded
method are removed. The main bias figures and LaTeX tables can be regenerated with
the study's `06_generate_figures.R` and `07_generate_tables.R` scripts using the
included combined estimates. These tables recompute ranking colours for this
paper's method set.

The `09_plot_available_results.R` scripts create additional summary/runtime plots
from exported CSVs. These plots describe the available summary values, rather than
the replicate-level distribution shown by stage 06.

Raw cohorts, completed/imputed patient datasets and model checkpoints are excluded.
Optional stage-08 plots use completed datasets and are separate from the combined
regression-result exports. The clinical case study includes estimation results,
configurations and sampling seeds, but no patient-level records.

## Verification

Run `python scripts/validate_repository.py` and `Rscript scripts/check_r_syntax.R .`
from the repository root for structural and syntax checks. These checks do not
run training or regenerate simulation data.
