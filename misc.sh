/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew tap homebrew/cask-drivers
brew install zsh
brew install git
brew install yarn
brew cask install hammerspoon
brew cask install steelseries-exactmouse-tool

touch ~/.hushlogin
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_basic_vimrc.sh
cat << EOF > ~/Library/KeyBindings/DefaultKeyBinding.dict
{
    "\UF729"  = "moveToBeginningOfLine:";
    "\UF72B"  = "moveToEndOfLine:";
    "$\UF729" = "moveToBeginningOfLineAndModifySelection:";
    "$\UF72B" = "moveToEndOfLineAndModifySelection:";
}
EOF
