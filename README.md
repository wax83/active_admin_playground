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


### Step #3: Reformat posts HTML

Views need a little help. Especially that ugly `posts#index`. *(Generating `for` instead of `each` by default? Are you kidding me?)*
