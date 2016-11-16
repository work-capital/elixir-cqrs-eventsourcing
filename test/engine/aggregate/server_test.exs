defmodule Engine.Aggregate.ServerTest do
  #doctest Engine.Aggregate.Server
  use ExUnit.Case

  ### COMMANDS
  alias Engine.Example.Account.Commands.{OpenAccount,DepositMoney,WithdrawMoney,CloseAccount}
  ### EVENTS
  alias Engine.Example.Account.Event.{AccountOpened,MoneyDeposited,MoneyWithdrawn,AccountClosed}

  ### HANDLERS

  ### AGGREGATES

  ### REPOSITORY
  alias Engine.Repository

  test "execute command against an aggregate" do
    account_number = UUID.uuid4

    #{:ok, aggregate} = Registry.open_aggregate(BankAccount, account_number)

    # :ok = Aggregate.execute(aggregate, %OpenAccount{account_number: account_number, initial_balance: 1_000}, OpenAccountHandler)
    #
    # Helpers.Process.shutdown(aggregate)
    #
    # # reload aggregate to fetch persisted events from event store and rebuild state by applying saved events
    # {:ok, aggregate} = Registry.open_aggregate(BankAccount, account_number)
    #
    # bank_account = Aggregate.aggregate_state(aggregate)
    #
    # assert bank_account.state.account_number == account_number
    # assert bank_account.state.balance == 1_000
    # assert length(bank_account.pending_events) == 0
    # assert bank_account.uuid == account_number
    # assert bank_account.version == 1
  end

  # test "aggregate returning an error tuple should not persist pending events or state" do
  #   account_number = UUID.uuid4
  #
  #   {:ok, aggregate} = Registry.open_aggregate(BankAccount, account_number)
  #
  #   :ok = Aggregate.execute(aggregate, %OpenAccount{account_number: account_number, initial_balance: 1_000}, OpenAccountHandler)
  #
  #   state_before = Aggregate.aggregate_state(aggregate)
  #
  #   # attempt to open same account should fail with a descriptive error
  #   {:error, :account_already_open} = Aggregate.execute(aggregate, %OpenAccount{account_number: account_number, initial_balance: 1}, OpenAccountHandler)
  #
  #   assert state_before == Aggregate.aggregate_state(aggregate)
  # end
  #
  # test "executing a command against an aggregate with concurrency error should terminate aggregate process" do
  #   account_number = UUID.uuid4
  #
  #   {:ok, aggregate} = Registry.open_aggregate(BankAccount, account_number)
  #   {:ok, stream} = EventStore.Streams.open_stream(account_number)
  #
  #   # block until aggregate has loaded its initial (empty) state
  #   Aggregate.aggregate_state(aggregate)
  #
  #   # write an event to the aggregate's stream, bypassing the aggregate process (simulate concurrency error)
  #   :ok = EventStore.Streams.Stream.append_to_stream(stream, 0, [
  #     %EventStore.EventData{
  #       event_type: "Elixir.Commanded.ExampleDomain.BankAccount.Events.BankAccountOpened",
  #       data: %BankAccountOpened{account_number: account_number, initial_balance: 1_000}
  #     }
  #   ])
  #
  #   Process.flag(:trap_exit, true)
  #
  #   spawn_link(fn ->
  #     Aggregate.execute(aggregate, %DepositMoney{account_number: account_number, transfer_uuid: UUID.uuid4, amount: 50}, DepositMoneyHandler)
  #   end)
  #
  #   # aggregate process should crash
  #   assert_receive({:EXIT, _from, _reason})
  #   assert Process.alive?(aggregate) == false
  # end
end
