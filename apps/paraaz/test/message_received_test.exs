defmodule MessageRecievedTest do
  use Paraaz.Case
  alias Paraaz.CategoryType.MessageReceived

  test "should be able to create message received category type" do
    category = MessageReceived.type()
    assert category.value == "message_received"
  end
end
