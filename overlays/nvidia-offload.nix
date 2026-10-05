final: prev: {
  nvidiaOffload = pkg: final.symlinkJoin {
    name = "${pkg.name or "package"}-nvidia-offload";
    paths = [ pkg ];
    buildInputs = [ final.makeWrapper ];
    postBuild = ''
      if [ -d "$out/bin" ]; then
        for file in $out/bin/*; do
          if [ -L "$file" ]; then
            target=$(readlink -f "$file")
            rm "$file"
            makeWrapper "$target" "$file" \
              --set __NV_PRIME_RENDER_OFFLOAD 1 \
              --set __NV_PRIME_RENDER_OFFLOAD_PROVIDER NVIDIA-G0 \
              --set __GLX_VENDOR_LIBRARY_NAME nvidia \
              --set __VK_LAYER_NV_optimus NVIDIA_only
          fi
        done
      fi

      if [ -d "$out/share/applications" ]; then
        rm -rf "$out/share/applications"
        mkdir -p "$out/share/applications"
        for desktop in ${pkg}/share/applications/*.desktop; do
          if [ -f "$desktop" ]; then
            sed -E "s|^Exec=(\S*/)?(\S+)|Exec=$out/bin/\2|" "$desktop" > "$out/share/applications/$(basename "$desktop")"
            if ! grep -q "PrefersNonDefaultGPU" "$out/share/applications/$(basename "$desktop")"; then
              echo "PrefersNonDefaultGPU=true" >> "$out/share/applications/$(basename "$desktop")"
            fi
          fi
        done
      fi
    '';
  };
}
