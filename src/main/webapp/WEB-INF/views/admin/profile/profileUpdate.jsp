<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<jsp:useBean id="toDay" class="java.util.Date" />

<script>
var strDeptCd = ${profile.profileUser[0].dept_cd};
var init_yn = "Y";

var today = new Date();
var mm = today.getMonth()+1; //January is 0!
var dd = today.getDate(); //January is 0!
if(mm<10) mm='0'+mm;
if(dd<10) dd='0'+dd;
var yyyy = today.getFullYear();
var yyyyMm = yyyy+'-'+ mm;
var yyyyMmDd = yyyy+'-'+ mm+'-'+ dd;

$(document).ready(function(){
	// X 버튼으로 row 삭제
	$('body').on('click', '.btn_delete', function() {
		var table_row = $(this);
	    table_row.parent().parent().remove();
	});
	$('body').on('click', '.carr_btn_delete', function() {
		var table_row = $(this);
	    table_row.parent().parent().remove();
	    setCareerPeriod();
	});
	
	// 저장
	$("#btnUpdate").on("click", function(e) {
		updateAction();
	});
	
	// 취소
	$("#btnCancel").on("click", function(e) {
		cancelAction();
	});
	
	// 부서 변경	
	$("#dept_cd").on("change",function(e){
		changeCmbM(this.value);
	});
	
	// 군필 아닐 경우 날짜 비활성화
	$("#mil_cd").on("change",function(e){
		changeMilCd(this.value);
	});
	
	// 이미지
	$("#btnImage").on("click", function(e) {
		$("#file").trigger("click");
	});
	$("#productImageDiv").on("click", function(e) {
		$("#file").trigger("click");

	});
	
	// 파일 이미지 보이기
	$("#file").on("change", handleImgFileSelect);
	
	// default 값 넣기
	$("#tel_no").val(phoneFomatter('${profile.profileUser[0].tel_no}'));
	$("#cell_no").val(phoneFomatter('${profile.profileUser[0].cell_no}'));
	$("#fax_no").val(phoneFomatter('${profile.profileUser[0].fax_no}'));
	
	// 경력 default 값 계산
	setCareerPeriod();
});

// 경력 default 값 계산
function setCareerPeriod() {

	var careerTableTr = $('#careerTable tbody').find('tr');
	var eduTableTr = $('#eduTable tbody').find('tr');
	var dateCount = 0; // 일수 저장
	
	// 경력 일수
	careerTableTr.each(function(idx) {
		var carr_strt_dt = $('#careerTable input[name="carr_strt_dt"]').eq(idx).val();
		var carr_end_dt = $('#careerTable input[name="carr_end_dt"]').eq(idx).val();
		dateCount += dateDiff(carr_strt_dt, carr_end_dt); // 누적
	});
	
	// 일수 계산
	var year = 0;
	var month = 0;
	
	if(dateCount < 30) {
		year = 0;
		month = 0;
	} else if (dateCount < 365) {
		year = 0;
		month = Math.floor(dateCount / 30);
	} else if (dateCount > 365) {
		year = Math.floor(dateCount / 365);
		month = dateCount % 365;
		month = Math.floor(month / 30);
	} else {}
	
	$("#career_y").val(year);
	$("#career_m").val(month);
	$("#career_period").val(dateCount);

}

//경력 사항 수정 시 경력 자동 변경
function updateCareerPeriod(obj){
	onlyNumber(obj);
	setCareerPeriod();
}

// 날짜 차이 계산
function dateDiff(dateA, dateB) {
    var diffDateA = dateA instanceof Date ? dateA : new Date(dateA);
    var diffDateB = dateB instanceof Date ? dateB : new Date(dateB);
 
    diffDateA = new Date(diffDateA.getFullYear(), diffDateA.getMonth()+1, diffDateA.getDate());
    diffDateB = new Date(diffDateB.getFullYear(), diffDateB.getMonth()+1, diffDateB.getDate());
 
    var diff = Math.abs(diffDateB.getTime() - diffDateA.getTime());
    diff = Math.ceil(diff / (1000 * 3600 * 24));
 
    return diff;
}

// 군필
function changeMilCd(cmb) {
	if(cmb == '1'){
		$("#mil_strt_dt").removeAttr("disabled");
		$("#mil_end_dt").removeAttr("disabled");
		$("#mil_strt_dt").val(yyyyMmDd);
		$("#mil_end_dt").val(yyyyMmDd);
	}else{
		$("#mil_strt_dt").val('');
		$("#mil_end_dt").val('');
		$("#mil_strt_dt").attr("disabled","disabled");
		$("#mil_end_dt").attr("disabled","disabled");
	}
}

// 파일 이미지 보이기
function handleImgFileSelect(e) {
	
	var f=this.files[0];
	
	var maxSize = 1024 * 1024 * 5;
 	if (f.size > maxSize || f.fileSize > maxSize)
    {
		swal({
	        title: '<spring:message code="label.file.txt.fileupload.volume.error"/>'
	    });
       	return;
    }
	
	var fileExt = getFileExt($(this).val()).toUpperCase();
	if (fileExt != "JPG" && fileExt != "JPEG" && fileExt != "GIF" && fileExt != "PNG" && fileExt != "BMP") {
		swal({
	        title: '<spring:message code="label.file.txt.fileupload.type.error"/>'
	    });
		return;
	}
	
	var files = e.target.files;
    var filesArr = Array.prototype.slice.call(files);
    
    filesArr.forEach(function(f) {
      if(!f.type.match("image.*")) {
    	  swal({
		        title: '<spring:message code="label.product.prod.valid.limit.image"/>'
		    });
        return;
      }
      
      sel_file = f;
      
      var reader = new FileReader();
      reader.onload = function(e) {
        $("#productImageDiv"). attr("src", e.target.result);
      }
      reader.readAsDataURL(f);
    
    });
  
 }

