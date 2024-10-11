defmodule Repo do
  use Ecto

  Ecto.register_procedure("cms_GetUser", %{"@age" => :int} , "EXEC cam_GetUser")

end
