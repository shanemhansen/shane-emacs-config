Shane's emacs config

Mostly centered around go development.
TO install:

1. Run emacs24. On recent debian apt-get install emacs24-nox, on OSX brew install emacs --HEAD --use-git-head --cocoa --srgb
2. Clone repo to $HOME/.local/shane-emacs-config (or somewhere else)
3. Symlink my .emacs (this assumes you're an emacs novice, if you're not, copy the stuff you like)
ln -s $HOME/.local/shane-emacs-config/.emacs $HOME/.emacs
4. Symlink in the gobuild script to your PATH. My favorite method:
   4.1 chown /usr/local to your user.
   4.2  ln -s $HOME/.local/shane-emacs-config/gobuild /usr/local/bin/gobuild
