# query=$1
# cd /Users/fusidic/Documents/work/com.hugo.fusidic
# if [ "$query" = "b" ] || [ "$query" = "d" ];then
#     path='/Users/fusidic/Documents/notes/'
#     files=$(ls $path)
#     for filename in $files
#     do
#         if [ ! -f "./content/posts/${filename}" ]
#         then
#             hugo new posts/${filename}
#         fi
#     done
    
#     rm -rf ./public
#     hugo -t pure
# fi

# if [ "$query" = "d" ];then
#         cd ./public

#         # git operations
#         git init
#         git add -A
#         msg="no message for this update"
#         # $#检查执行命令时所带参数个数是否为1,参数即为commit
#         if [ $# -eq 2 ]
#             then msg="$2"
#         fi
#         git commit -m "$msg"

#         git push -f git@github.com:fusidic/fusidic.github.io.git master

# fi

# I QUIT
open -a /Applications/iTerm.app /Users/fusidic/Documents/work/com.hugo.fusidic/
open //Users/fusidic/Documents/work/com.hugo.fusidic/content/posts
