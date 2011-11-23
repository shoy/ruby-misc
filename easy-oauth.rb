###############################################################
# easy-oauth.rb OAuth_Informatio_File
# 
# -- OAuth_Information_File Format --
# OAuth URL
# Consumer Key
# Consumer Secret
# -----------------------------------
# 
# Easy OAuth Authorization.
# 1. Read OAuth_Information_File, and 
#    automatically request OAuth authorization
# 2. Launch browser, and go to confirmation web page
# 3. < Input OAuth verifier >
# 4. Show access_token and access_token_secret
# 
###############################################################
require 'rubygems'
require 'oauth'

DEFAULT_OATH_URL 	= 'http://twitter.com'
CONSUMER_KEY 		= 'Your Consumer Key'
CONSUMER_SECRET 	= 'Your Consumer Secret'

if ARGV.size == 1
  # Read OAuth_Information_File
  f = open(ARGV[0], "r")
  oauth_url = f.gets.chomp
  ckey = f.gets.chomp
  csecret = f.gets.chomp
else
  # If no arguments
  oauth_url = DEFAULT_OATH_URL
  ckey = CONSUMER_KEY
  csecret = CONSUMER_SECRET
end

# Get request token
consumer = OAuth::Consumer.new(ckey, csecret, :site => oauth_url)
request_token = consumer.get_request_token

# # Output authorization URL
# puts "Access this URL and approve => #{request_token.authorize_url}"
# Launch browser and go to confirmation web page
IO.popen("open -a 'Google Chrome' '" + request_token.authorize_url + "'")

# Prompt OAuth Verifier
print "Input OAuth Verifier: "
oauth_verifier = $stdin.gets.chomp.strip

access_token = request_token.get_access_token(:oauth_verifier => oauth_verifier)

# Output access_token and access_secret
puts "Access token: #{access_token.token}"
puts "Access token secret: #{access_token.secret}"

