#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'cash', new CashPot
    @set 'cashView', new CashPotView {model: @get 'cash' }
    @set 'deck', deck = new Deck
    do @newGame

  dealerAction: =>
    hand = @get('dealerHand')
    if not hand.at(0).get('revealed') then hand.at(0).flip()
    score = hand.score
    if score[0] >= 17 or (score[1] > 17 and score[1] <= 21) then do hand.stand
    else
      do hand.hit
      if score[0] <= 21 then do @dealerAction

  newGame: =>
    @set 'deck', deck = new Deck
    @set 'playerHand', do deck.dealPlayer
    @set 'dealerHand', do deck.dealDealer
    if @get('playerHand').score[1] is 21
      @trigger 'toggle'
      do @endGame
    @get('playerHand').on 'stand', @dealerAction
    @get('playerHand').on 'bust', @endGame
    @get('dealerHand').on 'bust stand', @endGame

  endGame: =>
    playerScore = @get('playerHand').score
    playerScore = if playerScore[1] <= 21 then playerScore[1] else playerScore[0]
    dealerScore = @get('dealerHand').score
    dealerScore = if dealerScore[1] <= 21 then dealerScore[1] else dealerScore[0]

    console.log 'player', playerScore, 'dealer', dealerScore

    cash = @get 'cash'
    funds = cash.get 'funds'
    bet = parseInt cash.get 'bet'

    console.log funds
    if playerScore is 21 and @get('playerHand').length is 2 then cash.set 'funds', funds + bet * 1.5 #blackjack
    else if playerScore > 21 then cash.set 'funds', funds - bet #dealer wins
    else if dealerScore > 21 then cash.set 'funds', funds + bet #player wins
    else if dealerScore > playerScore then cash.set 'funds', funds - bet #dealer wins
    else if playerScore > dealerScore then cash.set 'funds', funds + bet #player wins
    # else @

    console.log @get('cash').get 'funds'
