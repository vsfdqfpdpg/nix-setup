{ mkDerivation, fetchFromGitHub, lib,  composer } :

let 
  pname = "jupyter-php-kernel";
  version = "1.0.4";

in mkDerivation {
  inherit pname version;
  src = fetchFromGitHub {
    owner = "Rabrennie";
    repo = "jupyter-php-kernel";
    rev = "refs/tags/${version}";
    sha256 = "sha256-H4vjESEMlzNiwHnB8KxOU47BPu/jdwdH8Y76z6NB7W8=";
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
    substituteInPlace composer.json --replace '4.1' '4.3.1'
    composer install
    chmod -R a-w $out
    set +x
    runHook postInstall
  '';

  meta = with lib; {
    description = "Jupyter-PHP's Installer";
    license = licenses.mit;
    homepage = "https://github.com/Rabrennie/jupyter-php-kernel";
    maintainers = with maintainers; [ jtojnar ] ++ teams.php.members;
  };
}