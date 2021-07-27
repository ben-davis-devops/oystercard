require 'Oystercard'

describe Oystercard do
  let(:entry_station){ double :station }
  let(:exit_station){ double :station}
  # let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

  it 'default balance of 0' do
    expect(subject.balance).to eq 0
  end 

  it 'can respond to top_up' do 
    expect(subject).to respond_to(:top_up).with(1).argument
  end

  # it 'can respond to deduct' do 
  #   expect(subject).to respond_to(:deduct).with(1).argument
  # end

  it 'can top_up card with new balance' do 
    expect{ subject.top_up(10)}.to change {subject.balance}.by(10)
  end 

  it 'throws error when exceeding maximum balance' do
    subject.top_up(90)
    expect{ subject.top_up(5)}.to raise_error 'Maximum balance exceeded'
  end

  # it 'deducts the fare from balance' do 
  #   subject.top_up(50)
  #   expect{ subject.deduct(2)}.to change {subject.balance}.by(-2)
  # end

  # it 'touches_in for journey' do
  #   expect(subject).to respond_to(:touch_in)
  # end

  # it 'touches_out for journey' do 
  #   expect(subject).to respond_to(:touch_out)
  # end

  it 'is initially not in journey?' do 
    expect(subject).not_to be_in_journey
  end 

  it 'is user in journey?' do
    subject.top_up(50)
    subject.touch_in(entry_station)
    expect(subject).to be_in_journey
  end

 it 'can touch out' do
    subject.top_up(10)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject).not_to be_in_journey
  end

  it '@balance must be at least 1 to touch_in' do
    subject.top_up(0)
    expect{ subject.touch_in(entry_station) }.to raise_error 'You cannot ride - you broke'
  end 

  it 'fare deducted from balance' do
    subject.top_up(10)
    subject.touch_in(entry_station)
    expect {subject.touch_out(exit_station)}.to change {subject.balance}.by(-Oystercard::MINIMUM_FARE)
  end
  
  it 'stores the entry station' do
    subject.top_up(10)
    subject.touch_in(entry_station)
    expect(subject.entry_station).to eq entry_station
  end

  it 'stores the exit station' do
    subject.top_up(10)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.exit_station).to eq exit_station
  end

  it 'has an empty list of journeys by default' do
    expect(subject.journey_log).to be_empty
  end

  # it 'stores journey' do
  #   subject.top_up(10)
  #   subject.touch_in(entry_station)
  #   subject.touch_out(exit_station)
  #   expect(subject.journey_log).to include journey
  # end
 
end 