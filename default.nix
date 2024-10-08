{ stdenv
, lib
, qtbase
, wrapQtAppsHook
, cmake
, pkg-config
, kdePackages
, SDL2
, ffmpeg
, dhclient
, libnl
, autoPatchelfHook
}:
stdenv.mkDerivation rec {
  version = "0.0.0";
  name = "vanilla";
  src = ./.;

  buildInputs = [ qtbase ];
  nativeBuildInputs = [
    wrapQtAppsHook
    cmake
    pkg-config
    kdePackages.qtmultimedia
    SDL2
    ffmpeg
    dhclient
    libnl
    autoPatchelfHook
  ];

  patchPhase = ''
    cp -r $src/ ./
    cp $src/lib/hostap/conf/wpa_supplicant.config ./lib/hostap/wpa_supplicant/.config
  '';

  configurePhase = ''
    mkdir build
    cd build
    cmake ..
  '';

  buildPhase = ''
    cmake --build .
  '';

  installPhase = ''
    mkdir -p $out
    cp -r ./lib $out
    cp -r ./bin $out
    cp -r ../lib/hostap/wpa_supplicant/*.so $out/lib
  '';

  fixupPhase =
    ''
      patchelf --add-needed ../lib/libwpa_client.so ./bin/*
      wrapQtAppsHook $out
    '';
}