function onlyNumber(obj) {
    $(obj).keyup(function(){
         $(this).val($(this).val().replace(/[^0-9-]/gi,""));
    });
}

function phoneNumber(obj) {
    $(obj).keyup(function(){
         $(this).val($(this).val().replace(/[^0-9-]/gi,""));
         $(this).val(phoneFomatter($(this).val()));
    });
}

// row 추가
// 0509 - index 추가 (profileService에서 배열로 저장)
function addCol(obj){
	var btnId = $(obj).attr("id");

	if(btnId == "btnAddEdu"){
		var rowCount = $('#eduTable >tbody >tr').length;
		var strTd  = "<tr class= 'datepickerRange'><td>"+ (rowCount+1) + "</td>";
			strTd += "<td><input type='text' id='schl_nm"+ rowCount +"' name='schl_nm' class='inp w90p' placeholder=<spring:message code='label.profile.edu.schl.nm'/> /></td>";
			strTd += "<td><input type='text' id='edu_strt_dt"+ rowCount +"' name='edu_strt_dt' value="+ yyyyMmDd +" class='inp datepicker startDate w90p' onkeydown='onlyNumber(this)'/></td>";
			strTd += "<td><input type='text' id='edu_end_dt"+ rowCount +"' name='edu_end_dt' value="+ yyyyMmDd +" class='inp datepicker endDate w90p' onkeydown='onlyNumber(this)'/></td>";
			strTd += "<td><input type='text' id='major"+ rowCount +"' name='major' class='inp w90p' placeholder=<spring:message code='label.profile.edu.major'/> /></td>";
			strTd += "<td><input type='text' id='edu_remark"+ rowCount +"' name='edu_remark' class='inp w90p' placeholder=<spring:message code='label.profile.common.remark'/> /></td>";
			strTd += "<td><button id='btnDelete' class='amb_btnstyle white middle onlyIcon btn_delete'><i class='ambicon-015_mark_times'></i></button></td></tr>";
		$('#eduTable > tbody:last').append(strTd);
	}else if(btnId == "btnAddCert"){
		var rowCount = $('#certTable >tbody >tr').length;
		var strTd  = "<tr><td>"+ (rowCount+1) + "</td>";
			strTd += "<td><input type='text' id='cert_nm"+ rowCount +"' name='cert_nm' class='inp w90p' placeholder='<spring:message code='label.profile.cert.nm'/>' /></td>";
			strTd += "<td><input type='text' id='get_dt"+ rowCount +"' name='get_dt' id='' value="+ yyyyMmDd +" class='inp datepicker w90p' onkeydown='onlyNumber(this)'/></td>";
			strTd += "<td><input type='text' id='cert_remark"+ rowCount +"' name='cert_remark'  placeholder=<spring:message code='label.profile.common.remark'/> class='inp w90p' /></td>";
			strTd += "<td><button id='btnDelete' class='amb_btnstyle white middle onlyIcon btn_delete'><i class='ambicon-015_mark_times'></i></button></td></tr>";
		$('#certTable > tbody:last').append(strTd);
	} else if(btnId == "btnAddCareer"){
		var rowCount = $('#careerTable >tbody >tr').length;
		var strTd  = "<tr class= 'datepickerRange'><td>"+ (rowCount+1) + "</td>";
			strTd += "<td><input type='text' id='carr_com_nm"+ rowCount +"' name='carr_com_nm' class='inp w90p' placeholder=<spring:message code='label.profile.carr.com.nm'/> /></td>";
			strTd += "<td><input type='text' id='carr_strt_dt"+ rowCount +"' name='carr_strt_dt'  value="+ yyyyMmDd +" class='inp datepicker startDate w90p' onchange='javascript:updateCareerPeriod(this);'/></td>";
			strTd += "<td><input type='text' id='carr_end_dt"+ rowCount +"' name='carr_end_dt'  value="+ yyyyMmDd +" class='inp datepicker endDate w90p' onchange='javascript:updateCareerPeriod(this);'/></td>";
			strTd += "<td><input type='text' id='carr_rank_nm"+ rowCount +"' name='carr_rank_nm' class='inp w90p' placeholder=<spring:message code='label.profile.carr.rank.nm'/> /></td>";
			strTd += "<td><input type='text' id='work"+ rowCount +"' name='work' class='inp w90p' placeholder=<spring:message code='label.profile.carr.work'/> /></td>";
			strTd += "<td><button id='btnDelete' class='amb_btnstyle white middle onlyIcon carr_btn_delete'><i class='ambicon-015_mark_times'></i></button></td></tr>";
		$('#careerTable > tbody:last').append(strTd);
	} else {
		var rowCount = $('#taskTable >tbody >tr').length;
		var strTd  = "<tr class= 'datepickerRange'><td>"+ (rowCount+1) + "</td>";
			strTd += "<td><input type='text' id='prjt_nm"+ rowCount +"' name='prjt_nm' class='inp w90p' placeholder=<spring:message code='label.profile.task.prjt.nm'/> /></td>";
			strTd += "<td><input type='text' id='rltd_com"+ rowCount +"' name='rltd_com' class='inp w90p' placeholder=<spring:message code='label.profile.task.rltd.com'/> /></td>";
			strTd += "<td><input type='text' id='dev_strt_dt"+ rowCount +"' name='dev_strt_dt'  value="+ yyyyMmDd +" class='inp datepicker startDate w90p' onkeydown='onlyNumber(this)'/></td>";
			strTd += "<td><input type='text' id='dev_end_dt"+ rowCount +"' name='dev_end_dt' value="+ yyyyMmDd +" class='inp datepicker endDate w90p' onkeydown='onlyNumber(this)'/></td>";
			strTd += "<td><input type='text' id='my_role"+ rowCount +"' name='my_role' class='inp w90p' placeholder=<spring:message code='label.profile.task.my.role'/> /></td>";
			strTd += "<td><input type='text' id='used_mdel"+ rowCount +"' name='used_mdel' class='inp w90p' placeholder=<spring:message code='label.profile.task.used.mdel'/> /></td>";
			strTd += "<td><input type='text' id='used_os"+ rowCount +"' name='used_os' class='inp w90p' placeholder=<spring:message code='label.profile.task.used.os'/> /></td>";
			strTd += "<td><input type='text' id='used_lang"+ rowCount +"' name='used_lang' class='inp w90p' placeholder=<spring:message code='label.profile.task.used.lang'/> /></td>";
			strTd += "<td><input type='text' id='used_dbms"+ rowCount +"' name='used_dbms' class='inp w90p' placeholder=<spring:message code='label.profile.task.used.dbms'/> /></td>";
			strTd += "<td><input type='text' id='used_dc"+ rowCount +"' name='used_dc' class='inp w90p' placeholder=<spring:message code='label.profile.task.used.dc'/> /></td>";
			strTd += "<td><button id='btnDelete' class='amb_btnstyle white middle onlyIcon btn_delete'><i class='ambicon-015_mark_times'></i></button></td></tr>";
		$('#taskTable > tbody:last').append(strTd);
	}
	
	// row 추가 시 달력 안뜨는 문제 해결
	datepicker();
}

