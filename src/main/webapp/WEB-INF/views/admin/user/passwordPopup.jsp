<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<script src='/js/tinymce/tinymce.min.js'></script>
<script src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/js/sweetalert/sweetalert.min.js"></script>
<script src="/js/jquery/jquery.print.js"></script>

<style>
.mce-edit-area {
	border-width: 0px !important;
}
.bg_green{
	background-color: honeydew !important;
}

</style>
<script type="text/javascript">
var totalhr = 0;
var lastDayPlus = ${lastDay} +1;


$(document).ready(function() {
	
});

function checkParam(){
 	var pwd_asis = $('#passwordTable tbody input[name="pwd_asis"]').val().trim();
 	var pwd_tobe = $('#passwordTable tbody input[name="pwd_tobe"]').val().trim();
 	var pwd_tobe_chk = $('#passwordTable tbody input[name="pwd_tobe_chk"]').val().trim();
 	
 	if (pwd_asis.length == 0){
 		swal('<spring:message code="label.user.password.txt.null.error"/>', '', 'error');
 		return false;
 	}
 	
 	if (pwd_tobe.length < 8){
 		swal('<spring:message code="label.user.password.txt.length.error"/>', '', 'error');
 		return false;
 	}
 	
 	if (pwd_tobe != pwd_tobe_chk){
 		swal('<spring:message code="label.user.password.txt.diff.error"/>', '', 'error');
 		return false;
 	}
	
 	var param = new Object();
 	param.emp_no = $('#passwordTable tbody input[name="emp_no"]').eq(0).val();
 	param.upd_id = $('#passwordTable tbody input[name="upd_id"]').eq(0).val();
 	param.pwd_asis = pwd_asis;
 	param.pwd_tobe = pwd_tobe;

	return param;
	
}

function updatePasswordAction(){

	var param = checkParam();
	if(param){
		swalConfirm('저장하시겠습니까?', 'warning', function() {
			$.ajax({
				url:'updatePasswordAction.json'
				, type:'POST'
				, data : JSON.stringify(param)
				, dataType: 'text'
				, contentType: 'application/json; charset=utf-8'
				, success: function(data) {
					if ( data == 'succ'){
						swal({
							  title: '',
							  text: "저장에 성공 했습니다.",
							  type: 'success',
							  showConfirmButton:true,
							  confirmButtonText: 'OK',
							  
							},function(){
								movePage('/admin/user/userUpdate.ajax', {emp_no:'${User.emp_no}'});
							})
					}
					else{
						swal({
				    			title: '비밀번호가 틀립니다.',
				  			  	type: 'error',
						    })
					}
				}
			});
		});
	}else{
		swal({
			  title: '변경 비밀번호가 서로 다릅니다.',
			  type: 'error',
			});
	}
}


</script>

<div class="amb_layout_common amb_admin_layout_temp_01 modal-dialog" style="width: 70%; margin-top: -136.5px;">
	<div class="modal-content">
		<!-- 실제 컨텐츠 작업부분 -->
		<div class="modal_header">
			<span class="title">비밀번호 변경</span> 
			<a href="#" class="close"onClick="javascript:closeModal(this);"><i class="ambicon-015_mark_times"></i></a>
		</div>
		
		<div class="modal_body content" style="max-height: 825px; overflow-y: auto;">
			<div class="rowBox">
				<div class="g_column w_1_1">
					<div id="" class="unitBox grayBox lineBox">
						<table class="amb_form_table" id="passwordTable">
							<colgroup>
								<col style="width: 20%;" />
								<col style="width: ;" />
							</colgroup>
							<tbody>
								<tr>
									<th>현재 비밀번호</th>
									<td>
										<input type="hidden" id="emp_no" name="emp_no" value="${User.emp_no}"/>
										<input type="hidden" id="upd_id" name="upd_id" value="${sessionScope.session_user.emp_no}"/>
										<input type="password" id="pwd_asis" name="pwd_asis" class="inp w90p" maxlength="10"/>								
									</td>
								</tr>
								<tr>
									<th>변경 비밀번호</th>
									<td>
										<input type="password" id="pwd_tobe" name="pwd_tobe" class="inp w90p" maxlength="10"/>								
									</td>
								</tr>
								<tr>
									<th>변경 비밀번호 확인</th>
									<td>
										<input type="password" id="pwd_tobe_chk" name="pwd_tobe_chk" class="inp w90p" maxlength="10"/>								
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
				<button type="button" class="amb_btnstyle middle gray" onclick="javascript:updatePasswordAction();">
					<span class="text">저장</span>
				</button>
				<button type="button" class="amb_btnstyle middle gray" onclick="closeModal(this);">
					<span class="text">취소</span>
				</button>
			</div>
		</div>
	</div>
</div>