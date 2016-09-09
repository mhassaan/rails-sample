class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :excluding_archived, lambda {where(archived_at: nil)}

  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end

  def archive
    self.update(archived_at:Time.now)
  end

  def active_for_authentication?
    super && archived_at.nil?
    #The call to super in this method will allow all of the other checks to take place,
    #to make sure the user’s account is unlocked, and confirmed, and so on. If you left
    #that out, you’d stop archived users from signing in, but you’d also allow locked users
    #or unconfirmed users to sign in, as long as they weren’t archived. Not good.
  end

  def inactive_message
    archived_at.nil? ? super : :archived
  end
end
