#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('stand', @dealerAction)

  dealerAction: =>
    hand = @get('dealerHand')
    if not hand.at(0).get('revealed') then hand.at(0).flip()
    score = do hand.scores
    if score[0] > 17 or score[1] is 17 then do hand.stand
    else
      do hand.hit
      if hand.scores()[0] < 21 then do @dealerAction
