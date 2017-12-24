set -x



# Install system packages.
case $TRAVIS_OS_NAME in
    linux)
        sudo add-apt-repository -y ppa:avsm/ocaml42+opam12
        sudo apt-get update -qq
        sudo apt-get install -qq libev-dev ocaml-nox opam
        ;;
    osx)
        brew update > /dev/null
        brew install libev gtk+ ocaml opam
        ;;
esac



# Initialize opam.
opam init -ya --compiler=$COMPILER
eval `opam config env`
ocaml -version



# Install dependencies.
opam install conf-libev
opam pin add -y --no-action lwt_glib .
opam install -y --deps-only lwt_glib



# Build and install Lwt_glib. This is the only inherent test.
opam install -y --verbose lwt_glib



# Build our one and only reverse dependency, to make sure all is likely well.
opam install -y 0install
