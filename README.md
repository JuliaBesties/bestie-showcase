# BestieTemplate.jl showcase

This repo showcases the resulting repo after running
[BestieTemplate.jl](https://github.com/JuliaBesties/BestieTemplate.jl) with
different strategies.

The packages in this repo are generated via [`BestieTemplate.new_pkg_quick`](https://juliabesties.github.io/BestieTemplate.jl/stable/95-reference/#BestieTemplate.new_pkg_quick). You can check [Bestie's quick guide](https://juliabesties.github.io/BestieTemplate.jl/stable/10-guides/05-quick-guide/) for more info, and the <main.jl> script for details on its use in this repo.

Finally, you can check the commits in this repo so see what was introduced by each new version (after v0.18.3).

The four generated packages are (description might be out of date, always check):

- <StrategyLevel0Tiny.jl>: Smallest package, i.e., "no" to every addition.
- <StrategyLevel1Light.jl>: Starting point for most packages.
  - Docs with Documenter.jl, and GitHub workflow for automated build and deploy.
  - Testing with [TestItems](https://www.julia-vscode.org/docs/stable/userguide/testitems/), and automated testing for pushes to `main` and pull requests.
  - Dependabot for Julia `[compat]` updates, and [TagBot](https://github.com/JuliaRegistries/TagBot) workflow for tags management.
  - Little-friction inclusions, like configuration for linters and formatters and PR template.
- <StrategyLevel2Moderate.jl>: Introduces some friction to enforce some quality.
  - [`pre-commit`](https://pre-commit.com) configuration
  - Lint GitHub action to run the linters and formatters via pre-commit and link checker
  - Dependabot for github-actions version update
- <StrategyLevel3Robust.jl>: Resilience over speed.
  - Contributing and developer documentation
  - Community-related files, such as `CITATION.cff`, `CODE_OF_CONDUCT.md`, `.all-contributorsrc`, and issue templates
