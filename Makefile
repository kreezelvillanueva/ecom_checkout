.PHONY: help setup migrate seed build start stop delete status

default: help

help: ## Show help topics
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

setup: ## Setup  `web` environment and database
	@docker-compose build
	@docker-compose up -d
	@docker-compose exec web bundle install
	@docker-compose exec web bin/rails db:setup
	@docker-compose exec web yes | yarn install
	@docker-compose exec web yes | yarn build 

migrate: ## Run `web` database migrations
	@docker-compose run --rm web bundle exec rails db:migrate
	@docker-compose exec -e RAILS_ENV=test web bin/rails db:migrate

rollback: ## Rollback latest migration
	@docker-compose run --rm web bundle exec rails db:rollback

migrate-status: ## Show migration status
	@docker-compose run --rm web bundle exec rails db:migrate:status

build: ## Build `web` application container
	@docker-compose build

start: ## Start `web` application container
	@docker-compose up -d
	@docker-compose exec web yes | yarn build 

stop: ## Stop `web` application container
	@docker-compose stop

delete: ## Delete `web` application container
	@docker-compose down

status: ## Show `web` application container status
	@docker-compose ps

logs: ## Show `web` application container logs
	@docker-compose logs -f web

console: ## Open Rails console inside container
	@docker-compose run --rm web bundle exec rails console

rebuild: ## Rebuild `web` Stop, Build, Start application
	@docker-compose stop
	@docker-compose build
	@docker-compose up -d
	@docker-compose exec web yes | yarn build 

restart: ## Restart web and postgresql
	@docker-compose down
	@docker-compose up -d

bundle-install: ## Install gem dependencies
	@docker-compose exec web bundle install

yarn-build:
	@docker-compose exec web rm -rf app/assets/builds/*
	@docker-compose exec web yes | yarn build 

test:
	@docker-compose exec -e RAILS_ENV=test web bundle exec rspec

rubocop:
	@docker-compose exec web bundle exec rubocop