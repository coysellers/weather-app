# Weather App

<img width="1313" alt="Screenshot 2025-02-20 at 9 35 52 AM" src="https://github.com/user-attachments/assets/db634aef-f22f-444e-abaf-009084fcf7e3" />

----

Run:
* `bundler`
* `rails db:migrate`
* `bin/rails server`
* in new tab: `bin/rails tailwindcss:watch` # To compile style
* in new tab: `yarn build:watch` # to compile the javascirpt

Run tests with: `bundle exec rspec`

visit: http://localhost:3000/

Quick test data:
Addresses:
* Memphis
* 239 Greene St New York, NY 10003
* Austin

IP Addresses:
* 34.21.9.50
* 192.168.1.1


I would have liked to spend more time on the JavaScript side but ran out of time. I did have the notices/JS working at one point, but I forgot that I was manually compiling the styles and JS at the time. I made some changes along the way and realized it was broken when I set up the app from scratch again. It's probably something simple, but I wanted to honor the time constraint. I also noticed a few quirks along the way since I was moving quickly to focus on the frontend.

Also would have made smaller commits but did larger bulk commits given the time.


## Time

4:45 - 6:45

- Create GitHub repo
- Create Rails App
- Setup controller and views
- Add API for Geocode
- Start writing initial tests

Dinner Break

8:30 - 10:45:
- Write out as many tests as I can think of
- Work through model, views, and controller
- Add tailwind for quick styles
- Work through test failures and update tests where needed

8:15-9:30:
- Add some hotwire and stimulus
- Update controllers with turbo streams

Small break

11:00 - 11:30:
- Update ReadMe and test out app setup

Total time: 6 hours
