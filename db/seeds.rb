10.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(:name => name,
               :email => email,
               :password => password,
               :admin => false,
               )
end
10.times do |t|
  name = Faker::Games::Pokemon.name
  password = "password"
  Task.create!(:name => name,
               :detail => name,
               :importance => 0,
               :user_id => 2,
               )
end
%W[a b c d e f g h i j k].each { |a| Label.create(name: a) }