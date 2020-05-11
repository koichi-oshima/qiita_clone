FactoryBot.define do
  factory :article do
    title { Faker::Lorem.characters(number: Random.new.rand(1..50)) }
    body { Faker::Lorem.paragraph(sentence_count: 10) }
    user
  end
end
