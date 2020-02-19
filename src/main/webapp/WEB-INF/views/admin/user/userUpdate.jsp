<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<script src="/js/jquery.form.js"></script>
<jsp:useBean id="toDay" class="java.util.Date" />
<script>
var strDeptCd = ${user.userInfo[0].dept_cd};
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
	
	$('body').on('click', '.btn_delete', function() {
		var table_row = $(this);
	    table_row.parent().parent().remove();
	});
	
	$("#dept_cd").on("change",function(e){
		changeCmbM(this.value);
	});
	
	$("#btnImage").on("click", function(e) {
		$("#file").trigger("click");
	});
	
	$("#productImageDiv").on("click", function(e) {
		$("#file").trigger("click");

	});
	
	
	$("#btnSave").on("click", function(e) {
		updateAction();
	});
	
	$("#btnUseYn").on("click", function(e) {
		updateUseYn();
	});
	
	$("#file").on("change", handleImgFileSelect);
	
	$("#mil_cd").on("change",function(e){
		changeMilCd(this.value);
	});
	
	changeCmbM(strDeptCd);
	changeMilCd('${user.userInfo[0].mil_cd}');
	
	$('#mari_yn').val('${user.userInfo[0].mari_yn}');
	$('#mil_cd' ).val('${user.userInfo[0].mil_cd}');
	$("#dept_cd").val('${user.userInfo[0].dept_cd}');
	$("#psit_cd").val('${user.userInfo[0].psit_cd}');
	$("#rank_cd").val('${user.userInfo[0].rank_cd}');
	$("#grade"	).val('${user.userInfo[0].grade}');
	$("#step_cd").val('${user.userInfo[0].step_cd}');
	$("#tel_no").val(phoneFomatter('${user.userInfo[0].tel_no}'));
	$("#cell_no").val(phoneFomatter('${user.userInfo[0].cell_no}'));
	$("#fax_no").val(phoneFomatter('${user.userInfo[0].fax_no}'));
	$("#gend_cd").val('${user.userInfo[0].gend_cd}');
	
	
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
			var teamHtml = '<option value=""><spring:message code="label.file.search.select"/></option>';
			for(var i=0; i<teamList.length; i++){
				teamHtml += '<option value="' + teamList[i].dtl_cd +'">' + teamList[i].dtl_cd_desc + '</option>';
			}
			$("#team_cd").html(teamHtml);
			if(init_yn == "Y"){
				var strTeamCd = ${user.userInfo[0].team_cd}+''; // null 값의 경우 null 값이 아닌 ''로  표현하도록 세팅
				if(strTeamCd == ''){
					
				}else{
					$("#team_cd").val(strTeamCd);
				}
				init_yn = "N";
			}
		}
	});
}

function updateUseYn(){
	var param = new Object();
	param.emp_no = $("#emp_no").val();
	swalConfirm('<spring:message code="label.user.txt.notice.unuse"/>', 'warning', function() {
		$.ajax({
			url:"updateUseYnAction.ajax",
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
						movePage('/admin/user/userList.ajax');
					})
			},
		});
	});
}

function changeMilCd(cmb) {
	if(cmb == '1'){
		$("#mil_strt_dt").removeAttr("disabled");
		$("#mil_end_dt").removeAttr("disabled");
	}else{
		$("#mil_strt_dt").val('');
		$("#mil_end_dt").val('');
		$("#mil_strt_dt").attr("disabled","disabled");
		$("#mil_end_dt").attr("disabled","disabled");
	}
	
}

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
         $(this).val(phoneFomatter($(this).val()));
    });
}

