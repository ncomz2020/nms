<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<jsp:useBean id="toDay" class="java.util.Date" />
<%@ page import="com.ncomz.nms.domain.common.SessionUser" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
	HttpSession ses = request.getSession();
	SessionUser sessionUser = (SessionUser) ses.getAttribute("session_user");
%>

<script>
	$(document).ready(function() {
		$("#dept_cd").on("change",function(e){
			changeCmbM(this.value);
		});
		
		changeCmbM();
		
		searchList(1);
	});
	
	function searchList(page) {
		$("#page").val(page);
		var param = $('#userGroupListForm').serialize();
		$.ajax({
			url : "userGroupListAction.ajax",
			type : "POST",
			data : param,
			success : function(data) {
				$("#listActionDiv").html(data);
			},
			error : function() {
				swal({
		    			title: '<spring:message code="label.common.fail"/>'
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
					teamHtml += '<option value=""><spring:message code="label.common.all"/></option>';
				for(var i=0; i<teamList.length; i++){
					teamHtml += '<option value="' + teamList[i].dtl_cd +'">' + teamList[i].dtl_cd_desc + '</option>';
				}
				
				$("#team_cd").html(teamHtml);
			}
		});
	}
	
	
</script>
<!-- rowBox 반복단위 -->

<div class="rowBox mgT20">
	<div class="g_column w_1_1">
		<form id="userGroupListForm" name="userGroupListForm">
			<input type="hidden" id="page" name="page">
			<div class="unitBox searchBox" style="">
				<table class="amb_form_table">
					<colgroup>
						<col style="width: 10%;" />
						<col style="width: ;" />
						<col style="width: 10%;" />
						<col style="width: ;" />
						<col style="width: 10%;" />
						<col style="width: ;" />
					</colgroup>
					<tbody>
						<tr>
							<th><spring:message code="label.usergroup.name"/></th>
							<td>
								<select id="search_usr_grp_id" name="search_usr_grp_id" class="inp w90p">
									<option value=""><spring:message code="label.common.all"/></option>
									<c:forEach items="${getUsrGroupList}" var="getUsrGroupList" varStatus="status">
										<option value="${getUsrGroupList.usr_grp_id}">${getUsrGroupList.expln}</option>
									</c:forEach>
								</select>
							</td>
		                    <th><spring:message code="label.user.dept"/></th>
							<td>
								<select id="dept_cd" name="dept_cd" class="inp w90p">
									<option value=""><spring:message code="label.common.all"/></option>
									<c:forEach items="${getDeptList}" var="getDeptList" varStatus="status">
										<option value="${getDeptList.dtl_cd}">${getDeptList.dtl_cd_desc}</option>
									</c:forEach>
								</select>
							</td>
							<th><spring:message code="label.user.team"/></th>
							<td>
								<select id="team_cd" name="team_cd" class="inp w90p">
									<option value=""><spring:message code="label.common.all"/></option>
								</select>
							</td>
							<th><spring:message code="label.user.usernm"/></th>
							<td>
								<input type="text" id="usr_nm" name="usr_nm" class="inp w90p" placeholder='' />
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