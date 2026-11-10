{ pkgs, ... }:

let
  android = pkgs.androidenv.composeAndroidPackages {
    platformVersions = [ "36" ];
    buildToolsVersions = [ "35.0.0" ];
    abiVersions = [ "x86_64" ];
    includeEmulator = true;
    includeSystemImages = true;
  };
in
{
  ############################
  # Android SDK licenses
  ############################
  nixpkgs.config.android_sdk.accept_license = true;

  home = {
    ############################
    # Packages
    ############################
    packages = with pkgs; [
      android-studio
      android.androidsdk
      android-tools # adb, fastboot
      jetbrains.rider
      dotnet-sdk_10
    ];

    ############################
    # Environment variables
    ############################
    sessionVariables = {
      ANDROID_ = "${android.androidsdk}/libexec/android-sdk";
      ANDROID_SDK_ROOT = "${android.androidsdk}/libexec/android-sdk";

      # Hyprland / Wayland: avoid emulator GPU crashes
      QT_QPA_PLATFORM = "wayland;xcb";
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };

    file = {
      ############################
      # Gradle cache
      ############################
      "gradle/gradle.properties".text = ''
        org.gradle.jvmargs=-Xmx4g
        android.useAndroidX=true
        android.enableJetifier=true
      '';

      ############################
      # Android Studio launcher (Wayland fix)
      ############################
      "local/bin/android-studio-wayland" = {
        executable = true;
        text = ''
          #!/usr/bin/env bash
          exec android-studio --disable-gpu --nosplash "$@"
        '';
      };

      ############################
      # Emulator launcher (Swiftshader for NixOS/Wayland)
      ############################
      ".local/bin/start-android-emulator" = {
        executable = true;
        text = ''
          #!/usr/bin/env bash
          echo "Starting Android emulator..."
          export ANDROID_"${android.androidsdk}/libexec/android-sdk"
          export ANDROID_SDK_ROOT="$ANDROID_

          # Check if already running
          if adb devices | grep -q "emulator-"; then
            echo "Emulator already running!"
            adb devices
            exit 0
          fi

          # Start emulator with Swiftshader (required on NixOS/Wayland)
          emulator -avd Medium_Phone -gpu swiftshader_indirect -no-snapshot -no-boot-anim &

          echo "Waiting for emulator to boot..."
          adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done;'

          echo "Emulator ready!"
          adb devices
        '';
      };
    };

    ############################
    # PATH extension
    ############################
    sessionPath = [
      "$.local/bin"
    ];
  };
}
