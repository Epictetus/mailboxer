class Mailboxer::InstallGenerator < Rails::Generators::Base #:nodoc:
  include Rails::Generators::Migration
  source_root File.expand_path('../templates', __FILE__)
  require 'rails/generators/migration'

  def self.next_migration_number path
    unless @prev_migration_nr
    @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
    else
    @prev_migration_nr += 1
    end
    @prev_migration_nr.to_s
  end

  def create_initializer_file
    template 'initializer.rb', 'config/initializers/mailboxer.rb'
  end

  def copy_migrations
    migrations = [["20110511145103_create_mailboxer.rb","create_mailboxer.rb"],
                  ["20110719110700_add_notified_object.rb","add_notified_object.rb"],
                  ["20110912163911_add_notification_code.rb","add_notification_code.rb"],
                  ["20111204163911_add_attachments.rb","add_attachments.rb"]]
    migrations.each do |migration|
    #  begin
        migration_template "../../../../db/migrate/" + migration[0], "db/migrate/" + migration[1]
     # rescue
     #   puts "Another migration is already named '" + migration + "'. Moving to next one."
     # end
    end
  end
end