echo "Type your email address for ssh:"
read EMAIL_ADDRESS
ssh-keygen -t rsa -b 4096 -C "$EMAIL_ADDRESS"
eval "$(ssh-agent -s)"
cat <<EOF > ~/.ssh/config
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa
EOF
ssh-add -K ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub | pbcopy
echo "Public key copied!"
