require 'rails_helper'

RSpec.feature 'Static pages' do
  scenario 'Visiting the home page' do
    visit '/'

    expect(page).to have_text('Personal Timeline')
  end
end
