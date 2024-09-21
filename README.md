[![CI](https://github.com/reaper/entity2-challenge/actions/workflows/ci.yml/badge.svg)](https://github.com/reaper/entity2-challenge/actions/workflows/ci.yml)
[![Linters](https://github.com/reaper/entity2-challenge/actions/workflows/linters.yml/badge.svg)](https://github.com/reaper/entity2-challenge/actions/workflows/linters.yml)

# entity2 challenge

## Website
A website representing the challenge has been deployed to https://entity2-challenge.fiwares.com

Deployed with dokku on a VPS (we can discuss about it later)

Missions JSON is acessible here, order by listing_id and date (DESC): https://entity2-challenge.fiwares.com/missions.json

<img width="1248" alt="Screenshot 2023-04-07 at 09 35 14" src="https://user-images.githubusercontent.com/82464/230564225-8e708a2b-ba15-4229-81fb-c6eff6fca6f1.png">


## Preparations

Install ruby 3.2.2 and gems
```
rvm install 3.2.2 # if you like rvm
bundle install
```

With docker, run postgresql in a container:
```
docker-compose up -d
```

Prepare the database for local development
```
rails db:prepare
```

FYI `seeds.rb` file contains the input hash which had to be processed for the challenge:
```
{
  "listings": [
    { "id": 1, "num_rooms": 2 },
    { "id": 2, "num_rooms": 1 },
    { "id": 3, "num_rooms": 3 }
  ],
  "bookings": [
    { "id": 1, "listing_id": 1, "start_date": "2016-10-10", "end_date": "2016-10-15" },
    { "id": 2, "listing_id": 1, "start_date": "2016-10-16", "end_date": "2016-10-20" },
    { "id": 3, "listing_id": 2, "start_date": "2016-10-15", "end_date": "2016-10-20" }
  ],
  "reservations": [
    { "id": 1, "listing_id": 1, "start_date": "2016-10-11", "end_date": "2016-10-13" },
    { "id": 2, "listing_id": 1, "start_date": "2016-10-13", "end_date": "2016-10-15" },
    { "id": 3, "listing_id": 1, "start_date": "2016-10-16", "end_date": "2016-10-20" },
    { "id": 4, "listing_id": 2, "start_date": "2016-10-15", "end_date": "2016-10-18" }
  ]
}
```

## Run the server
```
./bin/dev
```

## Run tests

```
rails test:all

Running 68 tests in parallel using 8 processes
Run options: --seed 28305

# Running:

....................................................................

Finished in 1.227350s, 55.4039 runs/s, 123.8441 assertions/s.
68 runs, 152 assertions, 0 failures, 0 errors, 0 skips
```
