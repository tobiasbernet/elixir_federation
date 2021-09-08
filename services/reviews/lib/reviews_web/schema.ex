defmodule ReviewsWeb.Schema do
  use Absinthe.Schema
  import_types(ReviewsWeb.Schema.ReviewTypes)

  alias ReviewsWeb.Resolvers

  query do
    @desc "Get a review"
    field :author, :review do
      arg(:authorId, non_null(:integer))
      resolve(&Resolvers.Reviews.find/3)
    end

    @desc "Get reviews"
    field :reviews, list_of(:review) do
      arg(:id, non_null(:integer))
      resolve(&Resolvers.Reviews.reviews/3)
    end

    field :_service, :service_sdl do
      resolve(&Resolvers.Reviews.sdl/3)
    end
  end
end
