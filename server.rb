require "sinatra"
require "active_record"
require "./card"

get "/" do
  @decks = Deck.all
  erb :index
end

get "/decks/new" do
  erb :new_deck
end

post "/decks" do
  deck = Deck.new(params[:deck])
  deck.name.capitalize!
  deck.save
  redirect to("/decks/#{deck.id}")
end

get "/decks/:id" do
  @deck = Deck.find(params[:id])
  erb :deck_index
end

post "/decks/:id/cards/new" do
  Card.create(params[:card])
  redirect to("/decks/#{params[:id]}")
end

get "/decks/:id/cards/random" do
  deck = Deck.find(params[:id])
  cards = Card.where(deck_id: deck.id)
  card = cards.sample
  redirect to("/decks/#{deck.id}/cards/#{card.id}")
end

get "/decks/:id/cards/:card_id"do
  @card = Card.find(params[:card_id])
  erb :front
end

post "/decks/:id/cards/:card_id/back" do
  card = Card.find(params[:card_id])
  input = params[:card][:back]
  if input.downcase == card.back.downcase
    redirect to("/decks/#{card.deck_id}/cards/#{card.id}/right")
  else
    redirect to("/decks/#{card.deck_id}/cards/#{card.id}/wrong")
  end
end

get "/decks/:id/cards/:card_id/right" do
  @deck = Deck.find(params[:id])
  erb :right
end

get "/decks/:id/cards/:card_id/wrong" do
  @deck = Deck.find(params[:id])
  @card = Card.find(params[:card_id])
  erb :wrong
end

get "/decks/:id/edit" do
  @deck = Deck.find(params[:id])
  erb :edit_deck
end

put "/decks/:id" do
  deck = Deck.find(params[:id])
  deck.update(params[:deck])
  redirect to("/")
end

delete "/decks/:id/delete" do
  deck = Deck.find(params[:id])
  deck.destroy
  redirect to("/")
end

