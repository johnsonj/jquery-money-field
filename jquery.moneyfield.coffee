$ = jQuery
value_field_selector = "[data-money-field]"

$.fn.extend \
  moneyfield: ->
  	$(this).keyup update_value_field


get_value_field = ->
	$(this).parent().find(value_field_selector)

convert_input_to_actual = ->
	$(this).val()

update_value_field = ->
	$val = get_value_field.apply(this)
	$val.val(convert_input_to_actual.apply(this))