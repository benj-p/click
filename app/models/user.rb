class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  has_many :registrations
  has_many :sections, through: :registrations
  has_many :attempts
  has_many :curriculums, -> { where is_teacher: true }

  mount_uploader :photo, PhotoUploader

end
