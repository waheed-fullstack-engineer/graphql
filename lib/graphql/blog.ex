defmodule Graphql.Blog do
  @moduledoc """
  The Blog context.
  """

  import Ecto.Query, warn: false
  alias Graphql.Repo
  alias Graphql.Blog.Post

  @doc """
  Returns the list of posts with user assoc.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    # query =
    #   from(p in Post,
    #     join: u in assoc(p, :user),
    #     preload: [user: u]
    #   )

    Repo.all(Post)
  end

  @doc """
  Returns the list of posts with user assoc and pagination applied.

  ## Examples
      iex> list_posts()
      [%Post{}, ...]
  """

  def get_pagination_list_posts(limit, page) do
    # Repo.all(from(p in Post, limit: ^limit, offset: ^offset)) 

    Post
    |> Repo.paginate(%{page: page, page_size: limit})
  end

  @doc """
  Gets a single post.

  Return `nil` if the Post does not exist.

  ## Examples

      iex> get_post(123)
      %Post{}

      iex> get_post(456)
      nil

  """
  def get_post(id), do: Repo.get(Post, id)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  alias Graphql.Blog.Comment

  @doc """
  Returns the list of comments with assoc to user and post data.

  ## Examples

      iex> list_comments()
      [%Comment{}, ...]

  """
  def list_comments do
    # query =
    #   from(c in Comment,
    #     join: u in assoc(c, :user),
    #     join: p in assoc(c, :post),
    #     preload: [user: u, post: p]
    #   )

    Repo.all(Comment)
  end

  def get_pagination_list_comments(limit, page) do
    Comment
    |> Repo.paginate(%{page: page, page_size: limit})
  end

  def list_post_comments(post_id) do
    query =
      from(c in Comment,
        where: c.post_id == ^post_id
      )

    Repo.all(query)
  end

  @doc """
  Gets a single comment.

  Return `nil` if the Comment does not exist.

  ## Examples

      iex> get_comment!(123)
      %Comment{}

      iex> get_comment(456)
      nil

  """
  def get_comment(id), do: Repo.get(Comment, id)

  @doc """
  Creates a comment.

  ## Examples

      iex> create_comment(%{field: value})
      {:ok, %Comment{}}

      iex> create_comment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a comment.

  ## Examples

      iex> update_comment(comment, %{field: new_value})
      {:ok, %Comment{}}

      iex> update_comment(comment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a comment.

  ## Examples

      iex> delete_comment(comment)
      {:ok, %Comment{}}

      iex> delete_comment(comment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking comment changes.

  ## Examples

      iex> change_comment(comment)
      %Ecto.Changeset{data: %Comment{}}

  """
  def change_comment(%Comment{} = comment, attrs \\ %{}) do
    Comment.changeset(comment, attrs)
  end
end
