defmodule TheProgram do

  require Repo

  def the_user() do

    Repo.cms_GetUser(%{"ikan2" => "ayam"})

  end

end
