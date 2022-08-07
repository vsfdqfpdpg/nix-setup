{ pkgs ? import <nixpkgs> {} } :

let

inherit (pkgs) callPackage php81;

mkDerivation = { pname, ... }@args: pkgs.stdenv.mkDerivation (args // {
    pname = "php-${pname}";
});

zmq = callPackage ../development/php-packages/zmq { inherit php81;};
php = callPackage ../development/php-packages/php { inherit php81 zmq; };

composer = (php.withExtensions ({ all, enabled }:
  enabled ++ (with all ; [ imagick opcache swoole redis amqp zmq xdebug curl ] ))
).packages.composer;

jupyterPhpKernel = callPackage ../development/php-packages/jupyter-php-kernel { inherit mkDerivation composer; };
laravel = callPackage ../development/php-packages/laravel { inherit mkDerivation composer php; };
think = callPackage ../development/php-packages/think { inherit mkDerivation composer php; };
phpunit = callPackage ../development/php-packages/phpunit { inherit mkDerivation php; };

in  {
  inherit php phpunit jupyterPhpKernel laravel think composer;
}

