pull () {
	git pull origin $1
	
	if [ ! $? -eq 0 ]; then
		echo "\nResolve conflicts and press Enter to continue..."
		read
	fi
}

merge () {
	git merge $1
	
	if [ ! $? -eq 0 ]; then
		echo "\nResolve conflicts and press Enter to continue..."
		read
	fi
}

currentBranch=$(git symbolic-ref --short -q HEAD)
git add .

pull $currentBranch

pull master

git push origin $currentBranch

for var in "$@"
do
	if [ ! -z "$var" ] # check if branch name is present
	then
		targetBranch=$var

		git checkout $targetBranch

		pull $targetBranch
		
		pull master
		
		merge $currentBranch

		git commit -m "Merge with $currentBranch"
		
		dotnet test
		
		if [ ! $? -eq 0 ]; then
			echo "\nTEST SUIT FAILED"
			git checkout $currentBranch
			read
			exit
		fi

		git push origin $targetBranch
		
		git checkout $currentBranch
		echo "\nPUSH FINISHED WITH SUCCESS. PRESS ENTER TO CONTINUE"
		read
	
	else
		echo "InputError: Target branch was not provided"
	fi
done
echo "Process finished with success"
echo "This window will automatically close in 5 seconds..."
sleep 5s
exit
