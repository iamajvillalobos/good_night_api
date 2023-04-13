# Goodnight API
This is a simple sleep tracking app API built with Ruby on Rails.

## Authentication
Each request needs a authentication header. The format is

```
"Authentication" => auth_token
```

The auth_token can be found on the User model, auth_token field. It is generated when the user is created.

## Endpoints

| Endpoint | HTTP Method | Request Payload | Response Object |
| --- | --- | --- | --- |
| /api/v1/clock_in | POST | `Authorization: <auth_token>` | `{"message": "You are clocked in", "data": {"id": integer, "user_id": integer, "clock_in": datetime, "clock_out": datetime, "created_at": datetime, "updated_at": datetime}}` |
| /api/v1/clock_out | PUT | `Authorization: <auth_token>` | `{"message": "You are clocked out"}` |
| /api/v1/clock_ins | GET | `Authorization: <auth_token>` | `{"data": [{"id": integer, "user_id": integer, "clock_in": datetime, "clock_out": datetime, "created_at": datetime, "updated_at": datetime}]}` |
| /api/v1/follow/:followee_id | POST | `Authorization: <auth_token>` | `{"message": "You are now following <followee_name>"}` |
| /api/v1/unfollow/:followee_id | DELETE | `Authorization: <auth_token>` | `{"message": "You are no longer following <followee_name>"}` |
| /api/v1/feeds | GET | `Authorization: <auth_token>` | `{"data": [{"id": integer, "user_name": string, "clock_in": datetime, "clock_out": datetime, "duration": float}]}` |

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
