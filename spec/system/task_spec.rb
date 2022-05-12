require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in'task[name]',with: '田中'
        fill_in'task[detail]',with: '田中'
        fill_in'task[deadline]',with: '002022-01-01'
        select '着手', from: 'task_status'
        click_on '登録する'
        expect(page).to have_content'田中'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, name: 'task', detail: 'task')
        visit tasks_path
        current_path
        Task.count
        page.html
        expect(page).to have_content 'task'
      end
    end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        FactoryBot.create(:task, name: 'task', detail: 'task1')
        FactoryBot.create(:task, name: 'task', detail: 'task2')
        FactoryBot.create(:task, name: 'task', detail: 'task3')
        FactoryBot.create(:task, name: 'task', detail: 'task6')
        visit tasks_path
        task_list = all('.task_all') 
        task_first = task_list[0]
        expect(task_first).to have_content "6"
      end
    end
    
    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限日が一番近いものが上に表示される' do
        FactoryBot.create(:task, name: 'task2', detail: 'task2', deadline: "2020-02-02")
        FactoryBot.create(:task, name: 'task1', detail: 'task1', deadline: "2020-01-01")
        FactoryBot.create(:task, name: 'task3', detail: 'task3', deadline: "2020-03-03")
        visit tasks_path
        click_on '終了期限'
        task_list = all('.task_all') 
        task_first = task_list[0]
        expect(task_first).to have_content "task1"
      end
    end

    context 'タスクをタイトルで検索した場合' do
      it '検索条件に該当するものが上に表示される' do
        FactoryBot.create(:task, name: 'task1', detail: 'task1', deadline: "2020-03-03")
        FactoryBot.create(:task, name: 'task2', detail: 'task2', deadline: "2020-03-03")
        visit tasks_path
        fill_in'search',with: '1'
        click_on 'Search'
        expect(page).to have_content "task1"
      end
    end

    context 'タスクをステータスで検索した場合' do
      it '検索条件に該当するものが上に表示される' do
        FactoryBot.create(:task, name: 'task1', detail: 'task1', deadline: "2020-03-03", status:"着手")
        FactoryBot.create(:task, name: 'task2', detail: 'task2', deadline: "2020-03-03", status:"未着手")
        visit tasks_path
        select '着手', from: 'status_serch'
        click_on 'Search'
        expect(page).to have_content "task1"
      end
    end

    context 'タスクをタイトルとステータスで検索した場合' do
      it '検索条件に該当するものが上に表示される' do
        FactoryBot.create(:task, name: '田中', detail: '田中', deadline: "2020-03-03", status:"着手")
        FactoryBot.create(:task, name: 'task2', detail: 'task2', deadline: "2020-03-03", status:"着手")
        FactoryBot.create(:task, name: '加藤', detail: '加藤', deadline: "2020-03-03", status:"未着手")
        FactoryBot.create(:task, name: 'task4', detail: 'task4', deadline: "2020-03-03", status:"未着手")
        visit tasks_path
        fill_in'search',with: '田中'
        select '着手', from: 'status_serch'
        click_on 'Search'
        expect(page).to have_content "田中"
      end
    end

    context '優先順位でソートするというリンクを押した場合' do
      it '優先順位の高い順に並び替えられたタスク一覧が表示される' do
        FactoryBot.create(:task, name: '田中', detail: '田中', deadline: "2020-03-03", importance:2)
        FactoryBot.create(:task, name: '佐藤', detail: '佐藤', deadline: "2020-03-03", importance:0)
        FactoryBot.create(:task, name: '加藤', detail: '加藤', deadline: "2020-03-03", importance:1)
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
        task = FactoryBot.create(:task, name: 'name', detail: 'task')
        id = task.id
        visit tasks_path(id)
        expect(page).to have_content 'task'
       end
     end
  end

end