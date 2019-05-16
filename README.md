# README

## In-Progress work

used the rapidfire gem for making surveys.

(https://github.com/code-mancers/rapidfire)["link to rapidfire gem repo"]


Steps:

bundle install
rails console
User.create!({username: "admin", password: "123456"}) (BCrypt will salt and hash)
rails server (start up server)
visit localhost:3000/rapidfire (should root to it as main page)