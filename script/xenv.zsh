# Setup for pyenv
# Set system python to the one from brew
[ -r ~/.pyenv ] && export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"
[ -r ~/.pyenv ] && eval "$(pyenv init - --no-rehash)"
# [ -r ~/.pyenv ] && eval "$(pyenv virtualenv-init -)" # this command is optional

# Jenv
[ -r ~/.jenv ] && eval "$(jenv init -)"

# Nodenv
[ -r ~/.nodenv ] && eval "$(nodenv init -)"
