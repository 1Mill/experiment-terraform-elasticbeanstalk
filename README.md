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
1. Update the `.env` file with your AWS information
1. Create a remote state for your local `terraform` service here: https://github.com/1Mill/terraform-create-remote-state
1. Update `terraform/state.tf` with your remote state information
1. Run `docker-compose up --build terrafrom` to build all resources on AWS
1. Run `docker-comopse up --build aws` to publish a new version of `app` service to AWS S3.
1. Update `.env` files with your published version of `app`
1. Run `docker-compse up --build terraform` to publish the `app` to to AWS
1. Run `docker-compse run terraform sh` and then `terraform init && terraform destroy -auto-approve` to destroy all created resources
