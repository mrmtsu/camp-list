FactoryBot.define do
  factory :log do
    content { "タープもいいかも" }
    association :article
  end
end
