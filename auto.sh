touch datelog
date=`date '+%Y.%m.%d - %H:%M:%S'`
echo $date >> datelog
cat datelog
git status
git add .
git commit -m "${date} update"
git push origin master
