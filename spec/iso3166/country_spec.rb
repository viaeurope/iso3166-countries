# frozen_string_literal: true

RSpec.describe ISO3166::Country do
  describe ".new" do
    it "returns a country instance" do
      expect(ISO3166::Country.new("BR")).to be_a(ISO3166::Country)
    end

    context "not found" do
      it "returns nil" do
        expect(ISO3166::Country.new("X")).to be_nil
      end
    end
  end
end
