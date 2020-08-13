{ nixpkgs ? import <nixpkgs> {} }:

let
  inherit (nixpkgs) pkgs;
  myTex = with pkgs; texlive.combine {
    inherit (texlive) scheme-basic dvisvgm amsfonts mathtools stmaryrd;
  };

in pkgs.mkShell {
  name = "env";
  buildInputs = with pkgs; [
    ghostscript
    imagemagick
    myTex
    which
  ];
}
