defmodule LiveBlog.CommentFeed do
  use Agent
  alias LiveBlog.Comment
  alias LiveBlog.Post

  def start_link(_) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def comment(%Post{id: post_id}, comment) do
    Agent.update(__MODULE__, fn comments ->
      new_comment = %Comment{id: next_id(comments), post_id: post_id, comment: comment}

      Map.update(comments, post_id, [new_comment], fn existing_comments ->
        existing_comments ++ [new_comment]
      end)
    end)
  end

  def for_post(post_id) do
    Agent.get(__MODULE__, &Map.get(&1, post_id, []))
  end

  defp next_id(comments) do
    comments
    |> Map.values()
    |> List.flatten()
    |> Enum.map(& &1.id)
    |> Enum.max(&>=/2, fn -> 0 end)
    |> Kernel.+(1)
  end
end
