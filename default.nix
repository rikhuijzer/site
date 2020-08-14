{ nixpkgs ? import <nixpkgs> {} }:

let
  inherit (nixpkgs) pkgs;
  myTex = with pkgs; texlive.combine {
    # pgf contains TikZ.
    inherit (texlive) scheme-basic dvisvgm amsfonts mathtools pdfcrop stmaryrd pgf;
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
