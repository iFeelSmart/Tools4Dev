#Source https://www.andyibanez.com/posts/getting-started-app-store-connect-api/
# Usage
# ruby $Tools4Dev_PATH/Source/Apple/token.rb<ISSUER_ID> <KEY_ID> <P8_FILEPATH> 
require "base64"
require "jwt"

ISSUER_ID = ARGV[0]
KEY_ID = ARGV[1]
P8_FILEPATH = ARGV[2]

private_key = OpenSSL::PKey.read(File.read(P8_FILEPATH))

token = JWT.encode(
   {    iss: ISSUER_ID,
    exp: Time.now.to_i + 20 * 60,
    aud: "appstoreconnect-v1"
   },
   private_key,
   "ES256",
   header_fields={
     kid: KEY_ID }
 )

puts token
