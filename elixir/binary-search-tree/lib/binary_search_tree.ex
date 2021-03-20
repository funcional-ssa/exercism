defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """

  @spec new(any) :: bst_node
  def new(data) do
    # Your implementation here
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(nil, data), do: new(data)

  def insert(%{data: node_data, left: left_data} = tree, data) when node_data >= data do
    %{tree | left: insert(left_data, data)}
  end

  def insert(%{data: node_data, right: right_data} = tree, data) when node_data < data do
    %{tree | right: insert(right_data, data)}
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(nil), do: []

  def in_order(%{data: data, right: right, left: left}) do
    in_order(left) ++ [data] ++ in_order(right)
  end
end
