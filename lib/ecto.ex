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
          IO.warn "some param was not supplied"

     end
  end

  # defmacro expose_func(name, content) do
  #   quote do
  #     def unquote(:"#{name}")() do
  #       unquote(content)
  #     end
  #   end
  # end

  defmacro expose_func(name, param, content) do
    quote do
      def unquote(:"#{name}")(param_val) do
        IO.inspect unquote(param), label: "sql params"
        call_db(unquote(:"#{name}"), unquote(param), unquote(content), param_val)
      end
    end
  end

  # defmacro expose_call_func(name, content, param, param_val) do
  #   quote do
  #     IO.inspect unquote(name), label: "invoking sql"
  #     IO.inspect unquote(param_val), label: "quoted param_val"
  #     #sql_content =
  #     #expose_call_func2(fn_)
  #     call_db(unquote(content), unquote(param), unquote(param_val))
  #   end
  # end

  defmacro expose_call_func2(fn_name, param_val) do
    quote do
      unquote(:"fn_#{fn_name}")(unquote(param_val))
    end
  end

  defmacro expose_call_db(name, param_def, content, param_val) do

    IO.inspect(name)

    #unquote(:"fn_#{fn_name}")(unquote(param_val))
    quote do
      Repo.calldb(unquote(name), unquote(param_def))
    end
  end

  defmacro expose_call_db(name) do
    IO.inspect(name, label: "aiyi")
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

        #name2 = unquote(name)
        #name2 = quote do: name2
        name = unquote(name)

        param_def = unquote(param_def)
        param_def1 = quote do: param_def

        IO.inspect param_def, label: "superman"
        IO.inspect param_def1, label: "superman1"

        #IO.inspect name2, label: "iiihhh"



        quote do

          proc_name = unquote(name)
          proc_name = unquote(proc_name)

          IO.inspect proc_name, "subhanallah"

          #proc_param_def = unquote(param_def1)


          #expose_call_db(proc_name)
          #IO.inspect proc_name, label: "ikan"
          #IO.inspect proc_param_def, label: "ayam"
        end

        #IO.inspect(param_def, label: "iiii")

        # quote do: proc_param_def = param_def

        # quote do: var!(a) = 1

        #IO.inspect unquote(param_def), label: "param def"

        #validate_param(unquote(param_def), param_vals)

        #IO.inspect unquote(content), label: "sql content"

        #fn_name = unquote("fn_#{name}")
        #content2 = unquote(content)

        #param = unquote(param_def)
        #IO.inspect(name2)

        #IO.inspect(param_def, label: "kkkk")

        #quote do
          #expose_call_db(unquote(name2), unquote(param_def), content, param_val)
          #var!(proc_name) = name2
          #proc_name = unquote(name2)
          #proc_param_def = unquote(param_def)

          #expose_call_db(proc_name)
          #IO.inspect proc_name, label: "ikan"
          #IO.inspect proc_param_def, label: "ayam"
        #end


        #quote do

          #content = unquote(content)
          #expose_call_func2(unquote(name), unquote(param_val))
        #  calldb(unquote(content2), param_defs, param_val)

        #end
        #expose_call_func2(unquote(name), param_val)
        #expose_call_func(unquote(name), unquote(content), unquote(param_def), param_val)
        #call_db(unquote(content), unquote(param), unquote(param_val))

        #unquote(content)
      end

    end
  end

  defmacro register_procedure(name, param, content) do
    quote do
      Ecto.expose_func(unquote(:"#{name}"), unquote(param), unquote(content))
      #Ecto.expose_func(unquote(:"c_#{name}"), unquote(param), unquote(content))
      #Ecto.expose_func(unquote(:"fn_#{name}"), unquote(param), unquote(content))
      #Ecto.expose_func(unquote(:"p_#{name}"), unquote(param))
      #Ecto.expose_func(unquote(:"c_#{name}"), unquote(content))
      #Ecto.expose_macro(unquote(:"#{name}"), unquote(param), unquote(content))
    end
  end

end
