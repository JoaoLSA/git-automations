for var in "$@"
do
	if [ ! -z "$var" ] # check if branch name is present
	then
		targetBranch=$var
		currentBranch=$(git symbolic-ref --short -q HEAD)
		git add .
		
		git push origin $currentBranch

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
echo "Process finished with success"
echo "This window will automatically close in 5 seconds..."
sleep 5s
exit
