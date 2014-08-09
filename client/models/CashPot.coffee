class window.CashPot extends Backbone.Model

  initialize: ->
    @set 'funds', 2000
    @set 'bet', 25

  askForBet: =>
    @trigger 'newBet', @

  playerWin: =>
    console.log @get 'funds'
    @set 'funds', parseInt(@get 'funds') + parseInt(@get 'bet')
    console.log @get 'funds'

  playerLose: =>
    console.log @get 'funds'
    @set 'funds', parseInt(@get 'funds') - parseInt(@get 'bet')
    console.log @get 'funds'

  playerBlackjack: =>
    console.log @get 'funds'
    @set 'funds', parseInt(@get 'funds') + parseInt(@get 'bet') * 1.5
    console.log @get 'funds'
