using BestieTemplate
using YAML

const package_owner = "JuliaBesties"
const user_name = "Bestie Template"
const user_email = "me@bestie.tmp"
const authors = "$user_name <$user_email>"

# Main script
for (i, strategy) in enumerate((:tiny, :light, :moderate, :robust))
  @info "Strategy $strategy"

  package_name = "StrategyLevel$(i - 1)" * titlecase(string(strategy)) * ".jl"
  package_path = joinpath(@__DIR__, package_name)

  if isdir(package_path)
    @info "Removing old folder '$package_path'"
    rm(package_path, recursive=true)
  end

  @info "Creating $package_name with new_pkg_quick"
  BestieTemplate.new_pkg_quick(
    package_path,
    package_owner,
    authors,
    strategy,
    template_source = :local,
  )

  @assert isdir(package_path)

  cd(package_path) do
    answers = YAML.load_file(".copier-answers.yml")
    bestie_version = answers["_commit"]

    @info "git add $package_name"
    run(`git add .`)

    if !success(`git diff-index --exit-code HEAD .`)
      @info "Committing"
      run(`git commit -m "Add $package_name from BestieTemplate@$bestie_version"`)
    else
      @warn "Nothing to commit"
    end

    if isfile(".pre-commit-config.yml")
      max_precommit_runs = 3
      pre_commit_runs = 0
      while pre_commit_runs < max_precommit_runs
        @info "Running $package_name's pre-commit"
        pre_commit_runs += 1
        pre_commit_success = success(`pre-commit run -a`)

        if pre_commit_success
          @info "Successfully ran pre-commit"
          break
        else
          @warn "pre-commit failed execution #$pre_commit_runs"
        end
      end
      run(`git add .`)
      if !success(`git diff-index --exit-code HEAD. `)
        @info "Adding modifications"
        run(`git commit -m "Add $package_name after running its pre-commit"`)
      end
    end
  end
end
