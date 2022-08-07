{ pkgs ? import <nixpkgs> {} } :

let
  inherit (pkgs) go gophernotes runCommand writeShellScriptBin;

  kernel = writeShellScriptBin "gophernotes-kernel-install" ''
  dst=`jupyter --data-dir`"/kernels/go"
  mkdir -p $dst
  echo '{
    "argv": [
        "${gophernotes}/bin/gophernotes",
        "{connection_file}"
    ],
    "display_name": "Go",
    "language": "go",
    "name": "go"
}' > $dst/kernel.json
  '';

  kernel2 = runCommand "gophernotes-kernel" {} ''
    echo ${gophernotes}
    echo /home/happy/.local/share/jupyter
    mkdir -p $out/kernels/gophernotes
  '';

in  
{
  inherit go gophernotes kernel;
}