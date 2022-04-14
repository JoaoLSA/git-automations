message=$1 # Commit message parameter
currentBranch=$(git symbolic-ref --short -q HEAD)

if [ ! -z "$1" ] # check if the commit message is present
then
	git add .
	git commit -m "$message"
	git push origin $currentBranch
else
	echo "Commit message was not provided"
fi

read # Make pause to read script output