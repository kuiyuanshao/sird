args <- commandArgs(trailingOnly = TRUE)
root <- if (length(args)) args[1] else "."
files <- list.files(root, pattern = "[.]R$", recursive = TRUE, full.names = TRUE)
for (f in files) parse(file = f)
cat(length(files), "R scripts parsed successfully\n")