function checkParam(){
	
	if($("#mil_cd").val() == '1'){
		if($("#mil_strt_dt").val() == '' || $("#mil_end_dt").val() == ''){
			swal('<spring:message code="label.user.txt.military.error"/>', '', 'error');
			return false;
		}
	}
	
	if($("#rank_cd").val() == ''){
		swal('<spring:message code="label.user.txt.rank.error"/>', '', 'error');
		return false;
	}
	
	if($("#psit_cd").val() == ''){
		swal('<spring:message code="label.user.txt.psit.error"/>', '', 'error');
		return false;
	}
	
	if($("#com_strt_dt").val() == ''){
		swal('<spring:message code="label.user.txt.comstrt.error"/>', '', 'error');
		return false;
	}
	
	if($("#srt_no").val() == ''){
		swal('<spring:message code="label.user.txt.srtno.error"/>', '', 'error');
		return false;
	}
	
	if($("#dept_cd").val() == ''){
		swal('<spring:message code="label.user.txt.deptcd.error"/>', '', 'error');
		return false;
	}
	
	if($("#step_cd").val() == ''){
		swal('<spring:message code="label.user.txt.stepcd.error"/>', '', 'error');
		return false;
	}
	
	if($("#rank_cd").val() == ''){
		swal('<spring:message code="label.user.txt.rankcd.error"/>', '', 'error');
		return false;
	}
	
	
	
	return true;
}

//사용자 수정
function updateAction(){
	var param = checkParam();
	if(param){
		$("#userInfoForm").ajaxForm({
			dataType : "text",
	        beforeSend : function(xmlHttpRequest){
	            xmlHttpRequest.setRequestHeader("AJAX", "true"); 
	        },
			success : function(responseText, statusText) {
				swal({
					  title: '',
					  text: '<spring:message code="label.common.success.save"/>',
					  type: 'success',
					  showConfirmButton:true,
					  confirmButtonText: 'OK',
					  
					},function(){
						movePage('/admin/user/userList.ajax');
					})
			},
			
			
		}).submit();
	}
}
</script>

