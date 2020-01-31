<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<jsp:useBean id="toDay" class="java.util.Date" />
<script>

var today = new Date();
var mm = today.getMonth()+1; //January is 0!
var dd = today.getDay(); //January is 0!
if(mm<10) mm='0'+mm;
if(dd<10) dd='0'+dd;
var yyyy = today.getFullYear();
var yyyyMm = yyyy+'-'+ mm;
var yyyyMmDd = yyyy+'-'+ mm+'-'+ dd;
var strUsrGrpId	 = "${USER_GRP_ID}";

	$(document).ready(function() {
		
		$("#search_cplt_ym").val(yyyyMm);
		
		$("#dept_cd").on("change",function(e){
			changeCmbM(this.value);
		});
		if(strUsrGrpId == '1' || strUsrGrpId == '2' ){ 
			changeCmbM($("#dept_cd").val());
		}
		
		searchList(1);
		
	});
	

	function goPage(){
		var param = new Object();
		
		param.card_ym = $("#search_cplt_ym").val().replace('-','');
		param.dept_cd = $("#dept_cd").val();
		param.team_cd = $("#team_cd").val();
		movePage("/admin/card/cardAllList", param);
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
					teamHtml += '<option value="">전체</option>';
					for(var i=0; i<teamList.length; i++){
						teamHtml += '<option value="' + teamList[i].dtl_cd +'">' + teamList[i].dtl_cd_desc + '</option>';
					}
				}else if(strUsrGrpId == '2'){ // 사업부장
					teamHtml += '<option value="">전체</option>';
					for(var i=0; i<teamList.length; i++){
						teamHtml += '<option value="' + teamList[i].dtl_cd +'">' + teamList[i].dtl_cd_desc + '</option>';
					}
				}
				
				$("#team_cd").html(teamHtml);
			}
		});
	}

	
		
	function searchList(page) {
		$("#page").val(page);
		var param = $('#cardListForm').serialize();
		$.ajax({
			url : "cardListAction.ajax",
			type : "POST",
			data : param,
			success : function(data) {
				$("#listActionDiv").html(data);
			},
			error : function() {
				swal({
		    			title: '실패'
				    });
			}
		});
	}
	
</script>
<!-- rowBox 반복단위 -->
<div class="rowBox mgT20">
	<div class="g_column w_1_1">
		<form id="cardListForm" name="cardListForm">
			<input type="hidden" id="page" name="page">
			<div class="unitBox searchBox" style="">
				<table class="amb_form_table">
					<colgroup>
						<col style="width: 5%;">
						<col style="width: ;">
						<col style="width: 5%;">
						<col style="width: ;">
						<col style="width: 5%;">
						<col style="width: ;">
						<col style="width: 5%;">
						<col style="width: ;">
					</colgroup>
					<tbody>
						<tr>
		                    <th><spring:message code="label.user.dept"/></th>
							<td>
								<select id="dept_cd" name="dept_cd" class="inp w90p">
									<c:choose>
										<c:when test="${USER_GRP_ID eq '1'}">
											<option value="">전체</option>
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
							</td>
							<th><spring:message code="label.user.team"/></th>
							<td>
								<select id="team_cd" name="team_cd" class="inp w90p">
									<c:choose>
										<c:when test="${USER_GRP_ID eq '1'}">
											<option value="">전체</option>
										</c:when>
										<c:when test="${USER_GRP_ID eq '2'}">
											<option value="">전체</option>
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
							<th><spring:message code="label.common.fromto"/></th>
							<td>
								<input type="text" id="search_cplt_ym" name="search_cplt_ym" class="inp datepicker months w90p"  placeholder="year-month"/>
							</td>
							<th><spring:message code="label.user.usernm"/></th>
							<td>
								<input type="text" id="usr_nm" name="usr_nm" class="inp w90p" placeholder='검색' />
							</td>
                 		</tr>
					</tbody>
				</table>
				<span class="searchFormBtn">
					<a href="javascript:searchList(1);" class="amb_btnstyle black middle"><spring:message code="label.common.search"/></a>
				</span>
			</div>
		</form>
	</div>
</div>
<div id="listActionDiv" class="nh_conBox"></div>