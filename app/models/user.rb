class User < ActiveRecord::Base

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable
  include DeviseTokenAuth::Concerns::User



  validates :email, presence: true, length: { minimum: 4, maximum: 25 }, if: Proc.new { |u| u.provider == 'email' }
  validates_presence_of :uid, if: Proc.new { |u| u.provider != 'email' }

  # only validate unique emails among email registration users
  validate :unique_email_user, on: :create

  # keep uid in sync with email
  before_save :sync_uid
  before_create :sync_uid


  protected

  # only validate unique email among users that registered by email
  def unique_email_user
    if provider == 'email' and self.class.where(provider: 'email', email: email).count > 0
      errors.add(:email, I18n.t("errors.messages.already_in_use"))
    end
  end

  def sync_uid
    self.uid = email if provider == 'email'
  end
end

