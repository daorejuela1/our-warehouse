class Item < ApplicationRecord
  belongs_to :box
  belongs_to :user, optional: true
  has_one_attached :picture, dependent: :destroy

  VALID_DESCRIPTION_REGEX = /\A[a-zA-Z0-9\-\s]+\z/
  validates :description, format: {with: VALID_DESCRIPTION_REGEX, message: "Invalid name format, only the special character '-' & '  ' are accepted"}, presence: true

  validate :correct_file_mime_type
  validates :user, uniqueness: {scope: :users}

  private

  def correct_file_mime_type
    if !picture.attached? || (picture.attached? && !picture.image?)
      picture.purge if picture.persisted?
      errors.add(:picture, 'Image must be a JPG or PNG file')
    end
  end

end
