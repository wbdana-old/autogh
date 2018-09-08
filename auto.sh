# Check for -t option and ensure it has an argument (times)
while getopts ":t:" opt; do
	case ${opt} in
		# Set -t argument to $times
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

# Use regex to check if $times is an integer
check_if_int ()
{
	re='^[0-9]+$'
	if ! [[ $times =~ $re ]] ; then
		echo "Error: -t flag must be supplied with an integer">&2; exit 1
	fi
}

# Keep logging those dates
edit_and_commit ()
{
	touch datelog
	date=`date '+%Y.%m.%d - %H:%M:%S'`
	echo $date >> datelog
	echo "datelog updated"
	git status
	# git add .
	git commit -am "${date} update"
}

# Do once if no -t flag
if [ -z "$times" ]; then
	edit_and_commit
# Or do $times times if $times is an integer
else
	check_if_int
	for ((i=1;i<=times;i++)); do
		edit_and_commit
	done
fi

git push origin master
echo "Finished"
