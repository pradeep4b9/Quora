json.extract! comment, :id, :body, :user_id, :answer_id, :updated_at

json.user comment.user, :id, :first_name, :last_name, :email
