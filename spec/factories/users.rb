FactoryBot.define do
  factory :user do
    name {"x"}
    email{"x@gmail.com"}
    password{"xxxxxx"}
    password_confirmation{"xxxxxx"}
    admin {false}
  end

  factory :user2, class: User do
    name {"z"}
    email{"z@gmail.com"}
    password{"zzzzzz"}
    password_confirmation{"zzzzzz"}
    admin {true}
  end

  factory :user3, class: User do
    name {"t"}
    email{"t@gmail.com"}
    password{"tttttt"}
    password_confirmation{"tttttt"}
    admin {true}
    trait :with_a_task_and_label do
      after(:build) do |user|
        user.task << FactoryBot.build(:task, :with_label)
      end
    end
  end
end
