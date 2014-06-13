(function(){var a=function(c,b){return function(){return c.apply(b,arguments)}};define(function(){var b;return b=function(){function c(){this.onKeydown=a(this.onKeydown,this),this.onInput=a(this.onInput,this),this.onClick=a(this.onClick,this)}return c.prototype.opts={tag:"stepper",wrap:"fieldset",num:"input[type='number']",btn:"button",inc:"inc",dec:"dec",msg:"number of days",minus:"&#8722;",plus:"&#43;"},c.prototype.createButton=function(g,e,d){var f;return f=document.createElement(g),f.classList.add(e),f.innerHTML=d,f},c.prototype.createWrapper=function(k,g,e){var d,j,h;return j=k.parentNode,d=k.nextElementSibling,h=document.createElement(g),h.classList.add(e),k.classList.remove(e),d?j.insertBefore(h,d):j.appendChild(h),h.appendChild(k),h},c.prototype.getValues=function(e){var d;return d={},d.min=parseFloat(e.getAttribute("min")),d.min=typeof d.min!==undefined&&!isNaN(d.min)?d.min:!1,d.max=parseFloat(e.getAttribute("max")),d.max=typeof d.max!==undefined&&!isNaN(d.max)?d.max:!1,d.step=parseFloat(e.getAttribute("step"))||1,d.step=typeof d.step!==undefined&&!isNaN(d.step)?d.step:1,d.value=parseFloat(e.value),(typeof d.value===undefined||isNaN(d.value))&&(d.value=d.min!==!1?d.min:0),d},c.prototype.setButtons=function(g,e){var d,f;d=g.parentNode.querySelector("."+this.opts.dec),e.value===e.dec?(d.setAttribute("disabled","disabled"),d.setAttribute("aria-label","minimum "+this.opts.msg+" is "+e.dec)):(d.removeAttribute("disabled"),d.setAttribute("aria-label","decrease "+this.opts.msg+" to "+e.dec)),f=g.parentNode.querySelector("."+this.opts.inc),e.value===e.inc?(f.setAttribute("disabled","disabled"),f.setAttribute("aria-label","maximum "+this.opts.msg+" is "+e.inc)):(f.removeAttribute("disabled"),f.setAttribute("aria-label","increase "+this.opts.msg+" to "+e.inc))},c.prototype.setValues=function(e,d){d.min!==!1&&d.value<d.min?d.value=d.min:d.max!==!1&&d.value>d.max&&(d.value=d.max),d.dec=d.value-d.step,d.min!==!1&&d.dec<d.min&&(d.dec=d.min),d.inc=d.value+d.step,d.max!==!1&&d.inc>d.max&&(d.inc=d.max),this.setButtons(e,d),e.value=d.value},c.prototype.step=function(f,e){var d;d=this.getValues(f),d.orig=d.value,d.change=e;switch(e){case"inc":d.value+=d.step;break;case"dec":d.value-=d.step;break;case"min":d.min&&(d.value=d.min);break;case"max":d.max&&(d.value=d.max)}this.setValues(f,d)},c.prototype.onClick=function(e){var d;d=e.target.parentNode.querySelector(this.opts.num),this.step(d,e.target.className)},c.prototype.onInput=function(f){var e,d;d=f.target,e=this.getValues(d),this.setValues(d,e)},c.prototype.onKeydown=function(f){var e,d;d=f.keyCode,e={pu:33,pd:34,en:35,ho:36,le:37,up:38,ri:39,dn:40},d===e.up||d===e.pu?(f.preventDefault(),this.step(f.target,"inc")):d===e.dn||d===e.pd?(f.preventDefault(),this.step(f.target,"dec")):d===e.ho?(f.preventDefault(),this.step(f.target,"max")):d===e.en&&(f.preventDefault(),this.step(f.target,"min"))},c.prototype.addListeners=function(){[].forEach.call(document.querySelectorAll("."+this.opts.tag+" > "+this.opts.btn),function(d){return function(e){e.addEventListener("click",d.onClick)}}(this)),[].forEach.call(document.querySelectorAll("."+this.opts.tag+" > "+this.opts.num),function(d){return function(e){e.addEventListener("blur",d.onInput),e.addEventListener("keydown",d.onKeydown)}}(this))},c.prototype.initialize=function(){[].forEach.call(document.querySelectorAll(""+this.opts.num+"."+this.opts.tag),function(d){return function(f){var e;f.setAttribute("aria-label",d.opts.msg),e=d.createWrapper(f,d.opts.wrap,d.opts.tag),e.insertBefore(d.createButton(d.opts.btn,d.opts.dec,d.opts.minus),e.firstChild),e.appendChild(d.createButton(d.opts.btn,d.opts.inc,d.opts.plus)),d.setValues(f,d.getValues(f)),d.addListeners()}}(this))},c}()})}).call(this);
