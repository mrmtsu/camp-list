FactoryBot.define do
  factory :comment do
    user_id { 1 }
    content { "Good！" }
    association :article
  end
end
