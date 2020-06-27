mkdir ~/.zinit
git clone https://github.com/zdharma/zinit.git ~/.zinit/bin

autoload -U compaudit
compaudit | xargs chmod g-w

# dotfiles
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
ln -s ~/.zsh/.huskyrc ~/.huskyrc
ln -s ~/.zsh/.bat.conf ~/.bat.conf
ln -s ~/.zsh/.global_gitignore ~/.gitignore
git config --global core.excludesfile "~/.gitignore"

# Vim
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_basic_vimrc.sh

# KeyBindings
mkdir -p ~/Library/KeyBindings
ln -s ~/.zsh/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict
