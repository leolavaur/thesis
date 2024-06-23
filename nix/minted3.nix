{ lib
, stdenv, fetchFromGitHub, writeShellScript
, texlive
, latexminted
, latex2pydata ? texlive.latex2pydata
, fvextra ? texlive.fvextra
}:

stdenv.mkDerivation {
  # Make this a valid tex(live-new) package;
  # the pkgs attribute is provided with a hack below.
  pname = "minted";
  version = "v3.0.0beta5";
  tlType = "run";

  outputs = [ "tex" "texdoc" ];
  passthru.tlDeps = with texlive; [ 
    catchfile
    etoolbox
    float
    framed
    fvextra
    latex2pydata
    newfloat
    pdftexcmds
    # pgfkeys
    pgfopts
    # shellesc
    xcolor
  ];

  src = fetchFromGitHub {
    owner = "gpoore";
    repo = "minted";
    rev = "v3-dev";
    hash = "sha256-UGi24pUWZ1lHr36APClMv9AQuiG1CHo9mrA5bgsEuGY=";
  } + "/latex";

  buildInputs = [latexminted];
  nativeBuildInputs = [
    (writeShellScript "force-tex-output.sh" ''
        out="''${tex-}"
      '')
  ];

  dontConfigure = true;

  installPhase = ''
    runHook preInstall

    path="$tex/tex/latex/minted"
    mkdir -p "$path"
    cp minted/*.{cls,def,clo,sty} "$path/"

    path="$texdoc/doc/tex/latex/minted"
    mkdir -p "$path"
    cp minted/*.pdf "$path/"

    path="$tex/tex/latex/restricted"
    mkdir -p "$path"
    cp restricted/*.py "$path/"
    chmod +x "$path/"*.py
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://https://github.com/gpoore/minted/tree/v3-dev";
    description = "Highlighted source code for LaTeX";
    license = licenses.lppl13c;
    platforms = platforms.unix;
  };
}