PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
query=$1

if [ "$query" = "s" ];then
    cd /Users/fusidic/Documents/work/hexo/fusidic
    hexo s
    open /Applications/Safari.app http://localhost:4000
fi

# Exit node server
if [ "$query" = "e" ];then
    lsof -P | grep ':4000' | awk '{print $2}' | xargs kill -9
fi

if [ "$query" = "b" ] || [ "$query" = "d" ];then
    # 检查/Users/fusidic/Documents/notes文件夹的新文件，并加入hugo中
    path='/Users/fusidic/Documents/notes/'
    # path='/Users/fusidic/Documents/work/com.hugo.fusidic/content/posts/'
    files=$(ls $path)
    cd /Users/fusidic/Documents/work/hexo/fusidic/
    ls
    for filename in $files
    do
        if [ ! -f "/Users/fusidic/Documents/work/hexo/fusidic/source/_posts/${filename}" ]
        then
            # echo "add ${filename} to hugo"
            # echo "add ${filename} to hexo"
            # hugo new posts/${filename}
            split=${filename%%.md}
            # echo $split
            hexo new ${split}
            cat ${path}${filename} >> /Users/fusidic/Documents/work/hexo/fusidic/source/_posts/${filename}
            open -a /Applications/Typora.app /Users/fusidic/Documents/work/hexo/fusidic/source/_posts/${filename}
        fi
    done
	open -a /Applications/iTerm.app /Users/fusidic/Documents/work/hexo/fusidic
fi


if [ "$query" = "d" ];then
    cd /Users/fusidic/Documents/work/hexo/fusidic
    hexo clean && hexo deploy
fi

# open //Users/fusidic/Documents/work/hexo/fusidic/source/_posts

# open -a /Applications/iTerm.app /Users/fusidic/Documents/work/hexo/fusidic

