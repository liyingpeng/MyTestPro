define("component/util/common",function(n,t){Object.defineProperty(t,"__esModule",{value:!0}),t.default=void 0;var e={getUrlParam:function(n,t){var e,i;return i=new RegExp("[?|&]"+t+"=(.*?)(&|#|$)","i"),e=n.match(i),e&&decodeURIComponent(e[1])||void 0},stopEvent:function(n,t){n.stopPropagation(),n.stopImmediatePropagation(),t!==!1&&n.preventDefault()},getOs:function(){var n=navigator.userAgent.toLowerCase();return/|iphone|ipod|ipad|ios/.test(n)?"ios":"other"},isHuoshan:function(){return/live_stream/.test(navigator.userAgent)},isiOS:function(){return!!navigator.userAgent.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/)},isAndroid:function(){return navigator.userAgent.indexOf("Android")>-1||navigator.userAgent.indexOf("Adr")>-1},hasViewd:function(n){var t=arguments.length>1&&void 0!==arguments[1]?arguments[1]:0,e=n.getBoundingClientRect(),i=e.left>=0,o=e.bottom<=(window.innerHeight||document.documentElement.clientHeight)+t,r=e.right<=(window.innerWidth||document.documentElement.clientWidth)+t;return i&&o&&r},throttle:function(n,t,e){var i,o,r,a,u=0;e||(e={});var l=function(){u=e.leading===!1?0:Date.now(),i=null,a=n.apply(o,r),i||(o=r=null)},d=function(){var d=Date.now();u||e.leading!==!1||(u=d);var c=t-(d-u);return o=this,r=arguments,0>=c||c>t?(i&&(clearTimeout(i),i=null),u=d,a=n.apply(o,r),i||(o=r=null)):i||e.trailing===!1||(i=setTimeout(l,c)),a};return d.cancel=function(){clearTimeout(i),u=0,i=o=r=null},d}},i=e;t.default=i});