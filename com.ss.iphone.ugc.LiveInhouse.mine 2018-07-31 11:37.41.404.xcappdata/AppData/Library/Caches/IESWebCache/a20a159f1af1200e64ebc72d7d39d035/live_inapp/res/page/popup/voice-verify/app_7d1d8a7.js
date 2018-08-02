define("page/popup/voice-verify/app.vue",function(e,t,o){function i(e){return e&&e.__esModule?e:{"default":e}}Object.defineProperty(t,"__esModule",{value:!0}),t.default=void 0;var n=i(e("component/util/huoshan")),s=(e("component/const/jsbridge"),i(e("component/api/voice-verify"))),a={data:function(){return{phone:"",verifyCode:"",countdown:0,timer:0,submitting:!1}},created:function(){n.default.setWebviewPopup(window.location.href,300,232,8,0)},methods:{onClose:function(){n.default.closeWebviewPopup(window.location.href)},onRetrieveVerifyCode:function(){var e=this;return this.phone?/\d{11}/.test(this.phone)?void(this.countdown>0||s.default.retrieveVerifyCode(this.phone).then(function(){e.countdown=80,e.timer=setInterval(function(){e.countdown>0?e.countdown-=1:clearInterval(e.timer)},1e3)}).catch(function(e){n.default.showToast(e.message)})):void n.default.showToast("手机号码不正确"):void n.default.showToast("请填写手机号码")},onSubmit:function(){var e=this;if(!this.submitting){if(!this.phone)return void n.default.showToast("请填写手机号码");if(!/\d{11}/.test(this.phone))return void n.default.showToast("手机号码不正确");if(!this.verifyCode)return void n.default.showToast("请填写验证码");this.submitting=!0,s.default.verify(this.phone,this.verifyCode).then(function(){e.submitting=!1,n.default.showToast("验证成功"),n.default.closeWebviewPopup(window.location.href)}).catch(function(t){e.submitting=!1,n.default.showToast(t.message)})}}}};t.default=a;var r;r=t&&t.__esModule&&t.default?t.default:o.exports,r.render=function(){var e=this,t=e.$createElement,o=e._self._c||t;return o("div",{staticClass:"voice-verify-page"},[o("div",{staticClass:"icon-close",on:{click:e.onClose}},[o("img",{attrs:{src:"//hotsoon.snssdk.com/falcon/live_inapp/res/static/image/voice-verify/icon_close@2x_6fc0afc.png"}})]),e._v(" "),o("div",{staticClass:"header"},[e._v("请进行语音验证")]),e._v(" "),o("div",{staticClass:"body"},[o("form",{staticClass:"form"},[o("div",{staticClass:"form-item"},[o("div",{staticClass:"label"},[e._v("手机号")]),e._v(" "),o("div",{staticClass:"input-wrapper"},[o("input",{directives:[{name:"model",rawName:"v-model",value:e.phone,expression:"phone"}],attrs:{type:"text"},domProps:{value:e.phone},on:{input:function(t){t.target.composing||(e.phone=t.target.value)}}})])]),e._v(" "),o("div",{staticClass:"form-item"},[o("div",{staticClass:"label"},[e._v("验证码")]),e._v(" "),o("div",{staticClass:"input-wrapper"},[o("input",{directives:[{name:"model",rawName:"v-model",value:e.verifyCode,expression:"verifyCode"}],attrs:{type:"text"},domProps:{value:e.verifyCode},on:{input:function(t){t.target.composing||(e.verifyCode=t.target.value)}}}),e._v(" "),o("button",{"class":{disabled:e.countdown>0},on:{click:function(t){return t.preventDefault(),e.onRetrieveVerifyCode(t)}}},[e._v(e._s(e.countdown>0?e.countdown+"s":"获取语音验证码"))])])])])]),e._v(" "),o("div",{staticClass:"footer"},[o("button",{on:{click:e.onSubmit}},[e._v("提交")])])])},r.staticRenderFns=[]});