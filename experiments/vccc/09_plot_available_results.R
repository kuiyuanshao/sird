.root <- getwd()
while (!file.exists(file.path(.root, "pyproject.toml")) && dirname(.root) != .root) .root <- dirname(.root)
source(file.path(.root, "R", "plot_available_results.R"))
plot_available_results()
