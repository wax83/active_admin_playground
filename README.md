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


### Step #8: Add cancan gem

Edit the `Gemfile`, and run the (boring) `bundle install`


### Step #9: Limit access to RailsAdmin to admin users

Generate a CanCan ability with

    rails g cancan:ability

Edit the appropiate files and voila! Only admin users can access RailsAdmin!


### Step #10: User account links

To prepare authorization for our Post model, first add a login/register feature. This only requires view editing, since everything else is graciously provided by Devise.  
We also put a link to RailsAdmin for admin users to avoid typing the URL every time.


### Step #11: Allow only registered users to manage posts

This feature mostly relies on editing the `app/models/ability.rb` to define the rules, but we also need to tell `PostsController` to gain access to the (`@post`) resource to handle authorization.

It's also a nice addition to handle `CanCan::AccessDenied` errors application-wide by redirecting the users to the root URL and display a heart-warming message there, instead of throwing them an ugly error. This is done in the `ApplicationController`.

And if we're already this thoughtful, why not hide all the links that can't be accessed anyway?


### Step #12: Associate posts with users

It'd be great to indicate who created what. And, besides, it'll be the basis of one of the features we'll develop later, so let's set up that nasty `has_many`/`belongs_to` relationship between the `User` and the `Post` model.  
Create a migration:

    rails g migration associate_posts_with_users

Add the column, then:

    rake db:migrate

We also need to edit the `PostsController`, the 2 models and the views to get a properly functioning feature.


### Step #13: Users can only manage their own posts

Now we have all the associations set up, but we also need to ensure that users won't delete each other's posts. Admins should still do whatever the hell they want.

Doing this is a joke: just check our `Ability` class, and be amazed :)  
It's also a good idea to check permissions to hide unneeded links.
