!function(){function e(e){return this.config=e,this}e.prototype={reset:function(){var e=this.config&&this.config.baseline&&!isNaN(this.config.baseline)?this.config.baseline:750,n=Math.min(document.documentElement.clientWidth,e)/e*100;document.documentElement.style.fontSize=n+"px";var t=parseFloat(window.getComputedStyle(document.documentElement).fontSize),o=n/t;1!=o&&(document.documentElement.style.fontSize=n*o+"px")}},window.Adapter=new e(window.ADAPTER_CONF||{}),window.Adapter.reset(),window.onload=function(){window.Adapter.reset()},window.onresize=function(){window.Adapter.reset()}}();