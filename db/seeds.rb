# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do
  20.times do |_n|
    name = Faker::Internet.username(specifier: 3..20) # バリデーションの文字数制限に当てはめる
    email = "#{_n}_" + Faker::Internet.email
    password = Faker::Internet.password(min_length: 8, max_length: 20, mix_case: true)
    User.create!(
        name: name,
        email: email,
        password: password,
        )
  end

  100.times do
    title = Faker::Lorem.sentence
    body = Faker::Lorem.paragraph
    user_id = User.pluck(:id).sample # sampleメソッドでUserテーブルのuser_idをランダム取得
    Article.create!(
        title: title,
        body: body,
        user_id: user_id,
        )
  end

  300.times do
    body = Faker::Lorem.paragraph
    user_ids = User.pluck(:id) # pluckメソッドでUserテーブルのuser_idをarray取得
    user_id = user_ids.sample # sampleメソッドでuser_idsからuser_idをランダム取得
    user_ids.delete(user_id)
    other_user_id = user_ids.sample
    article_id = Article.where(user_id: other_user_id).pluck(:id).sample
    next unless article_id # article_idがfalseの場合、次のループへ

    Comment.create!(
        body: body,
        user_id: user_id,
        article_id: article_id, #user_id以外のid(user_ids)が作成した記事に投稿する(投稿者と記事作成者が同一にならないようにする)
        )
  end

  Article.find_each do |article|
    other_user_ids = User.where.not(id: article.user_id).pluck(:id) # 記事作成者以外のuser_idをarray取得
    other_user_ids.each do |other_user_id|
      next unless [true, false].sample # レコードを投稿する（いいねをする）かをsampleメソッドでランダムにする。

      ArticleLike.create!(
          user_id: other_user_id,
          article: article,
          )
    end
  end
end