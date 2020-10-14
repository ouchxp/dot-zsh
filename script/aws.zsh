##
# AWS - Helper Functions
##
if [[ -f ~/.awsAliases ]]; then
    source ~/.awsAliases
    alias awsall="_awsListAll"
    alias awslp="_awsListProfile"
    alias awsp="_awsSwitchProfile"
    alias awswho="aws configure list"
fi

##
# AWS Vault - Helper Functions
##
_av_auto_unset() {
    if [[ $1 = 'exec' ]] && [[ -n $AWS_VAULT ]]; then
        unset AWS_VAULT
    fi
    aws-vault $@
}
