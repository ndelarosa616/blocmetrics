require 'faker'

# Create Users
5.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10)
    )
  user.skip_confirmation!
  user.save!
end
users = User.all

# Create an example user
user = User.new(
  name: 'Nicole De La Rosa',
  email: 'nicoledelarosa616@gmail.com',
  password: 'monkey324'
  )
user.skip_confirmation!
user.save!

# Create registered applications
registered_application = RegisteredApplication.create!(
  user: user,
  name: 'Registered Application',
  url: 'https://nicole-blocitoff.herokuapp.com/'
  )
registered_application.save!

5.times do
  registered_application = RegisteredApplication.create!(
    user: user,
    name: Faker::App.name,
    url: Faker::Internet.url
    )
end
registered_applications = RegisteredApplication.all

# Create events
application_event = Event.create!(
  registered_application: registered_application,
  name: 'view'
  )
application_event.save!

50.times do
  event = Event.create!(
    registered_application: registered_applications.sample,
    name: Faker::Hacker.verb
    )
end
events = Event.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{RegisteredApplication.count} applications created"
puts "#{Event.count} events created"