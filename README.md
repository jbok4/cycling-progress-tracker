# cycling-progress-tracker

This project is supported by Bundler and includes a `Gemfile`.

Run 'bundle install' before getting started. Then run 'rake db:migrate' followed by 'shotgun' and you can view and interact with the project via localhost:9393 in your browser. Enjoy!

## Overview

The goal of this project is to build a hub where fellow cyclists can share their updates and newest ride info.

A user cannot take any actions (except sign-up), unless they are logged in. Once a user is logged in, they should be able to create, edit and delete their own rides while keeping track of their previous rides, as well as view all the rides by their friends.

### File Structure

```
├── CONTRIBUTING.md
├── Gemfile
├── Gemfile.lock
├── LICENSE.md
├── README.md
├── Rakefile
├── app
│   ├── controllers
│   │   └── application_controller.rb
│   ├── models
│   │   ├── Cyclist.rb
│   │   └── Ride.rb
│   └── views
│       ├── index.erb
│       ├── layout.erb
│       ├── rides
│       │   ├── create_ride.erb
│       │   ├── edit_ride.erb
│       │   ├── rides.erb
│       │   └── show_ride.erb
│       └── cyclists
│           ├── create_cyclist.erb
│           └── error.erb
│           └── failure.erb
│           └── login.erb
│           └── show.erb
├── config
│   └── environment.rb
├── config.ru
├── db
│   ├── development.sqlite
│   ├── migrate
│   │   ├── create_cyclists.rb
│   │   └── create_rides.rb
│   ├── schema.rb

#### License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


##### environment.rb

As this project has quite a few files, an `environment.rb` is included that loads all the code in your project along with Bundler. You do not ever need to edit this file. When you see require_relative `../config/environment`, that is how your environment and code are loaded.

