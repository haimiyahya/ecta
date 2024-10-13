defmodule Repo do
  use Ecto

  def call_db(_name, _param_def, sql, param_val) do

    IO.inspect "calling database.."
    IO.inspect sql, label: "sql to be executed"
    IO.inspect param_val, label: "param_values"
    #IO.inspect "param_val"
    #IO.inspect param_val
    IO.inspect param_val, label: "quoted param_val"

    #quote do

    #  IO.inspect(unquote(param_val), label: "unquoted param_val")

    #end

    # %{"result" => "testing"}

  end

  Ecto.register_procedure("cms_GetUser", %{"@age" => :int}, "EXEC cam_GetUser")



end
