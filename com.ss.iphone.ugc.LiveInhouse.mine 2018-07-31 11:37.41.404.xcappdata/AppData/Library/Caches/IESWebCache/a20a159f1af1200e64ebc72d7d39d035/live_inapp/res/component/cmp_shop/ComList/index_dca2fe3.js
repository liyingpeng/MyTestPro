define("component/cmp_shop/ComList/index.vue",function(t,e,o){function i(t){return t&&t.__esModule?t:{"default":t}}Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0;var s=i(t("component/Bus/index")),a=i(t("node_modules/axios/index")),d=(i(t("component/util/common")),i(t("component/common/Loading/index.vue"))),n={data:function(){return{pickedId:0,ownerGoods:[],tap:!0}},props:{data:{type:Array,required:!0},hasMore:{type:Boolean,"default":!0}},components:{Loading:d.default},created:function(){var t=this.$route.query.selected;t?this.pickedId=t:this.getGoodsList()},mounted:function(){var t=this;s.default.$on("deleteGoods",function(){t.pickedId=0,t.ownerGoods.slice(0,1)}),s.default.$on("sendSaveGoods",function(e){t.pickedId=0===e.length?0:e[0].promotion_id})},methods:{onSelectGoods:function(t,e){this.tap&&(this.pickedId==t?(this.pickedId=0,this.ownerGoods.splice(0,1)):(this.pickedId=t,this.ownerGoods.splice(0,1,this.data[e])),s.default.$emit("sendSaveGoods",this.ownerGoods))},getGoodsList:function(){var t=this,e="/web/api/ecom/video/goodlist/",o=this.$route.query.item_id||0;a.default.get(e,{params:{item_id:o},timeout:5e3}).then(function(e){if(0===e.data.status_code){var o=e.data.data;o&&o.length&&(t.ownerGoods.splice(0,1,o[0]),t.pickedId=o[0].promotion_id,s.default.$emit("sendSaveGoods",t.ownerGoods))}})},getOwnerGoods:function(){var t=this,e="/hotsoon/commerce/item_goods_info/",o=this.$route.query.item_id||0;a.default.get(e,{params:{item_id:o},timeout:5e3}).then(function(e){if(0===e.data.status_code){var o=e.data.data;o&&o.length&&(o[0].promotion_id=o[0].id_str,o[0].cover=o[0].image,o[0].item_type=o[0].type,t.ownerGoods.splice(0,1,o[0]),t.pickedId=o[0].promotion_id,s.default.$emit("sendSaveGoods",t.ownerGoods))}})},watchScroll:function(){if(this.tap){var t=this;t.tap=!1,setTimeout(function(){t.tap=!0},300)}}}};e.default=n;var c;c=e&&e.__esModule&&e.default?e.default:o.exports,c.render=function(){var t=this,e=t.$createElement,o=t._self._c||e;return o("div",{staticClass:"com-list-wrapper",on:{touchmove:function(e){t.watchScroll(e)}}},[o("ul",{staticClass:"items-list"},[t._l(t.data,function(e,i){return o("li",{key:i,staticClass:"item",on:{click:function(){t.onSelectGoods(e.promotion_id,i)}}},[o("a",{staticClass:"item-wrapper",attrs:{href:"javascript:;"}},[o("div",{staticClass:"cover"},[o("img",{attrs:{src:e.cover.url_list[0],alt:""}})]),t._v(" "),o("div",{staticClass:"desc"},[o("div",{staticClass:"title"},[t._v(t._s(e.title))]),t._v(" "),o("div",{staticClass:"price-info-wrapper"},[o("div",{staticClass:"price"},[t._v("￥"+t._s(t._f("formatMoney")(e.price)))]),t._v(" "),o("div",{staticClass:"info"},[o("div",{staticClass:"sale-count"},[t._v("月销"+t._s(t._f("formatNum")(e.sales))+"笔")]),t._v(" "),o("div",{staticClass:"cos-fee"},[t._v("赚￥"+t._s(t._f("formatFee")(e.cos_fee)))])])])]),t._v(" "),o("div",{staticClass:"checkWrapper","class":{checked:t.pickedId==e.promotion_id}})])])}),t._v(" "),o("li",{staticClass:"list-footer"},[t.hasMore?t._e():o("a",{attrs:{href:"javascript:;"}},[o("span",{staticClass:"loading-text"},[t._v("没有更多了~")])])])],2),t._v(" "),o("Loading",{directives:[{name:"show",rawName:"v-show",value:!t.data.length,expression:"!data.length"}]})],1)},c.staticRenderFns=[],c._scopeId="_v-fc2eba21"});