require 'rqrcode'
class Box < ApplicationRecord
  belongs_to :account
  belongs_to :user
  has_one_attached :qr_code, dependent: :destroy
  validates :name, presence: true, uniqueness: {scope: :account, case_sensitive: false}
  validate :boxes_limit

  def boxes_limit
    active_subscription = ActsAsTenant.current_tenant.subscriptions.find { |dict| dict['status'] == 'active' }
    if self.new_record? && (ActsAsTenant.current_tenant.boxes.count > 0) && (!active_subscription &&  active_subscription.name == 'Free')
      errors.add(:base, "Free plans cannot have more than one boxes")
    elsif self.new_record? && (ActsAsTenant.current_tenant.boxes.count > 4) && (active_subscription && active_subscription.name == 'Moderate')
      errors.add(:base, "Moderate plans cannot have more than five boxes")
    end
  end

  def add_qr_code(url)
    if !qr_code.attached?
      qrcode = RQRCode::QRCode.new(url)
      IO.binwrite("/tmp/#{id}.png", qrcode.as_png.to_s)
      qr_code.attach(io: File.open("/tmp/#{id}.png"), filename: "Box-#{id}.png")
    end
  end

end
