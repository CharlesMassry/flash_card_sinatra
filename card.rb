ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'flash_card'
)

class Card < ActiveRecord::Base
end

class Deck < ActiveRecord::Base
  has_many :cards, dependent: :destroy
end

