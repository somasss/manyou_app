user = User.new(:name => "seed",:email => 'first@email.com', :password => 'seedseed', :admin => false)
user.save!
%W[デイリー ウィークリー マンスリー].each { |a| Label.create(name: a) }