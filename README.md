![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/JuliaBinaryWrappers/gismo_jll.jl/total?label=Downloads%20(gismo_jll)&color=008A00)
![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/gismo/Gismo.jl/total?label=Downloads%20(Gismo.jl)&color=008A00)

|Gismo.jl||
|--:|---|
|License|![GitHub License](https://img.shields.io/github/license/gismo/gismo?color=008A00)|
|OS support|Linux, Windows, macOS|
|Build status|[![ci](https://github.com/gismo/gsKLShell/actions/workflows/ci.yml/badge.svg)](https://github.com/gismo/gsKLShell/actions/workflows/ci.yml)|
|Developers/maintainers| [![Static Badge](https://img.shields.io/badge/@hverhelst-008A00)](https://github.com/hverhelst) [![Static Badge](https://img.shields.io/badge/@Albe21072000-008A00)](https://github.com/Albe21072000)|
|Activity|![GitHub commits since latest release](https://img.shields.io/github/commits-since/gismo/Gismo.jl/latest?color=008A00) ![GitHub commit activity](https://img.shields.io/github/commit-activity/m/gismo/Gismo.jl?color=008A00)|

# Gismo.jl: Geometry + Simulation Modules meet Julia
The Gismo.jl package provides an interface to the [Geometry + Simulation Modules](https://github.com/gismo/gismo) inside Julia.

## Getting started
We provide a hand full of examples in the `examples` directory, which can be run after [installation](#installation) of the package.

## Installation
There are two ways to install Gismo.jl: via Julia's package manager, or by linking it to a local build of G+Smo.

### Via `Pkg`
The Gismo.jl package can be directly downloaded from Julia's package management system `Pkg` using
```
] add Gismo
```
This command fetches the dependency [`gismo_jll`](https://github.com/JuliaBinaryWrappers/gismo_jll.jl) contaning pre-compiled library files, and it fetches the current repository which calls `gismo_jll`.

### Enabling Gismo.jl locally
Alternatively, one can use a local build of G+Smo as a back-end for the Julia bindings. This requires the [`gsCInterface`](https://github.com/gismo/gsCInterface) module to be compiled, and the Gismo.jl package to be fetched as a submodule in G+Smo.

#### a. Fetching and compiling the required G+Smo submodules
Enable the `gsCInterface` and the `Gismo.jl` modules inside G+Smo
```
cd path/to/gismo/build
cmake . -DGISMO_OPTIONAL="<OTHER OPTIONAL MODULES>;gsCInterface;Gismo.jl" \
        -DGISMO_JL_DEVELOP=ON
```
And compile everything
```
make gismo
```
#### b. Link libgismo to Gismo.jl
In the file `Gismo.jl/src/Gismo.jl`, the shared library should be included as follows:
```
libgismo = "path/to/gismo/build/lib/libgismo"
```

#### c. Install Gismo.jl in Julia
Add the local package Gismo.jl to Julia's development packages
```
cd path/to/gismo/
cd optional
julia -e 'using Pkg; Pkg.develop(path="Gismo.jl")'
```
