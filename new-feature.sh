newFeatureCode=$1
newFeatureDescription=$2

if [ ! -z $1 ]
then
	if [[ ! $1 =~ ^PROD-[0-9] ]]; then
		echo "Invalid feature code. Valid code is: PROD-123"
		echo ""
		echo "Press enter to exit..."
		read
		exit
	fi
	git add .
	git checkout master
	git pull origin master
	branchName=feature/$newFeatureCode/$newFeatureDescription
	git checkout -b $branchName
else
	echo "You need to supply a code for the new feature (PROD-XXX)"
fi
read