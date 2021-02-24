# Rails Engine  

## Overview  
Rails Engine was a 7 day project for Turing School of Software & Design's Backend Program. It is meant to simulate building and exposing an API that a frontend could consume for a fictitious E-Commerce Application.  

## README Content
- [Getting Started](#getting-started)
- [Endpoints](#endpoints)
- [Testing](#testing-tools-utilized)
- [Database Schema](#database-schema)
- [Author](#author)

## Getting Started  
```  
$ git clone git@github.com:leahriffell/rails_engine.git  
(or fork from that repo and clone your own fork)  
$ cd rails_engine  
```  

### Prerequisites  
![rails-badge](https://img.shields.io/badge/Rails-5.2.4-informational?style=flat-square)    
![ruby-badge](https://img.shields.io/badge/Ruby-2.5.3-informational?style=flat-square)  

### Installing
#### Install gems and setup your database:
```
$ bundle install
$ rails db:create
$ rails db:migrate
$ rails db:seed
```
#### Run your own development server:  
- The command below starts a local server where you can check out endpoints from this API.  
```
$ rails s
```

## Testing Tools Utilized
- RSpec  
- Capybara  
- SimleCov  
- To run test suite:  
```
$ bundle exec rspec.
```
- After the test suite runs you can enter this in the command line to see a test coverage report:  
```
$ open coverage/index.html
```  

## Database Schema
<img width="944" alt="Screen Shot 2021-02-15 at 9 06 59 AM" src="https://user-images.githubusercontent.com/68261312/108461439-f4c12b00-7237-11eb-945c-ac708118f6fd.png">


## API Endpoints

### Items RESTful Endpoints
```
# Get all items
GET http://localhost:3000/api/v1/items

# Get one item
GET http://localhost:3000/api/v1/items/:id

# Create new item
POST http://localhost:3000/api/v1/items

# Update existing item
PATCH http://localhost:3000/api/v1/items/:id

# Destroy an item
DELETE http://localhost:3000/api/v1/items/:id

# Get an item's associated merchant
GET http://localhost:3000/api/v1/items/:id/merchants
```

### Merchants RESTful Endpoints
```
# Get all merchants
GET http://localhost:3000/api/v1/merchants

# Show one merchant
GET http://localhost:3000/api/v1/merchants/:id

# Get all items associated with a specific merchant id
GET http://localhost:3000/api/v1/merchants/:id/items
```

### Search Endpoints
- Searches are case insensitive and will also fetch partial matches  

#### Find All Items  
- Search Criteria:  
  - name  
  - description  
  - unit_price  
  - merchant_id  
```
# Search for all items that match search criteria
GET /api/v1/items/find_all?<attribute>=<value>
```
#### Find One Merchant
```
# Search for merchant that match search criteria
GET /api/v1/merchants/find?name=<value>
```

### Business intelligence Endpoints
#### Merchants with Most Revenue
```
# Returns records of merchants sorted by descending revenue  
# Optional param of quantity can be passed in to choose how many records to retrieve  
GET /api/v1/merchants/most_revenue?quantity=x
# x is the number of merchants to be returned
```
## Author

- Saundra Catalina | [github](https://github.com/saundracatalina) | [linkedin](https://www.linkedin.com/in/saundra-catalina/)
