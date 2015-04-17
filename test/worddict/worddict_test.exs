defmodule WordlibTest do
  use ExUnit.Case, async: true

  test "looks up words" do
    {:ok, word_dict} = WordDict.start_link
    result = WordDict.lookup(word_dict, "cat")
    assert result.exists? == true
  end

  test "knows if words are bad" do
    {:ok, word_dict} = WordDict.start_link

    result = WordDict.lookup(word_dict, "shit")
    assert result.word == "shit"
    assert result.exists? == true
    assert result.naughty? == true
    assert result.iffy? == false
    assert result.cool? == false
  end
end
