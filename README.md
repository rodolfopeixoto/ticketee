# SunnyTicketee

Application developed for manager ticketee and use BDD ( Capybara, Fake, FactoryBot and Best practices in Ruby and Ruby on Rails).

App example: 

[www.about.me/rodolfopeixoto](http://www.about.me/rodolfopeixoto) 

Version current Project 0.1
================

About version
---------------------

- Docker
 - Docker Compose
- Ruby 2.3.1
 - Gems
  - RSpec 3.7
  - FactoryBot
  - Capybara
  - Faker


Set up

---------------------

You should to have the docker and docker-compose installed.

```bash
  docker-compose build
```

Turn on server

```bash
  docker-compose up
```

You wish generate documentation or test.

```bash
  docker-compose run --rm web [COMMAND]
```

```bash
  docker-compose run --rm web rspec
```

You wish generate database scheme.

```bash
  docker-compose run --rm web rails db:create
```

```bash
  docker-compose run --rm web rails db:migrate
```

You roll migration back

```bash
  docker-compose run --rm web rails db:rollback
```

Documentation
----------------------

View variants allow you to provide different views based on certain criteria.
[VIEWS VARIANTS](http://guides.rubyonrails.org/4_1_release_notes.html#action-pack-variants)

If you need to do something different on the **up** and **down** parts, you can use those methods instead.

```ruby
class CreateProjects < ActiveRecord::Migration
  def up
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.timestamps null: false
    end
  end
  def down
    drop_table :projects
  end
end
```

Removing a column

```ruby
class CreateProjects < ActiveRecord::Migration
  def up
    remove_column :projects, :name
  end
  def down
    add_column :projects, :name, :string
  end
end
```

You can combine flash and redirect_to by passing the flash as an option to the redirecto_to

```ruby

      flash[:notice] = 'Project has been created.'
      redirect_to @project

```

to

```ruby
  redirect_to @project, alert: 'Project has not been created.'
```

If you don't wish to use either **notice** or **alert**, you must specify flash as a hash:

```ruby
  redirect_to @project, flash: { success: 'Project has not been created.' }
```


flash vs flash.now

flash vs. flash.now
The controller action in listing 3.25 uses two different methods to access the array
of flash messages for your page—flash and flash.now. What’s the difference?
flash is the standard way of setting flash messages, and it will store the message
to display on the very next page load. You do this immediately before issuing redirects—
in this case you redirect immediately to the show page in the ProjectsController,
and that page is the next page load, meaning that the flash message displays on the
show view.

flash.now is an alternative way of setting flash messages, and it will store the mes-
sage to display on the current page load. In this case, you don’t redirect anywhere,
you simply render a view out from the same action, so you need to use flash.now
to make sure the user sees the error message when you render the new view.
There’s also a third method—flash.keep—but this is used very rarely. If you want
to keep an existing flash message around for another request, you can call
flash.keep in your controller, and the flash message will hang around for a little
while longer.

If you were to use flash instead of flash.now in this case, the user would see the
message twice—once on the current page and once on the next page.

```ruby
  def create
    @project = Project.new(project_params)

    if @project.save
      flash[:notice] = 'Project has been created.'
      redirect_to @project
    else
      flash.now[:alert] = 'Project has not been created.'
      render 'new'
    end
  end

```

Use SASS, Let's go create **sematic styling** for example:

```ruby

 <li><%= link_to 'Edit Project', edit_project_path(@project), class: 'edit' %></li>

```

Code SASS:

```scss
a.edit {
    @extend .btn;
    @extend .btn-primary;

    &:before {
        font-family: 'FontAwesome';
        @extend .fa-pencil;
        padding-right: 0.5em;
    }
}
```

In code above edit extend of the bootstrap and font-awesome and add icon font in text and add space between.


##### Flash message output

app/views/layouts/application.html.erb

```html
   <div class="container">
      <% flash.each do |key, message| %>
        <div class="alert alert-<%= key %>">
          <%= message %>
        </div>
      <% end %>
   </div>
```

and file app/assets/stylesheet/application.scss

```scss 
.alert-notice{
    @extend .alert-success;
    text-align: center;
}

.alert-alert{
    @extend .alert-danger;
    text-align: center;
}

```


##### Rake - SCHEMA

RESTORING WITH RAKE Large projects can have hundreds of migrations,
which may not run due to changes in the system over time. It’s best to use
bundle exec rake db:schema:load.

```bash
 bundle exec rails db:schema:load
```


#### Polymorphic routing

POLYMORPHIC ROUTING A great description of polymorphic routing can be
found on blog, “The Life of a Radar,” at [http://ryanbigg.com/2012/03/polymorphic-routes](http://ryanbigg.com/2012/03/polymorphic-routes) .


#### Sequence before_action

The sequence here is important, because you want to find the @project before you go looking for tickets for it.

```ruby
  before_action :set_project
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
```

##### Method simple_format

The new method, simple_forma, converts the line breaks entered into description field into HTML break tags (<br>)
so that the description renders exactly how the user intends it to.

```ruby
  <%= simple_format(@ticket.description) %>
```

#### Dependent delete_all or destroy

The problem is that if you have a large number of tickets, destroy is called on each one, which will be slow.

```ruby
  has_many :tickets, dependent: :destroy
```

```ruby
  has_many :tickets, dependent: :delete_all
```
dependent delete_all is equal:

```sql
  DELETE FROM tickets WHERE project_id = :project_id
```

Thirdly, if you want to disassociate tickets from a project and unset the project_id field, you can use this options:

```ruby
  has_many :tickets, dependent: :nullify
```
or

```sql
  UPDATE tickets SET project_id = NULL WHERE project_id = :project_id
```

#### TIME_AGO_IN_WORDS

THE TIME_AGO_IN_WORDS VIEW HELPER
You’re using a view helper called
time_ago_in_words here. It will present the timestamp for when the ticket was cre-
ated in a nice readable format, such as “about 3 minutes” or “about 2 hours.” Just
a little nicety. You can find time_ago_in_words at (http://api.rubyonrails.org/)[http://api.rubyonrails.org/]
classes/ActionView/Helpers/DateHelper.html#method-i-time_ago_in_words.


#### How to use belongs_to :author, class_name: 'User'

We can to add a new name for column.

```ruby
class Ticket < ActiveRecord::Base
  belongs_to :author, class_name: "User"
end
```

```bash
rails g migration add_author_to_tickets author:references
```

Change this code.

```ruby
class AddAuthorToTickets < ActiveRecord::Migration
  def change
    add_reference :tickets, :author, index: true, foreign_key: true
  end
end
```

to:


```ruby
class AddAuthorToTickets < ActiveRecord::Migration[5.1]
  def change
    add_reference :tickets, :author, index: true
    add_foreign_key :tickets, :users, column: :author_id
  end
end

```

Why do you need tp dp this? Because Rails', automatic inference will try to apply a foreign key on your **tickets** table, pointing to an authors table - and you don't have a ticket table. The author will be a **User**, living in the users table, so you need to specifically tell Rails that the foreign key should point to the users table instead (but still use the author_id field to do so.)


#### How to use authorization in view with Helper

File: index.html.erb

```html
<% admins_only do %>

<ul class="actions">
  <li>
    <%= link_to "New Project", new_admin_project_path, class: 'new' %>
  </li>
</ul>

<% end %>
```

File: application_helper.rb

```ruby
module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        ( parts << 'Ticketee').join(' - ')
      end
    end
  end

  def admins_only(&block)
    block.call if current_user.try(:admin?)
  end
end


```
The admins_only method takes a block (as promised), which is the code between
the admins_only do and end in your view. To run this code in the block, you call
block.call , which only runs it if current_user.try(:admin?) returns true . This
try method tries a method on an object; if the object is nil (as it would be if no
user is currently logged in), try gives up and returns nil , rather than raising a
NoMethodError exception.


#### Member routes vs. collection routes
When you’re looking at defining custom routes outside the normal seven RESTful
routes, you’ll come across these terms: member routes and collection routes. The
difference can often be confusing for people learning Rails—which type do you use,
and when?
Collection routes are typically used when you want to perform an action on a group of
model instances. index is an example of a collection route—other examples might
be search, or autocomplete, or export. These routes will generate URLs like
/projects/search or /projects/export.
Member routes are typically used when you want to perform an action on a single
model instance. edit, update, and destroy are all examples of member routes—
they first find an instance of a model, and then take some action on it. Other exam-
ples might be archive, or approve, or preview. These routes will generate URLs
like /projects/1/archive or /projects/3/approve.



#### References in generate model


```
  rails g model role user:references role:string project:references
```

```
class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.references :user, index: true, foreign_key: true
      t.string :role
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

```

What does this acctually mean?

The **user:references** is a shortcut for doing several things:

  - Adding a **user_id** integer field to the **roles** table

  - Adding an index to the **roles** table on the **user_id** field (seen in the migrationj as **index:true**)

  - Adding a foreign_key between the user_id field on the **roles** table and the id field on the **roles** table (seen in the migration as foreign_key: true)
  
  - Adding a belongs_to :user association to the generated Role model

##### Association Mannually

* Specifying *user_id:integer* when generating the migration

* Adding the index in the migration with *add_index* *:roles*, *user_id*

* Adding the foreign key in the migration with *add_foreign_key* *:roles* , *:users*

* Editing the generated *Role* model and adding the required association


#### Try in Real-world apps

try can be seen as a code smell. 1 If you don’t know whether or not your user variable
has a nil value, it doesn’t look like you have confidence in your code. But in this case,
you know exactly when you have nil and exactly when you don’t—if no user is current-
ly logged in, then user will be nil.
If this book were much longer and you were building a real-world production app, you
could look at implementing a “guest” user record that would always return false to
the question of admin?. But we’ll leave that for you to explore. (Hint: this is called the
Null Object Pattern.)


##### Metaprograming -> has_member? and has_manager, has_editor, has_viewer

This is a little bit of Ruby metaprogramming magic. Instead of manually defining has_manager?.
has_editor?. and has_viewer?

**define_method** takes the name of the method to define as the first argument, the arguments to the method
as the block arguments (|user|), and the content of the method as the content of the block. Thses methods work identifcally to those you'd write normally, just with less code.

File: app/models/project.rb

```ruby

class Project < ApplicationRecord
  validates :name, presence: true

  has_many :tickets, dependent: :delete_all
  has_many :roles, dependent: :delete_all

  def has_member?(user)
    roles.exists?(user_id: user)
  end

  [:manager, :editor, :viewer].each do |role|
    define_method "has_#{role}?" do |user|
      roles.exists?(user_id: user, role: role)
    end
  end

end

```

Refactoring policies

```ruby
class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.none if user.nil?
      return scope.all if user.admin?

      scope.joins(:roles).where(roles: { user_id: user })
    end
  end

  def show?
    user.try(:admin?) || record.has_member?(user)
  end

  def update?
    user.try(:admin?) || record.has_manager?(user)
  end
end

```


```ruby

```

### Links

Developer
---------------------
-   [Rodolfo Peixoto](http://www.rogpe.me)
