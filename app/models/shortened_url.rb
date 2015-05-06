class ShortenedUrl < ActiveRecord::Base

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id
  )

  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true, uniqueness: true

  def self.random_code
    rand_code = SecureRandom.urlsafe_base64
    while exists?(short_url: rand_code)
      rand_code = SecureRandom.urlsafe_base64
    end
    rand_code
  end

  # create will create an instance and save to database with attributes

  def self.create_for_user_and_long_url!(user, long_url)
    create!(long_url: long_url, short_url: self.random_code, submitter_id: user.id)
  end

end
