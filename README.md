# Goal
1. Deploy a Ruby on Rails application to Elastic Beanstalk connected to an postgreSQL RDS instance

## Structure
  - src: Ruby on Rails application
    - Dockerfile
    - Other rails files
  - terraform: .tf files
    - Dockerfile
    - state: Remote state setup
    - *tf files for Ruby on Rails
  - docker-comopse.yml
  - docker-compse.tf.yml
  - .env
