# Goal
1. Deploy a Ruby on Rails application to Elastic Beanstalk connected to an postgreSQL RDS instance

## Structure
  - src: Ruby on Rails application
    - Dockerfile
    - Other rails files
  - terraform: .tf files
    - Dockerfile
    - *tf files for Ruby on Rails and database
  - docker-comopse.yml
  - .env

# Articles
https://awsfeed.com/whats-new/compute/introducing-a-new-generation-of-aws-elastic-beanstalk-platforms/

# How to use this project
1. Install Docker
1. Update the `.env` file to reflect your AWS credentials and profile
1. Create a remote terraform state for your `terraform` service and update `terraform/state.tf`
    * https://github.com/1Mill/terraform-create-remote-state
1. Run `docker-compose build`
1. Run `docker-compose run terraform sh`
1. Run `terraform init && terraform apply -target=aws_s3_bucket.default -auto-approve`
    * This will create the S3 bucket in which our application is uploaded to
1. Run `exit` to leave the docker container
1. Run `docker-comopse up --build aws` to release a version of the application (found in `app` service)
1. Update the `.env` file to reflect your new release
    * Example: `APP_VERSION=2020-04-22_13-14-15`
1. Run `docker-compose up --build terraform` to build the AWS resources to deploy the application
    * Note: This takes some time to complete the first run
1. Make changes to the `app` service
1. To deploy your changes:
    1. Run `docker-compose up --build aws`
    1. Update `.env` with the new release version
    1. Run `docker-compse up --build terraform`
