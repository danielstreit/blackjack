#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'cash', new CashPot
    @set 'cashView', new CashPotView {model: @get 'cash' }
    @set 'playerHand', new Hand []
    @set 'dealerHand', new Hand [], true
    @set 'deck', deck = new Deck

    @get('playerHand').on 'stand', =>
      do @dealerAction
      do @toggle
    @get('playerHand').on 'bust', =>
      do @get('cash').playerLose
      do @toggle
    @get('dealerHand').on 'bust', =>
      do @get('cash').playerWin
    @get('dealerHand').on 'stand', =>
      do @endGame

    do @newGame

  dealerAction: =>
    hand = @get('dealerHand')
    if not hand.at(0).get('revealed')
      do hand.at(0).flip
      do hand.scores
    score = hand.score
    if score >= 17 then do hand.stand
    else
      do hand.hit
      score = hand.score
      if score <= 21 then do @dealerAction

  toggle: ->
    @trigger 'toggle', @

  newGame: =>
    if @get('deck').length < 20
      @set 'deck', deck = new Deck
    deck = @get('deck')
    @get('playerHand').newHand deck
    @get('dealerHand').newHand deck

    if @get('playerHand').score is 21
      do @get('cash').playerBlackjack
      do @toggle

  endGame: =>
    playerScore = @get('playerHand').score
    dealerScore = @get('dealerHand').score

    cash = @get 'cash'

    if dealerScore > playerScore then do cash.playerLose
    else if playerScore > dealerScore then do cash.playerWin

