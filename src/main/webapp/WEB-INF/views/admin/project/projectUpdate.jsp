<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<script src="/js/jquery.form.js"></script>
<jsp:useBean id="toDay" class="java.util.Date" />
<script>
var strDeptCd = ${project.projectInfo[0].dept_cd};
var init_yn = "Y";
$(document).ready(function(){
	var num = 1;
	var textData = [];
	
	$("#dept_cd").on("change",function(e){
		changeCmbM(this.value);
	});
	
	
	$("#btnSave").on("click", function(e) {
		checkParam();
	});

	$("#btnDelete").on("click", function(e) {
		deletePj();
	});	
	
	changeCmbM(strDeptCd);
	
	$("#dept_cd").val('${project.projectInfo[0].dept_cd}');
	
	memberList();
	
});

	function addCol(obj){
		var btnId = $(obj).attr("id");	
		if(btnId == "insertMember"){
			openModal('/admin/project/projectMemberPopup.ajax' , 'projectMemberPopup', '', '700');
		}
	}

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
				var teamHtml = '<option value="">선택</option>';
				for(var i=0; i<teamList.length; i++){
					teamHtml += '<option value="' + teamList[i].dtl_cd +'">' + teamList[i].dtl_cd_desc + '</option>';
				}
				$("#team_cd").html(teamHtml);
				if(init_yn == "Y"){
					var strTeamCd = ${project.projectInfo[0].team_cd}+''; // null 값의 경우 null 값이 아닌 ''로  표현하도록 세팅
					if(strTeamCd == ''){
					
					}else{
						$("#team_cd").val(strTeamCd);
					}
					init_yn = "N";
				}
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
		}else{
			updateAction();
		}
	}

	function updateAction(){
		var sessionId = '${sessionScope.session_user.usr_grp_id}'; 
		if( sessionId != '1') {
			swal('<spring:message code="label.project.update.error" />', '<spring:message code="msg.project.update.error" />', 'error');
			return false;
		}
		
		swal({
			title: '<spring:message code="label.common.modify" />',
	     	text: '<spring:message code="label.common.confirm.save" />',
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
				error : function() {
					swal({
			    		title: '<spring:message code="label.common.cancel" />'
					});
					
				}
			}).submit();
	   });	
	}

	function deletePj(){
		var param = new Object();
		param.pjt_no = $("#pjt_no").val();
	
		var sessionId = '${sessionScope.session_user.usr_grp_id}'; 
		if( sessionId != '1') {
			swal('<spring:message code="label.project.delete.error" />', '<spring:message code="msg.project.delete.error" />', 'error');
			return false;
		}
	
	swal({
		title: "<spring:message code='label.common.delete' />",
	    text: "<spring:message code='label.common.confirm.delete' />",
	    type: "warning",
	    showCancelButton: true,
	    confirmButtonClass: "btn-danger",
	    confirmButtonText: "<spring:message code='label.common.delete' />",
	    cancelButtonText: "<spring:message code='label.common.cancel' />",
	    closeOnConfirm: false
	    },
	   	function(){   
			$.ajax({
				url:  '/admin/project/projectDeleteAction.ajax',
				type:'POST',
				data : param,
				dataType: 'json',
				success: function(data){
					swal({
						title: '',
						text : '<spring:message code="label.common.success.delete" />',
						type: 'success', 
						showConfirmButton:true, 
						confirmButtonText:'OK',},function(){
							movePage('/admin/project/projectList');
						});
	 			 },
	 			 error:function(request,status,error){
	 			 	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	 			 }
	 		});
	   });	
	}

	function memberList(){
		var List = '<c:forEach items='${member.memberInfo}' var='memberInfo' >';
			List += '<li id="row${memberInfo.emp_no}" name="row${memberInfo.emp_no}" class="memberCount">';
			List += '<i class="ambicon-033_human"></i>';
			List += '<span class="name bold">';
			List += '${memberInfo.usr_nm} ${memberInfo.rank_cd}';
			List += '</span>';
			List += '&nbsp;';
			List += '<span class="date"> (${memberInfo.strt_dt} ~ ${memberInfo.end_dt})';
			List += '</span>';
			List += '<input type="hidden" name="emp_no" id="emp_no" value="${memberInfo.emp_no}">';
			List += '<input type="hidden" name="work_dt" value="${memberInfo.work_dt}">';
			List +=	'<input type="hidden" name="mem_strtdt" value="${memberInfo.strt_dt}">';
			List += '<input type="hidden" name="mem_enddt" value="${memberInfo.end_dt}">';
			List += '<input type="hidden" name="work_ect" value="${memberInfo.work_ect}">';
			List += '<span onclick="deleteRow(this)">';	
			List += '<a class="amb_btnstyle gray small onlyIcon"><i class="ambicon-015_mark_times"></i></a></span>';
			List += '</li>';
			List += '</c:forEach>';
			$(".memberList").append(List);
	}


	function deleteRow(obj) {
    	$(obj).parent().remove();       
	}

 
