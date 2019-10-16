# Setup for pyenv
# Set system python to the one from brew
[ -r ~/.pyenv ] && export PATH="/usr/local/opt/python/libexec/bin:$PATH" || true
export PATH="$PYENV_ROOT/bin:$PATH"
[ -r ~/.pyenv ] && eval "$(pyenv init - --no-rehash)" || true
# [ -r ~/.pyenv ] && eval "$(pyenv virtualenv-init -)" # this command is optional

# Jenv, Graal will provide a node and npm binary, but we do not want that
[ -r ~/.jenv ] \
    && eval "$(jenv init --no-rehash -)" \
    && [ -f ~/.jenv/shims/node ] \
    && /bin/rm ~/.jenv/shims/node \
    && /bin/rm ~/.jenv/shims/npm || true

# Nodenv
[ -r ~/.nodenv ] && eval "$(nodenv init -)" || true

# Rubyenv
# [ -r ~/.rbenv ] && eval "$(rbenv init -)" || true
