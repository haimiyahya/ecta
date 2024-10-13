defmodule Ecto do

  defmacro __using__(opts) do
    quote(bind_quoted: [opts: opts]) do
      import Ecto
      @behaviour Ecto
    end
  end

  @callback call_db(proc_name ::  term, param :: map(), sql :: term, param_val :: map()) :: {:ok, result :: map} | {:error, reason :: term}

  def validate_param(param_defs, param_vals) do

    param_val_param_names =
      param_vals
      |> Enum.map(fn {item, _} -> item end)

    param_def_param_names = param_defs |> Map.keys()

    case Enum.all?(param_def_param_names, fn x -> Enum.member?(param_val_param_names, x) end) do
        true -> ""
        false ->
          Enum.each(param_def_param_names,
            fn x ->
              case Enum.member?(param_val_param_names, x) do
                false -> IO.inspect "not found #{x}"
              end
          end)
          raise ArgumentError, message: "some param was not supplied"

     end
  end


  defmacro expose_func(name, param, content) do
    quote do
      def unquote(:"fn_#{name}")(param_val) do
        IO.inspect("calling function", label: "fn signature")
        IO.inspect unquote(param), label: "sql params"
        IO.inspect param_val, label: "param val"
        call_db(unquote(:"#{name}"), unquote(param), unquote(content), param_val)
      end
    end
  end


  defmacro expose_macro(name, param, _content) do
    quote do
      defmacro unquote(:"#{name}")(param_val) do

        {:%{}, _, param_vals} = param_val
        validate_param(unquote(param), param_vals)
        proc_name = unquote(name)

        quote do
          Repo.unquote(:"fn_#{proc_name}")(unquote(param_val))
        end

      end
    end
  end

  defmacro register_procedure(name, param, content) do
    quote do
      Ecto.expose_func(unquote(:"#{name}"), unquote(param), unquote(content))
      Ecto.expose_macro(unquote(:"#{name}"), unquote(param), unquote(content))
    end
  end

end
