###
jquery-currency-input
Copyright (c) 2012 Greg Leaver
http://github.com/gregleaver/jquery-currency-input

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
###


$ = jQuery


# From _.isFinite
isNumber = (obj) ->
  (toString.call obj) == '[object Number]' and isFinite(obj)

toNumber = (str) -> 
  str = str.toString().replace /[$,\s]/g, ''
  num = parseFloat str
  if isNumber num then num else 0.00

left = (num) ->
  str = (Math.floor num).toFixed().toString()
  digits = (str.split '').reverse()
  grouped = []
  while digits.length > 3
    grouped.push digits.shift() for i in [1..3]
    grouped.push ','
  grouped.push i for i in digits
  grouped.reverse().join ''

right = (num) ->
  (num - (Math.floor num)).toFixed(2).replace /\d*\./, ''

format = (num) -> 
  unless isNumber num
    format(toNumber num)
  else
    "$ #{left num}.#{right num}"


$.fn.currency = () ->
  this.each ->
    this.value = format this.value
    $(this).closest('form').bind 'submit.currency', () =>
      this.value = toNumber this.value
      return true
    $(this).bind 'blur.currency', () => 
      this.value = format this.value

$ ->
  $('input[type="currency"]').currency()
