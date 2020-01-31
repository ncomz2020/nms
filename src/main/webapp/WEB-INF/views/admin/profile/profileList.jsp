<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<jsp:useBean id="toDay" class="java.util.Date" />

<script>
var today = new Date();
var mm = today.getMonth()+1;
if(mm<10) mm='0'+mm;
var yyyy = today.getFullYear();
var yyyyMm = yyyy+'-'+ mm;

var strUsrGrpId = "${USER_GRP_ID}"; // 세션 사용자의 그룹 아이디

$(document).ready(function() {
	
	$("#dept_cd").on("change",function(e){
		changeCmbM(this.value);
	});
	
	// 권한별 부서 변경
	if(strUsrGrpId == '1' || strUsrGrpId == '2' ){ 
		changeCmbM($("#dept_cd").val());
	}

	$('#search_month').val(yyyyMm);
	searchList(1);
});

//사용자 계정의 검색 차단 스크립트
$(document).on('click', '#btnSearch', function(){
	var sessionId = '${sessionScope.session_user.usr_grp_id}'; 
	if( sessionId == '4') {
		swal('<spring:message code="label.profile.txt.error"/>', '<spring:message code="label.profile.txt.search.error.txt"/>', 'error');
		return false;
	}
});	
	
// 엑셀 다운로드
function goExcel() {
	// 사용자 계정의 엑셀 다운로드 차단
	var sessionId = '${sessionScope.session_user.usr_grp_id}'; 
	if( sessionId == '4') {
		swal('<spring:message code="label.profile.txt.error"/>', '<spring:message code="label.profile.txt.excel.error.txt"/>', 'error');
		return false;
	}
	else {			
		var param = $('#calculDailyListForm').serialize();
		param = decodeURIComponent((param + "").replace(/W+/g,'%20'));
		$.download('exportAction.ajax', param, 'post');
	}
}

// 검색
function searchList(page) {
	$("#page").val(page);
	var param = $('#calculDailyListForm').serialize();
	$.ajax({
		url : "profileListAction.ajax",
		type : "POST",
		data : param,
		success : function(data) {
			$("#profileListActionDiv").html(data);
		},
		error : function() {
			swal({
	    			title: '<spring:message code="label.product.prod.valid.limit.image"/>'
			    });
		}
	});
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
         var teamHtml = '';
         if(strUsrGrpId == '1'){ // 관리자
            teamHtml += '<option value=""><spring:message code="label.common.all"/></option>';
            for(var i=0; i<teamList.length; i++){
               teamHtml += '<option value="' + teamList[i].dtl_cd +'">' + teamList[i].dtl_cd_desc + '</option>';
            }
         }else if(strUsrGrpId == '2'){ // 사업부장
            teamHtml += '<option value=""><spring:message code="label.common.all"/></option>';
            for(var i=0; i<teamList.length; i++){
               teamHtml += '<option value="' + teamList[i].dtl_cd +'">' + teamList[i].dtl_cd_desc + '</option>';
            }
         }
         $("#team_cd").html(teamHtml);
      }
   });
}
</script> 

<!-- rowBox 반복단위 -->
<div class="rowBox mgT20">
	<div class="g_column w_1_1">
		<form id="calculDailyListForm" name="calculDailyListForm">
			<input type="hidden" id="page" name="page">
			<div class="unitBox searchBox" style="">
				<table class="amb_form_table">
					<colgroup>
						<col style="width: 5%;" />
						<col style="width: 20%;" />
						<col style="width: 5%;" />
						<col style="width: 20%;" />
						<col style="width: 5%;" />
						<col style="width: 20%;" />
					</colgroup>
					<tbody>
						<tr>
		                     <th><spring:message code="label.profile.common.upd.ym"/></th>
		                     <td>
								<input type="text" id="search_month" name="search_month" value="" class="inp datepicker months w90p"/>
		                     </td>
		                     <th><spring:message code="label.user.usernm"/></th>
		                     <td>
		                         <input type="text" id="usr_nm" name="usr_nm" class="inp w90p" placeholder='<spring:message code="label.user.usernm"/>' />
		                     </td>
		                     <th><spring:message code="label.user.deptteam"/></th>
		                     <td>
		                         <select id="dept_cd" name="dept_cd" class="inp w45p">
									<c:choose>
										<c:when test="${USER_GRP_ID eq '1'}">
											<option value=""><spring:message code="label.common.all"/></option>
											<c:forEach items="${getDeptList}" var="getDeptList" varStatus="status">
												<option value="${getDeptList.dtl_cd}">${getDeptList.dtl_cd_desc}</option>
											</c:forEach>
										</c:when>
										<c:when test="${USER_GRP_ID eq '2'}">
											<c:forEach items="${getDeptList}" var="getDeptList" varStatus="status">
												<option value="${getDeptList.dtl_cd}">${getDeptList.dtl_cd_desc}</option>
											</c:forEach>
										</c:when>
										<c:when test="${USER_GRP_ID eq '3'}">
											<c:forEach items="${getDeptList}" var="getDeptList" varStatus="status">
												<option value="${getDeptList.grp_cd}">${getDeptList.grp_cd_desc}</option>
											</c:forEach>
										</c:when>
										<c:when test="${USER_GRP_ID eq '4'}">
											<c:forEach items="${getDeptList}" var="getDeptList" varStatus="status">
												<option value="${getDeptList.grp_cd}">${getDeptList.grp_cd_desc}</option>
											</c:forEach>
										</c:when>
									</c:choose>
								</select>
								<select id="team_cd" name="team_cd" class="inp w45p">
									<c:choose>
										<c:when test="${USER_GRP_ID eq '1'}">
											<option value=""><spring:message code="label.common.all"/></option>
										</c:when>
										<c:when test="${USER_GRP_ID eq '2'}">
											<option value=""><spring:message code="label.common.all"/></option>
										</c:when>
										<c:when test="${USER_GRP_ID eq '3'}">
											<c:forEach items="${getDeptList}" var="getDeptList" varStatus="status">
												<option value="${getDeptList.dtl_cd}">${getDeptList.dtl_cd_desc}</option>
											</c:forEach>
										</c:when>
										<c:when test="${USER_GRP_ID eq '4'}">
											<c:forEach items="${getDeptList}" var="getDeptList" varStatus="status">
												<option value="${getDeptList.dtl_cd}">${getDeptList.dtl_cd_desc}</option>
											</c:forEach>
										</c:when>
									</c:choose>
								</select>
		                     </td>  
                 		</tr>
					</tbody>
				</table>
				<span class="searchFormBtn">
					<a href="javascript:searchList(1);" id="btnSearch" class="amb_btnstyle black middle"><spring:message code="label.common.search"/></a>
				</span>
			</div>
		</form>
	</div>
</div>

<!-- 목록 -->
<div id="profileListActionDiv" class="nh_conBox"></div> 