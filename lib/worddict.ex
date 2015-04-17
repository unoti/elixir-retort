defmodule WordDict do
  @moduledoc """
  WordDict can look up words, select random words, and create quality streams
  of random letters for word games.
  """
  defmodule WordResult do
    defstruct word: "_",        # The word, as a string
              exists?: true,    # The word exists in the dictionary.
              naughty?: false,  # The word is not to be spoken in polite company.
              iffy?: false,     # The word is likely not a real word, it has a star in the source dictionary.
              cool?: false      # This word has been identified as a cool word.
  end

  @doc """
  Starts a new word dictionary server.
  """
  def start_link do
    Agent.start_link(fn -> loadDict end)
  end

  @doc """
  Lookup checks to see if the word exists.  Returns a WordResult.
  """
  def lookup(word_dict, word) do
    lookup = Agent.get(word_dict, &HashDict.get(&1, word))
    if lookup do
      lookup
    else
      %WordResult{word: word, exists?: false}
    end
  end

  defp loadDict do
    # Temporary test dictionary
    HashDict.new
    |> HashDict.put("cat", %WordResult{word: "cat"})
    |> HashDict.put("shit", %WordResult{word: "shit", naughty?: true})
  end

end

