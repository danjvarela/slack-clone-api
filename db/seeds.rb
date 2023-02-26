user = User.find_by(email: "email@example.com")
user2 = User.find_by(email: "email2@example.com")

if user.blank?
  user = User.create email: "email@example.com", password: "password"
end

if user2.blank?
  user2 = User.create email: "email2@example.com", password: "password"
end

channel1 = user.created_channels.empty? ? Channel.create(name: "User 1 channel", creator: user) : user.created_channels.first
channel1.members << user2 unless channel1.members.include?(user2)
