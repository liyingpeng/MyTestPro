define("component/util/http",function(e,t){function o(e){return e&&e.__esModule?e:{"default":e}}Object.defineProperty(t,"__esModule",{value:!0}),t.default=void 0;var n=o(e("node_modules/axios/index")),u=n.default.create({baseURL:"/web/api",timeout:8e3});u.interceptors.response.use(function(e){return 200===e.status&&10014===e.data.status_code?(console.log("not login"),e):e});var a=u;t.default=a});