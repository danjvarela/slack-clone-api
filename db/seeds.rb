user = User.find_by(email: "email@example.com")

if user.blank?
  user = User.create email: "email@example.com", password: "password"
end
