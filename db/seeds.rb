# メインのサンプルユーザーを1人作成する
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "ゲスト",
             email: "guest@sapliapli.com",
             password:              "sapliapli123",
             password_confirmation: "sapliapli123",
             admin:     false,
             activated: true,
             activated_at: Time.zone.now)

Faker::Config.locale = :ja

# 追加のユーザーをまとめて生成する
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

# ユーザーの一部を対象にマイクロポストを生成する
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end

#リレーションシップの作成
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }


# サンプルサプリの生成
50.times do |n|
  suppli_name  = "example-sapli#{n+1}"
  sup = Supplement.create!(name: suppli_name,
                           description: "サプリの説明文" * 10)
  sup.img.attach(io: File.open("./db/fixtures/noimage.jpg"), filename: "noimage.jpg")
end

#サンプルレビューの生成
users = User.order(:created_at).take(6)
Faker::Config.locale = :en
10.times do |n|
  supplement = Supplement.find_by(id: n + 1)
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.reviews.create!(supplement: supplement, supplement_id: n + 1, content: content, score: rand(0..5))}
end

# 99.times do |n|
#   suppli_name  = "example-sapli#{n+1}"
#   supplement = Supplement.create!(name:  suppli_name)
#   supplement.img.attach("./app/assets/images/noimage.jpg")
# end