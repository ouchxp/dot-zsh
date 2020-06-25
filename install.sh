git clone https://github.com/zplug/zplug.git ~/.zplug
if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc.backup
fi
if [ -f ~/.zshenv ]; then
    mv ~/.zshenv ~/.zshenv.backup
fi
if [ ! -f ~/.z ]; then
    touch ~/.z
fi
ln -s ~/.zsh/.zshrc ~/.zshrc
ln -s ~/.zsh/.zshenv ~/.zshenv
ln -s ~/.zsh/.hushlogin ~/.hushlogin

# Vim
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_basic_vimrc.sh

# KeyBindings
cat << EOF > ~/Library/KeyBindings/DefaultKeyBinding.dict
{
    "\UF729"  = "moveToBeginningOfLine:";
    "\UF72B"  = "moveToEndOfLine:";
    "$\UF729" = "moveToBeginningOfLineAndModifySelection:";
    "$\UF72B" = "moveToEndOfLineAndModifySelection:";
}
EOF
