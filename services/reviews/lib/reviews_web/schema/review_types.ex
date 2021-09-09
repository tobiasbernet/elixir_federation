defmodule ReviewsWeb.Schema.ReviewTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Federation.Notation

  alias ReviewsWeb.Resolvers

  object :review do
    key_fields("id")

    field(:id, non_null(:id))
    field(:body, non_null(:string))

    field :author, :user do
      provides_fields("username")
      resolve(&Resolvers.Reviews.review/3)
    end

    field(:product, :product)
  end

  object :user do
    extends()
    key_fields("id")

    field(:id, non_null(:id), do: external())

    field(:username, :string) do
      external()
      resolve(&Resolvers.Reviews.username/3)
    end

    field(:reviews, list_of(:review)) do
      resolve(&Resolvers.Reviews.find/3)
    end

    field(:number_of_reviews, :integer) do
      resolve(&Resolvers.Reviews.number_of_reviews/3)
    end
  end

  object :product do
    extends()
    key_fields("upc")

    field(:upc, non_null(:string)) do
      external()
    end

    field(:reviews, list_of(:review))
  end
end
