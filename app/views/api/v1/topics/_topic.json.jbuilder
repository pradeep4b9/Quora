json.extract! topic, :id, :title, :description

json.questions do
  json.array! topic.questions do |question|
    json.partial! 'api/v1/questions/question', question: question
  end
end
