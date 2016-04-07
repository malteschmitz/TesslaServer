defmodule TesslaServer.SpecProcessor do
  @moduledoc """
  Entry point for processing a Tessla Spec generated by the Tessla Compiler
  """

  alias TesslaServer.SpecProcessor.{Preprocessor, Lexer, Parser, GraphBuilder}

  @spec process(String.t) :: any
  def process(spec) do
    processed = spec
                |> Preprocessor.process
                |> Lexer.lex
                |> Parser.parse
                |> GraphBuilder.build
  end
end
