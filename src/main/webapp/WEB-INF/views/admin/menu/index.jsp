<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script src="/js/dynatree/jquery.dynatree.js"></script>
<link rel="stylesheet" href="/js/dynatree/skin/ui.dynatree.css">
<script>
	$(document).ready(function() {
		var activateKey = "${param.menu_id}";
		if (isEmpty(activateKey)) {
			activateKey = "0";
		}
		$("#activateKey").val(activateKey);
		initTree();
	});

	function refreshScreen(menu_id) {
		var param = new Object();
		param.menu_id = menu_id;
		movePage("", param);
	}

	function initTree() {
		$("#tree").dynatree({
		title : '<spring:message code="label.menu.manage"/>',
		clickFolderMode : 1, // 1:activate, 2:expand, 3:activate and expand
		fx : {
		height : "toggle",
		duration : 100
		},
		autoFocus : false,
		initAjax : {
		url : "getTreeAction.json",
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
			goUpdate(node.data.key);
		},
		});
	}

	function goAdd() {
		var activeNode = $("#tree").dynatree("getActiveNode");
		if (activeNode == null) {
			swal({
		        title: '<spring:message code="label.menu.valid.select.parent"/>'
		    });
			return;
		}
		var url = "insert.ajax";
		var param = new Object();
		param.menu_id = activeNode.data.key;
		openModal(url, "insertModal", param,"500");
	}

	function goUpdate(menu_id) {
		if (menu_id == "0") {
			return;
		}
		var url = "update.ajax";
		var param = new Object();
		param.menu_id = menu_id;
		openModal(url, "updateModal", param);
	}
</script>

<!-- rowBox 반복단위 -->
<div class="rowBox mgT30">
	<div class="g_column w_1_1">
		<div class="unitBox lineBox menuTreeBox" style="">
			<h4>
				<span class="title"><spring:message code="label.menu.manage"/></span>
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


