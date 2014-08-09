class window.CardView extends Backbone.View

  tagName: 'img'

  className: 'card'

  template: _.template 'img/<% if(revealed){%>cards/<%=rankName%>-<%=suitName%><%}else{%>card-back<%}%>.png'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    # console.log @model.attributes
    @$el.attr 'src', @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'
