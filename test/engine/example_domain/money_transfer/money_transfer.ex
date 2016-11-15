defmodule Engine.ExampleDomain.MoneyTransfer do
  use Aggregate, fields: [transfer_uuid: nil, source_account: nil, target_account: nil, amount: 0, reversed?: false]

  alias Engine.ExampleDomain.MoneyTransfer

  ### COMMANDS
  defmodule Commands do
    defmodule TransferMoney, do: defstruct transfer_uuid: UUID.uuid4, source_account: nil, target_account: nil, amount: nil
  end

  ### EVENTS
  defmodule Events do
    defmodule MoneyTransferRequested, do: defstruct transfer_uuid: nil, source_account: nil, target_account: nil, amount: nil
    defmodule MoneyTransferSucceeded, do: defstruct transfer_uuid: nil, source_account: nil, target_account: nil, amount: nil
    defmodule MoneyTransferFailed,    do: defstruct transfer_uuid: nil, source_account: nil, target_account: nil, amount: nil
  end

  ### ALIASES
  alias Commands.{TransferMoney}
  alias Events.{MoneyTransferRequested}

  ### API
  def transfer_money(%MoneyTransfer{} = money_transfer, 
                     %TransferMoney{transfer_uuid: transfer_uuid, 
                                    source_account: source_account,
                                    target_account: target_account,
                                    amount: amount})
                                    when amount > 0 do
    money_transfer = money_transfer |> update(%MoneyTransferRequested{transfer_uuid: transfer_uuid,
                                               source_account: source_account, target_account: target_account, amount: amount})
    {:ok, money_transfer}
  end

  ### STATE MUTATORS
  def apply(%MoneyTransfer.State{} = state, %MoneyTransferRequested{} = transfer_requested) do
    %MoneyTransfer.State{state |
      transfer_uuid: transfer_requested.transfer_uuid,
      source_account: transfer_requested.source_account,
      target_account: transfer_requested.target_account,
      amount: transfer_requested.amount
    }
  end
end
