$ ->
  if $('#timeline').length > 0
    createStoryJS
      type: 'timeline'
      width: '100%'
      height: '550'
      embed_id: 'timeline'
      source: $('#timeline').data('src')

  $('input[type=date]').datepicker
    format: 'yyyy-mm-dd'
    todayHighlight: true
    autoclose: true