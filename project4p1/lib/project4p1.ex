defmodule Project4p1 do
  def main(args) do
    #~~~~~~~~~~#
    [numNodes, request] = args
    numClients = String.to_integer(numNodes)
    numMessages = String.to_integer(request) #No of tweet a user has to make.
    #~~~~~~~~~~#
    :ets.new(:MainDatabase, [:set, :public, :named_table])

    #Start the server
    Server.start_link()
    #Start clients
    spawnClients(1,numClients,numMessages)

  end

    #Inittialize all the clients as genservers.
  def spawnClients(count,numClients,numMessages)do
    userName = Integer.to_string(count)
    pid = Client.start_link(userName,Integer.to_string(numClients),Integer.to_string(numMessages))
    :ets.insert(:MainDatabase, {userName, pid})
    if (count != numClients) do spawnClients(count+1,numClients,numMessages) end
  end



end
