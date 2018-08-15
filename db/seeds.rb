User.create(first_name: 'Bobby', last_name: 'Booshay', username: 'boozilla', email: 'b.booshay@gmail.com', password: '1234', birthday: 19910722)

Post.create(title: 'This Is a Title', content: 'This is some content for this post', user_id: 1)

Tag.create(name: 'first')

Post_Tag.create(post_id: 1, tag_id: 1)

