json.extract! question, :id, :title, :description, :user_id, :updated_at

json.user question.user, :id, :first_name, :last_name, :email

json.answers do
  json.array! question.answers do |answer|
    json.partial! 'api/v1/answers/answer', answer: answer
  end
end

json.topics do
  json.array! question.topics do |topic|
    json.extract! topic, :id, :title, :description
  end
end
