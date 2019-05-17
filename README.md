# README

## In-Progress work

used the rapidfire gem for making surveys.

[link to rapidfire gem repo](https://github.com/code-mancers/rapidfire)


Steps:

bundle install
rails console
User.create!({username: "admin", password: "123456"}) (BCrypt will salt and hash)
rails server (start up server)
visit localhost:3000/rapidfire (should root to it as main page)

look at the repo for more setup info, possibly about the migrations