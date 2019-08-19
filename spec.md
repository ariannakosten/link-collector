# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database -- My models and DB use Active Record.
- [x] Include more than one model class (e.g. User, Post, Category) -- I have 3 models (category.rb, link.rb, & user.rb).
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts) -- My Category & User models have has_many relationships.
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User) -- My Link model has 2 belongs_to relationships.
- [x] Include user accounts with unique login attribute (username or email) -- In the User Controller and User model i have accounted for this.
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying -- Link model has routes for CRUD
- [x] Ensure that users can't modify content created by other users
- [x] Include user input validations --  I included validation where empty strings/ fields cannot be accepted.
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new) -- I used the rack flash3 gem to display messages.
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code -- I have included these specifications.

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
