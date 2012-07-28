# Blogger

### Step #1: Creating the application

    rails new blogger


### Step #2: Add some useful development dependencies

Then, of course, run `bundle install`


### Step #3: Generate our Post model

We do the scaffolding using a nifty-generator, and migrate the stuff right away.

    rails g nifty:layout
    rails g nifty:scaffold Post title:string body:text
    rake db:migrate

Remove the static index file

    rm public/index.html

*Also remove `public/stylesheets`. Nifty generators are getting old... :)*


### Step #4: Reformat posts HTML

Views need a little help. Especially that ugly `posts#index`. *(Generating `for` instead of `each` by default? Are you kidding me?)*


### Step #5: Add `devise` & `rails_admin` gems

And run our old friend: `bundle install`


### Step #6: Generate RailsAdmin

Run:

    rails g rails_admin:install

Defaults are fine. Just press return twice.  
Since this creates a new `User` model, we need to run the migration in order to use RailsAdmin

    rake db:migrate

Now you're good to go: access the admin interface under **/admin**, eg. [http://localhost:3000/admin](http://localhost:3000/admin)


### Step #7: Add admin attribute to users

Since we need to distinguish between a regular and an admin user, have to have a flag in the database.

    rails g migration add_admin_to_users

Edit the migration file, then:

    rake db:migrate


### Step #7: Add admin seed data

Edit `db/seeds.rb`, then:

    rake db:seed

Now we have an admin account (u/p: admin@example.com/password) It doesn't have any speacial features yet, though...
