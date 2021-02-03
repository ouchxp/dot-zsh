##
# AWS Vault - Helper Functions
##
_av_auto_unset() {
    if [[ $1 = 'exec' ]] && [[ -n $AWS_VAULT ]]; then
        unset AWS_VAULT
    fi
    command aws-vault $@
}
