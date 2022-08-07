# nix repl --file helper.nix

{ pkgs ? import <nixpkgs> {} } : 

let 
 inherit (pkgs) php81 python310Packages;
in {
 inherit pkgs php81 python310Packages;
} 

