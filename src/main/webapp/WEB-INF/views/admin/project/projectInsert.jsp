<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<script src="/js/jquery.form.js"></script>
<jsp:useBean id="toDay" class="java.util.Date" />
<script>
$(document).ready(function(){
	var textData = [];
	showDate();

	$("#btnSave").on("click", function(e) {
		checkParam();
	});
	
	$("#dept_cd").on("change",function(e){
		changeCmbM(this.value);
	});
	
});

function changeCmbM(cmb){
	var param = new Object();
	param.dept_cd = cmb;

	$.ajax({
		url:"cmbAction.ajax",
		type:'POST',
		data : param,
		dataType: 'json',
		success: function(data){
			var teamList = data.data;
			var teamHtml = '<option value="">-</option>';
			for(var i=0; i<teamList.length; i++){
				teamHtml += '<option value="' + teamList[i].dtl_cd +'">' + teamList[i].dtl_cd_desc + '</option>';
			}
				$("#team_cd").html(teamHtml);
		}
	});

}

function onlyNumber(obj) {
    $(obj).keyup(function(){
         $(this).val($(this).val().replace(/[^0-9-]/gi,""));
    });
}

function checkParam(){
	var pjtcheck = $("#pjt_no").val();
	//코드 체크
	var pjtnocheck = ((pjtcheck.indexOf('CP')+1) || (pjtcheck.indexOf('OP')+1) || (pjtcheck.indexOf('LV')+1));
	if($("#pjt_no").val() == ''){
		swal('<spring:message code="msg.project.valid.chk.pjtno" />', '', 'error');
		return false;
	}if(pjtnocheck == 0){
		swal('<spring:message code="msg.project.valid.chk.pjtnocd" />','','error');
		return false;
	}if(pjtcheck.length != 9){
		swal('<spring:message code="msg.project.valid.chk.pjtnolen" />', '', 'error');
		return false;
	}if($("#pjt_name").val() == ''){
		swal('<spring:message code="msg.project.valid.chk.pjtnm" />', '', 'error');
		return false;
	}if($("#cust_nm").val() == ''){
		swal('<spring:message code="msg.project.valid.chk.custnm" />', '', 'error');
		return false;
	}if($("#pm_nm").val() == ''){
		swal('<spring:message code="msg.project.valid.chk.pmnm" />', '', 'error');
		return false;
	}if($("#dept_cd").val() == ''){
		swal('<spring:message code="msg.project.valid.chk.deptcd" />', '', 'error');
		return false;
	}if($("#strt_dt").val() == ''){
		swal('<spring:message code="label.common.chk.startdate" />', '','error');
		return false;
	}if($("#end_dt").val() == ''){
		swal('<spring:message code="label.common.chk.enddate" />', '','error');
		return false;
	}if(checkDate() == 0){
		swal('<spring:message code="msg.project.valid.chk.checkdt" />', '', 'error');
		return false;
	}else{
		insertAction();
	}
}

function deleteRow(obj) {
	var $obj = $(obj);
	var name = $obj.parent().find('.name').text();
    $(obj).parent().remove();      
    
 }

function addCol(obj){
	var btnId = $(obj).attr("id");	
	if(btnId == "insertMember"){
		openModal('/admin/project/projectMemberPopup.ajax' , 'projectMemberPopup', '', '700');
	}
}

function insertAction(){
	swal({
	     title: "<spring:message code='label.common.save' />",
	     text: "<spring:message code='label.common.confirm.save' />",
	     type: "warning",
	     showCancelButton: true,
	     confirmButtonClass: "btn-danger",
	     confirmButtonText: "<spring:message code='label.common.confirm' />",
	     cancelButtonText: "<spring:message code='label.common.cancel' />",
	     closeOnConfirm: false
	   },
	   function(){
		   $("#projectInfoForm").ajaxForm({
				dataType : "text",
		        beforeSend : function(xmlHttpRequest){
		            xmlHttpRequest.setRequestHeader("AJAX", "true"); 
		        },
				success : function(responseText, statusText) {
					if(responseText == "SUC"){
						swal({
							title: '',
							text : '<spring:message code="label.common.success.save" />',
							type: 'success', 
							showConfirmButton:true, 
							confirmButtonText:'OK',},function(){
								movePage('/admin/project/projectList');
							});
					}
					else if(responseText == "FAIL"){
						swal({
							title: '',
							text: '<spring:message code="msg.project.valid.chk.overlap" />',
							type: 'error',
							showConfirmButton:true,
							confirmButtonText:'OK',},function(){
								return false;
						});
					}
					
				},
				error : function(responseText, statusText){
					swal({
						title: '',
						text: '<spring:message code="label.common.cancel" />',
						type: 'error',
						showConfirmButton:true,
						confirmButtonText:'OK',},function(){
							return false;
					});
				},
			}).submit();
	   });
}

function showDate(){	
	var date = new Date();
	//말일 구하기
	var lastDate = new Date();
	lastDate.setMonth(lastDate.getMonth()+1);
	lastDate.setDate(0);
	
	//첫일 구하기
	var startDate = new Date();
	startDate.setDate(1);
	
	var year = date.getFullYear();
	var month = date.getMonth()+1;
	var day = date.getDate();
	if(month < 10){
		month = "0"+month;
	}
	if(day < 10){
		day = "0"+day
	}
	var currentDate = year+"-"+month+"-0"+startDate.getDate();
	var futureDate = year + "-" + month + "-" + lastDate.getDate();
	$("#strt_dt").val(currentDate);
	$("#end_dt").val(futureDate);
}

