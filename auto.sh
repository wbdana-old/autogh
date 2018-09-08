while getopts ":t:" opt; do
	case ${opt} in
		t )
			times=$OPTARG
		;;
		\? )
			echo "Invalid option: $OPTARG" 1>&2
		;;
		: )
			echo "Invalid option: $OPTARG requires an argument" 1>&2
		;;
	esac
done

check_if_int ()
{
	re='^[0-9]+$'
	if ! [[ $times =~ $re ]] ; then
		echo "Error: -t flag must be supplid with an integer">&2; exit 1
	fi
}


edit_and_commit ()
{
	touch datelog
	date=`date '+%Y.%m.%d - %H:%M:%S'`
	echo $date >> datelog
	cat datelog
	git status
	git add .
	git commit -m "${date} update"
}

if [ -z "$times" ]; then
	echo "First"
	edit_and_commit
else
	echo "Second $times"
	check_if_int
	for i in {1..$times}; do
		edit_and_commit
	done
fi

git push origin master
echo "Finished"
