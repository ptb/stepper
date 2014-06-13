(function() {
  require(['stepper-min', 'fastclick'], function(Stepper, FastClick) {
    new Stepper().initialize();
    FastClick.attach(document.body);
  });
}).call(this);
