include RandomData

# Create Posts
50.times do
    Post.create!(
      title: RandomData.random_sentence,
      body: RandomData.random_paragraph
    )
end
posts = Post.all

# Create Comments
100.times do
   Comment.create!(
    post: posts.sample,
    body: RandomData.random_paragraph
    ) 
end

# Create unique post
Post.find_or_create_by(title: "Assignment 33", body: "This is supposed to be a unique post")

# Create unique comment
Comment.find_or_create_by(body: "Assignment 33, unique comment")

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"