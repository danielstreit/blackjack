class window.CashPot extends Backbone.Model

  initialize: (cash = 2000)->
    @set 'cash', cash
    @set 'bet', do ->
      $('#bet').text do $('#bet-bar').val

  askForBet: =>
    @trigger 'newBet', @
