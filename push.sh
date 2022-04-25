targetBranch=$1

if [ ! -z "$1" ] # check if the commit message is present
then
	currentBranch=$(git symbolic-ref --short -q HEAD)
	git add .

	git checkout $targetBranch

	git pull origin $targetBranch

	git merge $currentBranch

	if [ ! $? -eq 0 ]; then
		echo "\nResolve conflicts and push..."
	else
		git commit -m "Merge with $currentBranch"

		git push origin $targetBranch
		
		git checkout $currentBranch
	fi
else
	echo "InputError: Target branch was not provided"
fi
	read # Make pause to read script output