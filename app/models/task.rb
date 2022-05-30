class Task < ApplicationRecord
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
  belongs_to :user
  validates :name, presence: true
  validates :detail, presence: true
  enum importance: {低: 0, 中: 1, 高: 2}
  scope :latest, ->  { all.order(deadline: :asc) } 
  scope :importance,  ->  { all.order(importance: :desc) } 
  scope :name_search, ->  (params) do 
    where('name LIKE ?', "%#{params}%") 
  end
  scope :status_serch, -> (params) do 
    where(status: params)
  end
end
