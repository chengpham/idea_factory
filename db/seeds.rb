
Idea.delete_all
Review.delete_all
Like.delete_all
User.delete_all


PASSWORD='supersecret'

super_user=User.create(
    name: 'Jon Snow',
    email: 'js@winterfell.gov',
    password: PASSWORD,
    admin: true
)

20.times do
    name = Faker::Name.name
    User.create(
        name: name,
        email: "#{name.split.map(&:capitalize).join('.')}@example.com",
        password: PASSWORD,
        created_at: Faker::Date.backward(days: 365)
    )
end
users=User.all
70.times do
    ideas=Idea.create(
        title: Faker::Quote.famous_last_words,
        description: Faker::Lorem.sentence(word_count: 30),
        user: users.sample
    )
    if ideas.valid?
        ideas.reviews = rand(2..25).times.map do
            Review.create(
                body: Faker::Hipster.paragraph,
                user: users.sample
            )
        end
        ideas.likers=users.shuffle.slice(0,rand(users.count))
    end
end

puts "Idea Count #{Idea.count}"
puts "Review Count #{Review.count}"
puts "Like Count #{Like.count}"
puts "User Count #{User.count}"
puts "Log in with super user. Username: #{super_user.email} Password: #{PASSWORD}"