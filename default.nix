let
  # Pinning explicitly to 20.03 to avoid issues with an outdated cache.
  rev = "5272327b81ed355bbed5659b8d303cf2979b6953";
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
  inherit (nixpkgs) pkgs;
  myTex = with pkgs; texlive.combine {
    # pgf contains TikZ.
    inherit (texlive) scheme-basic dvisvgm amsfonts mathtools pdfcrop stmaryrd pgf xcolor;
  };
in [
  pkgs.hugo
  myTex
]
