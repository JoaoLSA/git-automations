for var in "$@"
do
	if [ ! -z "$var" ] # check if branch name is present
	then
		targetBranch=$var
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
done
read # Make pause to read script output
