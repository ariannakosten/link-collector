require './config/environment'  #require my environment file

if ActiveRecord::Migrator.needs_migration?  #reminder to run migrations
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride  #helps with patch/delete
use CategoriesController  #use the rest of the controllers
use LinksController
use UsersController
run ApplicationController  #main controller mount
