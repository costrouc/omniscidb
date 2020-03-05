let overlay = self: super: {
      arrow-cpp = super.callPackage ./nix/arrow-cpp-0.13.0.nix { };
      libkml = super.callPackage ./nix/libkml.nix { };
      bisonpp = super.callPackage ./nix/bisonpp.nix { };
      omniscidb = super.callPackage ./nix/omniscidb.nix { };
    };

    pkgs = import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs-channels/archive/42f0be81ae05a8fe6d6e8e7f1c28652e7746e046.tar.gz";
      sha256 = "1rxb5kmghkzazqcv4d8yczdiv2srs4r7apx4idc276lcikm0hdmf";
    }) { overlays = [ overlay ]; };

    pythonPackages = pkgs.python3Packages;
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    omniscidb
  ];
}
