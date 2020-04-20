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
1. Create a remote state for your local `terraform` service here: https://github.com/1Mill/terraform-create-remote-state
1. Update `terraform/state.tf` with your remote state information
1. Update the `.env` file with your AWS information
1. Run `docker-compose build`
1. Run `docker-compose run terrafrom sh` to enter the `terraform` service
1. Inside the `terraform` service, run `terrafrom init && terraform apply`
1. When prompted, enter `yes` to create the listed resources on AWS
1. Run `terraform destroy` to teardown all created services
