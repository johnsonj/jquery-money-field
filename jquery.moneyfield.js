// Generated by CoffeeScript 1.4.0
(function() {
  var $, block_invalid_chars, convert_actual_to_friendly, convert_input_to_actual, defaults, get_mode, get_prefix, get_value_field, jquery_moneyfield_helpers, update_value, update_view, value_field_selector;

  $ = jQuery;

  value_field_selector = "[data-money-field]";

  defaults = {
    prefix: ''
  };

  $.fn.extend({
    moneyfield: function(params) {
      return this.each(function() {
        var cursor_pos, opts;
        opts = {};
        $.extend(opts, defaults, params);
        if ($(this).data('money-field')) {
          return this;
        }
        $(this).data('money-field', opts);
        $(this).keypress(block_invalid_chars);
        $(this).focus(update_view);
        $(this).focusout(update_view);
        $(this).keyup(update_value);
        cursor_pos = $(this).caret().start;
        update_view.call(this);
        $(this).caret(cursor_pos, cursor_pos);
        return this;
      });
    }
  });

  get_mode = function() {
    return $(this).data('money-field').type_field.val();
  };

  get_value_field = function() {
    return $(this).parent().find(value_field_selector);
  };

  get_prefix = function() {
    return $(this).data('money-field').prefix;
  };

  convert_input_to_actual = function(prefix, append_zeros) {
    var clean_value, val_str;
    if (append_zeros == null) {
      append_zeros = false;
    }
    val_str = $(this).val().toString();
    clean_value = parseInt(val_str.replace(/\./g, "").replace(/\$/g, "").replace(/,/g, ""));
    if (append_zeros) {
      if (val_str.indexOf('.') === -1 || val_str.indexOf('.') === (val_str.length - 1)) {
        clean_value *= 100;
      } else if (val_str.indexOf('.') === (val_str.length - 2)) {
        clean_value *= 10;
      }
    }
    return clean_value;
  };

  convert_actual_to_friendly = function(prefix) {
    var dollars;
    dollars = $(this).val() / 100;
    if (isNaN(dollars)) {
      dollars = 0;
    }
    return "" + prefix + (dollars.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
  };

  update_view = function() {
    var $val;
    $val = get_value_field.call(this);
    return $(this).val(convert_actual_to_friendly.call($val, get_prefix.call(this), true));
  };

  update_value = function() {
    var $val, actual_value;
    $val = get_value_field.call(this);
    actual_value = convert_input_to_actual.call(this, get_prefix.call(this), true);
    if (isNaN(actual_value)) {
      actual_value = 0;
    }
    return $val.val(actual_value);
  };

  block_invalid_chars = function(e) {
    var str, str_int;
    str = String.fromCharCode(e.which);
    str_int = parseInt(str);
    return !isNaN(str_int) || str === "." || str === "$" || str === ",";
  };

  jquery_moneyfield_helpers = {
    convert_cents_to_friendly: convert_actual_to_friendly
  };

  window.jquery_moneyfield_helpers = jquery_moneyfield_helpers;

}).call(this);
