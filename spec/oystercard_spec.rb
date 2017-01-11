require "./lib/oystercard"

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let (:station) {double :bank}
  let (:exit_station) {double :victoria}

  it 'should show oystercard balance' do
  expect(subject.balance).to eq(0)
  end

  it 'checks that the card has an empty list of journeys by default' do
  expect(subject.journeys).to be_empty
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'should add the value passed to balance' do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end
    it 'should throw an error if exceeding maximum balance (90)' do
      expect{subject.top_up(91)}.to raise_error "the maximum allowed balance is #{Oystercard::MAX_BALANCE} !"
    end

  end

  # describe '#deduct' do
  #
  #   it { is_expected.to respond_to(:deduct).with(1).argument }
  #   end
  #
  #   it 'should deduct fare from balance' do
  #     subject.deduct(10)
  #     expect(subject.balance).to eq -10
  #   end

  describe '#touch_in' do
    it {is_expected.to respond_to(:touch_in).with(1).argument}

    it "should change journey_status to true" do
      subject.top_up(Oystercard::MIN_BALANCE)
      subject.touch_in(station)
     expect(subject.current_journey).not_to eq(nil)
    end
    it 'raises an error if balance unsufficient' do
      expect{subject.touch_in("Bank")}.to raise_error "Unsuffient balance. Top up to at least #{Oystercard::MIN_BALANCE}!"
    end
    it "should allow the card to remember the station after touching in" do
      subject.top_up(Oystercard::MIN_BALANCE)
      subject.touch_in(station)
      expect(subject.current_journey.entry_station).to eq(station)
    end
  end

  describe '#touch_out' do
    it {is_expected.to respond_to(:touch_out)}
    it "should change journey_status to false" do
      subject.top_up(Oystercard::MIN_BALANCE)
      subject.touch_in(station)
      subject.touch_out(exit_station)
      expect(subject.current_journey).to eq(nil)
    end

    it 'deduct minimum fare at the end of a journey' do
      oystercard.top_up(50)
      oystercard.touch_in(station)
      expect {oystercard.touch_out(exit_station)}.to change{subject.balance}.by(-Oystercard::MIN_BALANCE)
    end

    it 'checks that card creates a journey touching in and out' do
      subject.top_up(Oystercard::MIN_BALANCE)
      subject.touch_in(station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to include({entry_station: station, exit_station: exit_station})
    end
  end

end
