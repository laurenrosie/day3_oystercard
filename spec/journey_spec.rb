require './lib/journey.rb'
require './lib/station.rb'

describe Journey do

  subject(:journey){described_class.new(instance_double(Station))}
  let(:bond){instance_double(Station)}

  it "has an entry station" do
    expect(journey.respond_to?(:entry_station)).to eq true
  end
  it "has an exit station" do
    expect(journey.respond_to?(:exit_station)).to eq true
  end
  it "has an exit station" do
    expect(journey.respond_to?(:exit_station)).to eq true
  end
  it "has an in_journey method" do
    expect(journey.respond_to?(:journey_complete?)).to eq true
  end
  it "can tell if journey_complete?" do
    expect(journey.journey_complete?).to eq false
  end
  it "has an exit station" do
    expect(journey.respond_to?(:exit_station)).to eq true
  end
  it "responds to finish" do
    journey.finish(bond)
    expect(journey.exit_station).to eq bond
  end
  it "responds to finish" do
    journey.finish(bond)
    expect(journey.journey_complete?).to eq true
  end
end
