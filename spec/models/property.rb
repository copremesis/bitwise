
require 'spec_helper'

describe Property do
  it 'should have Fitness' do
    Property.first.has_amenity?('Fitness').should be_true
  end

  it 'should not have Foo' do
    Property.first.has_amenity?('Foo').should be_false
  end

  it 'can query several amenities as a search result' do
    Property.with_amenities("A/C", "Washer/Dryer Hookups", "Washer/Dryer in Unit").size.should == 3
  end
end
