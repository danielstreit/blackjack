class window.CashPotView extends Backbone.View

  className: 'betController'

  template: _.template '<input id="bet-bar" type="range" step=25 min=25 max=<% cash %> /></br>
                        <label id="bet"><%bet%></label>'

  initialize: ->
    @render
    @model.on 'newBet', do @render

  render: ->
    @$el.html @template @model.attributes

