require 'rails_helper'

RSpec.feature 'Timelines' do
  fixtures :timelines

  feature 'Public Timelines' do
    scenario 'I can find the link to the public timelines' do
      visit '/'

      within 'nav' do
        click_link 'Public Timelines'
      end

      expect(current_path).to eq('/timelines/public')
      expect(page).to have_content('Public timelines')
    end

    scenario 'I should only see public timelines' do
      visit '/timelines/public'

      expect(page).to have_content('My Public Timeline')
      expect(page).not_to have_content('My Private Timeline')
    end

    scenario 'I can see the timeline of a public timeline' do
      visit '/timelines/public'

      click_on 'My Public Timeline'

      expect(page).to have_content('My Public Timeline')
    end

    scenario 'I can see the list of events for a public timeline' do
      visit '/timelines/public'
      click_on 'My Public Timeline'

      click_on 'Events'

      expect(page).to have_content('All categories')
    end

    scenario 'I can see the list of eras for a public timeline' do
      visit '/timelines/public'
      click_on 'My Public Timeline'

      click_on 'Eras'

      expect(page).to have_content('Eras')
    end

    scenario 'I cannot see the buttons to create a new timeline' do
      visit '/timelines/public'

      expect(page).not_to have_button('New timeline')
      expect(page).not_to have_button('Import JSON')
    end
  end
end
