{ lib, fetchgit, pkg-config, zeromq, php81, curl } :

let 
  
in php81.buildPecl {
  pname = "zmq";
  version = "1.1.2";

  src = fetchgit  {
    url = https://github.com/zeromq/php-zmq;
    rev = "ee5fbc693f07b2d6f0d9fd748f131be82310f386";
    sha256 = "sha256-3o+oZdAdssuQpKT0vyE2EdNycnbQYUkanuCDFSkleA4=";
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ zeromq ];
  
  meta = with lib; {
    description = "ZeroMQ for PHP";
    license = licenses.asl20;
    homepage = "https://github.com/zeromq/php-zmq";
    maintainers = teams.php.members;
  };
}