</script>

<form id="projectInfoForm" name="projectInfoForm" enctype="multipart/form-data" action="projectUpdateAction" method="POST" >
<!-- rowBox 반복단위 -->
<div class="rowBox mgT20">
	<div class="g_column w_1_1">
		<h3>
			<span class="title"><spring:message code='label.project.projectupdate' /></span>
		</h3>
			<div class="unitBox grayBox lineBox" style="">
			<input type="hidden" id="pre_pjt_no" name="pre_pjt_no" value="${project.projectInfo[0].pjt_no }"/>
				<table class="amb_form_table">
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
							<th><spring:message code='label.project.checkyn' /></th>
							<td>
							<c:choose>
								<c:when test="${project.projectInfo[0].check_yn == 2}">
									<select id="check_yn" name="check_yn" class="inp w90p">
							 			<option value="1"><spring:message code="label.project.new" /></option>
							 			<option value="2" selected><spring:message code="label.project.add" /></option>
		                        	</select>			
								</c:when>
								<c:otherwise>
									<select id="check_yn" name="check_yn" class="inp w90p">
							 			<option value="1" selected><spring:message code="label.project.new" /></option>
							 			<option value="2"><spring:message code="label.project.add" /></option>
		                        	</select>
								</c:otherwise>
							</c:choose>					
							</td>
							<td colspan="4"></td>
						</tr>
						
						<tr>
							<th><spring:message code="label.project.projectdivision" /></th>
							<td>
							<c:choose>
								<c:when test="${project.projectInfo[0].pjt_type_cd == 'N11'}">
									<select id="pjt_type_cd" name="pjt_type_cd" class="inp w90p">
										<option value="N11" selected><spring:message code="label.project.contract" /></option>
										<option value="N12"><spring:message code="label.project.nopjt" /></option>
										<option value="N13"><spring:message code="label.project.vacation" /></option>
									</select>
								</c:when>
								<c:when test="${project.projectInfo[0].pjt_type_cd == 'N12'}">
									<select id="pjt_type_cd" name="pjt_type_cd" class="inp w90p">
										<option value="N11"><spring:message code="label.project.contract" /></option>
										<option value="N12" selected><spring:message code="label.project.nopjt" /></option>
										<option value="N13"><spring:message code="label.project.vacation" /></option>
									</select>
									</c:when>
								<c:otherwise>
									<select id="pjt_type_cd" name="pjt_type_cd" class="inp w90p">
										<option value="N11"><spring:message code="label.project.contract" /></option>
										<option value="N12"><spring:message code="label.project.nopjt" /></option>
										<option value="N13" selected><spring:message code="label.project.vacation" /></option>
									</select>
								</c:otherwise>
								</c:choose>
							</td>
							<th><spring:message code="label.project.pjtno" /></th>
							<td>
								<input type="text" id="pjt_no" name="pjt_no" class="inp _input w90p" value="${project.projectInfo[0].pjt_no }"  maxlength="9"/>
							</td>
							<th><spring:message code="label.project.pjtname" /></th>
							<td>
								<input type="text" id="pjt_name" name="pjt_name" class="inp _input w90p" value="${project.projectInfo[0].pjt_name}" />
							</td>
						</tr>
						
						<tr>
							<th><spring:message code="label.project.custnm" /></th>
							<td>
								<input type="text" id="cust_nm" name="cust_nm" class="inp _input w90p" value="${project.projectInfo[0].cust_nm}"/>
		                    </td>
		                    
		                    <th><spring:message code="label.project.pmnm" /></th>
		                    <td>
		                    	<input type="text" id="pm_nm" name="pm_nm" class="inp _input w90p" value="${project.projectInfo[0].pm_nm}"/>
		                    </td>
						</tr>
						
						<tr>
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
							<c:choose>
								<c:when test="${project.projectInfo[0].cont_yn == 2}" >
									<select id="cont_yn" name="cont_yn" class="inp w90p">
							 			<option value="1"><spring:message code="label.project.yes" /></option>
							 			<option value="2" selected><spring:message code="label.project.no" /></option>
		                        	</select>
								</c:when>
								<c:otherwise>
									<select id="cont_yn" name="cont_yn" class="inp w90p">
							 			<option value="1" selected><spring:message code="label.project.yes" /></option>
							 			<option value="2"><spring:message code="label.project.no" /></option>
		                        	</select>
								</c:otherwise>
							</c:choose>
							</td>

							<th><spring:message code="label.project.useyn" /></th>
							<td>
							<c:choose>
								<c:when test="${project.projectInfo[0].use_yn == 2}">
									<select id="use_yn" name="use_yn" class="inp w90p">
		                        		<option value="1"><spring:message code="label.project.active" /></option>
							 			<option value="2" selected><spring:message code="label.project.close" /></option>
		                       		</select>
								</c:when>
								<c:otherwise>
									<select id="use_yn" name="use_yn" class="inp w90p">
		                        		<option value="1"selected><spring:message code="label.project.active" /></option>
							 			<option value="2"><spring:message code="label.project.close" /></option>
		                       		</select>
								</c:otherwise>
							</c:choose>	
							</td>
					
							<th><spring:message code="label.common.fromto" /></th>
							<td>
								<span class="datepickerRange">
								<input type="text" id="strt_dt" name="strt_dt" class="inp datepicker startDate" onkeydown="onlyNumber(this)" value="${project.projectInfo[0].strt_dt}"/>
								~
								<input type="text" id="end_dt" name="end_dt" class="inp datepicker endDate" onkeydown="onlyNumber(this)" value="${project.projectInfo[0].end_dt}"/>
								</span>
							</td>
						</tr>
						
						<tr>
							<th><spring:message code="label.project.etcyn" /></th>
							<td>
							<c:choose>
								<c:when test="${project.projectInfo[0].etc_yn == 2}">
									<select id="etc_yn" name="etc_yn" class="inp w90p">
							 			<option value="1"><spring:message code="label.project.delvel" /></option>
							 			<option value="2" selected><spring:message code="label.project.mainte" /></option>
		                     		</select>
								</c:when>
								<c:otherwise>
									<select id="etc_yn" name="etc_yn" class="inp w90p">
							 			<option value="1" selected><spring:message code="label.project.delvel" /></option>
							 			<option value="2"><spring:message code="label.project.mainte" /></option>
		                     		</select>
								</c:otherwise>
							</c:choose>
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
		
		<div class="rowBox mgT20">
			<div class="fr btnArea middle">
				<a id="btnDelete" class="amb_btnstyle blue middle" ><spring:message code="label.common.delete" /></a>
				<a href="javascript:movePage('/admin/project/projectList');" class="amb_btnstyle gray middle" ><spring:message code="label.common.cancel" /></a>
				<a id="btnSave" class="amb_btnstyle blue middle" ><spring:message code="label.common.modify" /></a>
			</div>
		</div>
</form>