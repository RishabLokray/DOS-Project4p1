defmodule Server do
  use GenServer

  def start_link() do
        GenServer.start_link(__MODULE__, {:ok})
    end


  def init(state)do
    IO.inspect("Started Main Server")
    :ets.new(:clientsregistry, [:set, :public, :named_table])
    :ets.new(:all_tweets, [:set, :public, :named_table])
    :ets.new(:hashtag_mentions, [:set, :public, :named_table])
    :ets.new(:following, [:set, :public, :named_table])
    :ets.new(:followers, [:set, :public, :named_table])
    api_handler_id = spawn_link(fn -> api_handler_func() end)
    :global.register_name(:server,api_handler_id)
    {:ok,state}
  end

  def api_handler_func()do
    receive do
      {:signup,userName,pid} -> register_me(userName,pid)
                                send(pid,{:confirmation})
      {:tweet,tweet,userName} -> send_tweet(tweet,userName)
      {:followpeople,userName,numClients,list,pid} -> followpeople(userName,numClients,list,pid)




    end
    api_handler_func()
  end

  def register_me(userName,pid) do
      :ets.insert(:clientsregistry, {userName, pid})
      :ets.insert(:all_tweets, {userName, []})
      :ets.insert(:following, {userName, []})
      :ets.insert(:followers, {userName, []})
    end

  def send_tweet(tweet,userName)do
       #process_string(tweet,userName)
  end

  def followpeople(userName,numClients,list,pid) do
      :ets.insert(:following,{userName,list})
      IO.inspect("#{list}")

  end



end
