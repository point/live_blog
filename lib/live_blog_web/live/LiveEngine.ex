defmodule LiveBlogWeb.LiveEngine do
  use LiveBlogWeb, :live_view
  alias LiveBlog.Feed

  def mount(_params, _session, socket) do
    {:ok, assign(socket, posts: Feed.all())}
  end

  def render(assigns) do
    ~H"""
    <div class="blog-content">
      <ul>
        <%= for post <- @posts do %>
          <.live_component
            id={"post-compoment-#{post.id}"}
            module={LiveBlogWeb.BlogPostComponent}
            post={post}
          />
        <% end %>
      </ul>
    </div>
    """
  end
end
