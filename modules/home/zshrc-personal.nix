{
  home.file.".zshrc-personal".text = ''
    gpush() {
      git add . && git commit -m "$1" && git push
    }
  '';
}
