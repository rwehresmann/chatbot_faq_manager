FactoryGirl.define do
  factory :tag do
    name "tag"

    trait :with_links do
      before(:create) { |tag| p tag.links << create(:link) }
    end

    trait :with_questions do
      before(:create) { |tag| tag.questions << create(:question) }
    end
  end
end
