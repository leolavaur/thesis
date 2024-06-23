{ lib
, stdenv, fetchFromGitHub, writeShellScript
, texlive
}:

stdenv.mkDerivation rec {
  # Make this a valid tex(live-new) package;
  # the pkgs attribute is provided with a hack below.
  pname = "latex2pydata";
  version = "v4.0.0";
  tlType = "run";

  outputs = [ "tex" "texdoc" ];

  src = fetchFromGitHub {
    owner = "gpoore";
    repo = "latex2pydata";
    rev = "main";
    hash = "sha256-FZs6qCH4dHfJ06UyBxzXoEVse/astRa3IQUcUQ0b+Yc=";
  } + "/latex/latex2pydata";

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
    description = "Write data to file in Python literal format";
    license = licenses.lppl13c;
    platforms = platforms.unix;
  };
}