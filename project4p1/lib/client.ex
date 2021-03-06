defmodule Client do
  use GenServer

  def start_link(userName,numClients,numMessages) do

        GenServer.start_link(__MODULE__, {userName,numClients,numMessages})
    end

  def init({userName,numClients,numMessages}) do
    #IO.inspect(numClients)
    IO.inspect("started client number #{userName}")
    :global.sync()

    #as soon as this node is initialized it is added to server tables
    send(:global.whereis_name(:server),{:signup,userName,self()})
    receive do
      {:confirmation} -> {:confirmation} end
    perform_client_actions(userName,numClients,numMessages)
     {:ok, {userName,numClients,numMessages} }
  end

  def perform_client_actions(userName,numClients,numMessages)do
    z = :random.uniform(19999)
    IO.inspect(z)
    #Make list of people to follow and send list to server to add to ets

      #list = for i <-1..no_tofollow do list++i end
       #send(:global.whereis_name(:server),{:followpeople,userName,numClients,a,self()})




    #send tweets



end

end