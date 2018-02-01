class Application < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  after_create :set_key

  def reset_key
    set_key
  end

  private
    def set_key
      self.key = JsonWebToken.encode({application_id: id, created_at: Time.now.to_s})
      self.save
    end
end
