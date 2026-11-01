{host, ...}: let
  vars = import ../../hosts/${host}/variables.nix;
  inherit
    (vars)
    barChoice
    tmuxEnable
    waybarChoice
    vscodeEnable
    helixEnable
    doomEmacsEnable
    ;
  # pythonEnable is optional in host variables; default to enabled when absent
  pythonEnabled = if vars ? pythonEnable then vars.pythonEnable else true;
  # Select bar module based on barChoice
  barModule =
    if barChoice == "noctalia"
    then ./noctalia.nix
    else waybarChoice;
in {
  imports =
    [
      ./bash.nix
      ./bashrc-personal.nix
      ./overview.nix
      ./cli/bat.nix
      ./cli/btop.nix
      ./cli/cava.nix
      ./cli/ghee.nix
      ./emoji.nix
      ./eza.nix
      ./fastfetch
      ./cli/fzf.nix
      ./cli/gh.nix
      ./cli/git.nix
      ./gtk.nix
      ./cli/htop.nix
      ./hyprland
      ./terminals/kitty.nix
      ./cli/lazygit.nix
      ./editors/nixvim.nix
      ./editors/nano.nix
      ./rofi
      ./qt.nix
      ./scripts
      ./stylix.nix
      ./swappy.nix
      ./swaync.nix
      ./tealdeer.nix
      ./virtmanager.nix
      barModule
      ./wlogout
      ./xdg.nix
      ./zoxide.nix
      ./zsh
    ]
    ++ (
      if pythonEnabled
      then [./python.nix]
      else []
    )
    ++ (
      if helixEnable
      then [./editors/evil-helix.nix]
      else []
    )
    ++ (
      if vscodeEnable
      then [./editors/vscode.nix]
      else []
    )
    ++ (
      if doomEmacsEnable
      then [
        ./editors/doom-emacs-install.nix
        ./editors/doom-emacs.nix
      ]
      else []
    )
    ++ (
      if tmuxEnable
      then [./terminals/tmux.nix]
      else []
    );
}
