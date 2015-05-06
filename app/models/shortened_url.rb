# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  long_url     :string
#  short_url    :string
#  submitter_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, :long_url, presence: true, uniqueness: true

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visited_urls,
    class_name: "Visit",
    foreign_key: :shortened_url_id,
    primary_key: :id
  )

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


# constants
# attributes
# validations
# custom validations
# associations
# class methods & factory methods
# instance methods
# proteced
# private
