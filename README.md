# TerraformFun
Using Terraform to Automate Cloud Deployment of multiple enviornments. 

This project is a set of [modules](https://www.terraform.io/docs/modules/index.html) and custom/third-party provider scripts for [Terraform](https://www.terraform.io/) which tries to automate creating resilient, disposable, secure, and agile infastructure for Red Teams.  I personally, am using the project for the sake of spinning up GoPhish servers in order to expediate the setup process of performing Social Engineering.  

### Author and Acknowledgments
The bulk of this project and inspiration came from byt3bl33d3r.  I have taken the premise and ran with it to help setup of certain infrastructure needs.  
Author: Marcello Salvati ([@byt3bl33d3r](https://twitter.com/byt3bl33d3r))

### Setup

Installing Terraform
To install Terraform, find the appropriate package for your system and download it. Terraform is packaged as a zip archive.

After downloading Terraform, unzip the package. Terraform runs as a single binary named terraform. Any other files in the package can be safely removed and Terraform will still function.

The final step is to make sure that the terraform binary is available on the PATH. See this page for instructions on setting the PATH on Linux and Mac. This page contains instructions for setting the PATH on Windows.

Verifying the Installation
After installing Terraform, verify the installation worked by opening a new terminal session and checking that terraform is available. By executing terraform you should see help output similar to this:

```
$ terraform
Usage: terraform [--version] [--help] <command> [args]
```

The available commands for execution are listed below.
The most common, useful commands are shown first, followed by
less common or more advanced commands. If you're just getting
started with Terraform, stick with the common commands. For the
other commands, please read the help and docs before usage.

```
Common commands:
    apply              Builds or changes infrastructure
    console            Interactive console for Terraform interpolations
```
    
If you get an error that terraform could not be found, your PATH environment variable was not set up properly. Please go back and ensure that your PATH variable contains the directory where Terraform was installed.

**Red Baron only supports Terraform version 0.11.0 or newer and will only work on Linux x64 systems.** 

**Linode Provider is only supported for Terraform 0.11.0. >= 0.12.0 is not supported. **


```
#~ git clone https://github.com/byt3bl33d3r/Red-Baron && cd Red-Baron
#~ export AWS_ACCESS_KEY_ID="accesskey"
#~ export AWS_SECRET_ACCESS_KEY="secretkey"
#~ export AWS_DEFAULT_REGION="us-east-1"
#~ export LINODE_API_KEY="apikey"
#~ export DIGITALOCEAN_TOKEN="token"
#~ export GODADDY_API_KEY="gdkey"
#~ export GODADDY_API_SECRET="gdsecret"
#~ export ARM_SUBSCRIPTION_ID="azure_subscription_id"
#~ export ARM_CLIENT_ID="azure_app_id"
#~ export ARM_CLIENT_SECRET="azure_app_password"
#~ export ARM_TENANT_ID="azure_tenant_id"

# For Google Cloud Compute see https://www.terraform.io/docs/providers/google/index.html#configuration-reference 
# and set the appropriate environment variable for your use case

# copy an infrastructure configuration file from the examples folder to the root directory and modify it to your needs
#~ cp examples/kali.tf .

#~ terraform init
#~ terraform plan
#~ terraform apply
```

### License
This fork of the original Red Baron repository is licensed under the GNU General Public License v3.0.
