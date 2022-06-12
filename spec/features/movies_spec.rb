require 'rails_helper'

RSpec.describe 'Movies', type: :system do
  describe '#index' do
    describe '- less than 10 movies' do
      it 'displays all movies' do
        FactoryBot.create_list(:movie, 8)

        visit movies_path

        page.assert_selector('[data-test-id="movie-list"] > section', count: 8)
      end

      it 'pagination is not shown '
    end

    describe 'Pagination' do
      it 'shows first 10 movies if more than 10 exist'
      it 'shows correct page highlighted'
      it 'shows the correct page when a number is clicked'
      it 'shows the correct page when next is clicked'
      it 'shows the correct page when prev is clicked'
      it 'prev is not shown if pagination is the first page'
    end
  end
end
