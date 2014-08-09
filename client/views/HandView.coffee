class window.HandView extends Backbone.View

  className: 'hand'

  #todo: switch to mustache
  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change bust', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text =>
      scores = @collection.scores()
      if scores[1] is 21 and @collection.length is 2 then @collection.stand()
      if scores[0] and scores[1]
        if scores[1] > 21 then scores[0]
        else scores[1]
      else scores[0]
