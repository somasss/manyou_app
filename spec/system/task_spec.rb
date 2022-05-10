require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in'task[name]',with: '田中'
        fill_in'task[detail]',with: '田中'
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
        # binding.irb
        expect(task_first).to have_content "6"
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