require 'rails_helper'

RSpec.describe Event, type: :model do
  let!(:event) { build(:event) }

  it "has a valid factory" do
    expect(event).to be_valid
  end

  it "is not valid without a name" do
    expect validate_presence_of(:name)
  end

  it "is valid without description" do
    valid_event = build(:event, description: nil)
    expect(valid_event).to be_valid
  end

  it "is valid with maximum name length" do
    expect validate_length_of(:name).is_at_most(50)
  end
  
  it "is not valid without a name" do
    expect validate_presence_of(:start_date)
  end

  it "is not valid without a name" do
    expect validate_presence_of(:start_time)
  end
end
