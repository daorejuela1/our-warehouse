require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :view do
  it 'displays plans details correctly' do
    render
    assert_select 'h5', text: 'Free'
    assert_select 'h6', text: '$0/month'
  end
end
