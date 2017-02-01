require 'rails_helper'

RSpec.describe UrlsController, type: :controller do
  describe 'GET #new' do
    it 'builds a new url' do
      get :new

      expect(response).to render_template(:new)
      expect(assigns[:url]).to be_a(Url)
    end
  end

  describe 'POST #create' do
    context 'when url is valid' do
      it 'creates a new url' do
        params = { url: 'http://google.com' }
        post :create, url: params

        expect(response).to redirect_to(edit_url_path(Url.last))
      end
    end

    context 'when url is invalid' do
      it 'renders new action' do
        params = { url: 'foo' }

        expect { post :create, url: params }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'GET #show' do
    context 'when url exists' do
      it 'redirects to url' do
        url = create(:url, url: 'https://google.com')
        get :show, code: url.code

        expect(response).to redirect_to('https://google.com')
      end
    end

    context 'when url does not exist' do
      it 'returns 404 not found' do
        get :show, code: '123abcd'

        expect(response.status).to eq(404)
      end
    end
  end
end