// 유효성 검사
function checkParam(){
	var check = true;
	
	// 군필 아니면 날짜값 없애기
	if($("#mil_cd").val() != '1'){
		$("#mil_strt_dt").val('');
		$("#mil_end_dt").val('');
	}
	
	// 기본 정보 체크
	if($("#usr_nm").val() == '' || $("#srt_no").val() == '' || $("#cell_no").val() == '' || $("#addr").val() == ''
		|| $("#email").val() == '' || $("#cre_dt").val() == ''){
		swal('<spring:message code="label.profile.txt.update.error"/>', '<spring:message code="label.profile.txt.update.basic"/>', 'error');
		check = false;
	}
	// 기타
	else {
		// 업무경험 체크
		var taskTableTr = $('#taskTable tbody').find('tr'); // tr 을 찾아서 배열로 저장
		taskTableTr.each(function(idx) {
			if($('#taskTable input[name="prjt_nm"]').eq(idx).val() == ''){
				swal('<spring:message code="label.profile.txt.update.error"/>', '<spring:message code="label.profile.txt.update.prjt"/>', 'error');
				check = false;
			} else if($('#taskTable input[name="rltd_com"]').eq(idx).val() == ''){
				swal('<spring:message code="label.profile.txt.update.error"/>', '<spring:message code="label.profile.txt.update.rltd"/>', 'error');
				check = false;
			} else { }

			if($('#taskTable input[name="my_role"]').eq(idx).val() == ''){
				$('#taskTable input[name="my_role"]').eq(idx).val('-');
			}
			if($('#taskTable input[name="used_mdel"]').eq(idx).val() == ''){
				$('#taskTable input[name="used_mdel"]').eq(idx).val('-');
			}
			if($('#taskTable input[name="used_os"]').eq(idx).val() == ''){
				$('#taskTable input[name="used_os"]').eq(idx).val('-');
			}
			if($('#taskTable input[name="used_lang"]').eq(idx).val() == ''){
				$('#taskTable input[name="used_lang"]').eq(idx).val('-');
			}
			if($('#taskTable input[name="used_dbms"]').eq(idx).val() == ''){
				$('#taskTable input[name="used_dbms"]').eq(idx).val('-');
			}
			if($('#taskTable input[name="used_dc"]').eq(idx).val() == ''){
				$('#taskTable input[name="used_dc"]').eq(idx).val('-');
			}
		});
		// 경력사항 체크
		var careerTableTr = $('#careerTable tbody').find('tr'); // tr 을 찾아서 배열로 저장
		careerTableTr.each(function(idx) {
			if($('#careerTable input[name="carr_com_nm"]').eq(idx).val() == ''){
				swal('<spring:message code="label.profile.txt.update.error"/>', '<spring:message code="label.profile.txt.update.com"/>', 'error');
				check = false;
			} else if($('#careerTable input[name="carr_strt_dt"]').eq(idx).val() >= yyyyMmDd){
				swal('<spring:message code="label.profile.txt.update.error"/>', '<spring:message code="label.profile.txt.update.strt"/>', 'error');
				check = false;
			} else if($('#careerTable input[name="carr_strt_dt"]').eq(idx).val() >= $('#careerTable input[name="carr_end_dt"]').eq(idx).val()){
				swal('<spring:message code="label.profile.txt.update.error"/>', '<spring:message code="label.profile.txt.update.end"/>', 'error');
				check = false;
			} else { }
			
			if($('#careerTable input[name="carr_rank_nm"]').eq(idx).val() == ''){
				$('#careerTable input[name="carr_rank_nm"]').eq(idx).val('-');
			}
			if($('#careerTable input[name="work"]').eq(idx).val() == ''){
				$('#careerTable input[name="work"]').eq(idx).val('-');
			}
		});
		// 자격사항 체크
		var certTableTr = $('#certTable tbody').find('tr'); // tr 을 찾아서 배열로 저장
		certTableTr.each(function(idx) {
			if($('#certTable input[name="cert_nm"]').eq(idx).val() == ''){
				swal('<spring:message code="label.profile.txt.update.error"/>', '<spring:message code="label.profile.txt.update.cert"/>', 'error');
				check = false;
			} else if($('#certTable input[name="get_dt"]').eq(idx).val() > yyyyMmDd){
				swal('<spring:message code="label.profile.txt.update.error"/>', '<spring:message code="label.profile.txt.update.get"/>', 'error');
				check = false;
			} else { }

			if($('#certTable input[name="cert_remark"]').eq(idx).val() == ''){
				$('#certTable input[name="cert_remark"]').eq(idx).val('-');
			}
		});
		// 학력사항 체크
		var eduTableTr = $('#eduTable tbody').find('tr'); // tr 을 찾아서 배열로 저장
		eduTableTr.each(function(idx) {
			if($('#eduTable input[name="schl_nm"]').eq(idx).val() == ''){
				swal('<spring:message code="label.profile.txt.update.error"/>', '<spring:message code="label.profile.txt.update.schl"/>', 'error');
				check = false;
			} else if($('#eduTable input[name="edu_strt_dt"]').eq(idx).val() >= yyyyMmDd){
				swal('<spring:message code="label.profile.txt.update.error"/>', '<spring:message code="label.profile.txt.update.strt"/>', 'error');
				check = false;
			} else if($('#eduTable input[name="edu_strt_dt"]').eq(idx).val() >= $('#eduTable input[name="edu_end_dt"]').eq(idx).val()){
				swal('<spring:message code="label.profile.txt.update.error"/>', '<spring:message code="label.profile.txt.update.end"/>', 'error');
				check = false;
			} else { }

			if($('#eduTable input[name="major"]').eq(idx).val() == ''){
				$('#eduTable input[name="major"]').eq(idx).val('-');
			}
			if($('#eduTable input[name="edu_remark"]').eq(idx).val() == ''){
				$('#eduTable input[name="edu_remark"]').eq(idx).val('-');
			}
		});
	}
	
	if (check) {
		return true;
	}
	else {
		return false;
	}
	
	// document.getElementById('profileForm').submit();
}

