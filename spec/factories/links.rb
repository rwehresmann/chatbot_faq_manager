FactoryGirl.define do
  factory :link do
    url "www.alink.com"
    description "Link description"

    trait :with_tag do
      before(:create) { |link| link.tags << (create(:tag)) }
    end
  end
end
