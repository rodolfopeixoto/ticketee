FactoryBot.define do
  factory :project do
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph(2) }
  end
end
