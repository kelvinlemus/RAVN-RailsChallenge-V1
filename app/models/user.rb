class User < ApplicationRecord
  attr_accessor :skip_password_validation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :rememberable, :validatable

  # devise :database_authenticatable, :registerable,
  # :recoverable, :rememberable, :validatable

  belongs_to :country, optional: true
  has_many :user_pokemons, dependent: :destroy
  has_many :pokemons, through: :user_pokemons

  has_one_attached :avatar

  enum :role, { trainer: "trainer", admin: "admin" }

  scope :trainers, -> { where(role: "trainer") }
  scope :by_name_or_email, ->(query) { where("UPPER(users.first_name) LIKE :query OR UPPER(users.last_name) LIKE :query OR UPPER(users.email) LIKE :query", query: "%#{query.upcase}%") }

  def full_name
    return "- - -" if first_name.blank? && last_name.blank?
    [ first_name, last_name ].join(" ")
  end

  def self.send_inactivity_email_to_trainers
    day6_ago = (Time.now - 6.days).beginning_of_day # 6 days ago + current day because task will run at the end of day
    trainers.where("created_at <= ?", day6_ago - 1.day).find_each(batch_size: 100) do |trainer|
      catched_count = trainer.user_pokemons.where("created_at BETWEEN ? AND ?", day6_ago, Time.now.end_of_day).count
      next if catched_count > 0

      UserMailer.with(user_id: trainer.id).trainer_inactivity.deliver_later
    end
  end

  protected

  def password_required?
    return false if skip_password_validation
    super
  end
end
