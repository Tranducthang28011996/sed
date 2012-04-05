namespace :db do
  desc "Fill the database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    User.create!( :name => "Mark Holmberg",
                  :email => "mark.d.holmberg@gmail.com",
                  :password => "abc123",
                  :password_confirmation => "abc123" )
    #create the specified amount of users
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n}@example.com"
      password = "password"
      User.create!( :name => name,
                    :email => email,
                    :password => password,
                    :password_confirmation => password )
    end # end creating users
  end # end populate task
end
