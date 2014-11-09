User.create!([
  {email: "yass8n@yahoo.com", encrypted_password: "$2a$10$wrikTeticPRcPZDvfcbH5uXSaEFxXFy0VRpCbi.XuBAACgFfoccDi", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 9, current_sign_in_at: "2014-11-09 07:45:42", last_sign_in_at: "2014-11-09 07:43:14", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", name: "yaseen"},
  {email: "a@a.com", encrypted_password: "$2a$10$QFongp57BCIaARkwtOcvn.1B9pesMH32PRHIUIiPWMm50.tE1NVMS", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 4, current_sign_in_at: "2014-11-09 07:44:48", last_sign_in_at: "2014-11-09 07:37:36", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", name: "ayman"},
  {email: "b@b.com", encrypted_password: "$2a$10$VcDRqawhAOisKoL9xFVrROyI47PqqeVwFE8G3530Z4NLlRh38wpbW", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 2, current_sign_in_at: "2014-11-09 07:45:00", last_sign_in_at: "2014-11-09 07:26:37", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", name: "b"},
  {email: "m@m.com", encrypted_password: "$2a$10$hSZ6AJRppX8BebEZq968wuV4SQzaRXujXIO0jDCcNju8sK985iCGm", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 2, current_sign_in_at: "2014-11-09 07:45:22", last_sign_in_at: "2014-11-09 07:39:26", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", name: "m"},
  {email: "h@h.com", encrypted_password: "$2a$10$UJFmiuQ5RimxXaRl92f71uTddGyaCSNFSgjijSA5etdJoYhxlJbCK", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2014-11-09 08:24:26", last_sign_in_at: "2014-11-09 08:24:26", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", name: "harry"},
  {email: "empty@empty.com", encrypted_password: "$2a$10$OGjeTAOz1lKApXjr4Mpz8uOp9lXRaBrMsTcTpw6772LX9alOXRMs2", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2014-11-09 08:25:48", last_sign_in_at: "2014-11-09 08:25:48", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", name: "empty"},
  {email: "tim@tim.com", encrypted_password: "$2a$10$SeyJ.LnPvHlY9T6gSHFi0OTUAZ5xMstlXleRlnfV07dstGswjRBD2", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2014-11-09 08:26:28", last_sign_in_at: "2014-11-09 08:26:28", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", name: "tim"},
  {email: "c@c.com", encrypted_password: "$2a$10$z9cjjyUOm45qRvSrMNGwleDzzyuEii7zgVTtcDP9kKTDvfHYO0t4C", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2014-11-09 08:27:59", last_sign_in_at: "2014-11-09 08:27:59", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", name: "carl"}
])
Image.create!([
  {filename: "d7057e38166cb5358ddbfeff7e04f6d3.jpg", public: true, user_id: 1},
  {filename: "ebc2a0e6695559a750cb8071ae00651f.jpg", public: true, user_id: 1},
  {filename: "9139bda8933fde63aba487df10401a21.jpg", public: true, user_id: 1},
  {filename: "29ce5e95addc50cefb533e242584a329.jpg", public: true, user_id: 1},
  {filename: "119fc5eb0240e5d086950caf7a8c7739.jpg", public: false, user_id: 2},
  {filename: "7550985e48d95f7afa4d4cc9ac9f224a.jpg", public: true, user_id: 2},
  {filename: "c8e5f2a97a4b7a21ff99d59a822040ee.jpg", public: true, user_id: 2},
  {filename: "a2353cdf6bd6745f3f657749a986ec4e.jpg", public: true, user_id: 2},
  {filename: "5053dbecba99bf2dcf7b78030a07847a.jpg", public: true, user_id: 3},
  {filename: "4b4c8176ff79f2dae24afc25dbab7f55.jpg", public: false, user_id: 3},
  {filename: "1cc7621ddb9b126762a080c7f1b0c676.jpg", public: false, user_id: 4},
  {filename: "fa89929a91aaf635a62f66f15f7b0b43.jpg", public: false, user_id: 4},
  {filename: "2444e4568c3ab8d6c130e1cf85faeeb0.jpg", public: false, user_id: 4},
  {filename: "f011f3b62a90e8350373ccc2855ff72f.jpg", public: true, user_id: 1},
  {filename: "0b0bd3b575f9e04ef3ac32d84d6de4b2.jpg", public: false, user_id: 5},
  {filename: "0f8a7a1ef3263a1a258a1831910ae8f9.jpg", public: true, user_id: 5},
  {filename: "4196dc8ff434f369b7e53e1fb7cac144.jpg", public: true, user_id: 7},
  {filename: "bbbe51371c632966a64b464870d8a8f8.jpg", public: false, user_id: 8}
])
ImageUser.create!([
  {image_id: 9, user_id: 1},
  {image_id: 14, user_id: 2},
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
  {image_id: 22, user_id: 5}
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
  {image_id: 22, tag_string: "coins"}
])
