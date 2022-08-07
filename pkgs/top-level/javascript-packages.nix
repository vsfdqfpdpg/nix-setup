{ pkgs ? import <nixpkgs> {} } :

let 
inherit (pkgs) nodejs nodePackages;
inherit (nodePackages) ijavascript;
  
in {
  inherit nodejs ijavascript;
}