# Plot the available summary exports without loading raw or replicate data.
plot_available_results <- function(result_dir = "simulations/results") {
  summary_file <- file.path(result_dir, "Summary_Table.csv")
  if (file.exists(summary_file)) {
    d <- read.csv(summary_file, check.names = FALSE)
    outcome <- if ("Outcome" %in% names(d)) "Outcome" else "Model"
    d$Panel <- paste(d[[outcome]], d$Design, sep = " / ")
    # Plot per-coefficient values; no new pooling or averaging is applied.
    pdf(file.path(result_dir, "summary_metrics.pdf"), width = 11, height = 8)
    for (panel in unique(d$Panel)) {
      q <- d[d$Panel == panel & d$Method != "VAL", , drop = FALSE]
      methods <- unique(q$Method); covs <- unique(q$Covariate)
      par(mfrow = c(1, 2), mar = c(6, 5, 4, 1))
      for (metric in c("Mean_Percent_Bias", "Nominal_Coverage")) {
        values <- lapply(methods, function(m) q[q$Method == m, metric])
        names(values) <- methods
        boxplot(values, las = 2, col = "#DCEAF5", cex.axis = 0.7,
                main = panel, ylab = gsub("_", " ", metric))
        abline(h = if (metric == "Nominal_Coverage") 0.95 else 0,
               col = "#B23A48", lty = 2)
        mtext("Distribution across coefficients of the included summary values", side = 3, cex = 0.6)
      }
    }
    dev.off()
  }
  timing_file <- file.path(result_dir, "results_TIMES.csv")
  if (file.exists(timing_file)) {
    t <- read.csv(timing_file)
    t <- t[is.finite(t$Time_Seconds) & t$Time_Seconds > 0, , drop = FALSE]
    if (nrow(t)) {
      pdf(file.path(result_dir, "runtime_comparison.pdf"), width = 10, height = 6)
      par(mar = c(6, 5, 4, 1))
      boxplot(Time_Seconds ~ Method, data = t, log = "y", las = 2,
              col = "#DCEAF5", ylab = "Runtime (seconds, log scale)",
              main = "Recorded runtimes across included sampling settings")
      dev.off()
    }
  }
}
