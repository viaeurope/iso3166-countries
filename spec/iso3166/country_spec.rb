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
      translation: "Brazil",
      number: "076",
      in_eu?: false,
      currency_code: "BRL"
    )
  end

  describe "#translation" do
    it "drops trailing (the)" do
      expect(ISO3166::Country.new("NL").translation).to eq "Netherlands"
      expect(ISO3166::Country.new("BR").translation).to eq "Brazil"
    end
  end

  context "#in_eu?" do
    let(:country_code) { "NL" }

    it "is in eu" do
      expect(subject.in_eu?).to eq true
    end
  end

  context "not found" do
    let(:country_code) { "X" }

    it "returns nil" do
      expect(subject).to be_nil
    end
  end

  describe ".find_by" do
    it "finds by alpha2" do
      expect(ISO3166::Country.find_by(alpha2: "BR")).to eq ISO3166::Country.new("BR")
    end

    it "finds by alpha3" do
      expect(ISO3166::Country.find_by(alpha3: "BRA")).to eq ISO3166::Country.new("BR")
    end

    it "raises error with multiple arguments" do
      expect { ISO3166::Country.find_by(alpha2: "BR", alpha3: "BRA") }
        .to raise_error ISO3166::Country::TooManyArguments
    end
  end

  describe ".[]" do
    it "works as .new(alpha2)" do
      expect(ISO3166::Country["BR"]).to eq ISO3166::Country.new("BR")
    end
  end

  describe ".all_names_with_codes" do
    it "returns list of 'officially-assigned' countries with code and name" do
      expect(ISO3166::Country.all_names_with_codes).to eq([
        ["Brazil", "BR"],
        ["Switzerland", "CH"],
        ["New Zealand", "NZ"],
        ["Netherlands (the)", "NL"]
      ])
    end
  end

  describe ".all" do
    it "returns array of country instances" do
      expect(ISO3166::Country.all).to eq([
        ISO3166::Country.new("BR"),
        ISO3166::Country.new("CH"),
        ISO3166::Country.new("NZ"),
        ISO3166::Country.new("NL")
      ])
    end
  end
end
