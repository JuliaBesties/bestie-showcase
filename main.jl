using BestieTemplate

const package_owner = "JuliaBesties"
const user_name = "Bestie Template"
const user_email = "me@bestie.tmp"
const authors = "$user_name <$user_email>"

function _git_setup()
  run(`git init -q`)
  run(`git add .`)
  run(`git config user.name "$user_name"`)
  run(`git config user.email "$user_email"`)
  run(`git commit -q -m "First commit"`)
end

function _precommit()
  try
    read(`pre-commit run -a`) # run and ignore output
  catch
    nothing
  end
end

function _full_precommit()
  run(`git add .`)
  _precommit()
  run(`git add .`)
  try
    read(`git diff-index --exit-code HEAD`)
    return # No commit necessary, exit now (consequence of pre-commit passing for default values)
  catch
    nothing
  end
  run(`git commit -q -m "git add . and pre-commit run -a"`)
end

# Main script
for (i, strategy) in enumerate((:tiny, :light, :moderate, :robust))
  @info "Strategy $strategy"

  package_name = "StrategyLevel$(i - 1)-" * titlecase(string(strategy)) * ".jl"
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
  )

  @assert isdir(package_path)

  cd(package_path) do
    @info "Creating first commit in repo"
    _git_setup()

    if isfile(".pre-commit-config.yml")
      @info "Running pre-commit"
      _full_precommit()
    end
  end
end
