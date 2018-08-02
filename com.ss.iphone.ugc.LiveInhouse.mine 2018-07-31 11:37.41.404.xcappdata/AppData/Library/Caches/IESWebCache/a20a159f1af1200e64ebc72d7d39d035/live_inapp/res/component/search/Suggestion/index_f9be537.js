define("component/search/Suggestion/index.vue",function(e,t,s){function a(e){return e&&e.__esModule?e:{"default":e}}function r(){return r=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var s=arguments[t];for(var a in s)Object.prototype.hasOwnProperty.call(s,a)&&(e[a]=s[a])}return e},r.apply(this,arguments)}Object.defineProperty(t,"__esModule",{value:!0}),t.default=void 0;var n=a(e("node_modules/axios/index")),i=a(e("node_modules/object-path/index")),o=a(e("component/util/huoshan")),u=a(e("page/search/store")),d={data:function(){return{store:u.default,reloading:!1,results:[],source:null,hightxt:""}},created:function(){this.reload()},components:{},beforeRouteUpdate:function(e,t,s){this.reload(),s()},methods:{onVisitSug:function(e){var t=e.sug_type,s="";if(1==t){var a=e.user.id;o.default.openProfile(a,u.default.state.fromLabel,u.default.state.page_source),o.default.sendAppLogV3("enter_profile",{event_belong:"relation",event_page:"search_sug",event_module:"recommend",event_type:"click",search_content:u.default.state.keywords,user_id:a,_staging_flag:"1"}),s="card"}else if(2==t){var a=e.hash_tag.id_string;o.default.openHashtag(a,"search_sug",u.default.state.user_action,"recommend"),s="hashtag"}else{var r=e.search.query_string;u.default.commit({type:"setSearchParams",searchparams:{keywords:r,enter_from:u.default.state.fromLabel,user_action:"initiative",page_source:u.default.state.page_source}}),o.default.setSearchKeywords(r),this.$router.push({name:"result"}),s="query"}o.default.sendAppLogV3("sug_search_click",{event_belong:"video",event_type:"click",event_page:"search",event_module:"search_result",type:s})},fetch:function(){var e=n.default.CancelToken,t=this,s="/hotsoon/search/get_suggest/";return u.default.state.appVersion>=330?o.default.fetch("https://api.huoshan.com"+s,"GET",{query:u.default.state.keywords||""}).then(function(e){var s=e.raw;if(1==e.code&&0==s.status_code)return t.hightxt=s.extra.query||"",t.hightxt!=u.default.state.keywords?null:s;throw new Error(s.data.message||s.data.prompt)}):n.default.get(s,{cancelToken:new e(function(e){t.source=e}),params:r({},u.default.state.apiParams,{query:u.default.state.keywords||""}),timeout:5e3}).then(function(e){var s=e.data;if(0!=s.status_code)throw new Error(s.data.message||s.data.prompt);return t.hightxt=s.extra.query||"",s})},reload:function(){var e=this;return o.default.sendAppLogV3("search_sug_show",{event_belong:"function",event_page:"search_sug",event_module:"recommend",event_type:"show",search_content:u.default.state.keywords}),this.source&&(this.source(),this.source=null),e.reloading=!1,u.default.state.keywords?void this.fetch().then(function(t){if(t){var s=e.highlight(t.data||[]);s.length>0?(e.results=s,o.default.sendAppLogV3("sug_search_show",{event_belong:"video",event_type:"show",event_page:"search",event_module:"search_result"}),e.reloading=!0):(e.$router.push({name:"result",query:{keywords:u.default.state.keywords}}),o.default.sendAppLogV3("query_search_show",{event_belong:"video",event_type:"show",event_page:"search",event_module:"search_result"}))}}).catch(function(){}):void(e.results=[])},highlight:function(e){var t=this,s=new RegExp(this.hightxt+"+","gi"),a=function(e){return e.replace(s,function(e){return'<span class="highlight">'+e+"</span>"})};return e.map(function(e){return 1==e.sug_type?{user:{id:i.default.get(e,"user.id_str"),nickname:a(i.default.get(e,"user.highlight_nickname")||i.default.get(e,"user.nickname")),fan_count:t.formatNum(i.default.get(e,"user.total_fan_count")),verified:i.default.get(e,"user.verified"),hotsoonVerified:i.default.get(e,"user.hotsoon_verified"),avatar:i.default.get(e,"user.avatar_thumb.url_list.0")},sug_type:1}:2==e.sug_type?{hash_tag:{id_string:i.default.get(e,"hash_tag.id_string"),title:a(i.default.get(e,"hash_tag.title")),video_cnt:t.formatNum(i.default.get(e,"hash_tag.video_cnt"))},sug_type:2}:3==e.sug_type?{search:{query_string:i.default.get(e,"search.query_string"),query:a(i.default.get(e,"search.query_string"))},sug_type:3}:{}})},formatNum:function(e){var e=parseInt(e,10),t=e.toString();return isNaN(e)?e:t.length<5?e:5===t.length?(e/1e4).toFixed(1)+"万":t.length>=6?(e/1e4).toFixed(0)+"万":void 0},search:function(){u.default.commit({type:"setSearchParams",searchparams:{keywords:u.default.state.keywords,enter_from:u.default.state.fromLabel,user_action:"initiative",page_source:u.default.state.page_source}}),this.$router.push({name:"result",query:{keywords:u.default.state.keywords}})}}};t.default=d;var l;l=t&&t.__esModule&&t.default?t.default:s.exports,l.render=function(){var e=this,t=e.$createElement,s=e._self._c||t;return s("div",{staticClass:"suggestion-wrapper"},[s("ul",{staticClass:"result-list"},e._l(e.results,function(t,a){return s("li",{key:a,staticClass:"result-item",on:{click:function(){e.onVisitSug(t)}}},[1==t.sug_type?s("div",{staticClass:"user-wrap clearfix"},[s("div",{staticClass:"head-wrap"},[s("img",{attrs:{src:t.user.avatar,alt:""}}),e._v(" "),s("div",{"class":{"verified-hotsoon-user":t.user.hotsoonVerified,"verified-weibo-user":t.user.verified}})]),e._v(" "),s("div",{staticClass:"profile-info"},[s("div",{staticClass:"nickname",domProps:{innerHTML:e._s(t.user.nickname)}}),e._v(" "),s("div",{staticClass:"fan-count"},[e._v("粉丝数："+e._s(t.user.fan_count))])])]):2==t.sug_type?s("div",{staticClass:"hash-wrap"},[s("img",{staticClass:"icon-wrap",attrs:{src:"//hotsoon.snssdk.com/falcon/live_inapp/res/static/image/search/hash_icon_727b5ed.png",alt:""}}),e._v(" "),s("div",{staticClass:"hash-info",domProps:{innerHTML:e._s(t.hash_tag.title)}}),e._v(" "),s("div",{staticClass:"hash-count"},[e._v("\n                    "+e._s(t.hash_tag.video_cnt)+"个视频\n                ")])]):3==t.sug_type?s("div",{staticClass:"search-wrap"},[s("img",{staticClass:"icon-wrap",attrs:{src:"//hotsoon.snssdk.com/falcon/live_inapp/res/static/image/search/search_icon_d516409.png",alt:""}}),e._v(" "),s("div",{staticClass:"search-info",domProps:{innerHTML:e._s(t.search.query)}})]):e._e(),e._v(" "),s("div",{staticClass:"hasborder","class":{hidden:a+1==e.results.length}})])})),e._v(" "),s("div",{directives:[{name:"show",rawName:"v-show",value:e.reloading,expression:"reloading"}],staticClass:"suggest",on:{click:e.search}},[e._v("\n        建议不够？点击"),s("span",[e._v("“搜索”")]),e._v("试试\n    ")])])},l.staticRenderFns=[]});