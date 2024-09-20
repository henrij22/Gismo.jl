using BinaryBuilder

# See https://github.com/JuliaPackaging/Yggdrasil/blob/master/C/CGAL/build_tarballs.jl

name = "gismo"
version = v"24.08.0"
sources = [
    GitSource("https://github.com/gismo/gismo.git",       # The URL of the git repository
              "18ac54d1d072a87ec626fb76dd76b1f08b29d5de") # The commit hash to checkout
]

# NOTE: to control nproc, use the environment variable BINARYBUILDER_NPROC=<number of processors>
script = raw"""
cmake -B build \
  `# cmake specific` \
  -DCMAKE_INSTALL_PREFIX=${prefix} \
  -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TARGET_TOOLCHAIN} \
  -DCMAKE_BUILD_TYPE=MinSizeRel \
  -DGISMO_OPTIONAL="gsCInterface" \
  -DGISMO_WITH_OPENMP=ON \
  gismo/

`# this is very temporary`
cd gismo/optional/gsCInterface
git remote set-branches origin '*'
git fetch --unshallow
git checkout JuliaMatlab
cd ../../../
`# end of temporary`

cmake --build build --config Release -- -j$nproc gismo

# HUGO: The following two lines should not be needed. However, it seems that we need to have the library files inside ${WORKSPACE}/destdir/lib    
mkdir $libdir
mv build/lib/libgismo.so $libdir

install_license ${WORKSPACE}/srcdir/gismo/LICENSE.txt
"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
# platforms = [AnyPlatform()]
platforms = [
    Platform("x86_64", "linux"; libc="glibc"),
]
platforms = expand_cxxstring_abis(platforms)

products = [
    LibraryProduct("libgismo", :libgismo),
]

# Dependencies that must be installed before this package can be built
dependencies = [
    # Essential dependencies
    # Dependency("boost_jll"; compat="=1.76.0"),
    # Dependency("GMP_jll"; compat="6.2.1"),
    # Dependency("MPFR_jll"; compat="4.1.0"),
]


build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies; preferred_gcc_version = v"9")