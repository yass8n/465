user = User.new
user.email = "yass8n@yahoo.com"
user.name = "yaseen"
user.password = 'y'
user.password_confirmation = 'y'
user.save!

user = User.new
user.email = "a@a.com"
user.name = "alex"
user.password = 'a'
user.password_confirmation = 'a'
user.save!

user = User.new
user.email = 'b@b.com'
user.name = "bob"
user.password = 'b'
user.password_confirmation = 'b'
user.save!

user = User.new
user.email = 'm@m.com'
user.name = "mom"
user.password = 'm'
user.password_confirmation = 'm'
user.save!

user = User.new
user.email = 'h@h.com'
user.name = "harry"
user.password = 'h'
user.password_confirmation = 'h'
user.save!

user = User.new
user.email = 'empty@empty.com'
user.name = "empty"
user.password = 'e'
user.password_confirmation = 'e'
user.save!

user = User.new
user.email = 'tim@tim.com'
user.name = "tim"
user.password = 't'
user.password_confirmation = 't'
user.save!

user = User.new
user.email = 'c@c.com'
user.password = 'c'
user.password_confirmation = 'c'
user.name = "cassy"
user.save!

images_hash = ([
  {filename: "2a47a5c4539657a10b8ef391351d385f.jpg", public: true, user_id: 1},
  {filename: "75479140b58a599d7d2b4ceeec91ae1c.jpg", public: true, user_id: 1},
  {filename: "a4cb308aa19dd3950fcc67ff626c2fc9.jpg", public: true, user_id: 1},
  {filename: "aea061cdc841d300fffa4409f546bc4d.jpg", public: false, user_id: 1},
  {filename: "d7af3b85e3c27aae5b53728e67b4add2.jpg", public: true, user_id: 8},
  {filename: "aef60a28c1acdcf9d41bccbf04dae5a7.jpg", public: true, user_id: 8},
  {filename: "faff59a6e2608f581df2b21ca100d504.jpg", public: false, user_id: 8},
  {filename: "cb098607383e9aab5936fbc4953ef662.jpg", public: true, user_id: 2},
  {filename: "c8fc9236ffb3737919cee7abe60103da.jpg", public: false, user_id: 2},
  {filename: "2b2867190d4b456e056ababdc92ec32b.jpg", public: true, user_id: 2},
  {filename: "9f43a2085f754660961709c8559e3c41.jpg", public: true, user_id: 3},
  {filename: "bb4ed0074c6207c3b6dfdbd126d5ee9e.jpg", public: true, user_id: 3},
  {filename: "fc96d30fc5c241d21115a5662e0e496c.jpg", public: false, user_id: 3},
  {filename: "55191a57169d93c6ba77db126c242e4b.jpg", public: true, user_id: 4},
  {filename: "9830d423e8ab42058503f7b867d119bd.jpg", public: true, user_id: 4},
  {filename: "eb1bcf4bcea6f48712e8e45d58e74974.jpg", public: false, user_id: 4},
  {filename: "0adb75d26d768142e3fa022de366fa27.jpg", public: true, user_id: 5},
  {filename: "f444b14ab535ac31e09d8b38dce9519c.jpg", public: false, user_id: 5},
  {filename: "d52f95216cd68e285b5d1421003015f1.jpg", public: true, user_id: 7},
  {filename: "982667a54b2456b4ab9b5e7fb341f037.jpg", public: true, user_id: 7},
  {filename: "0d8ad9d5c3426df9bbb28b12f9f03f5a.jpg", public: false, user_id: 7},
  {filename: "d6dbd6433dbffd923dc91183266bc9eb.jpg", public: true, user_id: 7},
  {filename: "0ab6b135069554065e4a68451ee79f22.jpg", public: false, user_id: 7},
  {filename: "4ea778479b798ba09c2326feb471a90d.jpg", public: true, user_id: 7},
  {filename: "80585be723cdec06a3fed13892c6adee.jpg", public: true, user_id: 5},
  {filename: "30de7372ccd89029ff65e79e5ed0383c.jpg", public: true, user_id: 5}
])

images_hash.each do |hash|
  image = Image.new
  image.filename = hash[:filename]
  image.public = hash[:public]
  image.user_id = hash[:user_id]
  image.save!
end

