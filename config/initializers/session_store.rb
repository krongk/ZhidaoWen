# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ZhidaoWen_session',
  :secret      => '1f7dec4efb0fc16514d3b5eb9dc6e4201f5ba621f4b1ce0f1f4abb6aa2b3f307805d2774fe677b9706679e001c1864fa5dfc5b6da1ac0b4cf7f58708734199bc'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
