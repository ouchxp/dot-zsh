/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

eval "$(/opt/homebrew/bin/brew shellenv)"

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
brew install startship
brew tap kaplanelad/tap && brew install shellfirm
# brew install fig

# Git
brew install git
brew install tig
brew install diff-so-fancy
brew install gnupg
brew install pinentry-mac
echo "pinentry-program $(which pinentry-mac)" >> ~/.gnupg/gpg-agent.conf
killall gpg-agent

# Node
brew install yarn
brew install nodenv
brew install nodenv/nodenv/nodenv-nvmrc

# Misc
brew install awscli
brew install sbt
brew install pyenv
brew install jenv
mkdir -p ~/.jenv/versions
brew install direnv

# Casks
brew tap homebrew/cask-versions
brew tap homebrew/cask-drivers
brew install hammerspoon --cask
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
