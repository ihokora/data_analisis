# README

Live Demo, but without client :-(  https://datasets-analisis.herokuapp.com/

Running Locally

  Clone the repo
    $ git clone https://github.com/sikigo/data_analisis.git
    $ cd data_analisis

  Install dependencies
    $ bundle install

  Migrate database
    $ rails db:migrate

  And start the server
    $ rails s

The following API routes are available for use by your client

POST   /auth       Email registration. Requires 'email', 'password', and
                   'password_confirmation' params.

POST   /sign_in    Email authentication. Requires 'email' and password
                   as params

DELETE /sign_out   Use this route to end the user's current session


POST /analisis     Array statistical analysis. Requires 'data_x' array

POST /correlation  Calcaulate Pearson correaltion coefficient between
                   two datasets(array). Requires 'data_x' 'and 'data_y' params


Sign Up
![Alt text](/images/registration.png?raw=true


