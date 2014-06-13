define ->
  class Stepper
    opts:
      tag: 'stepper'
      wrap: 'fieldset'
      num: "input[type='number']"
      btn: 'button'
      inc: 'inc'
      dec: 'dec'
      # msg: 'value'
      msg: 'number of days'
      minus: '&#8722;'
      plus: '&#43;'

    createButton: (b, c, s) ->
      el = document.createElement(b)
      el.classList.add(c)
      el.innerHTML = s
      return el

    createWrapper: (el, w, c) ->
      parent = el.parentNode
      next = el.nextElementSibling
      wrapper = document.createElement(w)
      wrapper.classList.add(c)
      el.classList.remove(c)
      if next
        parent.insertBefore(wrapper, next)
      else
        parent.appendChild(wrapper)
      wrapper.appendChild(el)
      return wrapper

    getValues: (el) ->
      data = {}

      data.min = parseFloat(el.getAttribute('min'))
      data.min = (if (typeof data.min isnt `undefined` and not isNaN(data.min)) then data.min else false)
      data.max = parseFloat(el.getAttribute('max'))
      data.max = (if (typeof data.max isnt `undefined` and not isNaN(data.max)) then data.max else false)
      data.step = parseFloat(el.getAttribute('step')) || 1
      data.step = (if (typeof data.step isnt `undefined` and not isNaN(data.step)) then data.step else 1)

      data.value = parseFloat(el.value)

      if typeof data.value is `undefined` or isNaN(data.value)
        if data.min isnt false
          data.value = data.min
        else
          data.value = 0

      return data

    setButtons: (el, data) ->
      dec = el.parentNode.querySelector(".#{@opts.dec}")
      if data.value is data.dec
        dec.setAttribute('disabled', 'disabled')
        dec.setAttribute('aria-label', "minimum #{@opts.msg} is #{data.dec}")
      else
        dec.removeAttribute('disabled')
        dec.setAttribute('aria-label', "decrease #{@opts.msg} to #{data.dec}")

      inc = el.parentNode.querySelector(".#{@opts.inc}")
      if data.value is data.inc
        inc.setAttribute('disabled', 'disabled')
        inc.setAttribute('aria-label', "maximum #{@opts.msg} is #{data.inc}")
      else
        inc.removeAttribute('disabled')
        inc.setAttribute('aria-label', "increase #{@opts.msg} to #{data.inc}")

    setValues: (el, data) ->
      if data.min isnt false and data.value < data.min
        data.value = data.min
      else if data.max isnt false and data.value > data.max
        data.value = data.max

      data.dec = data.value - data.step
      if data.min isnt false and data.dec < data.min
        data.dec = data.min

      data.inc = data.value + data.step
      if data.max isnt false and data.inc > data.max
        data.inc = data.max
        
      @setButtons(el, data)

      return el.value = data.value

    step: (el, change) ->
      data = @getValues(el)
      data.orig = data.value
      data.change = change

      switch change
        when 'inc' then data.value += data.step
        when 'dec' then data.value -= data.step
        when 'min' then data.value = data.min if data.min
        when 'max' then data.value = data.max if data.max

      @setValues(el, data)

    onClick: (e) =>
      el = e.target.parentNode.querySelector(@opts.num)
      @step(el, e.target.className)

    onInput: (e) =>
      el = e.target
      data = @getValues(el)
      @setValues(el, data)

    onKeydown: (e) =>
      k = e.keyCode

      KEYS =
        pu: 33
        pd: 34
        en: 35
        ho: 36
        le: 37
        up: 38
        ri: 39
        do: 40

      if k is KEYS.up or k is KEYS.pu
        e.preventDefault()
        @step(e.target, 'inc')
      else if k is KEYS.do or k is KEYS.pd
        e.preventDefault()
        @step(e.target, 'dec')
      else if k is KEYS.ho
        e.preventDefault()
        @step(e.target, 'max')
      else if k is KEYS.en
        e.preventDefault()
        @step(e.target, 'min')

    addListeners: ->
      [].forEach.call document.querySelectorAll(".#{@opts.tag} > #{@opts.btn}"), (el) =>
        el.addEventListener 'click', @onClick
      [].forEach.call document.querySelectorAll(".#{@opts.tag} > #{@opts.num}"), (el) =>
        el.addEventListener 'blur', @onInput
        el.addEventListener 'keydown', @onKeydown

    initialize: ->
      [].forEach.call document.querySelectorAll("#{@opts.num}.#{@opts.tag}"), (el) =>
        el.setAttribute('aria-label', @opts.msg)

        w = @createWrapper(el, @opts.wrap, @opts.tag)
        w.insertBefore(@createButton(@opts.btn, @opts.dec, @opts.minus), w.firstChild)
        w.appendChild(@createButton(@opts.btn, @opts.inc, @opts.plus))

        @setValues(el, @getValues(el))

        @addListeners()
