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
user.name = "carl"
user.save!

Image.create!([
  {filename: "d7057e38166cb5358ddbfeff7e04f6d3.jpg", public: true, user_id: 1},
  {filename: "ebc2a0e6695559a750cb8071ae00651f.jpg", public: true, user_id: 1},
  {filename: "9139bda8933fde63aba487df10401a21.jpg", public: true, user_id: 1},
  {filename: "29ce5e95addc50cefb533e242584a329.jpg", public: false, user_id: 1},
  {filename: "119fc5eb0240e5d086950caf7a8c7739.jpg", public: false, user_id: 2},
  {filename: "7550985e48d95f7afa4d4cc9ac9f224a.jpg", public: true, user_id: 2},
  {filename: "c8e5f2a97a4b7a21ff99d59a822040ee.jpg", public: true, user_id: 2},
  {filename: "a2353cdf6bd6745f3f657749a986ec4e.jpg", public: false, user_id: 2},
  {filename: "5053dbecba99bf2dcf7b78030a07847a.jpg", public: true, user_id: 3},
  {filename: "4b4c8176ff79f2dae24afc25dbab7f55.jpg", public: false, user_id: 3},
  {filename: "1cc7621ddb9b126762a080c7f1b0c676.jpg", public: false, user_id: 4},
  {filename: "fa89929a91aaf635a62f66f15f7b0b43.jpg", public: false, user_id: 4},
  {filename: "2444e4568c3ab8d6c130e1cf85faeeb0.jpg", public: false, user_id: 4},
  {filename: "f011f3b62a90e8350373ccc2855ff72f.jpg", public: false, user_id: 1},
  {filename: "0b0bd3b575f9e04ef3ac32d84d6de4b2.jpg", public: false, user_id: 5},
  {filename: "0f8a7a1ef3263a1a258a1831910ae8f9.jpg", public: true, user_id: 5},
  {filename: "4196dc8ff434f369b7e53e1fb7cac144.jpg", public: true, user_id: 7},
  {filename: "bbbe51371c632966a64b464870d8a8f8.jpg", public: false, user_id: 8}
])
ImageUser.create!([
  {image_id: 9, user_id: 1},
  {image_id: 14, user_id: 1},
  {image_id: 16, user_id: 3},
  {image_id: 16, user_id: 1},
  {image_id: 15, user_id: 2},
  {image_id: 15, user_id: 3},
  {image_id: 17, user_id: 1},
  {image_id: 17, user_id: 2},
  {image_id: 17, user_id: 3},
  {image_id: 19, user_id: 2},
  {image_id: 22, user_id: 1},
  {image_id: 22, user_id: 2},
  {image_id: 22, user_id: 3},
  {image_id: 22, user_id: 4},
  {image_id: 22, user_id: 5},
  {image_id: 4, user_id: 2},
  {image_id: 4, user_id: 3},
  {image_id: 4, user_id: 4},
  {image_id: 14, user_id: 2},
  {image_id: 14, user_id: 3},
  {image_id: 14, user_id: 4},
  {image_id: 14, user_id: 5},
  {image_id: 14, user_id: 7},
  {image_id: 14, user_id: 8},
  {image_id: 8, user_id: 1}
])
Tag.create!([
  {image_id: 4, tag_string: "fun"},
  {image_id: 8, tag_string: "fun"},
  {image_id: 7, tag_string: "g"},
  {image_id: 15, tag_string: "funny"},
  {image_id: 8, tag_string: "funny"},
  {image_id: 18, tag_string: "snapchat"},
  {image_id: 19, tag_string: "strong"},
  {image_id: 19, tag_string: "muscle"},
  {image_id: 20, tag_string: "sleeping"},
  {image_id: 21, tag_string: "costume"},
  {image_id: 21, tag_string: "funny"},
  {image_id: 21, tag_string: "old"},
  {image_id: 22, tag_string: "money"},
  {image_id: 22, tag_string: "coins"},
  {image_id: 3, tag_string: "girl"},
  {image_id: 1, tag_string: "girl"},
  {image_id: 14, tag_string: "funny"},
  {image_id: 14, tag_string: "tim"},
  {image_id: 4, tag_string: "bro"},
  {image_id: 8, tag_string: "yaseen"}
])