<form id="userInfoForm" name="userInfoForm" enctype="multipart/form-data" action="updateAction" method="POST" >
<div class="rowBox mgT20">
	<div class="g_column w_5_4">
		<h3>
			<span class="title"><spring:message code="label.user.userinfo"/></span>
		</h3>
		<div class="unitBox grayBox lineBox" style="">
			<table class="amb_form_table">
				<colgroup>
					<col style="width: 8%;" />
					<col style="width: ;" />
					<col style="width: 8%;" />
					<col style="width: ;" />
					<col style="width: 8%;" />
					<col style="width: ;" />
				</colgroup>
				<tbody>
					<tr>
						<th><spring:message code="label.user.usernm"/></th>
						<td>
							<input type="hidden" id="cre_id" name="cre_id" class="inp w90p" value="${sessionScope.session_user.emp_no}"/>
							<input type="hidden" id="upd_id" name="upd_id" class="inp w90p" value="${sessionScope.session_user.emp_no}"/>		
							<input type="hidden" id="file_id" name="file_id" class="inp w90p" value="${user.userInfo[0].file_id}"/>	
							<input type="text" id="usr_nm" name="usr_nm" class="inp w90p" value="${user.userInfo[0].usr_nm}" maxlength="10"/>								
						</td>
						<th><spring:message code="label.user.srtno"/></th>
						<td>
							<input type="text" id="srt_no" name="srt_no" value="${user.userInfo[0].srt_no}" class="inp datepicker w90p" placeholder="date" onkeydown="onlyNumber(this)"/>
						</td>
						<th><spring:message code="label.user.addr"/></th>
						<td>
							<input type="text" id="addr" name="addr" class="inp w90p" value="${user.userInfo[0].addr}" maxlength="100"/>
						</td>
					</tr>
					<tr>
						<th><spring:message code="label.user.phone"/></th>
						<td>
							<input type="text" id="tel_no" name="tel_no" class="inp w90p" maxlength="14" onkeydown="phoneNumber(this)" />
					   	</td>	
						<th><spring:message code="label.user.cellphone"/></th>
						<td>
							<input type="text" id="cell_no" name="cell_no" class="inp w90p" maxlength="14" onkeydown="phoneNumber(this)"/>
					   	</td>
					   	<th><spring:message code="label.user.fax"/></th>
						<td>
							<input type="text" id="fax_no" name="fax_no" class="inp w90p" maxlength="14" onkeydown="phoneNumber(this)"/>
					   	</td>
					</tr>
					<tr>
						<th><spring:message code="label.user.email"/></th>
						<td>
							<input type="text" id="email" name="email" class="inp w90p" value="${user.userInfo[0].email}" maxlength="30"/>
							
						</td>
						<th><spring:message code="label.user.marry"/></th>
							<td>
							<select id="mari_yn" name="mari_yn" class="inp w90p" >
									<option value="Y"><spring:message code="label.user.marry.married"/></option>
									<option value="N"><spring:message code="label.user.marry.single"/></option>
							</select>
							</td>
							<th><spring:message code="label.user.gender"/></th>
							<td>
								<select id="gend_cd" name="gend_cd" class="inp w90p" >
									<option value="M"><spring:message code="label.user.gender.male"/></option>
									<option value="F"><spring:message code="label.user.gender.female"/></option>
								</select>
							</td>
					</tr>
					<tr>
						<th><spring:message code="label.user.ability"/></th>
						<td>
							<input type="text" id="spe_abil" name="spe_abil" class="inp w90p" value="${user.userInfo[0].spe_abil}"/>
						</td>
						<th><spring:message code="label.user.military"/></th>
						<td colspan="3">
							<select id="mil_cd" name="mil_cd">
		                           <option value="1"><spring:message code="label.user.military.yes"/></option>
		                           <option value="2"><spring:message code="label.user.military.no"/></option>
		                           <option value="0"><spring:message code="label.user.military.exemption"/></option>
		                           <option value="3"><spring:message code="label.user.military.none"/></option>
	                        </select>
							<span class="datepickerRange">
								<input type="text" id="mil_strt_dt" name="mil_strt_dt" value="${user.userInfo[0].mil_strt_dt}" disabled="disabled" class="inp datepicker startDate from0" placeholder="date" onkeydown="onlyNumber(this)"/>
								~
								<input type="text" id="mil_end_dt" name="mil_end_dt" value="${user.userInfo[0].mil_end_dt}" disabled="disabled" class="inp datepicker endDate to0" placeholder="date" onkeydown="onlyNumber(this)"/>
							</span>
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
					 <img id="productImageDiv" src="${user.userInfo[0].file_uri}"  style="width: 120px; height: 154px; cursor:pointer; background:#ffffff; border: 1px solid #d1d1d1; position: relative;">
				</span>
			</div>
		</div>
	</div>
</div>
<!-- rowBox 반복단위 -->

