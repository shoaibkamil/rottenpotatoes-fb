# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rottenpotatoes_session',
  :secret      => 'ef02ffe5898221dcae82318db2c3bf01ce16c86503174fe1865e186b6080f51c9500517ebda3c49660747982b4c235837d3ef74134a349b394190a19ed05fa47'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