// 저장
function updateAction(){
	swal({
		title: "<spring:message code='label.profile.txt.update.confirm'/>",
		text: "<spring:message code='label.profile.txt.update.confirm.txt'/>",
		type: "warning",
		showCancelButton: true,
		confirmButtonClass: "btn-danger",
		confirmButtonText: "<spring:message code='label.common.yes'/>",
		cancelButtonText: "<spring:message code='label.common.no'/>",
		closeOnConfirm: false
	},
	function(){	
		var param = checkParam();
		if(param){
			$("#profileUpdateForm").ajaxForm({
				dataType : "text",
		        beforeSend : function(xmlHttpRequest){
		            xmlHttpRequest.setRequestHeader("AJAX", "true"); 
		        },
				success : function(responseText, statusText) {
					swal({
						title: "<spring:message code='label.profile.txt.update.succ'/>",
					  	text: "<spring:message code='label.profile.txt.update.succ.txt'/>",
					  	type: "success",
					},
					function(){	
						history.back();
					});
				},
				error : function(request, status, error) {
					alert("<spring:message code='label.profile.txt.update.error'/>");
				}
			}).submit();
		}
	});
}

//삭제
function deleteAction(empNo){
	var param = new Object();
	param.emp_no = empNo;
	
	swal({
	  	title: "<spring:message code='label.profile.txt.delete.confirm'/>",
	  	text: "<spring:message code='label.profile.txt.delete.confirm.txt'/>",
	  	type: "warning",
	  	showCancelButton: true,
	 	confirmButtonClass: "btn-danger",
		confirmButtonText: "<spring:message code='label.common.yes'/>",
		cancelButtonText: "<spring:message code='label.common.no'/>",
	  	closeOnConfirm: false
	},
	function(){
		$.ajax({
			url:"hideUserAction.ajax",
			type:'POST',
			data : param,
			dataType: 'json',
			success: function(data){
				swal({
					title: "<spring:message code='label.profile.txt.delete.succ'/>",
					text: "<spring:message code='label.profile.txt.delete.succ.txt'/>",
					type: "success"
				},
				function(){
					window.location.href = 'profileList';
				});				
			}
		});
	});
}

