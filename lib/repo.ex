defmodule Repo do
  use Ecto

  def call_db(name, param_def, sql, param_val) do

    IO.inspect "calling database.."
    IO.inspect(name, label: "proc name")
    IO.inspect(param_def, label: "proc param definition")
    IO.inspect sql, label: "proc sql to be executed"
    IO.inspect param_val, label: "proc param_values"

  end

  Ecto.register_procedure("cms_GetUser", %{"@age" => :int}, "EXEC cms_GetUser")

end
