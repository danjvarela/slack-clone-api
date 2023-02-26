user = User.find_by(email: "email@example.com") || User.create(email: "email@example.com", password: "password")
user2 = User.find_by(email: "email2@example.com") || User.create(email: "email2@example.com", password: "password")
user3 = User.find_by(email: "email3@example.com") || User.create(email: "email3@example.com", password: "password")

channel = Channel.find_by(name: "user's channel") || Channel.create(name: "user's channel", creator: user)
channel.members << user2 unless channel.members.include?(user2)

channel2 = Channel.find_by(name: "user2's channel") || Channel.create(name: "user2's channel", creator: user2)
channel2.members << user3 unless channel2.members.include?(user3)
