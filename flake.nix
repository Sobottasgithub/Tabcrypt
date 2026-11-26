{
  description = "Tabcrypt";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    tablog = {
      url = "github:Sobottasgithub/tablog";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      tablog,
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      version = "0.0.1";

      libtablog = tablog.packages.${system}.lib;

      commonDeps = with pkgs; [
        cmake
        gcc
        gnumake
        libtablog
      ];

      mkTabcryptPackage =
        {
          pname,
          buildTarget,
          enableLib ? false,
          enableTest ? false,
          extraInputs ? [ ],
        }:
        pkgs.stdenv.mkDerivation {
          inherit pname version;
          src = ./.;

          buildInputs = commonDeps ++ extraInputs;

          configurePhase = ''
            cmake -B build -S $src \
              -DCMAKE_BUILD_TYPE=Release \
              -DDEF_TABCRYPT=${if enableLib then "ON" else "OFF"} \
              -DDEF_TEST=${if enableTest then "ON" else "OFF"}
          '';

          buildPhase = ''
            cmake --build build \
              --target ${buildTarget} \
              -j$NIX_BUILD_CORES
          '';

          installPhase = ''
            cmake --install build --prefix=$out
            cp LICENSE $out/
          '';
        };

    in
    {
      packages.${system} =
        let
          lib = mkTabcryptPackage {
            pname = "libtabcrypt";
            buildTarget = "tabcrypt";
            enableLib = true;
          };
        in
        {
          inherit lib libtablog;

          test = mkTabcryptPackage {
            pname = "tabcrypt-test";
            buildTarget = "tabcrypt-test";
            enableTest = true;
            extraInputs = [ lib ];
          };

          full = mkTabcryptPackage {
            pname = "libtabcrypt-full";
            buildTarget = "all";
            enableLib = true;
            enableTest = true;
          };

          default = self.packages.${system}.lib;
        };

      devShells.${system}.default = pkgs.mkShell {
        packages = commonDeps ++ [
          pkgs.bridge-utils
          pkgs.clang-tools

          pkgs.man-db
          pkgs.man-pages
          pkgs.man-pages-posix
          pkgs.stdman
        ];

        extraOutputsToInstall = [
          "man"
          "doc"
        ];

        shellHook = ''
          export MANPATH="${pkgs.man-pages}/share/man:${pkgs.man-pages-posix}/share/man:$MANPATH"
          cmake -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
          git status
        '';
      };
    };
}
