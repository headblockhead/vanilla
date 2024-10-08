{
  description = "A software clone of the Wii U gamepad for Linux";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    dhclient.url = "github:NixOS/nixpkgs/8d34cf8e7dfd8f00357afffe3597bc3b209edf8e";
  };
  outputs = { self, nixpkgs, dhclient }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
      };
      dhcpkgs = import dhclient {
        config.permittedInsecurePackages = [
          "dhcp-4.4.3-P1"
        ];
        system = "x86_64-linux";
      };
      vanilla = pkgs.qt6Packages.callPackage ./default.nix {
        dhclient = dhcpkgs.dhcp.override { withClient = true; };
      };
    in
    {
      packages.x86_64-linux.default = vanilla;
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = [ vanilla ];
      };
    };
}
