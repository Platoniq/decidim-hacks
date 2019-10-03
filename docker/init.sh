#!/bin/bash
pwd
bundle install
echo -e "\e[33m Upgrading Decidim..."
bin/rails decidim:upgrade

echo -e "\e[33m Trying to execute migrations..."
if bin/rails db:migrate; then
    echo -e "\e[32m Database already created. No need for seeding."
else
    echo -e "\e[31m Migration failed. Installing database"
    bin/rails db:create
    echo -e "\e[33m Executing migrations..."
    bin/rails db:migrate
    echo -e "\e[32m Database just created so let's seed some data..."
    bin/rails db:seed
fi
echo -e "\e[33m Seeding hacks content..."
bin/rails db:seed:hacks

echo -e "\e[33m Starting rails server..."
bundle exec puma
# bundle exec rails server