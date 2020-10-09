defmodule TypoKiller.CLITest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO

  alias TypoKiller.CLI

  @help_message """
  TypoKiller - qu'est que ce
  ---------------------
  Usage:
    typokiller <command> <options>

  Available commands: run

  Options
    -p, --path <path>          Run TypoKiller in the given path

  Example:

    typokiller run --path ~/my_project


  """

  @invalid_options_message """
  Error -  invalid args:

  --something
  --another-thing

  """

  @no_action_message """
  Error: no action provided.

  Available actions: run

  """

  @unknown_action_message """
  Error: unknown action 'whatever'.

  Available: run

  """

  test "prints the help message" do
    assert capture_io(fn -> CLI.main(["--help"]) end) == @help_message
  end

  test "prints the invalid options message" do
    assert capture_io(fn -> CLI.main(["--something", "--another-thing"]) end) == @invalid_options_message
  end

  test "prints the no action message" do
    assert capture_io(fn -> CLI.main() end) == @no_action_message
  end

  test "prints the unknown action message" do
    assert capture_io(fn -> CLI.main(["whatever"]) end) == @unknown_action_message
  end
end
