<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script src="/js/dynatree/jquery.dynatree.js"></script>
<link rel="stylesheet" href="/js/dynatree/skin/ui.dynatree.css">
<style>
span.node_font_red  a {color:#f00;}
span.dynatree-active.node_font_red a {background-color:#f00!important;}
</style>
<script>
   $(document).ready(function() {
      var activateKey = "${param.grp_cd}";
      if (isEmpty(activateKey)) {
         activateKey = "0";
      }
      $("#activateKey").val(activateKey);
      initTree();
   });

	function refreshScreen(grp_cd) {
		var param = new Object();
		param.grp_cd = grp_cd;
		movePage("", param);
	}
	
   function initTree() {
      $("#tree").dynatree({
      title : '코드관리',
      clickFolderMode : 1, // 1:activate, 2:expand, 3:activate and expand
      fx : {
      height : "toggle",
      duration : 100
      },
      autoFocus : false,
      initAjax : {
      url : "/admin/code/getTreeAction.json",
      type : "POST",
      },
      onPostInit : function(isReloading, isError) {
         var activateKey = $("#activateKey").val();
         this.getNodeByKey(activateKey).activate();
         expandAll("tree");
      },
      onActivate : function(node) {
         
         $("#activateKey").val(node.data.key);
         
      },
      onDblClick : function(node, event) {
    	  goUpdate(node);
      },
      dnd : {
	      onDragStart : function(node) {
	         return false;
	      },
	      autoExpandMS : 1000,
	      preventVoidMoves : true, // Prevent dropping nodes 'before self', etc.
	      onDragEnter : function(node, sourceNode) {
	         if (node.parent !== sourceNode.parent) {
	            return false;
	         }
	         return ["before", "after"];
	      },
	      onDrop : function(node, sourceNode, hitMode, ui, draggable) {
				logMsg("tree.onDrop(%o, %o, %s)", node, sourceNode, hitMode);
				sourceNode.move(node, hitMode);

				var algn_ord;
				var childList = sourceNode.parent.childList;
				for (var i = 0; i < childList.length; i++) {
					var child = childList[i];
					if (child.data.key == sourceNode.data.key) {
						algn_ord = i + 1;
						break;
					}
				}

				var param = new Object();
				param.grp_cd = sourceNode.parent.data.key;
				param.depth = getNodeDepth(sourceNode) - 1;
				param.dtl_cd = sourceNode.data.key;
				param.algn_ord = algn_ord;
				$.ajax({
				url : "moveAction.json",
				type : "POST",
				data : param,
				dataType : "json",
				success : function(data) {
					var result = data.result;
					if (result == "succ") {
						$("#tree").dynatree("getTree").reload();
					} else {
						swal({
					        title: result
					    });
					}
				},
				});
			},
	      onDragLeave : function(node, sourceNode) {
	      }
      },
      });
   }
   
	function goAdd() {
		var activeNode = $("#tree").dynatree("getActiveNode");
		if (activeNode == null) {
			swal({
		        title: '등록'
		    });
			return;
		}
		var url = "insert.ajax";
		var param = new Object();
		
		var pgc = activeNode.parent.data.key;
		var pdc = activeNode.data.key;
		/* var pgd = activeNode.parent.data.title; */
		var pdd = activeNode.data.title;
		var pdde = activeNode.data.title_en;
 		var depth = getNodeDepth(activeNode) - 1;
 		
		if(pgc =='_1' || pgc == null || pgc =='' || pgc =='0') {
			pgc = "000";
		}
		
		if(pdc =='_1' || pdc == null || pdc =='' || pdc =='0') {
			pdc = "000";
		}
			
		param.grp_cd = pgc;
		param.dtl_cd = pdc;
		param.depth = depth;
		param.grp_cd_desc = pdd;
		param.grp_cd_desc_en = pdde;
		param.dtl_cd_desc = pdd;
		param.dtl_cd_desc_en = pdde;
		openModal(url, "insertModal", param,"500");
	}
	
	function goUpdate(node) {
		if (getNodeDepth(node) == 1) {
			return;
		}
		var url = "update.ajax";
		var param = new Object();
		
		var pgc = node.parent.data.key;
		var pdc = node.data.key;
		var pgd = node.parent.data.title;
		var pgde = node.parent.data.title_en;
		var pdd = node.data.title;
		var pdde = node.data.title_en;
 		var depth = getNodeDepth(node) - 1;
 		
 		
		if(pgc =='_1' || pgc == null || pgc =='' || pgc =='0') {
			pgc = "000";
		}
		
		if(pdc =='_1' || pdc == null || pdc =='' || pdc =='0') {
			pdc = "000";
		}
			
		param.grp_cd = pgc;
		param.dtl_cd = pdc;
		param.depth = depth;
		param.grp_cd_desc = pgd;
		param.grp_cd_desc_en = pgde;
		param.dtl_cd_desc = pdd;
		param.dtl_cd_desc_en = pdde;
		
		openModal(url, "updateModal", param,"500");
	}

</script>

<!-- rowBox 반복단위 -->
<div class="rowBox mgT30">
   <div class="g_column w_1_1">
      <div class="unitBox lineBox menuTreeBox" style="">
         <h4>
            <span class="title">코드관리</span>
            <div class="fr btnArea middle">
               <a href="javascript:expandAll('tree');" class="amb_btnstyle white middle onlyIcon">
                  <i class="ambicon-011_scale_up"></i>
               </a>
               <a href="javascript:collapseAll('tree');" class="amb_btnstyle white middle onlyIcon">
                  <i class="ambicon-012_scale_down"></i>
               </a>
               <a href="javascript:goAdd();" class="amb_btnstyle white middle">
				  <i class="ambicon-030_doc_add"></i>
			   </a>
            </div>
         </h4>
         <input type="hidden" id="activateKey" value="0">
         <div id="tree" class="menuTree" style="height: 500px;"></div>
         
            
      </div>
   </div>
</div>


<!-- rowBox 반복단위 -->

