defmodule TheProgram do

  require Repo

  def the_user() do

    Repo.cms_GetUser(%{"@age" => 10})
    #IO.inspect Repo.module_info()

  end

end
