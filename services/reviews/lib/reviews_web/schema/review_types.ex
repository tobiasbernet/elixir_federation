defmodule ReviewsWeb.Schema.ReviewTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Federation.Schema

  object :review do
    key_fields("id")

    field(:id, non_null(:id))
    field(:body, non_null(:string))

    field :author, :user do
      provides_fields("username")
    end

    field(:product, :product)
  end

  object :user do
    extends()
    key_fields("id")

    field :id, :id do
      external()
    end

    field :username, :string do
      external()
    end

    field(:reviews, list_of(:review))
  end

  object :product do
    extends()
    key_fields("upc")

    field :upc, :string do
      external()
    end

    field(:reviews, list_of(:review))
  end

  object :service_sdl do
    field(:sdl, :string)
  end
end
