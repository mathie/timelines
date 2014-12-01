$ ->
  if $('#timeline').length > 0
    createStoryJS
      type: 'timeline'
      width: '100%'
      height: '550'
      embed_id: 'timeline'
      source: $('#timeline').data('src')
