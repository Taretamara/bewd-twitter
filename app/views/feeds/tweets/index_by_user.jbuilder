json.array! @tweets do |tweet|
  json.id         tweet.id
  json.message    tweet.message
  json.username   @user.username
  json.created_at tweet.created_at
end
