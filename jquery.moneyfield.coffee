$ = jQuery
value_field_selector = "[data-money-field]"

defaults = 
	prefix: ''

$.fn.extend \
  moneyfield: (params) ->
  	this.each ->
  		opts = {}
  		$.extend(opts, defaults, params)

  		# Prevent multiple bindings
  		if $(this).data('money-field')
  			return this;

  		$(this).data('money-field', opts)

  		# Bind to update on keys
	  	$(this).keypress block_invalid_chars

	  	$(this).focus update_view
	  	$(this).focusout update_view
	  	$(this).keyup update_value

	  	# Set initial value
	  	cursor_pos = $(this).caret().start;

	  	update_view.call(this)

	  	$(this).caret(cursor_pos,cursor_pos)

	  	this

get_mode = ->
	$(this).data('money-field').type_field.val()

get_value_field = ->
	$(this).parent().find(value_field_selector)

get_prefix = ->
	$(this).data('money-field').prefix

convert_input_to_actual = (prefix, append_zeros=false)->
	val_str = $(this).val().toString()
	clean_value = parseInt(val_str.replace(/\./g,"").replace(/\$/g, "").replace(/,/g,""))

	if append_zeros
		# If there is no decimal place, then make add two 0's to it, aka * 100
		# .. or if they put a decimal at the end and nothing after
		if (val_str.indexOf('.') == -1 ||  val_str.indexOf('.') == (val_str.length - 1))
			clean_value *= 100
		# If there is a decimal place and 1 following, add one 0
		else if val_str.indexOf('.') == (val_str.length - 2)
			clean_value *= 10

	clean_value

convert_actual_to_friendly = (prefix)->
	dollars = $(this).val()/100
	if isNaN(dollars)
		dollars = 0

	"#{prefix}#{dollars.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");}"

# Clean up the view after focus out
update_view = ->
	$val = get_value_field.call(this)

	$(this).val(convert_actual_to_friendly.call($val, get_prefix.call(this), true))

update_value = ->
	$val = get_value_field.call(this)

	actual_value = convert_input_to_actual.call(this, get_prefix.call(this), true)

	if isNaN(actual_value)
		actual_value = 0

	$val.val actual_value


block_invalid_chars = (e)->
	str = String.fromCharCode(e.which)
	str_int = parseInt(str)

	!isNaN(str_int) or str == "." or str == "$" or str == ","


# Publish some helpers!
jquery_moneyfield_helpers = 
	convert_cents_to_friendly: convert_actual_to_friendly

window.jquery_moneyfield_helpers = jquery_moneyfield_helpers