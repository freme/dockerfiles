#!/bin/sh

whoami
sudo chown -R frab:frab /home/frab
# Switch to app dir
cd /home/frab

# Remove old symlinks
if [ -h /home/frab/config/initializers/secret_token.rb ]; then
    rm /home/frab/config/initializers/secret_token.rb
fi

if [ -h /home/frab/config/database.yml ]; then
    rm /home/frab/config/database.yml
fi

if [ -h /home/frab/config/settings.yml ]; then
    rm /home/frab/config/settings.yml
fi

# public is mounted from outside, so we may need to copy original content back
if [ ! -f /home/frab/public/system/attachments/.htaccess ]; then
  cp -a public_saved/* public/
fi

# make sure only one .env exists
rm -f .env.development .env.production .env.test
cp public/.env ./
ln -s .env .env.production

#sudo apt-get install -y sendmail
#sed -i '66i config.action_mailer.delivery_method = :sendmail' config/environments/production.rb

#precompile assets
RAILS_ENV=production bundle exec rake assets:precompile

#db setup if firsttime start
if [ ! -f /home/frab/public/installed ]; then
    echo "#######################"
    echo "# setting up database #"
    echo "#######################"
    RAILS_ENV=production bundle exec rake db:setup ; touch /home/frab/public/installed
fi

# migrate db on container start
RAILS_ENV=production bundle exec rake db:migrate

#run (now handled by nginx)
#RAILS_ENV=production bundle exec rails s -p 3000 -b 0.0.0.0

# for testing only
#RAILS_ENV=production bundle exec rake frab:add_fake_data

sudo /opt/nginx/sbin/nginx -t

echo "http://localhost"
echo "user: admin@example.org"
echo "pass: test123"

sudo /opt/nginx/sbin/nginx

