# Goodnight API
This is a simple sleep tracking app API built with Ruby on Rails.

## Demo App
The application is deployed on fly.io and can be accessed at https://goodnight.ajvillalobos.com. To interact with the app, use the URL and the provided auth_token for the sample user: `181006696ae26c0a1db0b0d8821362e0fe61fc81284cb17754c035b3d04de296`.

## Authentication
Each request needs a authentication header. The format is

```
"Authentication" => auth_token
```

The auth_token can be found on the User model, auth_token field. It is generated when the user is created.

## Endpoints

| Endpoint | HTTP Method | Request Headers | Request Payload | Response Object |
| --- | --- | --- | --- | --- |
| /api/v1/clock_in | POST | `Authorization: <auth_token>` | None | `{"message": "You are clocked in", "data": {"id": integer, "user_id": integer, "clock_in": datetime, "clock_out": datetime, "created_at": datetime, "updated_at": datetime}}` |
| /api/v1/clock_out | PUT | `Authorization: <auth_token>` | None | `{"message": "You are clocked out"}` |
| /api/v1/clock_ins | GET | `Authorization: <auth_token>` | None | `{"data": [{"id": integer, "user_id": integer, "clock_in": datetime, "clock_out": datetime, "created_at": datetime, "updated_at": datetime}]}` |
| /api/v1/follow | POST | `Authorization: <auth_token>` | `{"id": integer}` | `{"message": "You are now following <followee_name>"}` |
| /api/v1/unfollow | DELETE | `Authorization: <auth_token>` | `{"id": integer}` | `{"message": "You are no longer following <followee_name>"}` |
| /api/v1/feeds | GET | `Authorization: <auth_token>` | None | `{"data": [{"id": integer, "user_name": string, "clock_in": datetime, "clock_out": datetime, "duration": float}]}` |


## Running the Application

To run the application, first run bundle install to install the necessary gems. Then, run the following commands to create and seed the database:

```
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
```

## Runing the test
```
bin/rails test
```
