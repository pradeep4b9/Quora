json.extract! user, :id, :first_name, :last_name, :email, :topic_ids, :followers, :followed_users

json.topics do
  json.array! user.topics do |topic|
    json.partial! 'api/v1/topics/topic', topic: topic
  end
end

json.avatar user.avatar.url
json.success "true"
