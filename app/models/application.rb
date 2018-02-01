class Application < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  attr_accessor :key

  after_create :set_key

  def reset_key
    set_key
  end

  private
    def set_key
      self.key_created_at = Time.now.to_s
      self.key = JsonWebToken.encode({application_id: id, key_created_at: key_created_at})
      self.save
      puts "[New API Key Generated][Application: #{id}][API Key: #{key}]"
    end
end
