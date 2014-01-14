class Team < ActiveRecord::Base
  structure do
    name 'Overlords', validates: { presence: true, uniqueness: true }
    role :text
    timestamps
  end
  has_many :enrolments, dependent: :destroy
  has_many :users, through: :enrolments
end