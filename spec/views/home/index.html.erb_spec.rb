require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :view do
  it 'displays plans details correctly' do
    render
    assert_select 'tr>td', text: 'Free'.to_s
    assert_select 'tr>td', text: 'Moderated'.to_s
    assert_select 'tr>td', text: 'Unlimited'.to_s
  end
end
