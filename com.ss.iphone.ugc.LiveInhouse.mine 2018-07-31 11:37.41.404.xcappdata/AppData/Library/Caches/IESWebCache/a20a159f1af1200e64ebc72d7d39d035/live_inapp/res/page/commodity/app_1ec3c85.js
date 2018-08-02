define("page/commodity/app.vue",function(t,e,s){function o(t){return t&&t.__esModule?t:{"default":t}}Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0;var i=o(t("node_modules/axios/index")),a=o(t("component/util/huoshan")),n=o(t("component/util/common")),d=o(t("node_modules/qs/lib/index")),c={data:function(){return{results:[],selectNum:0,totalNum:1,pickedId:0,prePickedId:0,ownerGoods:[],showSelectedGoods:!1,haslist:!1,vshow:!1,userId:0,itemId:0,reloadFailed:!1,loadingMore:!1,loadMoreFailed:!1,offset:0,count:30,tap:!0}},mounted:function(){},created:function(){this.itemId=n.default.getUrlParam(location.href,"item_id"),this.getUserInfo()},methods:{onSelectGoods:function(t,e){return this.tap?this.pickedId==t?(this.pickedId=0,this.selectNum=0,void this.ownerGoods.splice(0,1)):(this.pickedId=t,this.selectNum=1,this.ownerGoods.splice(0,1,this.results[e]),void a.default.sendAppLogV3("commodity_add_click",{event_belong:"video",event_type:"click",event_page:"video_detail",event_module:"video",enter_from:"video",source:"video",action_type:"click",video_id:this.itemId,user_id:this.userId,commodity_id:this.pickedId})):void 0},onDeleteSelectedGoods:function(){this.pickedId=0,this.selectNum=0,this.ownerGoods.splice(0,1),this.showSelectedGoods=!1},onSave:function(){var t=this;t.prePickedId!=t.pickedId?t.fetch("/hotsoon/commerce/item_goods_bind/",{item_id:t.itemId,goods_ids:t.pickedId?t.pickedId:"",item_types:t.ownerGoods[0].type},"post").then(function(e){e.data&&0===e.data.status_code?(a.default.syncProductStatus(t.itemId,Number(!!t.pickedId)),a.default.sendAppLogV3("commodity_add_success",{event_belong:"video",event_type:"other",event_page:"commodity_add",commodity_id:t.pickedId}),a.default.closeWebview()):a.default.showToast("保存失败，请重新尝试")}).catch(function(){}):a.default.closeWebview()},onTogglePannel:function(t){t&&"mask"===t?this.showSelectedGoods=!1:this.ownerGoods.length&&(this.showSelectedGoods=!this.showSelectedGoods)},fetch:function(t,e,s){if(!s||"get"===s)return i.default.get(t,{params:e,timeout:5e3});if("post"===s){var o=d.default.stringify(e);return i.default.post(t,o)}},getGoodsInfo:function(){var t=this;return this.fetch("/hotsoon/commerce/user_goods_info/",{user_id:this.userId,type:1,offset:this.offset,count:this.count}).then(function(e){return 0===e.data.status_code?(e.data.data.length?0===t.offset&&(t.haslist=!0,t.bindScroll()):0===t.offset&&(t.haslist=!1),t.vshow=!0,e.data):(t.vshow=!0,t.loadingMore=!1,void(t.loadMoreFailed=!0))}).catch(function(){a.default.showToast("数据请求失败，请换个姿势重试")})},renderGoodsList:function(){var t=this;this.loadingMore||(this.loadingMore=!0,this.getGoodsInfo().then(function(e){t.haslist&&!t.loadMoreFailed&&(t.getOwnerGoodsInfo(),e.extra.has_more&&e.data.length<=0?t.hasMore=!1:(t.hasMore=e.extra.has_more,t.offset+=e.data.length,t.results=e.data,t.loadingMore=!1))}))},getOwnerGoodsInfo:function(){var t=this;this.fetch("/hotsoon/commerce/item_goods_info/",{item_id:this.itemId||0}).then(function(e){e.data.data.length&&(t.pickedId=e.data.data[0].id_str,t.prePickedId=t.pickedId,t.selectNum=1,t.ownerGoods=e.data.data)}).catch(function(){})},format:function(t){var e=parseInt(t,10),s=e.toString();return isNaN(e)?t:s.length<5?t:(e/1e4).toFixed(1)+"万"},formatMoney:function(t){var e=Math.floor(parseFloat(t,10)),s=e.toString();return isNaN(e)?t:1>e?"0.00":s.length<7?(e/100).toFixed(2):(e/1e6).toFixed(2)+"万"},formatFee:function(t){var e=parseFloat(t,10);return isNaN(e)?t:e.toFixed(2)},jumpToCommodityLibrary:function(){var t=encodeURIComponent("https://hotsoon.snssdk.com/hotsoon/in_app/create_commodity/"),e=encodeURIComponent("如何创建商品库？");a.default.openWebview(t,e,0,0,0,1)},getUserInfo:function(){var t=this;a.default.getUserInfo().then(function(e){e&&e.user_id&&(t.userId=e.user_id,t.renderGoodsList())}).catch(function(){t.haslist=!1,t.vshow=!0})},watchScroll:function(t){if(this.showSelectedGoods)n.default.stopEvent(t);else{if(!this.tap)return;var e=this;e.tap=!1,setTimeout(function(){e.tap=!0},300)}},loadMore:function(){var t=this;this.loadingMore||!this.hasMore||this.results.length<=0||(this.loadingMore=!0,this.loadMoreFailed=!1,this.getGoodsInfo().then(function(e){t.loadMoreFailed||(e.extra.has_more&&e.data.length<=0?t.hasMore=!1:(t.hasMore=e.extra.has_more,t.offset+=e.data.length,t.results=t.results.concat(e.data),t.loadingMore=!1))}))},bindScroll:function(t){var e=this,s=t||100;window.addEventListener("scroll",function(){var t=document.height||document.body.scrollHeight;scrollY>=t-innerHeight-s&&e.loadMore()})},jumpToStandard:function(){var t=encodeURIComponent("https://hotsoon.snssdk.com/hotsoon/in_app/commodity/page1/"),e=encodeURIComponent("视频与商品匹配标准");a.default.openWebview(t,e,0,0,0,1)}}};e.default=c;var l;l=e&&e.__esModule&&e.default?e.default:s.exports,l.render=function(){var t=this,e=t.$createElement,s=t._self._c||e;return s("div",{staticClass:"commodity-wrapper",on:{touchmove:function(e){t.watchScroll(e)}}},[t.haslist?s("div",{staticClass:"haslist"},[s("div",{staticClass:"pannel-header"},[s("div",{staticClass:"jump-btn",on:{click:function(){t.jumpToStandard()}}})]),t._v(" "),s("div",{staticClass:"pannel-body"},[s("ul",{staticClass:"items-list"},[t._l(t.results,function(e,o){return s("li",{key:o,staticClass:"item",on:{click:function(){t.onSelectGoods(e.id_str,o)}}},[s("a",{staticClass:"item-wrapper",attrs:{href:"javascript:;"}},[s("div",{staticClass:"cover"},[s("img",{directives:[{name:"lazy",rawName:"v-lazy",value:e.image.url_list[0],expression:"result.image.url_list[0]"}],attrs:{alt:""}})]),t._v(" "),s("div",{staticClass:"desc"},[s("div",{staticClass:"title"},[t._v(t._s(e.title))]),t._v(" "),s("div",{staticClass:"price-info-wrapper"},[s("div",{staticClass:"price"},[t._v("￥"+t._s(t.formatMoney(e.price)))]),t._v(" "),s("div",{staticClass:"info"},[s("div",{staticClass:"sale-count"},[t._v("月销"+t._s(t.format(e.sales))+"笔")]),t._v(" "),s("div",{staticClass:"cos-fee"},[t._v("赚￥"+t._s(t.formatFee(e.cos_fee)))])])])]),t._v(" "),s("div",{staticClass:"checkWrapper","class":{checked:t.pickedId==e.id_str}})])])}),t._v(" "),s("li",{staticClass:"list-footer"},[t.loadingMore?s("a",{attrs:{href:"javascript:;"}},[s("span",{staticClass:"loading-text"},[t._v("加载更多")]),t._v(" "),s("i",{staticClass:"loading-spinner spinning"})]):t.loadMoreFailed?s("a",{attrs:{href:"javascript:;"}},[s("span",{staticClass:"loading-text"},[t._v("加载失败")])]):!t.hasMore&&t.results.length>0?s("a",{attrs:{href:"javascript:;"}},[s("span",{staticClass:"loading-text"},[t._v("没有更多了~")])]):t._e()])],2)]),t._v(" "),s("div",{staticClass:"pannel-footer-toggle",on:{click:function(){t.onTogglePannel()}}},[s("transition",{attrs:{name:"margin"}},[s("a",{directives:[{name:"show",rawName:"v-show",value:t.showSelectedGoods,expression:"showSelectedGoods"}],staticClass:"pannel-footer-wrapper",attrs:{href:"javascript:;"}},[s("div",{staticClass:"goods-info"},[s("div",{staticClass:"title"},[t._v("我添加的商品")]),t._v(" "),s("div",{staticClass:"content"},[s("ul",{staticClass:"items-list"},t._l(t.ownerGoods,function(e,o){return s("li",{key:o,staticClass:"item"},[s("div",{staticClass:"cover"},[s("img",{attrs:{src:e.image.url_list[0],alt:""}})]),t._v(" "),s("div",{staticClass:"desc"},[s("div",{staticClass:"title"},[t._v(t._s(e.title))]),t._v(" "),s("div",{staticClass:"price"},[t._v("￥"+t._s(t.formatMoney(e.price)))])]),t._v(" "),s("a",{staticClass:"delete-icon",attrs:{href:"javascript:;"},on:{click:function(){t.onDeleteSelectedGoods(e.id_str)}}})])}))])])])])],1),t._v(" "),s("div",{staticClass:"pannel-footer",on:{click:function(){t.onTogglePannel()}}},[s("a",{staticClass:"toggle-info",attrs:{href:"javascript:;"}},[s("div",{staticClass:"icon"}),t._v(" "),s("a",{staticClass:"goods-panel",attrs:{href:"javascript:;"}},[s("div",{staticClass:"percent-desc"},[t._v("\n                        ("+t._s(t.selectNum)+"/"+t._s(t.totalNum)+")\n                    ")]),t._v(" "),s("div",{staticClass:"save",on:{click:function(e){e.stopPropagation(),t.onSave()}}},[t._v("\n                        保存\n                    ")])])])]),t._v(" "),s("transition",{attrs:{name:"fade"}},[s("a",{directives:[{name:"show",rawName:"v-show",value:t.showSelectedGoods,expression:"showSelectedGoods"}],staticClass:"mask",attrs:{href:"javascript:;"},on:{click:function(){t.onTogglePannel("mask")}}})])],1):t._e(),t._v(" "),!t.haslist&&t.vshow?s("div",{staticClass:"nolist"},[s("div",{staticClass:"banner"}),t._v(" "),s("div",{staticClass:"content"},[s("h3",[t._v("欢迎使用火山电商功能")]),t._v(" "),t._m(0),t._v(" "),s("div",{staticClass:"guide-btn",on:{click:t.jumpToCommodityLibrary}},[t._v("如何创建商品库")])])]):t._e()])},l.staticRenderFns=[function(){var t=this,e=t.$createElement,s=t._self._c||e;return s("div",{staticClass:"desc"},[s("p",[t._v("你可以从商品库挑选商品在视频中展示给粉丝")]),t._v(" "),s("p",[t._v("快去创建自己的商品库吧！")])])}]});