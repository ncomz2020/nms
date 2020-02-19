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
			<spring:message code="label.card.subtitle"/>(${count}<spring:message code="label.common.total.count"/>)
			</span>
			<div class="fr btnArea middle">
				<a href="javascript:goPage();" class="amb_btnstyle white middle"><spring:message code="label.card.alllist.btn"/></a>
				
			</div>
		</h3>
		
		<div class="unitBox" style="">
			<table class="amb_table center">
				<colgroup>
					<col style="width:60px;" />
					<col style="" />
					<col style="" />
					<col style="" />
					<col style="" />
					<col style="width:150px" />
					<col style="width:150px" />
					<col style="width:150px" />
				</colgroup>
				<thead>
					<tr>
						<th class="center"><spring:message code="label.common.seq"/></th>
						<th class="center"><spring:message code="label.user.empno"/></th>
						<th class="center"><spring:message code="label.user.usernm"/></th>
						<th class="center"><spring:message code="label.user.dept"/></th>
						<th class="center"><spring:message code="label.user.team"/></th>
						<th class="center">${cardYmList.TWO}</th>
						<th class="center">${cardYmList.ONE}</th>
						<th class="center">${cardYmList.CUR}</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${cardUserList}" var="info" varStatus="status">
					<tr>
						<td>${info.rownum}</td>
						<td>${info.emp_no}</td>
						<td>${info.usr_nm}</td>
						<td>${info.dept_nm}</td>
						<td>${info.team_nm}</td>
						<td>
							<c:choose>
								<c:when test="${info.two_month eq 'N'}">
									<c:choose>
										<c:when test="${info.chk_two_data eq 'Y'}">
											<a href="javascript:openModal('/admin/card/cardPopup.ajax' , 'cardPopup' ,'emp_no=${info.emp_no},${cardYmList.TWO_YM}' , '99%'); " class="amb_btnstyle green small"><spring:message code="label.common.regist.reging"/></a>
										</c:when>
										<c:when test="${info.chk_two_data eq 'N'}">
											<a href="javascript:openModal('/admin/card/cardPopup.ajax' , 'cardPopup' ,'emp_no=${info.emp_no},${cardYmList.TWO_YM}' , '99%'); " class="amb_btnstyle red small"><spring:message code="label.common.regist.unreg"/></a>
										</c:when>
									</c:choose>
								</c:when>
								<c:when test="${info.two_month eq 'Y'}">
									<a href="javascript:openModal('/admin/card/cardPopup.ajax' , 'cardPopup' ,'emp_no=${info.emp_no},${cardYmList.TWO_YM}', '99%'); " class="amb_btnstyle blue small"><spring:message code="label.common.regist.complete"/></a>
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${info.one_month eq 'N'}">
									<c:choose>
										<c:when test="${info.chk_one_data eq 'Y'}">
											<a href="javascript:openModal('/admin/card/cardPopup.ajax' , 'cardPopup' ,'emp_no=${info.emp_no},${cardYmList.ONE_YM}' , '99%'); " class="amb_btnstyle green small"><spring:message code="label.common.regist.reging"/></a>
										</c:when>
										<c:when test="${info.chk_one_data eq 'N'}">
											<a href="javascript:openModal('/admin/card/cardPopup.ajax' , 'cardPopup' ,'emp_no=${info.emp_no},${cardYmList.ONE_YM}' , '99%'); " class="amb_btnstyle red small"><spring:message code="label.common.regist.unreg"/></a>
										</c:when>
									</c:choose>
								</c:when>
								<c:when test="${info.one_month eq 'Y'}">
									<a href="javascript:openModal('/admin/card/cardPopup.ajax' , 'cardPopup' ,'emp_no=${info.emp_no},${cardYmList.ONE_YM}', '99%'); " class="amb_btnstyle blue small"><spring:message code="label.common.regist.complete"/></a>
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${info.cur_month eq 'N'}">
									<c:choose>
										<c:when test="${info.chk_cur_data eq 'Y'}">
											<a href="javascript:openModal('/admin/card/cardPopup.ajax' , 'cardPopup' ,'emp_no=${info.emp_no},${cardYmList.CUR_YM}' , '99%'); " class="amb_btnstyle green small"><spring:message code="label.common.regist.reging"/></a>
										</c:when>
										<c:when test="${info.chk_cur_data eq 'N'}">
											<a href="javascript:openModal('/admin/card/cardPopup.ajax' , 'cardPopup' ,'emp_no=${info.emp_no},${cardYmList.CUR_YM}' , '99%'); " class="amb_btnstyle red small"><spring:message code="label.common.regist.unreg"/></a>
										</c:when>
									</c:choose>
								</c:when>
								<c:when test="${info.cur_month eq 'Y'}">
									<a href="javascript:openModal('/admin/card/cardPopup.ajax' , 'cardPopup' ,'emp_no=${info.emp_no},${cardYmList.CUR_YM}', '99%'); " class="amb_btnstyle blue small"><spring:message code="label.common.regist.complete"/></a>
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
						</td>
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

