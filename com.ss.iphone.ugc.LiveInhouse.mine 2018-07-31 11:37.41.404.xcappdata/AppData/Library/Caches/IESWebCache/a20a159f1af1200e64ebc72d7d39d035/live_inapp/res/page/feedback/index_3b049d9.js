define("page/feedback/index",function(e){function u(e){return e&&e.__esModule?e:{"default":e}}e("node_modules/babel-polyfill/lib/index");var d=u(e("node_modules/vue/dist/vue.runtime.common")),n=u(e("node_modules/vue-router/dist/vue-router.common")),o=u(e("page/feedback/router")),t=u(e("page/feedback/app.vue"));d.default.use(n.default),new d.default({el:"#feedback",router:o.default,render:function(e){return e(t.default)}})});