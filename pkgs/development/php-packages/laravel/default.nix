{ mkDerivation, fetchFromGitHub, lib, writeShellScriptBin, composer, php } :

let 
  pname = "laravel";
  version = "4.2.12";

  artisan = writeShellScriptBin "artisan" ''
  ${php}/bin/php artisan $@
  '';

in mkDerivation {
  inherit pname version;
  src = fetchFromGitHub {
    owner = "laravel";
    repo = "installer";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-k03DE9N6zG28yk0fLULvzhEqgJyNbl+UNq/nNrKadN4=";
  };

  dontUnpack = true;
  
  nativeBuildInputs = [ composer ];

  installPhase = ''
    runHook preInstall
    set -x
    mkdir -p $out
    cp -r $src/. $out
    chmod -R a+w $out
    cd $out
    composer install
    cp -r ${artisan}/. $out
    chmod -R a-w $out
    set +x
    runHook postInstall
  '';

  meta = with lib; {
    description = "The Laravel application installer.";
    license = licenses.mit;
    homepage = "https://github.com/laravel/installer";
    maintainers = with maintainers; [ jtojnar ] ++ teams.php.members;
  };
}