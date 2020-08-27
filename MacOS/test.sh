query=$1

echo $query
build="b"
deployment="d"
if [ $# -eq 0 ]; then
    echo "please input your command after hugo"
elif [ "$query" == "$build" ] || [ "$query" == "$deployment" ];then
    cd /Users/fusidic/Documents/work/com.hugo.fusidic/
    ./build.sh
    if [ "$query" == "deployment" ];then
        exec ./deployment.sh
        wait
        open /Users/fusidic/Documents/work/com.hugo.fusidic/content/posts
    fi
fi
