{ mkDerivation, lib, makeWrapper, fetchurl, php } :

let 
  pname = "phpunit";
  version = "9.5.0";

in mkDerivation {
  inherit pname version;

  src = fetchurl {
    url = "https://phar.phpunit.de/phpunit-9.5.phar";
    sha256 = "sha256-yvsmgfoK0BIBsIubqJ99u0GXUUff6T/+8Ut2wGsx/qI=";
  };

  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    install -D $src $out/libexec/phpunit/phpunit.phar
    makeWrapper ${php}/bin/php $out/bin/phpunit \
      --add-flags "$out/libexec/phpunit/phpunit.phar"
    runHook postInstall
  '';

  meta = with lib; {
    description = "PHPUnit is a programmer-oriented testing framework for PHP";
    license = licenses.mit;
    homepage = "https://phpunit.de/getting-started/phpunit-9.html";
    changelog = "https://phpunit.readthedocs.io/en/9.5/";
    maintainers = with maintainers; [ offline ] ++ teams.php.members;
  };
}