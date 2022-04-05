/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Tools
brew install zsh
brew install trash
brew install vim
brew install watch
brew install ncdu
brew install fzf
brew install exa
brew install jq
brew install rg
brew install bat
brew install terminal-notifier
brew install fig

# Git
brew install git
brew install tig
brew install diff-so-fancy
brew install gnupg
brew install pinentry-mac

# Node
brew tap nodenv/nodenv
brew install yarn
brew install nodenv
brew install nodenv-nvmrc

# Misc
brew install awscli
brew install sbt
brew install jenv
mkdir -p ~/.jenv/versions
brew install direnv

# Casks
brew tap homebrew/cask-versions
brew tap homebrew/cask-drivers
brew install hammerspoon --cask
brew install linearmouse --cask
brew install zulu8 --cask
brew install visual-studio-code --cask
brew install slack --cask
brew install docker --cask
brew install jetbrains-toolbox --cask
brew install 1password --cask
brew install iterm2 --cask
brew install alfred --cask
brew install bartender --cask
brew install google-chrome --cask
brew install firefox --cask
