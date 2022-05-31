require 'rails_helper'
RSpec.describe 'タグ機能', type: :system do
  before(:each) do
    load Rails.root.join("db/seeds.rb")
  end

  describe '新規作成' do
    context 'タグ付きのタスクを新規作成した場合' do
      it '作成したタグが表示される' do
        FactoryBot.create(:user3)
        visit sessions_new_path
        fill_in'session[email]', with: 't@gmail.com'
        fill_in'session[password]', with: 'tttttt'
        click_on 'Log in'
        visit tasks_path
        click_on 'New Task'
        fill_in'task[name]', with: 't'
        fill_in'task[detail]', with: 't'
        check 'デイリー'
        click_on '登録する'
        visit tasks_path
        expect(page).to have_content'デイリー'
      end
    end
  end

  describe 'ソート' do
    context 'タグでソートした場合' do
      it 'ソートされたタスクが表示される'do
        FactoryBot.create(:user3)
        visit sessions_new_path
        fill_in'session[email]', with: 't@gmail.com'
        fill_in'session[password]', with: 'tttttt'
        click_on 'Log in'
        visit tasks_path
        click_on 'New Task'
        fill_in'task[name]', with: 't'
        fill_in'task[detail]', with: 't'
        check 'デイリー'
        click_on '登録する'
        visit tasks_path
        click_on 'New Task'
        fill_in'task[name]', with: 'k'
        fill_in'task[detail]', with: 'k'
        check 'マンスリー'
        click_on '登録する'
        visit tasks_path
        select "デイリー", from: 'label_id'
        click_on '検索'
        expect(page).to have_content't'
      end
    end
  end
end