require 'journey'
describe Journey do
  let(:entry_station) {double :entry_station}
  let(:exit_station) {double :exit_station}
  let(:zone) {double :zone}

  describe "#start" do
    it "creates new instance of Journey class with entry_station set" do
      subject.start(name, zone)
      expect(subject.journey.entry_station.name).to eq(name)
    end
  end

  describe "#finish" do
    it "sets exit_station" do
      subject.finish(name,zone)
      expect(subject.journey.exit_station.name).to eq(name)
    end
  end
end
