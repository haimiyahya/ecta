defmodule Repo do
  use Ecto2
  use Ecto

  Ecto2.register_procedure("cms_GetUser", %{"@age" => :int} , "EXEC cam_GetUser")

end
