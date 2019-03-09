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
  has_many :feed_events

  mount_uploader :photo, PhotoUploader

  def feed
    feed_events
  end

end
