define("page/feedback/router",function(e,t){function n(e){return e&&e.__esModule?e:{"default":e}}Object.defineProperty(t,"__esModule",{value:!0}),t.default=void 0;var o=n(e("node_modules/vue-router/dist/vue-router.common")),u=n(e("component/feedback/List/index.vue")),a=n(e("component/feedback/Help/index.vue")),d=n(e("component/api/feedback")),c=[{path:"/",component:u.default},{path:"/help",component:a.default}],f=new o.default({routes:c});f.beforeEach(function(e,t,n){var o=e.query.paths;if(0==o&&(e.query.paths="4881",o=e.query.paths),o){var u=o.split(",");d.default.getFAQ(u).then(function(e){document.title=e.name.length>5?"".concat(e.name.slice(0,5),"..."):e.name,n()})}else document.title="反馈与帮助",n()});var l=f;t.default=l});