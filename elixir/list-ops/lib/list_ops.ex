defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0

  def count([_h | tail]), do: 1 + count(tail)

  @spec reverse(list) :: list
  def reverse([]), do: []

  def reverse(l) do
    reduce(l, [], fn acc, x -> [acc | x] end)
  end

  @spec map(list, (any -> any)) :: list
  def map([], f) do
    []
  end

  def map([h | t], f) do
    [f.(h) | map(t, f)]
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _), do: []

  def filter([head | tail], f) do
    if f.(head) do
      [head | filter(tail, f)]
    else
      filter(tail, f)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _), do: acc

  def reduce([head | tail], acc, f) do
    reduce(
      tail,
      f.(head, acc),
      f
    )
  end

  @spec append(list, list) :: list
  def append([], b), do: b

  def append([head | tail], b), do: [head | append(tail, b)]

  def foldr([], acc, _), do: acc

  def foldr([head | tail], acc, f) do
    f.(head, foldr(tail, acc, f))
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    foldr(ll, [], fn acc, el ->
      append(acc, el)
    end)
  end
end
