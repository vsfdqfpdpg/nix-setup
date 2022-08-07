### Install nix
[download-nix](https://nixos.org/download.html#download-nix)   

### Search packages 
[search](https://search.nixos.org/packages)    

### languages section
[languages](https://github.com/NixOS/nixpkgs/tree/master/doc/languages-frameworks)
[nix manual](https://ryantm.github.io/nixpkgs/using/configuration/#chap-packageconfig)

### Nix wiki
[wiki](https://nixos.wiki/)   
[jupyterlab DataScience](https://nixos.wiki/wiki/Workgroup:DataScience)   
[creating-a-super-simple-derivation](https://www.sam.today/blog/creating-a-super-simple-derivation-learning-nix-pt-3/)     
[nix-flakes](https://xeiaso.net/blog/nix-flakes-2-2022-02-27)      
[nix-shell](https://nixos.wiki/wiki/Shell_Scripts)   
[syntax](https://gist.github.com/jD91mZM2/ccc42f1068780a52ed20c212120ebdac)   
[learn-nix](https://ianthehenry.com/posts/how-to-learn-nix/)   

```bash
nix-build --option sandbox false
nix-build --option sandbox false --no-out-link
nix-build --option sandbox false  php-packages.nix --repair
nix-build --option sandbox false  php-packages.nix --no-out-link

nix-store --delete
nix-store --gc

# Get environment variable
home = builtins.getEnv "HOME";
export USER=${builtins.getEnv "USER"}
export HOME=${builtins.getEnv "HOME"}
environment.systemPackages

nix-instantiate --eval default.nix 
nix-instantiate --eval --expr '5 + 6'

with import <nixpkgs> {};
```

### Repl file
```bash
nix repl --file helper.nix
```

### Phase
```bash
prePhases
unpackPhase
patchPhase
preConfigurePhases
configurePhase
preBuildPhases
buildPhase
checkPhase
preInstallPhases
installPhase
fixupPhase
installCheckPhase
preDistPhases
distPhase
postPhases
```


### WriteShell Bin
```bash
writeReferencesToFile (writeScriptBin "hi" ''${hello}/bin/hello'')
```

### jupyter
```bash
jupyter-php-kernel --install
jupyter notebook --port=8888 --no-browser
jupyter lab --no-browser
```
[interact-with-jupyter-notebooks-via-api](https://stackoverflow.com/questions/54475896/interact-with-jupyter-notebooks-via-api)

### Find biggest file
```bash
find / -xdev -type f -size +10M -print | xargs ls -lh | sort -k5,5 -h -r
find . -xdev -type f -size +10M -print | xargs ls -lh | sort -k5,5 -h -r
find . -newermt "2022-07-21" -type f | xargs rm -rf
find . -newermt "2022-07-21" -type f | xargs ls -la
```
