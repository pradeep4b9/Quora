json.array! @topics do |topic|
  json.partial! 'api/v1/topics/topic', topic: topic
end
