using Pkg

# This file is meant to be used by GitHub Actions.

Pkg.add(PackageSpec(url="https://github.com/rikhuijzer/codex.jl"))
Pkg.add(PackageSpec(url="https://github.com/rikhuijzer/gendoc.jl"))
Pkg.add(PackageSpec(url="https://github.com/rikhuijzer/gentex.jl"))

Pkg.develop(PackageSpec(path=""))
