# Ss2

To start SS2 app in dev mode:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phoenix.server`

To Start in production mode:
  ```
  mix deps.get
  mix compile
  mix amnesia.create -db Database --disk
  mix test
  MIX_ENV=prod mix compile;MIX_ENV=prod mix phoenix.digest;MIX_ENV=prod PORT=4092 mix phoenix.server
  ```


