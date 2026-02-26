{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = true;

      # Palette de couleurs Powerlevel10K
      # Bleu: #0087ff, Cyan: #00d7ff, Vert: #00ff00, Violet: #af00ff, Orange: #ff8700
      # Fond sombre: #1a1a1a, Texte clair: #ffffff, Gris: #808080

      # Format global avec séparateurs powerline
      format = "$os$directory$git_branch$git_status$fill$time$status$character";

      # OS Icon avec séparateur pointu
      os = {
        disabled = false;
        style = "bg:#1a1a1a fg:#ffffff";
        format = "[$symbol](bold $style)";
      };
      os.symbols = {
        Arch = "";
        Debian = "";
        Ubuntu = "";
        Fedora = "";
        NixOS = "";
        macOS = "";
        Windows = "";
      };

      # Directory avec fond bleu et séparateur
      directory = {
        style = "bg:#0087ff fg:#ffffff";
        format = "[$path ]($style)";
        truncation_length = 3;
        truncate_to_repo = false;
        truncation_symbol = "…/";
        read_only = " ";
        read_only_style = "bg:#0087ff fg:#ff0000";
      };
      directory.substitutions = {
        "Documents" = "";
        "Downloads" = "";
        "Music" = "";
        "Pictures" = "";
        "Videos" = "";
        "Projects" = "";
      };

      # Git branch avec fond violet
      git_branch = {
        style = "bg:#af00ff fg:#ffffff";
        format = "[ $branch ]($style)";
        symbol = "";
      };

      # Git status intégré au branch
      git_status = {
        style = "bg:#af00ff fg:#ffffff";
        format = "([$all_status$ahead_behind ]($style))";
        ahead = "";
        behind = "";
        diverged = "";
        up_to_date = "";
        untracked = "";
        staged = "";
        modified = "";
        renamed = "";
        deleted = "";
        conflicted = "";
      };

      # Fill (espace extensible)
      fill = {
        symbol = " ";
      };

      # Time avec fond sombre
      time = {
        disabled = false;
        style = "bg:#1a1a1a fg:#00d7ff";
        format = "[](bg:#1a1a1a fg:#0087ff)[$time]($style) ";
        time_format = "%H:%M:%S";
      };

      # Status (exit code) avec couleur dynamique
      status = {
        disabled = false;
        style = "bg:#1a1a1a fg:#00ff00";
        format = "[](bg:#1a1a1a fg:#00ff00)[$symbol$status](bold $style) ";
        symbol = "✔";
        success_symbol = "";
        not_executable_symbol = "✘";
        not_found_symbol = "✘";
        sigint_symbol = "✘";
        signal_symbol = "✘";
      };
      status.success_symbol = {
        style = "bg:#1a1a1a fg:#00ff00";
      };
      status.error_symbol = {
        style = "bg:#1a1a1a fg:#ff0000";
      };

      # Command duration
      cmd_duration = {
        disabled = false;
        style = "bg:#1a1a1a fg:#ff8700";
        format = "[⏱ $duration]($style) ";
        min_time = 3000;
        show_milliseconds = false;
      };

      # Character (prompt symbol) style Powerlevel10K
      character = {
        success_symbol = "[➜](bold fg:#00ff00) ";
        error_symbol = "[➜](bold fg:#ff0000) ";
        vimcmd_symbol = "[❮](bold fg:#00d7ff) ";
        vimcmd_replace_one_symbol = "[▶](bold fg:#00d7ff) ";
        vimcmd_replace_symbol = "[▶](bold fg:#00d7ff) ";
        vimcmd_visual_symbol = "[V](bold fg:#00d7ff) ";
      };

      # Modules désactivés par défaut (activer si besoin)
      python.disabled = true;
      golang.disabled = true;
      rust.disabled = true;
      nodejs.disabled = true;
      ruby.disabled = true;
      java.disabled = true;
      php.disabled = true;
      lua.disabled = true;
      perl.disabled = true;
      kubernetes.disabled = true;
      terraform.disabled = true;
      aws.disabled = true;
      gcloud.disabled = true;
      azure.disabled = true;
      nix_shell.disabled = true;
      todo.disabled = true;
      timewarrior.disabled = true;
      taskwarrior.disabled = true;
      background_jobs.disabled = true;
      direnv.disabled = true;
      asdf.disabled = true;

      # Line break
      line_break = {
        disabled = false;
      };
    };
  };
}
