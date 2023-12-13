class User < ApplicationRecord
  belongs_to :province, optional: true
  has_many :orders, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { user: 0, admin: 1 }
  after_initialize :set_default_role, if: :new_record?
  def set_default_role
    self.role ||= :user
  end

  attr_writer :login

  def login
    @login || username || email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value",
                                    { value: login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  # only allow letter, number, underscore and punctuation.
  validates :username, format: { with: /^[a-zA-Z0-9_.]*$/, multiline: true }

  validate :validate_username

  attr_accessor :province

  # validates :full_name, presence: true
  validates :email, format: { with: Devise.email_regexp }
  validates :province, presence: false, on: :create
  validates :encrypted_password, presence: true
  # validates_date :birthday, on_or_before: -> { 18.years.ago }
  validates :address, presence: true
  validates :birthday, presence: true

  validates :postal_code,
            format: { with:    /\A[A-Za-z]\d[A-Za-z] \d[A-Za-z]\d\z/,
                      message: "must be a valid Canadian postal code" }

  def validate_username
    return unless User.where(email: username).exists?

    errors.add(:username, :invalid)
  end
end
