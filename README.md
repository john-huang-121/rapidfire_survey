# README

A finished survey site built with rails 2.6.1 and the rapidfire gem. If you like the look of this site,
feel free to fork this project and use it however you'd like. Included is the MIT license.

Below is a link to the live site:

[Live survey site](https://rapidfire-survey.herokuapp.com/)

## The Rapidfire gem repo

This link leads to the repository which houses the rapidfire gem used in my site.

[link to rapidfire gem repo](https://github.com/code-mancers/rapidfire)


## Setup

1) Fork the project.
2) Bundle install
3) Run rails db:migrate to set up the database
4) Go into rails console and create an admin account with a 6-char password or longer: 
   + User.create!({username: "admin", password: "######"}) (BCrypt will salt and hash the password)
5) Start up rails server
   + visit localhost:3000/rapidfire (should root to it as main page)
6) Enjoy!