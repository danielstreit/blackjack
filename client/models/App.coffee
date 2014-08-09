#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'cash', new CashPot()
    @set 'cashView', new CashPotView {model: @get 'cash' }
    @set 'deck', deck = new Deck()
    do @newGame

  dealerAction: =>
    hand = @get('dealerHand')
    if not hand.at(0).get('revealed') then hand.at(0).flip()
    score = do hand.scores
    if score[0] >= 17 or (score[1] > 17 and score[1] <= 21) then do hand.stand
    else
      do hand.hit
      if hand.scores()[0] <= 21 then do @dealerAction

  newGame: =>
    # do @get('cash').askForBet
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('stand', @dealerAction)
    @get('playerHand').on('bust', @endGame)
    @get('dealerHand').on('bust stand', @endGame)

  endGame: =>
    playerScore = do @get('playerHand').scores
    playerScore = if playerScore[1] <= 21 then playerScore[1] else playerScore[0]
    dealerScore = do @get('dealerHand').scores
    dealerScore = if dealerScore[1] <= 21 then dealerScore[1] else dealerScore[0]

    if playerScore > 21 then console.log 'dealer wins'
    else if dealerScore > 21 then console.log 'player wins'
    else if dealerScore > playerScore then console.log 'dealer wins'
    else if playerScore > dealerScore then console.log 'player wins'
    else console.log 'push'
