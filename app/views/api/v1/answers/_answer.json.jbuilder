json.extract! answer, :id, :body, :question_id, :user_id, :updated_at

json.question answer.question, :id, :title, :description

json.comments do
  json.array! answer.comments do |comment|
    json.partial! 'api/v1/comments/comment',
    comment: comment
  end
end

json.user answer.user, :id, :first_name, :last_name

json.votes answer.votes
