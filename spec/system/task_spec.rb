require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before(:each) do
    FactoryBot.create(:user3)
    visit sessions_new_path
    fill_in'session[email]', with: 't@gmail.com'
    fill_in'session[password]', with: 'tttttt'
    click_on 'Log in'
    visit new_task_path
    fill_in'task[name]',with: '田中'
    fill_in'task[detail]',with: '田中'
    fill_in'task[deadline]',with: '002022-01-01'
    select '高', from: 'task[importance]'
    select '着手', from: 'task_status'
    click_on '登録する'
    visit new_task_path
    fill_in'task[name]',with: '加藤'
    fill_in'task[detail]',with: '加藤'
    fill_in'task[deadline]',with: '002022-05-01'
    select '低', from: 'task[importance]'
    select '未着手', from: 'task_status'
    click_on '登録する'
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        expect(page).to have_content'加藤'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content '田中'
      end
    end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('.task_all') 
        task_first = task_list[0]
        expect(task_first).to have_content "加藤"
      end
    end
    
    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限日が一番近いものが上に表示される' do
        visit tasks_path
        binding.irb
        click_on '終了期限'
        task_list = all('.task_all') 
        task_first = task_list[0]
        expect(task_first).to have_content "田中"
      end
    end

    context 'タスクをタイトルで検索した場合' do
      it '検索条件に該当するものが上に表示される' do
        visit tasks_path
        fill_in'search',with: '田中'
        click_on '検索'
        expect(page).to have_content "田中"
      end
    end

    context 'タスクをステータスで検索した場合' do
      it '検索条件に該当するものが上に表示される' do
        visit tasks_path
        select '着手', from: 'status_serch'
        click_on '検索'
        expect(page).to have_content "田中"
      end
    end

    context 'タスクをタイトルとステータスで検索した場合' do
      it '検索条件に該当するものが上に表示される' do
        visit tasks_path
        fill_in'search',with: '田中'
        select '着手', from: 'status_serch'
        click_on '検索'
        expect(page).to have_content "田中"
      end
    end

    context '優先順位でソートするというリンクを押した場合' do
      it '優先順位の高い順に並び替えられたタスク一覧が表示される' do
        visit tasks_path
        click_on '優先度'
        task_list = all('.task_all') 
        task_first = task_list[0]
        expect(task_first).to have_content "田中"
      end
    end

  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        visit tasks_path
        expect(page).to have_content '田中'
       end
     end
  end

end