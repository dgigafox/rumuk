defmodule Convertor.CrdtToModel do
alias Riak.CRDT.Map, as: M
    
    def to_model(crdt, kind) do
        model = reduce_map(crdt,kind)
        struct(kind, model)
    end

    def reduce_map(map, kind) do
         keys =  :orddict.fetch_keys(map)
        Enum.reduce( keys, %{}, fn(x, acc) -> 
        :maps.put(trim_key(x), 
        get_value(x, map, kind), acc) end)
    end

     defp get_value({value, type} = key , map, kind) when type==:map do
        nested_struct = kind.__struct__ |>  Map.get(trim_key(key))
        map = :orddict.fetch(key, map)
        result = reduce_map(map, kind)
        struct(nested_struct, result)
    end

     defp get_value(key, map, kind) do
       :orddict.fetch(key, map)
    end

     defp trim_key(key) do
       case key do
           {value, :register} -> String.to_atom(value)
           {value, :counter} -> String.to_atom(value)
           {value, :set} -> String.to_atom(value)
           {value, :flag} -> String.to_atom(value)
           {value, :map} -> String.to_atom(value)
       end 
    end
end