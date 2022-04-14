currentBranch=$(git symbolic-ref --short -q HEAD)

git add .

git checkout develop

git pull origin develop

git merge $currentBranch

if [ ! $? -eq 0 ]; then
    echo "\nResolve conflicts and push..."
else
	git commit -m "Merge with $currentBranch"

	git push origin develop
fi
read # Make pause to read script output

