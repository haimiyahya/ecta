defmodule EctaTest do
  use ExUnit.Case
  doctest Ecta

  test "greets the world" do
    assert Ecta.hello() == :world
  end
end
