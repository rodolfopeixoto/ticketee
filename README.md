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


### Links

Developer
---------------------
-   [Rodolfo Peixoto](http://www.rogpe.me)
