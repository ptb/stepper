define [
  'react'
  'fastclick'
], (React, FastClick) ->
  'use strict'

  class Stepper
    init: ->
      React.initializeTouchEvents true
      React.renderComponent(
        Stepper.control()
        document.getElementById 'stepper'
      )
      FastClick.attach document.getElementById 'stepper'

    @control: React.createClass
      getDefaultProps: ->
        label: 'number of days'
        minus: '\u2212'
        plus: '\u002b'
        min: 1
        max: 90
        step: 1
        value: 3

      setValues: (value) ->
        data =
          disable: {}
          label: {}
          value: value

        if data.value < @props.min
          data.value = @props.min
        else if data.value > @props.max
          data.value = @props.max

        data.dec = data.value - @props.step
        if data.dec < @props.min
          data.disable.dec = true
          data.label.dec = "minimum #{@props.label} is #{@props.min}"
        else
          data.disable.dec = false
          data.label.dec = "decrease #{@props.label} to #{data.dec}"

        data.inc = data.value + @props.step
        if data.inc > @props.max
          data.disable.inc = true
          data.label.inc = "maximum #{@props.label} is #{@props.max}"
        else
          data.disable.inc = false
          data.label.inc = "increase #{@props.label} to #{data.inc}"

        @setState data

      step: (change) ->
        value = parseFloat @state.value
        switch change
          when 'dec' then value -= @props.step
          when 'inc' then value += @props.step
          when 'min' then value = @props.min
          when 'max' then value = @props.max
        @setValues value

      onChange: (e) ->
        value = parseFloat e.target.value
        @setValues value unless isNaN(value)

      onClick: (e) ->
        e.preventDefault()
        @step e.target.className.trim()

      onKeyDown: (e) ->
        key = e.keyCode

        KEY =
          pageup: 33
          pagedown: 34
          end: 35
          home: 36
          left: 37
          up: 38
          right: 39
          down: 40

        if key is KEY['up'] or key is KEY['pageup']
          e.preventDefault()
          @step 'inc'
        else if key is KEY['down'] or key is KEY['pagedown']
          e.preventDefault()
          @step 'dec'
        else if key is KEY['home']
          e.preventDefault()
          @step 'max'
        else if key is KEY['end']
          e.preventDefault()
          @step 'min'

      componentWillMount: ->
        @setValues @props.value

      render: ->
        { fieldset, button, input } = React.DOM
        fieldset { className: 'stepper' },
          button {
            'aria-label': @state.label.dec
            disabled: 'disabled' if @state.disable.dec
            className: 'dec'
            onClick: @onClick
          }, @props.minus
          input
            'aria-label': @props.label
            max: @props.max
            min: @props.min
            step: @props.step
            type: 'number'
            onChange: @onChange
            onKeyDown: @onKeyDown
            value: @state.value
          button {
            'aria-label': @state.label.inc
            disabled: 'disabled' if @state.disable.inc
            className: 'inc'
            onClick: @onClick
          }, @props.plus
