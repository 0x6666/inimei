# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name: 'Example User',
             email: 'example@railstutorial.org',
             password: 'foobar',
             password_confirmation: 'foobar',
             admin: true,
             activated: true,
             activated_at: Time.zone.now.to_datetime)

User.create!(name: 'YangSong',
             email: 'yangsongfwd@163.com',
             password: 'yangsong',
             password_confirmation: 'yangsong',
             admin: true,
             activated: true,
             activated_at: Time.zone.now.to_datetime)

99.times do |n|
  User.create!(name: Faker::Name.name,
               email: "example-#{n+1}@inimei.org",
               password: 'password',
               password_confirmation: 'password',
               activated: true,
               activated_at: Time.zone.now.to_datetime)
end

users = User.order(:created_at).take(6)

50.times do
  content = Faker::Lorem.sentence(5)
  users.each do |user|
    user.microposts.create!(content: content)
  end
end

# Following relationships
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

yangsong = User.find_by_email('yangsongfwd@163.com')
(0..20).each do |index|
  title = Faker::Lorem.words(2).join(' ')
  content = Faker::Lorem.sentence(8)

  yangsong.schedules.create!(title: title,
                             content: content,
                             planed_completed_at: (index % 5).days.ago.to_datetime)

end