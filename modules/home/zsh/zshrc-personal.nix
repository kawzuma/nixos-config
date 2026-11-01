{
  home.file.".zshrc-personal".text = ''
    # All-in-one git push helper: gpush "commit message"
    gpush() {
      local msg="''${1:-update configuration}"
      git add -A
      git commit -m "$msg"
      git push origin main
    }
  '';
}
