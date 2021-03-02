# frozen_string_literal: true

RSpec.describe ISO3166::Country do
  subject { described_class.new(country_code) }

  let(:country_code) { "BR" }

  it "is a country instance" do
    expect(subject).to be_a(ISO3166::Country)
  end

  it "has attributes" do
    expect(subject).to have_attributes(
      alpha2: "BR",
      alpha3: "BRA",
      name: "Brazil",
      number: "076"
    )
  end

  context "not found" do
    let(:country_code) { "X" }

    it "returns nil" do
      expect(subject).to be_nil
    end
  end
end
