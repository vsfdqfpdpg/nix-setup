{ stdenv
, python310Packages
, python310
, fetchFromGitHub
}:
python310Packages.buildPythonPackage rec {
  pname = "nix-kernel";
  version = "0.1";
  src = fetchFromGitHub {
    owner = "GTrunSec";
    repo = "nix-kernel";
    rev = "dfa42d0812d508ded99f690ee1a83281d900a3ec";
    sha256 = "1lf4rbbxjmq9h6g3wrdzx3v3dn1bndfmiybxiy0sjavgb6lzc8kq";
  };
  doCheck = false;
  preBuild = ''
    export HOME=$(pwd)
  '';
  propagatedBuildInputs = with python310Packages; [ pexpect notebook ] ;
}