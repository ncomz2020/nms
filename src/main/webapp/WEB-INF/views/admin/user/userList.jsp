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
		
		selectBoxSetting('100', 'dept_cd');
	    selectBoxSetting('300', 'rank_cd');
	    selectBoxSetting('500', 'step_cd');
		$('#search_month').hide();
		$('#month_period').hide();
		searchList(1);
		
		//기간 선택 event
		$('#search_date_type').change(function(){
			
			$('#search_month').val("")
			
			if($('#search_date_type').val() == 'ALL'){
				$('#search_month').hide();
				$('#month_period').hide();
			}
			else if($('#search_date_type').val() == 'BIRTH'){
				$('#month_period').show(); 
				$('#search_month').hide();
			}
			else{
				$('#search_month').show();
				$('#month_period').hide();
			}
		});
	});
	
	
	//사용자 계정의 경우 다른 검색 차단 스크립트
	$(document).on('click', '.searchFormBtn', function(){
		var sessionId = '<%=sessionUser.getEmp_no()%>'; 
		if( sessionId != 'admin') {
			swal('사용자 계정은 검색을 사용할 수 없습니다.', '', 'error');
			return false;
		}
	});	
		
	function searchList(page) {
		$("#page").val(page);
		var param = $('#calculDailyListForm').serialize();
		$.ajax({
			url : "userListAction.ajax",
			type : "POST",
			data : param,
			success : function(data) {
				$("#listActionDiv").html(data);
			},
			error : function() {label.common.fail.action
				swal({
		    			title: '<spring:message code="label.common.fail.action"/>'
				    });
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
						<col style="width: 10%;" />
						<col style="width: 250px;" />
						<col style="width: 10%;" />
						<col style="width: ;" />
						<col style="width: 10%;" />
						<col style="width: ;" />
					</colgroup>
					<tbody>
						<tr>
		                     <th><spring:message code="label.user.deptteam"/> <spring:message code="label.common.search"/></th>
		                     <td>
		                         <select id="dept_cd" name="dept_cd" class="inp w45p"></select>
		                         <select id="team_cd" name="team_cd" class="inp w45p"></select>
		                     </td>
		                     <th><spring:message code="label.user.rank"/> <spring:message code="label.common.search"/></th>
		                     <td>
		                         <select id="rank_cd" name="rank_cd" class="inp w100p">
		                         </select>
		                     </td>
		                     <th><spring:message code="label.user.step"/> <spring:message code="label.common.search"/></th>
		                     <td>
		                         <select id="step_cd" name="step_cd" class="inp w100p">
		                         </select>
		                     </td>   
                 		</tr>
						<tr>
							<th><spring:message code="label.common.fromto"/> <spring:message code="label.common.inquiry"/></th>
							<td>
								<select id="search_date_type" name="search_date_type" class="inp w45p">
									<option value="ALL"><spring:message code="label.common.all"/></option>
									<option value="JOIN"><spring:message code="label.user.comstrt"/></option>
									<option value="BIRTH"><spring:message code="label.user.srtno"/></option>
								</select>
								<select id="month_period" name="month_period" class="inp w45p">
									<c:forEach var="item" step="1" begin="01" end="12">
										<option value="${item}">${item}<spring:message code="label.common.account"/></option>									
									</c:forEach>
								</select>
								<input type="text" id="search_month" name="search_month" value="" class="inp datepicker months w45p"  placeholder="year-month"/>
							</td>
							
							
							<th><spring:message code="label.user.usernm"/> <spring:message code="label.common.search"/></th>
							<td colspan="3">
								<input type="text" id="usr_nm" name="usr_nm" class="inp w100p"  placeholder='<spring:message code="label.common.search"/>' />
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