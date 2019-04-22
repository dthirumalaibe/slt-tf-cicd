[![Build Status](
https://travis-ci.org/nickrusso42518/slt-tf-cicd.svg?branch=master)](
https://travis-ci.org/nickrusso42518/slt-tf-cicd)

# Safari Live Training - Terraform for Network CI/CD in AWS

Source code for the training course. Please contact me with any questions.
Basic knowledge on the following topics is encouraged:
  * General Continuous Integration/Continuous Delivery (CI/CD) concepts
  * `git` and Github
  * Travis CI
  * Ansible for networks (e.g. `network_cli`, `ios_config`)

For this course, only Linux platforms should be used for the
development machine.

> Contact information:\
> Email:    njrusmc@gmail.com\
> Twitter:  @nickrusso42518

  * [Download Instructions](#download-instructions)
  * [Usage](#usage)

## Download Instructions
The easiest way to consume this code is to clone it using SSH or HTTPS.

SSH: `git clone git@github.com:nickrusso42518/slt-tf-cicd`

or

HTTPS: `git clone https://github.com/nickrusso42518/slt-tf-cicd`

After cloning, you should see the following file system structure. The
structure is similar to the `slt-netdevops` repository except adds
the `aws/` directory and several Terraform (`.tf`) files.

```
$ tree
.
├── ansible.cfg
├── aws
│   ├── dns.tf
│   ├── instance.tf
│   └── setup.sh
├── hosts.yml
├── LICENSE
├── ntp_config.yml
├── README.md
├── requirements.txt
└── test.yml
```

Ensure you have Python 3.6 installed along with pip. Feel
free to use Python `virtualenv` if you'd like to test multiple versions.

> Visit https://www.python.org/downloads/ to download Python.

`sudo python -m ensurepip`

or

`sudo easy_install pip`

You can install the required packages (Ansible, Terraform, a few other minor
components) using the following command:

`pip install -r requirements.txt`

You should have access to the `ansible` and `terraform` commands
on the correct versions.

```
$ ansible --version | head -1
ansible 2.7.7

(ans27) [centos@devbox slt-tf-cicd]$ terraform --version
Terraform v0.11.11
+ provider.aws v2.7.0
```

## Usage
This repository is kept minimal since the main point of this course is
building on the fundamentals of "Network DevOps" by integrating Terraform
to dynamically setup and teardown a cloud test infrastructure. The steps
below provide an outline of what Travis CI does for users that want to
experiment with it manually.
  * After installing the packages, use `aws configure` to provide your
    programmatic IAM credentials and other basic information.
  * Use `aws sts get-caller-identity` to ensure the AWS API access works.
  * Make appropriate edits to the `.tf` Terraform plan files in the `aws/`
    directory to suit your specific environment. In most cases, this is
    limited to the `variable` stanzas.
  * Use the following Terraform commands to interact with AWS:
    * `terraform init aws/`: Download any `provider` plugins needed (AWS, etc.)
    * `terraform apply aws/`: Idempotently create architecture into AWS
    * `terraform destroy aws/`: Idempotently remove architecture from AWS
  * Once the architecture is created, run `ansible-playbook test.yml` from
    the shell.
