require 'sinatra'
require 'mtg_sdk'

enable :sessions

def get_card
  legendary_cards = MTG::Card.where(set: 'DOM').where(supertypes: 'Legendary').all.to_a
  valid_cards = legendary_cards.select do |c|
    c.types.include?("Creature") || c.types.include?("Planeswalker")
  end
  valid_cards[rand(valid_cards.length)]
end

get '/' do
  session[:card] ||= get_card.image_url
  @img = session[:card]
  haml :index
end
