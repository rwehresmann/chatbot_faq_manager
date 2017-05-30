require './spec/spec_helper.rb'
include Utils

describe Helper do
  subject { Helper.new.call }

  it { is_expected.to eq success_hash }
end
