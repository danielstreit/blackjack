class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button>
    <button class="stand-button">Stand</button>
    <button class="new-game">New Game</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container hidden"></div>
    <div class="bet-area"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .new-game": ->
      do @model.newGame
      do @toggleButtons
      do @render

  initialize: ->
    @render()
    @model.on 'toggle', @toggleButtons, @

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.bet-area').html do @model.get('cashView').render

  toggleButtons: ->
    console.log('toggleButtons')
    $('.hit-button').toggle()
    $('.stand-button').toggle()
    $('.new-game').toggle()