ImageUser.create!([
  {image_id: 4, user_id: 2},
  {image_id: 4, user_id: 3},
  {image_id: 4, user_id: 4},
  {image_id: 4, user_id: 5},
  {image_id: 4, user_id: 7},
  {image_id: 4, user_id: 8},
  {image_id: 7, user_id: 1},
  {image_id: 7, user_id: 2},
  {image_id: 7, user_id: 3},
  {image_id: 7, user_id: 4},
  {image_id: 13, user_id: 1},
  {image_id: 13, user_id: 4},
  {image_id: 16, user_id: 1},
  {image_id: 16, user_id: 2},
  {image_id: 16, user_id: 3},
  {image_id: 16, user_id: 5},
  {image_id: 16, user_id: 7},
  {image_id: 16, user_id: 8},
  {image_id: 18, user_id: 1},
  {image_id: 23, user_id: 1},
  {image_id: 23, user_id: 2},
  {image_id: 23, user_id: 3},
  {image_id: 23, user_id: 4},
  {image_id: 23, user_id: 5},
  {image_id: 25, user_id: 1},
  {image_id: 25, user_id: 2},
  {image_id: 25, user_id: 3},
  {image_id: 25, user_id: 4},
  {image_id: 25, user_id: 5},
  {image_id: 25, user_id: 8}
])
Tag.create!([
  {image_id: 1, tag_string: "gf"},
  {image_id: 1, tag_string: "dog"},
  {image_id: 2, tag_string: "leaf"},
  {image_id: 2, tag_string: "UPE"},
  {image_id: 2, tag_string: "bidwell"},
  {image_id: 3, tag_string: "funny"},
  {image_id: 3, tag_string: "meme"},
  {image_id: 4, tag_string: "pancake"},
  {image_id: 4, tag_string: "challenge"},
  {image_id: 4, tag_string: "25pancakes"},
  {image_id: 5, tag_string: "life"},
  {image_id: 5, tag_string: "awesome"},
  {image_id: 5, tag_string: "best"},
  {image_id: 5, tag_string: "lift"},
  {image_id: 5, tag_string: "eat"},
  {image_id: 5, tag_string: "code"},
  {image_id: 5, tag_string: "sleep"},
  {image_id: 6, tag_string: "girls"},
  {image_id: 6, tag_string: "girl"},
  {image_id: 7, tag_string: "girl"},
  {image_id: 7, tag_string: "me"},
  {image_id: 8, tag_string: "babies"},
  {image_id: 8, tag_string: "little"},
  {image_id: 8, tag_string: "lol"},
  {image_id: 9, tag_string: "gunnar"},
  {image_id: 10, tag_string: "asian"},
  {image_id: 10, tag_string: "lmao"},
  {image_id: 10, tag_string: "sleeping"},
  {image_id: 10, tag_string: "funny"},
  {image_id: 11, tag_string: "friends"},
  {image_id: 11, tag_string: "outside"},
  {image_id: 12, tag_string: "coding"},
  {image_id: 12, tag_string: "code"},
  {image_id: 12, tag_string: "fun"},
  {image_id: 13, tag_string: "secret"},
  {image_id: 13, tag_string: "code"},
  {image_id: 14, tag_string: "schedule"},
  {image_id: 14, tag_string: "school"},
  {image_id: 15, tag_string: "tickets"},
  {image_id: 15, tag_string: "forsale"},
  {image_id: 15, tag_string: "craigslist"},
  {image_id: 16, tag_string: "face"},
  {image_id: 16, tag_string: "son"},
  {image_id: 16, tag_string: "room"},
  {image_id: 17, tag_string: "ninja"},
  {image_id: 17, tag_string: "turtle"},
  {image_id: 17, tag_string: "school"},
  {image_id: 17, tag_string: "halloween"},
  {image_id: 18, tag_string: "money"},
  {image_id: 20, tag_string: "turtles"},
  {image_id: 20, tag_string: "halloween"},
  {image_id: 22, tag_string: "heart"},
  {image_id: 22, tag_string: "mad"},
  {image_id: 23, tag_string: "hat"},
  {image_id: 23, tag_string: "for sale"},
  {image_id: 24, tag_string: "tights"},
  {image_id: 25, tag_string: "new"},
  {image_id: 25, tag_string: "watch"},
  {image_id: 25, tag_string: "happy"},
  {image_id: 26, tag_string: "hat"},
  {image_id: 26, tag_string: "forsale"},
  {image_id: 26, tag_string: "something"},
  {image_id: 26, tag_string: "stuff"},
  {image_id: 26, tag_string: "tag"}
])
