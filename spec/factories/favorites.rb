FactoryBot.define do
  factory :favorite do
    association :article
    association :user
  end
end
