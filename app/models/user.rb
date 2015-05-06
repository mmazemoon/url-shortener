class User < ActiveRecord::Base

  has_many(
    :shortened_urls,
    class_name: "ShortenedUrl",
    foreign_key: :submitter_id,
    primary_key: :id
  )

  validates :email, presence: true, uniqueness: true

end
