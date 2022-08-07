{ pkgs ? import <nixpkgs> {} } :

let

inherit (pkgs) mkShell callPackage;

php = callPackage ./pkgs/top-level/php-packages.nix { };

python = callPackage ./pkgs/top-level/python-packages.nix { };

go = callPackage ./pkgs/top-level/go-packages.nix { };

javascript = callPackage ./pkgs/top-level/javascript-packages.nix { };

inix = callPackage ./pkgs/top-level/nix-packages.nix { };

java = callPackage ./pkgs/top-level/java-packages.nix { python = python.pythonEnv; };

in 
mkShell {
  buildInputs = with pkgs; 
  [   
    curl        
    deno
    redis
    git
    inix.nix-bin
    inix.nix-kernel-install
  ]++
  [
    java.java
    java.ijava
  ]++
  [
    javascript.nodejs
    javascript.ijavascript
  ]
  ++
  [
    go.go
    go.gophernotes
    go.kernel
  ] ++
  [
    python.pythonEnv
    python.virtualenvwrapper
  ] ++  [
    php.php
    php.phpunit
    php.composer
    php.jupyterPhpKernel
    php.laravel
    php.think
  ];

  shellHook = ''
  source virtualenvwrapper.sh
  jupyter-php-kernel --install
  gophernotes-kernel-install
  install_c_kernel --user > /dev/null 2>&1
  ijsinstall --install=local > /dev/null 2>&1
  python -m bash_kernel.install > /dev/null 2>&1
  nix-kernel-install > /dev/null 2>&1
  '';
}


