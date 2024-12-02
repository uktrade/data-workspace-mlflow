# data-workspace-mlflow

The Dockerfile that runs MLFlow for Data Workspace, as well as as a basic JWT-based authentication proxy in front of it.


## Deployment

A simple script [./deploy](deploy) is provided to deploy MLFlow for any team into any Data Workspace environment.

1. Install the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) if you don't have it already.

2. Make sure you have an AWS SSO profile setup for each of the account(s) being deployed to. A typical name for the profile would be `data-infrastructure-prod`. Ask the SRE team to find out how to do this.

3. Login to that account on the command line:

   ```bash
   AWS_PROFILE=data-infrastructure-prod aws sso login
   ```

4. Then to build the Docker image and deploy the ds team MLFlow instance in the prod environment in that account run:

   ```bash
   AWS_PROFILE=data-infrastructure-prod ./deploy prod ds
   ```
