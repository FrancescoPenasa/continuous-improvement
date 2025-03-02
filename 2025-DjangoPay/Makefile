.PHONY: migrations
migrations:
	python manage.py makemigrations

.PHONY: migrate
migrate:
	python manage.py migrate

.PHONY: run-server
run-server:
	python manage.py runserver 8000

.PHONY: update
update: migrations migrate ;