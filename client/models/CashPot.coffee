class window.CashPot extends Backbone.Model

  initialize: ()->
    @set 'cash', 2000
    @set 'bet', 25

  askForBet: =>
    @trigger 'newBet', @
