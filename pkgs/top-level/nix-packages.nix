{pkgs ? import <nixpkgs> {} } :

let

inherit (pkgs) stdenv writeScriptBin nix python310 callPackage;

nix-kernel = callPackage ../development/nix-packages/nix-kernel {};
kernelEnv = (python310.withPackages (p: (with p; [
    nix-kernel
  ])
));

kernelFile = {
    display_name = "Nix";
    language = "Nix";
    argv = [
      "${nix-bin}/bin/nix-kernel"
      "-f"
      "{connection_file}"
    ];
    logo64 = "logo-64x64.png";
  };

nix-bin =  writeScriptBin "nix-kernel" ''
      #! ${stdenv.shell}
      PATH=${nix}/bin/:${kernelEnv}/bin:$PATH
      exec python -m nix-kernel $@
        '';

nix-kernel-install = writeScriptBin "nix-kernel-install" ''
  dst=`jupyter --data-dir`"/kernels/nix"
  mkdir -p $dst
  echo '${builtins.toJSON kernelFile}' > $dst/kernel.json
'';

in stdenv.mkDerivation {
    inherit nix-bin nix-kernel-install;
    pname = "inix";
    version = "0.1";
    phases = "installPhase";
    installPhase = ''
      mkdir -p $out/kernels/inix_nix
      echo '${builtins.toJSON kernelFile}' > $out/kernels/inix_nix/kernel.json
      echo $out
    '';
}