<!-- rowBox 반복단위 -->
<div class="rowBox mgT20">
	<h3>
		<span class="title"><spring:message code="label.user.cominfo"/></span>
	</h3>
	<div class="g_column w_1_1">
		<div class="unitBox grayBox lineBox" style="">
			<table class="amb_form_table">
				<colgroup>
					<col style="width: 8%;" />
					<col style="width: ;" />
					<col style="width: 8%;" />
					<col style="width: ;" />
					<col style="width: 8%;" />
					<col style="width: 2;" />
				</colgroup>
				<tbody>
					<tr>
						<th><spring:message code="label.user.empno"/></th>
						<td>
							<input type="text" id="emp_no" name="emp_no" class="inp w90p" style="width: 200px;" value="${user.userInfo[0].emp_no}" DIS  maxlength="5" />								
						</td>
						<th><spring:message code="label.user.dept"/></th>
						<td>
							<select id="dept_cd" name="dept_cd" class="inp w90p">
								<option value=""><spring:message code="label.file.search.select"/></option>
								<c:forEach items="${getDeptList}" var="getDeptList" varStatus="status">
										<option value="${getDeptList.dtl_cd}">${getDeptList.dtl_cd_desc}</option>
								</c:forEach>
							</select>
						</td>
						<th><spring:message code="label.user.team"/></th>
						<td>
							<select id="team_cd" name="team_cd" class="inp w90p">
								<option value=""><spring:message code="label.file.search.select"/></option>
							</select>
						</td>
					</tr>
					
					<tr>
						<th><spring:message code="label.user.rank"/></th>
						<td>
							<select id="rank_cd" name="rank_cd" class="inp w90p">
								<option value=""><spring:message code="label.file.search.select"/></option>		
								<c:forEach items="${getRankList}" var="getRankList" varStatus="status">
										<option value="${getRankList.dtl_cd}">${getRankList.dtl_cd_desc}</option>
								</c:forEach>
							</select>
					   	</td>	
						<th><spring:message code="label.user.psit"/></th>
						<td>
							<select id="psit_cd" name="psit_cd" class="inp w90p">
								<option value=""><spring:message code="label.file.search.select"/></option>		
								<c:forEach items="${getPsitList}" var="getPsitList" varStatus="status">
										<option value="${getPsitList.dtl_cd}">${getPsitList.dtl_cd_desc}</option>
								</c:forEach>
							</select>
					   	</td>
					   	<th><spring:message code="label.user.step"/></th>
						<td>
							<select id="step_cd" name="step_cd" class="inp w90p">
								<option value=""><spring:message code="label.file.search.select"/></option>		
								<c:forEach items="${getStepList}" var="getStepList" varStatus="status">
										<option value="${getStepList.dtl_cd}">${getStepList.dtl_cd_desc}</option>
								</c:forEach>
							</select>
					   	</td>
					</tr>
					<tr>
						<th><spring:message code="label.user.comstrt"/></th>
						<td>
							<input type="text" id="com_strt_dt" name="com_strt_dt" style="width: 200px;" value="${user.userInfo[0].com_strt_dt}" class="inp datepicker w90p" readonly="readonly" placeholder="date" onkeydown="onlyNumber(this)"/>
						</td>
						<th><spring:message code="label.user.stmp"/></th>
						<td>
							<select id="grade" name="grade" class="inp w90p">
								<option value=""><spring:message code="label.file.search.select"/></option>		
								<c:forEach items="${getGradeList}" var="getGradeList" varStatus="status">
										<option value="${getGradeList.dtl_cd}">${getGradeList.dtl_cd_desc}</option>
								</c:forEach>
							</select>
						</td>
						<th><spring:message code="label.user.comnm"/></th>
						<td>
							<input type="text" id="com_cd" name="com_cd" class="inp w90p" value="${user.userInfo[0].com_cd}"/>
						</td>
					</tr>
					<tr>
						<th><spring:message code="label.user.worp"/></th>
						<td>
							<input type="text" id="worp_cd" name="worp_cd" class="inp w90p" value="${user.userInfo[0].worp_cd}" maxlength="50"/>
					   	</td>
					   	<th></th>
						<td></td>
					   	<th></th>
						<td></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>	
</div>
<!-- rowBox 반복단위 -->
<div class="rowBox mgT10">
	<div class="fr btnArea middle">
		 <a href="javascript:movePage('/admin/user/userList.ajax');" class="amb_btnstyle gray middle" ><spring:message code="label.common.return"/></a>
		 <a href="javascript:openModal('/admin/user/passwordPopup.ajax' , 'passwordPopup' , 'emp_no=${user.userInfo[0].emp_no}' ,'600px');" class="amb_btnstyle green small"><spring:message code="label.common.change.password"/></a>
		 <a id="btnUseYn" class="amb_btnstyle blue middle" ><spring:message code="label.common.unuse"/></a>
		 <a id="btnSave" class="amb_btnstyle blue middle" ><spring:message code="label.common.save"/></a>
	</div>
</div>


</form>