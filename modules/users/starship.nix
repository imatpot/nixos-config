{ outputs, ... }:

{
  imports = [
    ./fonts.nix # Make sure Nerd Fonts are installed
  ];

  programs.starship = {
    enable = true;

    settings = {
      format = outputs.lib.concatStrings [
        "($username(@$hostname) )"
        "($directory)"
        "( $git_branch)"
        "( $git_commit)"
        "( $git_state)"
        "( $git_status)"
        "( $package)" # TODO: Doesn't seem to work on Darwin?
        "( $character)"
      ];

      right_format = outputs.lib.concatStrings [
        "( $nix_shell)"
        "( $shlvl)"
        "( $cmd_duration)"
      ];

      username = {
        format = "[$user]($style)";
        style_root = "bold red";
        style_user = "bold green";
      };

      hostname = {
        format = "[$hostname]($style)";
        ssh_symbol = "ssh:";
        style = "bold green";
      };

      directory = {
        format = "[$path]($style)[$read_only]($read_only_style)";
        read_only = ":ro";
        style = "bold yellow";
        read_only_style = "bold red";
      };

      git_branch = {
        format = "[$symbol$branch]($style)";
        style = "bold blue";
        symbol = "git:";
      };

      git_commit = {
        format = "[commmit:$hash( $tag)]($style)";
        tag_symbol = "tag:";
        style = "bold blue";
        tag_disabled = false;
      };

      git_state = {
        format = "[($state( $progress_current/$progress_total))]($style)";
        style = "bold cyan";
      };

      git_status = {
        ahead = "↑";
        behind = "↓";
        conflicted = "ϟ";
        deleted = "×";
        diverged = "↕";
        format = "[(\\($all_status$ahead_behind\\))]($style)";
        modified = "*";
        renamed = ">";
        staged = "+";
        stashed = "S";
        untracked = ":";
        up_to_date = "";
        style = "bold purple";
      };

      package = {
        format = "[$version]($style)";
        style = "bold white";
      };

      nix_shell = {
        format = "[$symbol( $name)](bold blue)( [\\($state\\)](bold purple))";
        symbol = " ";
        heuristic = true; # Adds experimental support for `nix shell`
      };

      shlvl = {
        disabled = false;
        format = "$symbol[$shlvl]($style)";
        symbol = "󰧾 ";
        style = "yellow";
      };

      cmd_duration = {
        format = "[took ](dimmed white)[$duration](dimmed yellow)";
        min_time = 3000;
      };

      character = {
        error_symbol = "[«](red)";
        success_symbol = "»";
      };
    };
  };
}
