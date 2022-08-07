{pkgs ? import <nixpkgs> {}, python } :

let 
  inherit (pkgs) stdenv lib fetchgit callPackage jdk11_headless;

  pname = "ijava";
  version = "1.3.0";
  home = builtins.getEnv "HOME";
  user = builtins.getEnv "USER";

in stdenv.mkDerivation {
  
  inherit pname version home user;

  depsBuildBuild = [ ];

  nativeBuildInputs = [  ];

  buildInputs = [ jdk11_headless ];


  src = fetchgit {
    url = "https://github.com/SpencerPark/IJava";
    rev = "a03ad7712a5e8c893bbffc527efd66ae9aae0207";
    sha256 = "sha256-fbT8DDCwoChNhqZSIJeVcyZ6IA0CrYlKM68l/x+PzKQ=";
    # stripRoot = false;
  };

  buildPhase = ''
      export USER=${user}
      export HOME=${home}
      export PATH=$PATH:${python}/bin
      echo ${python} $HOME $USER
      substituteInPlace gradlew --replace '/usr/bin/env sh' $(type -p bash)
      ./gradlew --stacktrace installKernel --prefix ${home}/.local  --python ${python}/bin/python
  '';

  installPhase = ''
    mkdir -p $out
    cp -r $src/. $out
    cd $out
    chmod -R 755 .
    ls -l
  '';

    meta = with lib; {
        description = "A Jupyter kernel for executing Java code.";
        homepage = "https://github.com/SpencerPark/IJava";
        license = licenses.mit;
      };
}