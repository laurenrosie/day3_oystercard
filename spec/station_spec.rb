require "./lib/station"

describe Station do
subject(:station) { described_class.new("station",1) }

it { is_expected.to respond_to(:name)}
it { is_expected.to respond_to(:zone)}

end
