currentBranch=$(git symbolic-ref --short -q HEAD)

git add .

git checkout stage

git pull origin stage

git merge $currentBranch

if [ ! $? -eq 0 ]; then
    echo "\nResolve conflicts and push..."
else
	git commit -m "Merge with $currentBranch"

	git push origin stage
fi
read # Make pause to read script output
