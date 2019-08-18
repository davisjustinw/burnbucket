require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use MomentController
use BucketListController
use BucketController
use JournalController
use UserController
run ApplicationController
