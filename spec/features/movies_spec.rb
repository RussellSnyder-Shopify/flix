require 'rails_helper'

RSpec.describe 'Movies', type: :system do
  describe '#index' do
    describe '- less than 20 movies' do
      it 'displays all movies' do
        FactoryBot.create_list(:movie, 8)

        visit movies_path

        page.assert_selector('[data-test-id="movie-list"] > section', count: 8)
      end

      it 'pagination is not shown' do
        page.assert_selector('nav.pagy-nav', count: 0)
      end
    end

    describe '- more than 20 movies' do
      describe 'Pagination' do
        it 'shows first 20 movies if more than 30 exist' do
          FactoryBot.create_list(:movie, 30)

          visit movies_path

          page.assert_selector('[data-test-id="movie-list"] > section', count: 20)
        end
        it 'shows correct page highlighted'
        it 'shows the correct page when a number is clicked'
        it 'shows the correct page when next is clicked'
        it 'shows the correct page when prev is clicked'
        it 'prev is not shown if pagination is the first page'
      end
    end
  end
end
