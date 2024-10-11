defmodule Ecto2 do
  defmacro __using__(opts) do
    quote(bind_quoted: [opts: opts]) do
      import Ecto2
    end
  end

  use Ecto

  defmacro register_procedure(name, param, content) do
    quote do
      #Ecto.expose_func(unquote(:"c_#{name}"), unquote(param), unquote(content))
      Ecto.expose_func(unquote(:"p_#{name}"), unquote(param))
      Ecto.expose_func(unquote(:"c_#{name}"), unquote(content))
      Ecto.expose_macro(unquote(:"#{name}"), unquote(param), unquote(content))
    end
  end

end
