# Add Your Git Repository To Whanos Instance

## Table of content
- [SSH Requiest](#ssh-requiest)
- [Create Your Project](#create-your-project)

## SSH Requiest
Before creating a project, you must add your private SSH key to the Jenkins instance by creating a corresponding credential for it. This will allow Jenkins to access the repositories specified in the jobs, provided the necessary permissions to the repositories are granted.

To do this, navigate to the `Dashboard` and go to the `Manage Jenkins` tab. Scroll down to the `Security` section and click on `Credentials`.

You should see something like this:
![Credentials Jenkins](./assets/JenkinsCredentials.png)

Then click on `System` -> `Global credentials (unrestricted)` -> `+ Add Credentials`.

Once on the page, select `SSH Username with private key` as the `Kind` and fill in the following fields:  

- **ID**: The identifier for the credential, which will be required when creating a job.  
- **Description**: A descriptive name (optional, for your reference).  
- **Username**: Your Git username.  
- **Treat username as secret**: Ensure this box is checked.  
- **Private Key**: Select `Enter directly`, click `Add`, and paste your private SSH key.  
- **Passphrase**: If your key is protected by a passphrase, enter it here.  

Finally, click **Create** to save the credential.

## Create Your Project
