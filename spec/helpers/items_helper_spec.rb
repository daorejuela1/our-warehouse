require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ItemsHelper. For example:
#
# describe ItemsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ItemsHelper, type: :helper do
  describe "Validates values" do
    let(:item) {create(:item)}

    it 'Returns null if there are not available boxes' do
      boxes = helper.get_available_boxes(nil)
      expect(boxes).to eq([])
    end
  end
end
