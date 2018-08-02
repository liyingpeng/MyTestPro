define("component/feedback/Help/index.vue",function(t,e,n){function a(t){return t&&t.__esModule?t:{"default":t}}Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0;var s=(a(t("node_modules/axios/index")),a(t("node_modules/object-path/index")),a(t("component/util/huoshan"))),o=a(t("component/api/feedback")),i=(t("component/const/jsbridge"),{data:function(){return{solutionStatus:0,fromLabel:"feedback",faq:null}},created:function(){var t=this;o.default.ready().then(function(){t.init(t.$route.query.paths)})},components:{},methods:{init:function(t){var e=this;o.default.getFAQ(t.split(",")).then(function(t){e.faq=t})},onVisitFeedback:function(){s.default.openFeedback(this.faq.id,this.$route.query.utm_source)},onFAQSolved:function(){var t=this;s.default.sendAppLogV3("satisfy_or_not",{event_type:"click",event_belong:"video",event_page:"feedback_3",event_module:"questionare",status:"yes"}),o.default.solved(this.faq.id).then(function(){t.solutionStatus=1})},onFAQUnSolved:function(){var t=this;s.default.sendAppLogV3("satisfy_or_not",{event_type:"click",event_belong:"video",event_page:"feedback_3",event_module:"questionare",status:"not"}),o.default.unsolved(this.faq.id).then(function(){return t.solutionStatus=2})}},watch:{$route:function(t){this.init(t.query.paths)}}});e.default=i;var c;c=e&&e.__esModule&&e.default?e.default:n.exports,c.render=function(){var t=this,e=t.$createElement,n=t._self._c||e;return t.faq?n("div",{staticClass:"feedback-help-page"},[n("section",{staticClass:"solution"},[n("h1",[t._v(t._s(t.faq.name))]),t._v(" "),n("p",[t._v(t._s(t.faq.value))])]),t._v(" "),n("section",{staticClass:"feedback"},[n("h1",[t._v("你的问题是否被解决")]),t._v(" "),n("div",{staticClass:"options"},[n("div",{staticClass:"option",on:{click:t.onFAQUnSolved}},[n("span",{staticClass:"icon-unhappy-face","class":{"icon-unhappy-face-highlight":2===t.solutionStatus}}),t._v(" "),n("span",{staticClass:"option-text"},[t._v("未解决")])]),t._v(" "),n("div",{staticClass:"option",on:{click:t.onFAQSolved}},[n("span",{staticClass:"icon-happy-face","class":{"icon-happy-face-highlight":1===t.solutionStatus}}),t._v(" "),n("span",{staticClass:"option-text"},[t._v("已解决")])])])]),t._v(" "),n("footer",[n("a",{attrs:{href:"javascript:;"},on:{click:t.onVisitFeedback}},[n("span",{staticClass:"edit-icon"}),t._v(" "),n("span",{staticClass:"footer-text"},[t._v("意见反馈")])])])]):t._e()},c.staticRenderFns=[]});