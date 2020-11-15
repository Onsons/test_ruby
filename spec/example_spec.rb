require 'spec_helper'

describe 'Your application' do

  it "works!" do
    get '/'
    expect(last_response.status).to eq 200
  end
  it "gets the history!" do
    get '/history'
    expect(last_response.status).to eq 200
  end
  it "delete all data in the history!" do
    get '/delete-history'
    expect(last_response.status).to eq 302
  end

  # todo: Add more tests here

end