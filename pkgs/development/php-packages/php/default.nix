{ php81, zmq } : 
let 

in php81.buildEnv {
  extensions = {enabled, all}: enabled ++ (with all; [ imagick opcache swoole redis amqp zmq xdebug ] );
  extraConfig = ''
  memory_limit=256M;
  xdebug.mode=debug;
  '';
}