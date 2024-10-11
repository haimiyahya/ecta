defmodule Ecto do

  defmacro __using__(opts) do
    quote(bind_quoted: [opts: opts]) do
      import Ecto

      #@interface_module Keyword.get(opts, :for)
    end
  end

  defmacro validate_param(param_def, param_val) do

    quote do
      {:%{}, _, list_of_item} = unquote(param_val)

      supplied_param =
        list_of_item
        |> Enum.map(fn {item, _} -> item end)

     param_spec = unquote(param_def) |> Map.keys

     case Enum.all?(param_spec, fn x -> Enum.member?(supplied_param, x) end) do
        true -> ""
        false -> IO.warn "param is invalid"
     end

    end
  end

  defmacro expose_func(name, content) do
    quote do
      def unquote(:"#{name}")() do
        unquote(content)
      end
    end
  end

  defmacro expose_pfunc(name, content) do
    quote do
      defp unquote(:"#{name}")() do
        unquote(content)
      end
    end
  end

  defmacro expose_macro(name, param_def, content) do
    quote do
      defmacro unquote(:"#{name}")(param_val) do
        validate_param(unquote(param_def), param_val)
        unquote(content)
      end
    end
  end

end
