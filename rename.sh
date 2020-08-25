path=/home/s3lab-1/文档/交行
dirs=$(ls $path)
for dir in $dirs
do
	person=$path/$dir
	files=$(ls $person)

	file1=`echo ${files[0]} | awk '{print $1}'`
	file2=`echo ${files[0]} | awk '{print $2}'`
	file3=`echo ${files[0]} | awk '{print $3}'`
	mv $person/$file1 $person/附件一
	mv $person/$file3 $person/附件二
	mv $person/$file2 $person/附件三

done

