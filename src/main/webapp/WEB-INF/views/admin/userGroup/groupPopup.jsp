<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src='/js/tinymce/tinymce.min.js'></script>
<script src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/js/sweetalert/sweetalert.min.js"></script>
<script src="/js/jquery/jquery.print.js"></script>

<style>
.mce-edit-area {
	border-width: 0px !important;
}
</style>

<script type="text/javascript">

	$(document).ready(function() {
		$("#usr_grp_id").val('${getUsrInfo.usr_grp_id}');
	});
	
	function updateAction(option){

		var param = new Object();
		param.emp_no = $("#emp_no").val();
		param.usr_grp_id = String($("#usr_grp_id").val());
		console.log($("#usr_grp_id").text());
		console.log($("#usr_grp_id").val());
		var msg = '<spring:message code="label.common.confirm.save"/>';
		
		if(param){
			swalConfirm(msg, 'warning', function() {
				$.ajax({
					url:"updateAction.ajax",
					type:'POST',
					data : param,
					dataType: 'json',
					success : function(responseText, statusText) {
						swal({
							  title: '', 
							  text: '<spring:message code="label.common.success.save"/>',
							  type: 'success',
							  showConfirmButton:true,
							  confirmButtonText: 'OK',
							  
							},function(){
								movePage('/admin/userGroup/userGroupList.ajax');
							})
					},
				});
			});
		}
	}	

</script>
<div class="amb_layout_common amb_admin_layout_temp_01 modal-dialog" style="width: 70%; margin-top: -136.5px;">
	<div class="modal-content">
		<!-- 실제 컨텐츠 작업부분 -->
		<div class="modal_header">
			<span class="title">사용자 권한 변경</span> 
			<a href="#" class="close"onClick="javascript:closeModal(this);"><i class="ambicon-015_mark_times"></i></a>
		</div>
		
		<div class="modal_body content" style="max-height: 825px; overflow-y: auto;">
			<div class="rowBox">
				<div class="g_column w_1_1">
					<div id="" class="unitBox grayBox lineBox">
						<table class="amb_form_table">
							<colgroup>
								<col style="width: 30%;" />
								<col style="width: ;" />
							</colgroup>
							<tbody>
								<tr>
									<th>사번</th>
									<td>
										<input type="text" id="emp_no" name="emp_no" class="inp w90p" value="${getUsrInfo.emp_no}" readonly="readonly"/>
										<input type="hidden" id="upd_id" name="upd_id" value="${sessionUserId}"/>							
									</td>
								</tr>
								<tr>
									<th>이름</th>
									<td>
										<input type="text" id="usr_nm" name="usr_nm" value="${getUsrInfo.usr_nm}" class="inp w90p" readonly="readonly"/>								
									</td>
								</tr>
								<tr>
									<th>사용자그룹</th>
									<td>
										<select id="usr_grp_id" name="usr_grp_id" class="inp w90p">
											<c:forEach items="${getUsrGroupList}" var="getUsrGroupList" varStatus="status">
												<option value="${getUsrGroupList.usr_grp_id}">${getUsrGroupList.expln}</option>
											</c:forEach>
										</select>							
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="modal_footer">
			<div class="btnArea right">
				<button type="button" class="amb_btnstyle middle blue" onclick="javascript:updateAction();">
					<span class="text"><spring:message code="label.common.save"/></span>
				</button>
				<button type="button" class="amb_btnstyle middle gray" onclick="closeModal(this);">
					<span class="text"><spring:message code="label.common.cancel"/></span>
				</button>
			</div>
		</div>
	</div>
</div>