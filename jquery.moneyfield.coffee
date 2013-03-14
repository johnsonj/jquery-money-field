$ = jQuery
value_field_selector = "[data-money-field]"

defaults = 
	prefix: '$'

$.fn.extend \
  moneyfield: (params) ->
  	opt = $.extend(defaults, params)

  	this.each ->
  		# Prevent multiple bindings
  		if $(this).data('money-field')
  			return this;

  		$(this).data('money-field', opt)

  		# Bind to update on keys
	  	$(this).keyup update_value_field

	  	# Set initial value
	  	$val = get_value_field.call(this)
	  	$(this).val(convert_actual_to_friendly.call($val, opt.prefix))

	  	this

get_value_field = ->
	$(this).parent().find(value_field_selector)

convert_input_to_actual = (prefix)->
	$(this).val().replace(/\./g,"").replace(prefix, "")

convert_actual_to_friendly = (prefix)->
	dollars = $(this).val()/100

	"#{prefix}#{dollars.toFixed(2)}"


update_value_field = ->	
	cursor_pos = $(this).caret().start
	prefix = $(this).data('money-field').prefix

	$val = get_value_field.call(this)
	$val.val(convert_input_to_actual.call(this, prefix))
	$(this).val(convert_actual_to_friendly.call($val, prefix))

	$(this).caret(cursor_pos,cursor_pos)