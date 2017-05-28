FactoryGirl.define do
  factory :question do
    description "Description"

    trait :with_tag do
      before(:create) { |question| question.add_tag(create(:tag)) }
    end

    trait :with_answer do
      before(:create) { |question| question.add_answer(create(:answer)) }
    end
  end
end
