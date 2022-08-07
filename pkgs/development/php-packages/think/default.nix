{ mkDerivation, lib, writeShellScriptBin, composer, php } : 

let 
  pname = "think";
  version = "6.0.0";

  thinkCreate = writeShellScriptBin "think-create" ''
  ${composer}/bin/composer create-project topthink/think $@
  '';

  think = writeShellScriptBin "think" ''
  ${php}/bin/php think $@
  '';

in mkDerivation rec {
  inherit pname version;

  buildInputs = [ thinkCreate think ];

  dontUnpack = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp -r ${thinkCreate}/. $out
    cp -r ${think}/. $out
    runHook postInstall
  '';

  meta = with lib; {
    description = "Create a think php project.";
    license = licenses.mit;
  };
}