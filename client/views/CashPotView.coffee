class window.CashPotView extends Backbone.View

  className: 'betController'

  template: _.template '<input id="bet-bar" value=25 type="range" step=25 min=25 max=<%= funds %> />
                        <div>Current Bet: <span id="bet">25</span></div>'

  events:
    'change #bet-bar': ->
      @model.set 'bet', $('#bet-bar').val()
      $('#bet').text @model.get 'bet'

  initialize: ->
    @render
    @model.on 'newBet', do @render

  render: ->
    @$el.html @template @model.attributes
