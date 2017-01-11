require "./lib/journey_log"

describe JourneyLog do
subject(:log) { described_class.new }

it { is_expected.to respond_to(:journeys)}
it { is_expected.to respond_to(:current_journey)}
it { is_expected.to respond_to(:start_journey).with(1).argument}
it { is_expected.to respond_to(:end_journey).with(1).argument}
it { is_expected.to respond_to(:update_list)}
it { is_expected.to respond_to(:journey_nil?)}


#it { is_expected.to respond_to(:zone)}

end
