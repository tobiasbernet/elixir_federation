defmodule ReviewsWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Federation.Schema

  import_types(ReviewsWeb.Schema.ReviewTypes)

  alias ReviewsWeb.Resolvers

  query do
    @desc "Get reviews"
    field :reviews, list_of(:review) do
      resolve(&Resolvers.Reviews.reviews/3)
    end
  end
end
