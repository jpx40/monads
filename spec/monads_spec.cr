require "./spec_helper"
require "./monads/**"

describe Monads do
  it "should have version" do
    Monads::VERSION.should eq("0.7.0")
  end
end
