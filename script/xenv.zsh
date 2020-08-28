# pyenv
[ -r ~/.pyenv ] && export PATH="/usr/local/opt/python/libexec/bin:$PATH" || true
export PATH="$PYENV_ROOT/bin:$PATH"
[ -r ~/.pyenv ] && eval "$(pyenv init - --no-rehash)" || true
# [ -r ~/.pyenv ] && eval "$(pyenv virtualenv-init -)" # this command is optional

# jenv, Graal will provide a node and npm binary, but we do not want that
[ -r ~/.jenv ] \
    && eval "$(jenv init --no-rehash -)" \
    && [ -f ~/.jenv/shims/node ] \
    && /bin/rm ~/.jenv/shims/node \
    && /bin/rm ~/.jenv/shims/npm || true

# nodenv
export PATH="$HOME/.nodenv/bin:$PATH"
[ -r ~/.nodenv ] && eval "$(nodenv init -)" || true

# rbenv
[ -r ~/.rbenv ] && eval "$(rbenv init -)" || true

# nix
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# direnv
command -v direnv &> /dev/null && eval "$(direnv hook zsh)"
