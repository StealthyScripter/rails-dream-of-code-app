require 'rails_helper'

RSpec.describe "Mentors", type: :request do
  describe "GET /mentors" do
    context 'mentors exist' do
      before do
        (1..3).each do |i|
          Mentor.create!(
            first_name: "Mentor#{i}",
            last_name: "Smith",
            email: "mentor#{i}@dreamofcode.com",
            max_concurrent_students: 5
          )
        end
      end

      it 'returns a page containing names of all mentors' do
        get '/mentors'
        expect(response.body).to include('Mentor1')
        expect(response.body).to include('Mentor2')
        expect(response.body).to include('Mentor3')
      end

      it 'returns successful response' do
        get '/mentors'
        expect(response).to have_http_status(:success)
      end
    end

    context 'mentors do not exist' do
      it 'returns a page with the title Mentors' do
        get '/mentors'
        expect(response.body).to include('Mentors')
      end

      it 'does not contain any mentor list items' do
        get '/mentors'
        expect(response.body).not_to include('<li>')
      end

      it 'returns successful response' do
        get '/mentors'
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET /mentors/:id" do
    context 'mentor exists' do
      let!(:mentor) do
        Mentor.create!(
          first_name: "Jane",
          last_name: "Smith",
          email: "jane.smith@dreamofcode.com",
          max_concurrent_students: 3
        )
      end

      it 'returns a page containing the mentor details' do
        get "/mentors/#{mentor.id}"
        expect(response.body).to include('Jane')
        expect(response.body).to include('Smith')
        expect(response.body).to include('jane.smith@dreamofcode.com')
      end

      it 'returns successful response' do
        get "/mentors/#{mentor.id}"
        expect(response).to have_http_status(:success)
      end
    end

    context 'mentor does not exist' do
      it 'returns a not found response' do
        get '/mentors/999'
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end