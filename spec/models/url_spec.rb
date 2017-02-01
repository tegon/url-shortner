require 'rails_helper'

RSpec.describe Url do
  before { build(:url) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_uniqueness_of(:url) }
    it { is_expected.to allow_value('https://google.com').for(:url) }
    it { is_expected.to allow_value('http://google.com').for(:url) }
    it { is_expected.to_not allow_value('http').for(:url) }
    it { is_expected.to_not allow_value('htts').for(:url) }
  end

  it 'generates a unique code for new urls' do
    url = create(:url, code: '123abc')
    new_url = build(:url, code: '123abc')

    expect(new_url).to be_valid
  end

  it 'gerenates a new value when database throws a unique exception' do
    allow(SecureRandom).to receive(:urlsafe_base64).and_return('123abc', 'abc123')
    url = create(:url, code: '123abc')
    allow(Url).to receive(:find_by).and_return(nil)
    new_url = Url.create_unique(url: 'https://google.com', code: '123abc')

    expect(new_url).to be_valid
  end
end
