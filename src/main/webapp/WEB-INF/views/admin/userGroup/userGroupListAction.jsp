<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script>
	
</script>

<div class="rowBox mgT20">
	<div class="g_column w_1_1">
		<h3>
			<span class="title">
			<spring:message code="label.user.emplist"/>(${count}<spring:message code="label.common.total.count"/>)
			</span>
		</h3>
		<div class="unitBox" style="">
			<table class="amb_table center">
				<colgroup>
					<col style="width: 60px" />
					<col style="" />
					<col style="" />
					<col style="" />
					<col style="" />
					<col style="" />
				</colgroup>
				<thead>
					<tr>
						<th class="center"><spring:message code="label.common.seq"/></th>
						<th class="center"><spring:message code="label.user.empno"/></th>
						<th class="center"><spring:message code="label.user.empno"/></th>
						<th class="center"><spring:message code="label.user.usernm"/></th>
						<th class="center"><spring:message code="label.user.dept"/></th>
						<th class="center"><spring:message code="label.user.team"/></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${user}" var="info" varStatus="status">
					<tr onClick="javascript:openModal('/admin/userGroup/groupPopup.ajax' , 'groupPopup' ,'emp_no=${info.emp_no}' , '400'); ">
						<td>${info.rownum}</td>
						<td>${info.expln}</td>
						<td>${info.emp_no}</td>
						<td>${info.usr_nm}</td>
						<td>${info.dept_cd}</td>
						<td>${info.team_cd}</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="paging center">
			<ul class="paginglist">
				<jsp:include page="/WEB-INF/views/include/paging.jsp" />
			</ul>
		</div>
	</div>
</div>