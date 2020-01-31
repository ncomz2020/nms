<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<script src="/js/jquery.form.js"></script>
<jsp:useBean id="toDay" class="java.util.Date" />
<script>

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
	
	//검색버튼
	$("#btnSave").on("click", function(e) {
		insertAction();
	});
	
	$("#btnImage").on("click", function(e) {
		$("#file").trigger("click");
	});
	
	$("#productImageDiv").on("click", function(e) {
		$("#file").trigger("click");

	});
	
	$("#dept_cd").on("change",function(e){
		changeCmbM(this.value);
	});
	
	$("#mil_cd").on("change",function(e){
		changeMilCd(this.value);
	});
	
	
	$("#file").on("change", handleImgFileSelect);
	$("#emp_no").val('${newEmpNo}');
	$("#com_strt_dt").val(yyyyMmDd);
	
	changeMilCd('1');
});

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
		}
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

function checkParam(){
	
	var strfileLength = $('#file').val().length;
	
	if($("#mil_cd").val() == '1'){
		if($("#mil_strt_dt").val() == '' || $("#mil_end_dt").val() == ''){
			swal('<spring:message code="label.user.txt.military.error"/>', '', 'error');
			return false;
		}
	}
	
	if(strfileLength == 0){
		swal('<spring:message code="label.user.txt.pic.error"/>', '', 'error');
		return false;
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

function insertAction(){ 
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
			}
		}).submit();
	}
	
}
</script>

<form id="userInfoForm" name="userInfoForm" enctype="multipart/form-data" action="insertAction" method="POST" >
<!-- rowBox 반복단위 -->
<div class="rowBox mgT20">
	<div class="g_column w_5_4">
		<h3>
			<span class="title"><spring:message code="label.user.userinfo"/></span>
		</h3>
			<div class="unitBox grayBox lineBox" style="">
				<table class="amb_form_table">
					<colgroup>
						<col style="width: 8%;"  />
						<col style="width: ;" />
						<col style="width: 8%;"  />
						<col style="width: ;" />
						<col style="width: 8%;"  />
						<col style="width: ;" />
					</colgroup>
					<tbody>
						<tr>
							<th><spring:message code="label.user.usernm"/></th>
							<td>
								<input type="hidden" id="cre_id" name="cre_id" class="inp _input" style="width: 200px;" value="${sessionScope.session_user.emp_no}"/>
								<input type="hidden" id="upd_id" name="upd_id" class="inp _input" style="width: 200px;" value="${sessionScope.session_user.emp_no}"/>		
								<input type="text" id="usr_nm" name="usr_nm" class="inp w90p" maxlength="10" />								
							</td>
							<th><spring:message code="label.user.srtno"/></th>
							<td>
								<input type="text" id="srt_no" name="srt_no" class="inp datepicker w90p" placeholder="date" onkeydown="onlyNumber(this)" maxlength="100"/>
							</td>
							<th><spring:message code="label.user.addr"/></th>
							<td>
								<input type="text" id="addr" name="addr" class="inp w90p" />
							</td>
						</tr>
						
						<tr>
							<th><spring:message code="label.user.phone"/></th>
							<td>
								<input type="text" id="tel_no" name="tel_no" class="inp w90p"  onkeydown="phoneNumber(this)" />
						   	</td>	
							<th><spring:message code="label.user.cellphone"/></th>
							<td>
								<input type="text" id="cell_no" name="cell_no" class="inp w90p" onkeydown="phoneNumber(this)"/>
						   	</td>
						   	<th><spring:message code="label.user.fax"/></th>
							<td>
								<input type="text" id="fax_no" name="fax_no" class="inp w90p" onkeydown="phoneNumber(this)"/>
						   	</td>
						</tr>
						<tr>
							<th><spring:message code="label.user.email"/></th>
							<td>
								<input type="text" id="email" name="email" class="inp w55p" value="" maxlength="30"/> @ncomz.com
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
								<input type="text" id="spe_abil" name="spe_abil" class="inp w90p" />
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
									<input type="text" id="mil_strt_dt" name="mil_strt_dt" class="inp datepicker startDate from0" disabled="false" placeholder="date" maxlength="10" onkeydown="onlyNumber(this)"/>
									~
									<input type="text" id="mil_end_dt" name="mil_end_dt" class="inp datepicker endDate to0" disabled="false" placeholder="date" maxlength="10" onkeydown="onlyNumber(this)"/>
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
					 <img id="productImageDiv" src="../../img/member_bIcon.png"  style="width: 120px; height: 154px; background:#ffffff; cursor:pointer; border: 1px solid #d1d1d1; position: relative;">
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
					<col style="width: ;" />
				</colgroup>
				<tbody>
					<tr>
						<th><spring:message code="label.user.empno"/></th>
						<td>
							<input type="text" id="emp_no" name="emp_no" class="inp w90p" maxlength="5" readonly="readonly" onkeydown="onlyNumber(this)"/>								
						</td>
						<th><spring:message code="label.user.dept"/></th>
						<td>
							<select id="dept_cd" class="inp w90p" name="dept_cd">
								<option value=""><spring:message code="label.file.search.select"/></option>
								<c:forEach items="${getDeptList}" var="getDeptList" varStatus="status">
										<option value="${getDeptList.dtl_cd}">${getDeptList.dtl_cd_desc}</option>
								</c:forEach>
							</select>
						</td>
						<th><spring:message code="label.user.team"/></th>
						<td>
							<select id="team_cd" class="inp w90p" name="team_cd">
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
							<input type="text" id="com_strt_dt" name="com_strt_dt"  value="" class="inp datepicker w90p" placeholder="date" onkeydown="onlyNumber(this)"/>
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
							<input type="text" id="com_cd" name="com_cd" class="inp w90p" value="㈜엔컴즈" readonly="readonly" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="label.user.worp"/></th>
						<td>
							<input type="text" id="worp_cd" name="worp_cd" class="inp w90p"/>
					   	</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
<!-- rowBox 반복단위 -->

</form>

<div class="rowBox mgT10">
	<div class="fr btnArea middle">
		 <a href="javascript:movePage('/admin/user/userList.ajax');" class="amb_btnstyle gray middle" ><spring:message code="label.common.return"/></a>
		<a id="btnSave" class="amb_btnstyle blue middle" ><spring:message code="label.common.save"/></a>
	</div>
</div>
