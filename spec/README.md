to run tests:

```
bundle exec rspec
```

Capybara needs assets need to be precompiled

run

```
rake assets:clobber
rake assets:precompile
```

if DB is stuck, open rails console and run

```
ActiveRecord::Base.connection.execute("BEGIN TRANSACTION; END;")
```
