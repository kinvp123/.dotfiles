{config, pkgs, ...}:
{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initExtra = "
      source ~/.p10k.zsh
      export GTK_IM_MODULE=ibus
      export XMODIFIERS=@im=ibus
      export QT_IM_MODULE=ibus
      ";
      
      zplug = {
        enable = true;
        plugins = [
          {name = "romkatv/powerlevel10k"; tags = [as:theme depth:1];}
        ];
      };

      shellAliases = {
        nixsw = "sudo nixos-rebuild switch --flake $HOME/.dotfiles/";
        homeimsw = "NIXPKGS_ALLOW_UNFREE=1 home-manager switch --flake $HOME/.dotfiles/ --impure";
        # Putting homeimsw as an emergency switch.
        homesw = "home-manager switch --flake $HOME/.dotfiles/";
        clear = "clear && pfetch";
        };
    };
    kitty = {
      enable = true;
      catppuccin.enable = true;
      shellIntegration.enableZshIntegration = true;
      settings = {
        confirm_os_window_close = 0;
        background_opacity = "0.85";
        background_blur = 1;
      };
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
      catppuccin.enable = true;
    };
    ranger = {
      enable = true;
    };
  };
}