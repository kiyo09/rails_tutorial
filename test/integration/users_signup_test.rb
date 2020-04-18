require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path                                                             # signup_path(/signup)ユーザー登録ページにアクセス
    assert_difference 'User.count', 1 do                                        # User.countでユーザー数をカウント、1とし、ユーザー数が変わったらtrue、変わってなければfalse
      post users_path, params: { user: { name:                  "Example User", # signup_path(/signup)からusers_path(/users)へparamsハッシュのuserハッシュの値を送れるか検証
                                         email:                 "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!                                                            # 指定されたリダイレクト先(users/show)へ飛べるか検証
    assert_template 'users/show'
    assert is_logged_in?                                                # users/showが描画されているか確認
  end
end