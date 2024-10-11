defmodule Ecto do

  defmacro __using__(opts) do
    quote(bind_quoted: [opts: opts]) do
      import Ecto
    end
  end

  @callback call_db(sql :: term, param_def :: map(), param_val :: map()) :: {:ok, result :: map} | {:error, reason :: term}

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
          IO.warn "some param was not supplied"

     end
  end

  def call_db(sql, param_def, param_val) do

    IO.inspect sql
    IO.inspect param_def
    IO.inspect param_val

    # %{"result" => "testing"}

  end

  defmacro expose_func(name, content) do
    quote do
      def unquote(:"#{name}")() do
        unquote(content)
      end
    end
  end

  defmacro expose_func(name, content, param) do
    quote do
      def unquote(:"#{name}")(param_val) do
        call_db(unquote(content), unquote(param), param_val)
      end
    end
  end

  defmacro expose_call_func(name, content, param, param_val) do
    quote do
      IO.inspect unquote(name)
      call_db(unquote(content), unquote(param), unquote(param_val))
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
        {:%{}, _, param_vals} = param_val

        param_defs = unquote(param_def)

        validate_param(param_defs, param_vals)

        IO.inspect unquote(content)

        expose_call_func(unquote(name), unquote(content), unquote(param_def), param_val)

        #unquote(content)
      end
    end
  end

  defmacro register_procedure(name, param, content) do
    quote do
      #Ecto.expose_func(unquote(:"c_#{name}"), unquote(param), unquote(content))
      Ecto.expose_func(unquote(:"fn_#{name}"), unquote(param), unquote(content))
      #Ecto.expose_func(unquote(:"p_#{name}"), unquote(param))
      #Ecto.expose_func(unquote(:"c_#{name}"), unquote(content))
      Ecto.expose_macro(unquote(:"#{name}"), unquote(param), unquote(content))
    end
  end

end
