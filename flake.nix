{
  description = "wrapper to build/run containers";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          name = "cnt";
          src = self;
          buildPhase = "";
          installPhase = "mkdir -p $out/bin; install -t $out/bin cnt";

          meta = {
            description = "wrapper to build/run containers";
            homepage = "https://github.com/dyercode/cnt";
            licence = pkgs.lib.licenses.gpl3;
            maintainers = [ ];
          };
        };

        devShells.default =
          pkgs.mkShell { nativeBuildInputs = with pkgs; [ fish ]; };
      });
}
