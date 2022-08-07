{ pkgs ? import <nixpkgs> {}, python } : 

let 
  inherit (pkgs) jdk11_headless writeScriptBin callPackage;
  ijava = callPackage ../development/java-packages/IJava { python = python; };
  java = jdk11_headless;

in {
  inherit java ijava;
}