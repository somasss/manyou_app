require 'rails_helper'
RSpec.describe 'ユーザー機能', type: :system do

  describe 'ユーザー登録機能' do
    context 'ユーザーを新規作成した場合' do
      it 'ユーザーが新規に登録される' do
        visit new_user_path
        fill_in'user[name]',with: 'y'
        fill_in'user[email]',with: 'y@gmail.com'
        fill_in'user[password]',with: 'yyyyyy'
        fill_in'user[password_confirmation]',with: 'yyyyyy'
        select 'true', from: 'user_admin'
        click_on '登録する'
        expect(page).to have_content'登録に成功しました'
      end
    end

    context 'ユーザーがログインせずにタスク一覧画面に飛ぼうとしした場合' do
      it 'ログイン画面に遷移される' do
        visit tasks_path
        expect(page).to have_content'Log in'
      end
    end
  end

  describe 'セッション機能' do
    context 'アカウント情報を記載した場合' do
      it 'ログインできる' do
        FactoryBot.create(:user)
        visit sessions_new_path
        fill_in'session[email]', with: 'x@gmail.com'
        fill_in'session[password]', with: 'xxxxxx'
        click_on 'Log in'
        expect(page).to have_content'x@gmail.com'
      end
    end

    context 'ログインして自分の詳細ページにアクセスした場合' do
      it 'アクセスできる' do
        user = FactoryBot.create(:user)
        visit sessions_new_path
        fill_in'session[email]', with: 'x@gmail.com'
        fill_in'session[password]', with: 'xxxxxx'
        click_on 'Log in'
        user_id = user.id
        visit user_path(user_id)
        expect(page).to have_content'ユーザー名'
      end
    end

    context 'ログアウトボタンを押した場合' do
      it 'ログアウトできる' do
        user = FactoryBot.create(:user)
        visit sessions_new_path
        fill_in'session[email]', with: 'x@gmail.com'
        fill_in'session[password]', with: 'xxxxxx'
        click_on 'Log in'
        visit users_path
        click_on'Logout'
        expect(page).to have_content'ログアウトしました'
      end
    end
  end

  describe '管理画面' do
    context '管理ユーザーでアクセスした場合' do
      it '管理画面にアクセスできる' do
        FactoryBot.create(:user2)
        visit sessions_new_path
        fill_in'session[email]', with: 'z@gmail.com'
        fill_in'session[password]', with: 'zzzzzz'
        click_on 'Log in'
        visit users_path
        click_on '管理者'
        expect(page).to have_content'管理者画面'
      end
    end
    
    context '一般ユーザーでアクセスした場合' do
      it '管理画面にアクセスできない' do
        FactoryBot.create(:user)
        visit sessions_new_path
        fill_in'session[email]', with: 'x@gmail.com'
        fill_in'session[password]', with: 'xxxxxx'
        click_on 'Log in'
        visit users_path
        click_on '管理者'
        expect(page).to have_content'管理者以外はアクセスできません'
      end
    end

    context '管理ユーザーでアクセスした場合' do
      it '新規ユーザーの登録ができる' do
        FactoryBot.create(:user2)
        visit sessions_new_path
        fill_in'session[email]', with: 'z@gmail.com'
        fill_in'session[password]', with: 'zzzzzz'
        click_on 'Log in'
        visit admin_users_path
        click_on 'New User'
        fill_in'user[name]', with: 'g'
        fill_in'user[email]', with: 'g@gmail.com'
        fill_in'user[password]', with: 'gggggg'
        fill_in'user[password_confirmation]', with: 'gggggg'
        select 'true', from: 'user_admin'
        click_on '登録する'
        expect(page).to have_content'登録に成功しました'
      end
    end

    context '管理ユーザーでアクセスした場合' do
      it 'ユーザの詳細画面にアクセスできる' do
        FactoryBot.create(:user2)
        visit sessions_new_path
        fill_in'session[email]', with: 'z@gmail.com'
        fill_in'session[password]', with: 'zzzzzz'
        click_on 'Log in'
        visit admin_users_path
        click_on 'Show'
        expect(page).to have_content'ユーザー詳細ページ'
      end
    end

    context '管理ユーザーでアクセスした場合' do
      it 'ユーザの編集画面からユーザを編集できる' do
        FactoryBot.create(:user2)
        visit sessions_new_path
        fill_in'session[email]', with: 'z@gmail.com'
        fill_in'session[password]', with: 'zzzzzz'
        click_on 'Log in'
        visit admin_users_path
        click_on 'Edit'
        fill_in'user[name]', with: 'g'
        fill_in'user[email]', with: 'g@gmail.com'
        fill_in'user[password]', with: 'gggggg'
        fill_in'user[password_confirmation]', with: 'gggggg'
        select 'true', from: 'user_admin'
        click_on '更新する'
        expect(page).to have_content'ユーザーの更新に成功しました'
      end
    end

    context '管理ユーザーでアクセスした場合' do
      it 'ユーザーの削除ができる' do
        FactoryBot.create(:user2)
        visit sessions_new_path
        fill_in'session[email]', with: 'z@gmail.com'
        fill_in'session[password]', with: 'zzzzzz'
        click_on 'Log in'
        visit admin_users_path
        click_on 'Destroy'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content'ユーザーの削除に成功しました.'
      end
    end

  end

end