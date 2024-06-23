{ lib
, stdenv, fetchFromGitHub, writeShellScript
, texlive
}:

stdenv.mkDerivation rec {
  # Make this a valid tex(live-new) package;
  # the pkgs attribute is provided with a hack below.
  pname = "fvextra";
  version = "v1.7.0";
  tlType = "run";

  outputs = [ "tex" "texdoc" ];

  src = fetchFromGitHub {
    owner = "gpoore";
    repo = "${pname}";
    rev = "master";
    hash = "sha256-u/RPUEyME8/Iu1Y8QShrXqLAwDSLvys66JRGiL9zuHY=";
  } + "/${pname}";

  nativeBuildInputs = [
    (writeShellScript "force-tex-output.sh" ''
        out="''${tex-}"
      '')
  ];

  dontConfigure = true;

  installPhase = ''
    runHook preInstall

    path="$tex/tex/latex/${pname}"
    mkdir -p "$path"
    cp *.{cls,def,clo,sty} "$path/"

    path="$texdoc/doc/tex/latex/${pname}"
    mkdir -p "$path"
    cp *.pdf "$path/"

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://https://github.com/gpoore/${pname}";
    description = "Extensions and patches for fancyvrb";
    license = licenses.lppl13c;
    platforms = platforms.unix;
  };
}