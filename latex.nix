{ nixpkgs ? import <nixpkgs> {} }:

let
  inherit (nixpkgs) pkgs;
  myTex = with pkgs; texlive.combine {
    # pgf contains TikZ.
    inherit (texlive) scheme-basic dvisvgm amsfonts mathtools pdfcrop stmaryrd pgf xcolor;
  };
in [
  myTex
]
