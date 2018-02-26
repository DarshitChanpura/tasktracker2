# TaskTracker2


Design Choices:

-Users
 - Manager to User is a many-to-many relation
 - Only a manager can assign tasks and to only those users who are managed by it
 - A user must 'manage' itself in order to see its tasks.
 - A user who is not a manager can only choose to manage itself, while a user
   who is a manager can choose to manage all the users.

-Tasks
 - Only a user's manager can assign them a task.
 - On pressing 'Start Working', application logs start_time and only on clicking
   'Stop' can the record be saved and a new entry is added to task report as the
   time spent on the particular task.





To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
