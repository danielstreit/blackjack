class window.CashPot extends Backbone.Model

  initialize: ()->
    @set 'funds', 2000
    @set 'bet', 25

  askForBet: =>
    @trigger 'newBet', @
