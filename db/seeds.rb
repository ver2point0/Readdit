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

# Create Advertisements
10.times do
    Advertisement.create!(
      title: RandomData.random_sentence,
      copy: RandomData.random_paragraph,
      price: RandomData.random_numbers
    )
end
advertisements = Advertisement.all

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} advertisements created"