//날짜 검사
function checkDate(){
	var strtDate = $("#strt_dt").val();
	var endDate = $("#end_dt").val();
	
	var strtArray = strtDate.split("-");
	var endArray = endDate.split("-");
	
	if(endArray[0] == strtArray[0]){
		if(endArray[1] < strtArray[1] || endArray[2] < strtArray[2]){
			return 0;	
		}
		else if(strtArray[1] > endArray[1]|| strtArray[2] > endArray[2]){
			return 0;
		}

	}else if(endArray[0] < strtArray[0]){
		return 0;
	}else if(strtArray[0] > endArray[0]){
		return 0;
	}
	
}

</script>

<form id="projectInfoForm" name="projectInfoForm" enctype="multipart/form-data" action="projectInsertAction" method="POST" >
<!-- rowBox 반복단위 -->
<div class="rowBox mgT20">
	<div class="g_column w_1_1">
		<h3>
			<span class="title">
			<spring:message code="label.project.projectinsert" />
			</span>
		</h3>
			<div class="unitBox grayBox lineBox" style="">
				<table class="amb_form_table" id="memberInsert">
					<colgroup>
						<col style="width:8%;" />
						<col style="" />
						<col style="width:8%;" />
						<col style="" />
						<col style="width:8%;" />
						<col style="" />
					</colgroup>
					<tbody>
						<tr>
							<th><spring:message code="label.project.checkyn" /></th>
							<td>
								<select id="check_yn" name="check_yn" class="inp w90p">
							 		<option value="1"><spring:message code="label.project.new" /></option>
							 		<option value="2"><spring:message code="label.project.add" /></option>
		                         </select>								
							</td>
							<td colspan="4">
							</td>
						</tr>
						
						<tr>
							<th><spring:message code="label.project.projectdivision" /></th>
							<td>
								<select id="pjt_type_cd" name="pjt_type_cd" class="inp w90p">
									<option value="N11"><spring:message code="label.project.contract" /></option>
									<option value="N12"><spring:message code="label.project.nopjt" /></option>
									<option value="N13"><spring:message code="label.project.vacation" /></option>
								</select>
							</td>
							<th><spring:message code="label.project.pjtno" /></th>
							<td>
								<input type="text" id="pjt_no" name="pjt_no" class="inp _input w90p" maxlength="9" placeholder ="<spring:message code="label.project.pjtno" />"/>
							</td>
							<th><spring:message code="label.project.pjtname" /></th>
							<td>
								<input type="text" id="pjt_name" name="pjt_name" class="inp _input w90p" placeholder ="<spring:message code="label.project.pjtname" />" />
							</td>
						</tr>
						
						<tr>
							<th><spring:message code="label.project.custnm" /></th>
							<td>
								<input type="text" id="cust_nm" name="cust_nm" class="inp _input w90p" placeholder ="<spring:message code="label.project.custnm" />"/>		
		                    </td>
		                    
		                    <th><spring:message code="label.project.pmnm" /></th>
		                    <td>
		                    	<input type="text" id="pm_nm" name="pm_nm" class="inp _input w90p" placeholder ="<spring:message code="label.project.pmnm" />"/>
							</td>
							<th><spring:message code="label.project.dept" /></th>
							<td>
								<select id="dept_cd" name="dept_cd" class="inp w90p">
									<option value=""><spring:message code="label.common.select" /></option>
									<c:forEach items="${getDeptList}" var="getDeptList" varStatus="status">
											<option value="${getDeptList.dtl_cd}">${getDeptList.dtl_cd_desc}</option>
									</c:forEach>
								</select>
						   	</td>	
						</tr>
						
						<tr>
							<th><spring:message code="label.project.contyn" /></th>
							<td>
								<select id="cont_yn" name="cont_yn" class="inp w90p">
							 		<option value="1"><spring:message code="label.project.yes" /></option>
							 		<option value="2"><spring:message code="label.project.no" /></option>
		                        </select>
							</td>
							<th><spring:message code="label.project.useyn" /></th>
							<td>
								<select id="use_yn" name="use_yn" class="inp w90p">
		                        		<option value="1"><spring:message code="label.project.active" /></option>
							 			<option value="2"><spring:message code="label.project.close" /></option>
		                       	</select>
							</td>
							<th><spring:message code="label.common.fromto" /></th>
							<td>
								<span class="datepickerRange">
								<input type="text" id="strt_dt" name="strt_dt" class="inp datepicker startDate" onkeydown="onlyNumber(this)"/>
								~
								<input type="text" id="end_dt" name="end_dt" class="inp datepicker endDate" onkeydown="onlyNumber(this)"/>
								</span>
							</td>
						</tr>
						
						<tr>
							<th><spring:message code="label.project.etcyn" /></th>
							<td>
								<select id="etc_yn" name="etc_yn" class="inp w90p">
							 		<option value="1"><spring:message code="label.project.delvel" /></option>
							 		<option value="2"><spring:message code="label.project.mainte" /></option>
		                     	</select>
		                     </td>
		                     <td colspan="4"></td>
						</tr>
						
						<tr>
							<th><spring:message code="label.project.peple" /></th>
							<td colspan="5">
								<div class="block">
									<button type="button" id="insertMember" class="amb_btnstyle black middle" onclick="addCol(this)"><spring:message code="label.project.add" /></button>
								</div>
								
								<div id="" class="block">
									<ul id="memberList" class="memberList whiteBox lineBox"></ul>
								</div>
								
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			
	</div>
</div>
</form>

<div class="paging">
		<div class="fr btnArea middle">
			<a href="javascript:movePage('/admin/project/projectList');" class="amb_btnstyle gray middle" ><spring:message code="label.common.cancel" /></a>
			<a id="btnSave" class="amb_btnstyle blue middle" ><spring:message code="label.common.save" /></a>	
		</div>
</div>