# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
dois = DoiObject.create(
  [
    { name: 'google', description: 'The best search Engine EVER. Bing sucks compared to google.', doi: '3Hv1Rzqnn5aRwV-WH-TM-w'},
    { name: 'facebook', description: 'Best Social Media Site', doi: '5KL3Vzqqq5FcwV-WX-IL-p'} 
  ]
)

url = UrlObject.create(
  [
    { url: 'https://google.com', doi_object_id: dois[0].id},
    { url: 'https://thefacebook.com', doi_object_id: dois[1].id},
    { url: 'https://facebook.com', doi_object_id: dois[1].id}
  ]
)