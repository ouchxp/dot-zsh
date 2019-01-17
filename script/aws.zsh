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
