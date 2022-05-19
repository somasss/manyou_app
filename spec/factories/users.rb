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
end
