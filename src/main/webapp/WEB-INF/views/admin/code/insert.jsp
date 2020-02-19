<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script>
	function insertAction() {
		if ($("#insert_dtl_cd").val() == "") {
			swal({
		        title: '<spring:message code="label.code.valid.input.code"/>'},function() {
					$("#insert_dtl_cd").focus();
			});	
			return;
		}
		
		if ($("#insert_dtl_nm").val() == "") {
			swal({
		        title: '<spring:message code="label.code.valid.input.name"/>'},function() {
				$("#insert_dtl_nm").focus();
			});	
			return;
		}
		
		var param = $("#insertForm").serialize();
		
		$.ajax({
			url : "insertAction.ajax",
			type : "POST",
			data : param,
			success : function(data) {
				var result = data.result;
				swal({
			        title: '성공'
					},function() {
						$("#insertModal a.close").trigger("click");
						$("#tree").dynatree("getTree").reload();
				});
				
			},
			error : function(request, status, error) {
				console.log("Error code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				swal({
	    			title: '실패'
			    });
			}
		});
	}
</script>
<div class="amb_layout_common amb_admin_layout_temp_01 modal-dialog">
<div class="modal-content">
	<h1 class="popupHeader">
		<span class="title"><spring:message code="label.code.add"/></span>
		<a href="javascript:;" class="close" onClick="javascript:closeModal(this);">
			<i class="ambicon-015_mark_times"></i>
		</a>
	</h1>

	<div id="content" class="content">
		<div class="rowBox">
			<div class="unitBox">
				<form id="insertForm" action="javascript:insertAction();">
					<input type="hidden" name="grp_cd" value="${(param.grp_cd == null || param.grp_cd == '') ? '000' : param.dtl_cd}">

					<input type="hidden" name="depth" value="${param.depth+1}">
					<table class="amb_form_table lineAll">
						<colgroup>
							<col style="width: 25%;" />
							<col style="" />
						</colgroup>
						<tbody>
							<tr>
								<th class="center">그룹코드</th>
								<td>
									<input type="text" class="inp" style="width: 100%;" value="${(param.grp_cd == null || param.grp_cd == '') ? '000' : param.dtl_cd}" id="insert_grp_cd_desc" name="grp_cd_desc" placeholder="<spring:message code="label.code.name"/>" maxlength="50">
								</td>
							</tr>
							<tr>
								<th class="center">그룹명</th>
								<td>
									<input type="text" class="inp" style="width: 100%;" value="${param.grp_cd_desc}" id="insert_grp_cd_desc" name="grp_cd_desc" placeholder="<spring:message code="label.code.name"/>" maxlength="50">
								</td>
								<td>
									<input type="text" class="inp" style="width: 100%;" value="${param.grp_cd_desc_en}" id="insert_grp_cd_desc_en" name="grp_cd_desc_en" placeholder="<spring:message code="label.code.name"/>" maxlength="50">
								</td>
							</tr>
							<tr>
								<th class="center"><spring:message code="label.code.code"/></th>
								<td>
									<input type="text" class="inp" style="width: 100%;" id="insert_dtl_cd" name="dtl_cd" placeholder="<spring:message code="label.code.code"/>" maxlength="20" autofocus>
								</td>
							</tr>
							<tr>
								<th class="center"><spring:message code="label.code.name"/></th>
								<td>
									<input type="text" class="inp" style="width: 100%;" id="insert_dtl_nm" name="dtl_cd_desc" placeholder="<spring:message code="label.code.name"/>" maxlength="50">
								</td>
								<td>
									<input type="text" class="inp" style="width: 100%;" id="insert_dtl_nm_en" name="dtl_cd_desc_en" placeholder="<spring:message code="label.code.name"/>" maxlength="50">
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				<div class="fr btnArea middle">
					<a href="javascript:insertAction();" class="amb_btnstyle gray middle"><spring:message code="label.common.save"/></a>
				</div>
			</div>
		</div>
		<!-- rowBox 반복단위 -->
	</div>
	</div>
</div>