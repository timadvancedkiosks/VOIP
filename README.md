# PREREQUISITES:

1. GIT command line tool, account set up
2. Heroku command line tool, account set up
3. Ruby, RoR
4. Default CouchDB installation (`application.rb` to change connection details)

# SETUP:

    $ git clone git@bitbucket.org:advancedkiosks/solution-template.git SOLUTION_NAME
    $ cd SOLUTION_NAME  
    $ rails g rename_to SOLUTION_NAME  
    $ rm -r -f vendor/plugins/  
    $ rm -r -f .git  
    # bundle
    $ git init  
    $ git add .  
    $ git commit -m "init"  
    $ git remote add origin GIT_URL  
    $ git push -u origin --all

    $ heroku create  
    $ heroku addons:add cloudant:oxygen  
    $ git push heroku master  

# USAGE:

To create a new app configuration, do: `POST APP_HOST/customers` and pass in a single argument `secret: SECRET_HASH`

It will return (in JSON) either:
* `{ 'success': true, 'database_uri': SOME_URI }` (if succeeded)
* `{ 'success': false, 'message': 'some message' }` (if something went wrong)

Root page at `http://host?secret=SECRET_HASH`  
Management page at `http://host/manage?secret=SECRET_HASH`  
Root page is mapped to `WelcomeController#index`  
Management page mapped to `ManagersController#edit`  