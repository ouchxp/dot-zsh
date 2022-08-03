de64() {
    if [ -t 0 ]; then
        data=$1
    else
        data=$(cat)
    fi
    echo $data | base64 --decode
}

en64() {
    if [ -t 0 ]; then
        data=$1
    else
        data=$(cat)
    fi
    echo $data | base64
}