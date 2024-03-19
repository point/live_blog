defmodule LiveBlogWeb.BlogPostComponent do
  use LiveBlogWeb, :live_component

  alias LiveBlog.CommentFeed

  def mount(socket) do
    {:ok, assign(socket, comment_form_shown?: false)}
  end

  def handle_event("show-comments", _params, socket) do
    {:noreply,
     assign(socket,
       comment_form_shown?: true,
       form: to_form()
     )}
  end

  def handle_event("comment", %{"comment" => comment}, %{assigns: %{post: post}} = socket) do
    CommentFeed.comment(post, comment)
    {:noreply, assign(socket, :form, to_form())}
  end

  def render(assigns) do
    ~H"""
    <li id={"post-#{@post.id}"}>
      <h2><%= @post.title %></h2>
      <hr />
      <div>
        <%= @post.content %>
      </div>
      <%= if @comment_form_shown? do %>
        <.simple_form for={@form} phx-target={@myself} phx-submit="comment">
          <.input field={@form[:comment]} type="textarea" label="Your comment:" />
          <:actions>
            <.button>Save</.button>
          </:actions>
        </.simple_form>
      <% else %>
        <a href="#" phx-target={@myself} phx-click="show-comments">
          Comment
        </a>
      <% end %>
    </li>
    """
  end

  def to_form(), do: to_form(%{}, id: "form-#{System.unique_integer()}")
end
