f="helloWorld"
bucket="graphql-playground"
trigger="--trigger-http"
gf="hello-graphql"

if [[ $1 -eq "dev" ]]; then
	# In dev mode, make sure that the functions local server is running, and then deploy the function
	if ! [[ $(ps -ax | grep functions-emulator | wc -l) -eq 2 ]]; then 
		echo "Starting the Google Cloud functions server"
		functions start
	fi

	echo "Deploying function '$f'"
	functions deploy $f $trigger
else
	# In non-dev mode, publish the function to GCP
	gcloud beta functions deploy $gf --stage-bucket $bucket $trigger --entry-point $f
fi