// 취소
function cancelAction(){
	swal({
	  	title: "<spring:message code='label.profile.txt.cancel.confirm'/>",
	  	text: "<spring:message code='label.profile.txt.cancel.confirm.txt'/>",
	  	type: "warning",
	  	showCancelButton: true,
	 	confirmButtonClass: "btn-danger",
		confirmButtonText: "<spring:message code='label.common.yes'/>",
		cancelButtonText: "<spring:message code='label.common.no'/>",
	  	closeOnConfirm: false
	},
	function(){	
		history.back();
	});
}
</script>

<form id="profileUpdateForm" name="profileUpdateForm" enctype="multipart/form-data" action="updateProfileAction" method="POST" >
	
	<div class="rowBox mgT20">
		<div class="g_column w_5_4">
			<h3>
				<span class="title"><spring:message code="label.user.userinfo"/></span>
			</h3>
			<div class="unitBox grayBox lineBox" style="">
				<table class="amb_form_table">
					<colgroup>
	                    <col style="width: 8%;">
	                    <col style="width: ;">
	                    <col style="width: 8%;">
	                    <col style="width: ;">
	                    <col style="width: 8%;">
	                    <col style="width: ;">
					</colgroup>
					<tbody>
						<tr>
							<th><spring:message code="label.user.usernm"/></th>
							<td>
								<!-- cre_id, upd_id : session user 의 id 값 -->
								<input type="hidden" id="cre_id" name="cre_id" class="inp w90p" value="${sessionScope.session_user.emp_no}"/>
								<input type="hidden" id="upd_id" name="upd_id" class="inp w90p" value="${sessionScope.session_user.emp_no}"/>		
								<input type="hidden" id="file_id" name="file_id" class="inp w90p" value="${profile.profileUser[0].file_id}"/>	
								<input type="hidden" id="gend_cd" name="gend_cd" class="inp w90p" value="${profile.profileUser[0].gend_cd}"/>
								<input type="text" id="usr_nm" name="usr_nm" class="inp w90p" maxlength="10" value="${profile.profileUser[0].usr_nm}" readonly/>
							</td>
							<th><spring:message code="label.user.srtno"/></th>
							<td>
								<input type="text" id="srt_no" name="srt_no" class="inp w90p" value="${profile.profileUser[0].srt_no}" maxlength="20" readonly/>
							</td>
							<th><spring:message code="label.user.addr"/></th>
							<td>
								<input type="text" id="addr" name="addr" class="inp w90p" value="${profile.profileUser[0].addr}" readonly />
							</td>
						</tr>
						
						<tr>
							<th><spring:message code="label.user.phone"/></th>
							<td>
								<input type="text" id="tel_no" name="tel_no" class="inp w90p" value="" onkeydown="phoneNumber(this)" readonly/>
						   	</td>	
							<th><spring:message code="label.user.cellphone"/></th>
							<td>
								<input type="text" id="cell_no" name="cell_no" class="inp w90p" value="" onkeydown="phoneNumber(this)" readonly/>
						   	</td>
						   	<th><spring:message code="label.user.fax"/></th>
							<td>
								<input type="text" id="fax_no" name="fax_no" class="inp w90p" value="" onkeydown="phoneNumber(this)" readonly/>
						   	</td>
						</tr>
						<tr>
							<th><spring:message code="label.user.email"/></th>
							<td>
								<input type="text" id="email" name="email" class="inp w90p" value="${profile.profileUser[0].email}" maxlength="30" readonly/>
							</td>
							<th><spring:message code="label.user.marry"/></th>
							<td>
								<input type="text" class="inp w90p" value="${profile.mari_yn_val}" readonly/>
								<input type="text" id="mari_yn" name="mari_yn" class="inp w90p" value="${profile.profileUser[0].mari_yn}" maxlength="30" hidden="hidden"/>
							</td>
						   	<th></th>
						   	<td></td>
						</tr>
						<tr>
							<th><spring:message code="label.user.ability"/></th>
							<td>
								<input type="text" id="spe_abil" name="spe_abil" class="inp w90p" value="${profile.profileUser[0].spe_abil}" readonly/>
							</td>
							<th><spring:message code="label.user.military"/></th>
							<td colspan="3"> 
								<input type="text" class="inp w30p" value="${profile.mil_cd_val}" readonly/>
								<input type="text" id="mil_cd" name="mil_cd" class="inp w90p" value="${profile.profileUser[0].mil_cd}" maxlength="30" hidden="hidden"/>
								<c:choose>
									<c:when test="${profile.profileUser[0].mil_cd eq '1'}">
								       	<span class="datepickerRange">
											<input type="text" id="mil_strt_dt" name="mil_strt_dt" class="inp w30p" readonly value="${profile.profileUser[0].mil_strt_dt}" placeholder="date" maxlength="10" onkeydown="onlyNumber(this)"/>
											~
											<input type="text" id="mil_end_dt" name="mil_end_dt" class="inp w30p" readonly value="${profile.profileUser[0].mil_end_dt}" placeholder="date" maxlength="10" onkeydown="onlyNumber(this)"/>
										</span>
							       	</c:when>
							       	<c:otherwise></c:otherwise>
							  	</c:choose>
						   	</td>
						</tr>
					</tbody>
				</table>
			</div>
			<input type="file" id="file" name="file" class="hidden" />
		</div>
		
		<div class="g_column w_5_1">            
	         <h3>
				<div class="fr btnArea middle">
					<!--  <button id="btnImage" class="amb_btnstyle black middle" onclick="javascript:openModal('/common/imgPopup.ajax' , 'imgPopup', '', '600')">사진등록</button> -->
					<button type="button" id="btnImage" class="amb_btnstyle black middle" onclick="javascript:;"><spring:message code="label.user.pic.insert"/></button>
				</div>
	         </h3>
	         <div class="unitBox grayBox lineBox pd0" style="">
	            <div class="photoBox center">
	               <span class="photoBox_imgBox">
	                  <img id="productImageDiv" src="${profile.profileUser[0].file_uri}"  style="width: 120px; height: 154px; cursor:pointer; background:#ffffff; border: 1px solid #d1d1d1; position: relative;">
	               </span>
	            </div>
	         </div>
	   	</div>
	</div>                    
		                    
	<!-- 사내정보 -->
	<div class="rowBox mgT20">
		<div class="g_column w_1_1">
			<h3>
				<span class="title"><spring:message code="label.user.cominfo"/></span>
			</h3>
				<div class="unitBox grayBox lineBox" style="">
					<table class="amb_form_table">
						<colgroup>
                     		<col style="width: 8%;">
                     		<col style="width: ;">
                     		<col style="width: 8%;">
                     		<col style="width: ;">
                     		<col style="width: 8%;">
                     		<col style="width: ;">
						</colgroup>
						<tbody>
							<tr>
								<th><spring:message code="label.user.empno"/></th>
								<td>
									<input type="text" id="emp_no" name="emp_no" class="inp w90p" maxlength="5" readonly value="${profile.profileUser[0].emp_no}"/>								
								</td>
								<th><spring:message code="label.user.dept"/></th>
								<td>
									<input type="text" class="inp w90p" value="${profile.profileUser[0].dept_cd_st}" readonly/>
									<input type="text" id="dept_cd" name="dept_cd" class="inp w90p" value="${profile.profileUser[0].dept_cd}" maxlength="30" hidden="hidden"/>
								</td>
								<th><spring:message code="label.user.team"/></th>
								<td>
									<input type="text" class="inp w90p" value="${profile.profileUser[0].team_cd_st}" readonly/>
									<input type="text" id="team_cd" name="team_cd" class="inp w90p" value="${profile.profileUser[0].team_cd}" maxlength="30" hidden="hidden"/>
								</td>
							</tr>
							<tr>
								<th><spring:message code="label.user.rank"/></th>
								<td>
									<input type="text" class="inp w90p" value="${profile.profileUser[0].rank_cd_st}" readonly/>
									<input type="text" id="rank_cd" name="rank_cd" class="inp w90p" value="${profile.profileUser[0].rank_cd}" maxlength="30" hidden="hidden"/>
							   	</td>	
								<th><spring:message code="label.user.psit"/></th>
								<td>
									<input type="text" class="inp w90p" value="${profile.profileUser[0].psit_cd_st}" readonly/>
									<input type="text" id="psit_cd" name="psit_cd" class="inp w90p" value="${profile.profileUser[0].psit_cd}" maxlength="30" hidden="hidden"/>
							   	</td>
							   	<th><spring:message code="label.user.step"/></th>
								<td>
									<input type="text" class="inp w90p" value="${profile.profileUser[0].step_cd_st}" readonly/>
									<input type="text" id="step_cd" name="step_cd" class="inp w90p" value="${profile.profileUser[0].step_cd}" maxlength="30" hidden="hidden"/>
							   	</td>
							</tr>
							<tr>
								<th><spring:message code="label.user.comstrt"/></th>
								<td>
									<input type="text" id="com_strt_dt" name="com_strt_dt" class="inp w90p" readonly value="${profile.profileUser[0].com_strt_dt }" class="inp" placeholder="date" onkeydown="onlyNumber(this)"/>
								</td>
								<th><spring:message code="label.user.stmp"/></th>
								<td>
									<input type="text" class="inp w90p" value="${profile.profileUser[0].grade_st}" readonly/>
									<input type="text" id="grade" name="grade" class="inp w90p" value="${profile.profileUser[0].grade}" maxlength="30" hidden="hidden"/>
								</td>
								<th><spring:message code="label.user.comnm"/></th>
								<td>
									<input type="text" id="com_cd" name="com_cd" class="inp w90p" value="${profile.profileUser[0].com_cd}" readonly/>
								</td>
							</tr>
							<tr>
								<th><spring:message code="label.user.worp"/></th>
								<td>
									<input type="text" id="worp_cd" name="worp_cd" class="inp w90p" value="${profile.profileUser[0].worp_cd}" readonly/>
							   	</td>
								<th><spring:message code="label.profile.hist.carr.period"/></th>
								<td>
									<input type="text" id="career_y" name="career_y" class="inp w35p" value="" readonly/><spring:message code="label.profile.hist.carr.period.y"/> &nbsp;
									<input type="text" id="career_m" name="career_m" class="inp w35p" value="" readonly/><spring:message code="label.profile.hist.carr.period.m"/>
									<input type="hidden" id="career_period" name="career_period" class="inp w35p" value="" readonly/>
							   	</td>
								<th></th>
								<td></td>
							</tr>
						</tbody>
					</table>
				</div>
		</div>
	</div>

	<!-- 학력사항 -->
	<div class="rowBox mgT20">
		<div class="g_column w_1_1">
			<h3>
				<span class="title"><spring:message code="label.profile.edu"/></span>
				<div class="fr btnArea middle">
					<a href="javascript:" id="btnAddEdu" class="amb_btnstyle black middle" onclick="addCol(this)"><i class="ambicon-013_mark_plus"></i> <spring:message code="label.profile.common.add"/></a>
				</div>
			</h3>
			<div class="unitBox" style="">
				<table class="amb_table center" id="eduTable">
					<colgroup>
	                    <col style="width:60px;" />
	                    <col style="" />
	                    <col style="" />
	                    <col style="" />
	                    <col style="" />
	                    <col style="" />
	                    <col style="width:60px;" />
					</colgroup>
					<thead>
						<tr>
							<th><spring:message code="label.profile.common.count"/></th> 
							<th><spring:message code="label.profile.edu.schl.nm"/></th> 
							<th><spring:message code="label.profile.common.strt.dt"/></th> 
							<th><spring:message code="label.profile.common.end.dt"/></th> 
							<th><spring:message code="label.profile.edu.major"/></th> 
							<th><spring:message code="label.profile.common.remark"/></th> 
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${profile.profileEdu}" var="profileEdu" varStatus="status">
							<tr class="datepickerRange">
								<td>${status.count}</td>
								<td><input id="schl_nm" name="schl_nm" type="text" class="inp w90p" value="${profileEdu.schl_nm}"/></td>
								<td><input id="edu_strt_dt" name="edu_strt_dt" type='text' class="inp datepicker startDate w90p" value="${profileEdu.edu_strt_dt}" onkeydown="onlyNumber(this)"/></td>
								<td><input id="edu_end_dt" name="edu_end_dt" type='text' class="inp datepicker endDate w90p" value="${profileEdu.edu_end_dt}" onkeydown="onlyNumber(this)"/></td>
								<td><input id="major" name="major" type="text" class="inp w90p" value="${profileEdu.major}"/></td>
								<td><input id="edu_remark" name="edu_remark" type="text" class="inp w90p" value="${profileEdu.edu_remark}"/></td>
								<td><button id='btnDelete' class='amb_btnstyle white middle onlyIcon btn_delete'><i class='ambicon-015_mark_times'></i></button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	<!-- 자격사항 -->
	<div class="rowBox mgT20">
		<div class="g_column w_1_1">
			<h3>
				<span class="title"><spring:message code="label.profile.cert"/></span>
				<div class="fr btnArea middle">
					<a href="javascript:" id="btnAddCert" class="amb_btnstyle black middle" onclick="addCol(this)"><i class="ambicon-013_mark_plus"></i> <spring:message code="label.profile.common.add"/></a>
				</div>
			</h3>
			<div class="unitBox" style="">
            <table class="amb_table center" id="certTable">
					<colgroup>
						<col style="width:60px;" />
						<col style="" />
						<col style="" />
						<col style="" />
						<col style="width:60px;" />
					</colgroup>
					<thead>
						<tr>
							<th><spring:message code="label.profile.common.count"/></th>
							<th><spring:message code="label.profile.cert.nm"/></th>
							<th><spring:message code="label.profile.cert.get.dt"/></th>
							<th><spring:message code="label.profile.common.remark"/></th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${profile.profileCert}" var="profileCert" varStatus="status">
							<tr>
								<td>${status.count}</td>
								<td><input type="text" id="cert_nm" name="cert_nm" class="inp w90p" value="${profileCert.cert_nm}"/></td>
								<td><input type='text' id="get_dt" name="get_dt" class="inp datepicker w90p" value="${profileCert.get_dt}" placeholder='date' maxlength="10" onkeydown="onlyNumber(this)"/></td>
								<td><input type="text" id="cert_remark" name="cert_remark" class="inp w90p" value="${profileCert.cert_remark}"/></td>
								<td><button id='btnDelete' class='amb_btnstyle white middle onlyIcon btn_delete'><i class='ambicon-015_mark_times'></i></button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
		</div>
	</div>
	
	<!-- 경력사항 -->
	<div class="rowBox mgT20">
		<div class="g_column w_1_1">
			<h3>
				<span class="title"><spring:message code="label.profile.carr"/></span>
				<div class="fr btnArea middle">
					<a href="javascript:" id="btnAddCareer" class="amb_btnstyle black middle" onclick="addCol(this)"><i class="ambicon-013_mark_plus"></i> <spring:message code="label.profile.common.add"/></a>
				</div>
			</h3>
			<div class="unitBox" style="">
				<table class="amb_table center" id="careerTable">
					<colgroup>
						<col style="width:60px;" />
						<col style="" />
						<col style="" />
						<col style="" />
						<col style="" />
						<col style="" />
						<col style="width:60px;" />
					</colgroup>
					<thead>
						<tr>
							<th><spring:message code="label.profile.common.count"/></th>
							<th><spring:message code="label.profile.carr.com.nm"/></th>
							<th><spring:message code="label.profile.common.strt.dt"/></th> 
							<th><spring:message code="label.profile.common.end.dt"/></th> 
							<th><spring:message code="label.profile.carr.rank.nm"/></th>
							<th><spring:message code="label.profile.carr.work"/></th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${profile.profileCarr}" var="profileCarr" varStatus="status">
							<tr class="datepickerRange">
								<td>${status.count}</td>
								<td><input type="text" id="carr_com_nm" name="carr_com_nm" class="inp w90p" value="${profileCarr.carr_com_nm}"/></td>
								<td><input type='text' id="carr_strt_dt" name="carr_strt_dt" class="inp datepicker startDate w90p" value="${profileCarr.carr_strt_dt}" placeholder='date' maxlength="10" onchange="javascript:updateCareerPeriod(this);"/></td>
								<td><input type='text' id="carr_end_dt" name="carr_end_dt" class="inp datepicker endDate w90p" value="${profileCarr.carr_end_dt}" placeholder='date' maxlength="10" onchange="javascript:updateCareerPeriod(this);"/></td>
								<td><input type="text" id="carr_rank_nm" name="carr_rank_nm" class="inp w90p" value="${profileCarr.carr_rank_nm}"/></td>
								<td><input type="text" id="work" name="work" class="inp w90p" value="${profileCarr.work}"/></td>
								<td><button id='btnDelete' class='amb_btnstyle white middle onlyIcon carr_btn_delete'><i class='ambicon-015_mark_times'></i></button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	<!-- 업무경험 -->
	<div class="rowBox mgT20">
		<div class="g_column w_1_1">
			<h3>
				<span class="title"><spring:message code="label.profile.task"/></span>
				<div class="fr btnArea middle">
					<a href="javascript:" id="btnAddTask" class="amb_btnstyle black middle" onclick="addCol(this)"><i class="ambicon-013_mark_plus"></i> <spring:message code="label.profile.common.add"/></a>
				</div>
			</h3>
			<div class="unitBox" style="">
				<table class="amb_table center" id="taskTable">
					<colgroup>
						<col style="width:60px;" />
						<col style="" />
						<col style="" />
						<col style="" />
						<col style="" />
						<col style="" />
						<col style="" />
						<col style="" />
						<col style="" />
						<col style="" />
						<col style="" />
						<col style="width:60px;" />
					</colgroup>
					<thead>
						<tr>
							<th><spring:message code="label.profile.common.count"/></th>
							<th><spring:message code="label.profile.task.prjt.nm"/></th>
							<th><spring:message code="label.profile.task.rltd.com"/></th>
							<th><spring:message code="label.profile.common.strt.dt"/></th> 
							<th><spring:message code="label.profile.common.end.dt"/></th> 
							<th><spring:message code="label.profile.task.my.role"/></th>
							<th><spring:message code="label.profile.task.used.mdel"/></th>
							<th><spring:message code="label.profile.task.used.os"/></th>
							<th><spring:message code="label.profile.task.used.lang"/></th>
							<th><spring:message code="label.profile.task.used.dbms"/></th>
							<th><spring:message code="label.profile.task.used.dc"/></th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${profile.profileTask}" var="profileTask" varStatus="status">
							<tr class="datepickerRange">
								<td>${status.count}</td>
								<td><input type="text" id="prjt_nm" name="prjt_nm" class="inp w90p" value="${profileTask.prjt_nm}"/></td>
								<td><input type="text" id="rltd_com" name="rltd_com" class="inp w90p" value="${profileTask.rltd_com}"/></td>
								<td><input type='text' id="dev_strt_dt" name="dev_strt_dt" class="inp datepicker w90p startDate" value="${profileTask.dev_strt_dt}" placeholder='date' maxlength="10" onkeydown="onlyNumber(this)"/></td>
								<td><input type='text' id="dev_end_dt" name="dev_end_dt" class="inp datepicker w90p endDate" value="${profileTask.dev_end_dt}" placeholder='date' maxlength="10" onkeydown="onlyNumber(this)"/></td>
								<td><input type="text" id="my_role" name="my_role" class="inp w90p" value="${profileTask.my_role}"/></td>
								<td><input type="text" id="used_mdel" name="used_mdel" class="inp w90p" value="${profileTask.used_mdel}"/></td>
								<td><input type="text" id="used_os" name="used_os" class="inp w90p"  value="${profileTask.used_os}"/></td>
								<td><input type="text" id="used_lang" name="used_lang" class="inp w90p" value="${profileTask.used_lang}"/></td>
								<td><input type="text" id="used_dbms" name="used_dbms" class="inp w90p" value="${profileTask.used_dbms}"/></td>
								<td><input type="text" id="used_dc" name="used_dc" class="inp w90p" value="${profileTask.used_dc}"/></td>
								<td><button id='btnDelete' class='amb_btnstyle white middle onlyIcon btn_delete'><i class='ambicon-015_mark_times'></i></button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	<!-- 저장 버튼 -->
	<div class="rowBox mgT20">
		<div class="fr btnArea middle">
			 <a id="btnCancel" class="amb_btnstyle gray middle" ><spring:message code="label.common.return"/></a>
			 <a id="btnUpdate" class="amb_btnstyle blue middle" ><spring:message code="label.common.save"/></a>
			 <c:if test="${sessionScope.session_user.usr_grp_id ne '4' && sessionScope.session_user.emp_no eq 'admin'}">
			 	<a href="javaScript:deleteAction('${profile.profileUser[0].emp_no}');" class="amb_btnstyle blue middle" >
			 		<spring:message code="label.common.delete"/>
			 	</a>
			 </c:if>
		</div>
	</div>

</form>