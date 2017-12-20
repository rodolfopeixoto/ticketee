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

### Links

Developer
---------------------
-   [Rodolfo Peixoto](http://www.rogpe.me)
