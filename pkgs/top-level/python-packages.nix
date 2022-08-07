{ pkgs ? import <nixpkgs> {} } :

let

  inherit (pkgs) python310 python310Packages callPackage ;

  pythonEnv = python310.withPackages (ps: [
    ps.numpy
    ps.toolz
    ps.scrapy
    ps.django
    ps.flask
    ps.pillow
    ps.tkinter
    ps.jupyter
    ps.pexpect
    ps.jupyterlab
    ps.jupyter-c-kernel
    ps.nix-kernel
    ps.bash_kernel
    ps.pip
  ]);


  virtualenvwrapper = python310Packages.virtualenvwrapper;

in {
  inherit pythonEnv virtualenvwrapper;
}