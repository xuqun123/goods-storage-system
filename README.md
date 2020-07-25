# goods_storage_system

A simple goods storage system implementation with data retrieve, bulk upload, tracking and report facilities using Rails.

* Ruby version
2.6.1

* Rails version
5.2.4.3

* Node version
^12.18.2

* App Install and Configuration
```
bundle install
```
```
rake db:drop db:create db:migrate db:seed
```
```
yarn install
```

* App Startup
```
rails s
```
or
```
foreman start
```
* How to run the test suite
```
rspec
```

* Unfinished items
- search function in goods listing page
- show a report chat in the report page with a 10s auto-refresh

* Further Improvment Thoughts
1. All ruby codes in the repo need to be fully tested.
2. Webpack with Vue setup needs to be removed from the repo as it is not used
3. Some unused Rails services like ActionCable/Mailer need to be removed
4. The app is implemented by Rails + some jquery codes in FE, if get more time, I would go with FE/BE isolation architecture: Rails app would be used as a API service and data storage facility, then FE uses whatever framework (e.g., Vue/React) to fetch data via APIs provided from Rails BE. But considering this project is only with some limiited features, implementaing a total separate FE app could be over engineered. 
