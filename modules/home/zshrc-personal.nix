{pkgs, ...}: {
  home.packages = with pkgs; [zsh];

  home.file."./.zshrc-personal".text = ''

    # This file allows you to define your own aliases, functions, etc
    # for Zsh. Below is a convenient shortcut to add, commit (with a
    # message), and push changes.

    #!/usr/bin/env zsh

    # Convenient shortcut to add, commit (with a message), and push changes
    gpush() {
      git add . && git commit -m "$1" && git push
    }

  '';
}
