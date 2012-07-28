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


### Step #14: Add and generate Twitter Bootstrap (twitter-bootstrap-rails)

Since our app is kinda ugly, we add Bootstrap to the mix. Edit the `Gemfile` and run:

    bundle install
    rails g bootstrap:install


### Step #15: Format HTML for Bootstrap

It's a bit better, but not that much without modifying the HTMLs to match Bootstrap's requirements. Let's just do that.


### Step #16: Install SimpleForm

We deliberately skipped the formatting of forms in the previous step: the reason for this is that SimpleForm -if properly configured- can play very well with Bootstrap.  
First, we add `simple_form` to our Gemfile, then just we just run a couple of commands:

    bundle install
    rails g simple_form:install

That's it for now, we'll start customizing it in the next step.


### Step #17: Customizing forms for Bootstrap with SimpleForm

First, we need to have a decent SimpleForm config in `config/initializers/simple_form.rb`. After it's done, making our post form a better Bootstrap-citizen is snap.


---

## Final words

Making a simple blogger application with such tools is a joy and can be done lightning fast. Hope you enjoned it! :)

#### Excersize

If you feel adventurous, consider addig a commenting feature with the following constraints:

* Comments belong to posts
* A comment has an author. If it's a registered user, then it should be his username for convenience
* This means the users will need to have usernames
* Anyone can create comments
* Only registered users can delete comments, and only the ones that belong to his own posts
* Even a registered user can't edit comments
* Admin users are still divine entities
* And finally: we didn't do any validations, so do it pronto! :)
