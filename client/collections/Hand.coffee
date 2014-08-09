class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @isDealer) ->
    @set(array)
    do @scores
    @on 'add', @scores

  stand: ->
    console.log 'stand triggered', @
    @trigger 'stand', @

  hit: ->
    @add(@deck.pop()).last()
    if @score > 21
      console.log 'bust trigger', @
      @trigger 'bust', @

  newHand: (deck) ->
    @deck = deck
    cards = if @isDealer then do deck.dealDealer else do deck.dealPlayer
    @reset cards
    do @scores

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce
      if score + 10 <= 21
        @score= score + 10
      else
        @score = score
    else
      @score = score

