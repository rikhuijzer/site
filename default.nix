{ pkgs ? import <nixpkgs> {} }:

let 
  packages = (import ./latex.nix {});
in pkgs.mkShell {
  buildInputs = packages;
}
