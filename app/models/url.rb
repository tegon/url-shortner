class Url < ActiveRecord::Base
  validates :url, presence: true, format: URI::regexp, uniqueness: true
  validates :code, presence: true

  before_validation :generate_code

  def self.create_unique(attributes)
    create!(attributes)
  rescue SQLite3::ConstraintException => e
    create_unique(attributes)
  end

  private

  def generate_code
    new_code = SecureRandom.urlsafe_base64(5)

    until Url.find_by(code: new_code).nil? do
      new_code = SecureRandom.urlsafe_base64(5)
    end

    self.code = new_code
  end
end
