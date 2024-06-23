{
  description = "PhD thesis manuscript.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    latex-toolbox = {
      url = "github:phdcybersec/latex-toolbox";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, latex-toolbox } @ inputs:

    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import inputs.nixpkgs { 
          inherit system;
        };
        latex2pydata = pkgs.callPackage ./nix/latex2pydata.nix { };
        fvextra = pkgs.callPackage ./nix/fvextra.nix { };
        minted3 = pkgs.callPackage ./nix/minted3.nix { inherit latex2pydata fvextra; };
        
        # recursively remove all dependencies matching (x: x.pname != pname) from pkg.tlDeps
        rmDeps = pkg: pnames:
          if pkg ? tlDeps && pkg.tlDeps != [] then
            pkg // { tlDeps = map (x: rmDeps x pnames) (pkgs.lib.filter (x: ! pkgs.lib.lists.any (y: y == x.pname) pnames) pkg.tlDeps); }
          else
            pkg;
          
        scheme = rmDeps (builtins.elemAt pkgs.texlive.scheme-full.pkgs 0) [ "minted" "latex2pydata" "fvextra" ];
        
      in {

        devShells = {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              (texlive.withPackages (_: [
                scheme
                minted3
              ]))


              # For the bibfix script
              flock
              fswatch

              # Python env (minted + graphs)
              (python3.withPackages (ps: with ps; [
                pygments # minted
                matplotlib
                pandas
                adjusttext
                ipykernel
              ]))
            ];
          };
        };

      }
    );

}
