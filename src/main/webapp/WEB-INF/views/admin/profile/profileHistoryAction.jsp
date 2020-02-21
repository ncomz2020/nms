<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<script type="text/javascript">
	function goToView(index, winId){
		var profileListTr = $('#profileList tbody').find('tr'); // tr 을 찾아서 배열로 저장
		
		// 변수 = 사번, 작성일
		var empNo = profileListTr[index].children[1].textContent;
		var creDt = profileListTr[index].children[5].dataset.cre_dt;
		alert(creDt);
		// var url = '/admin/profile/profileHistView/' + empNo + '/' + creDt + '.ajax';
		
		var param = empNo + "," + creDt;
		
		// 작성일과 사번 가지고 조회 페이지 이동 (인쇄 팝업)
		movePage('/admin/profile/profileHistView.ajax', {cre_dt_st: param});
		//openWindowWithParam(url, '860', 'full', winId, index);
	}
	
	// 내 프로필 등록하기
	function goToMyUpdate(sessionEmpNo){
		movePage('/admin/profile/profileUpdate.ajax', {emp_no: sessionEmpNo});
	}
</script>

<div class="rowBox mgT20">
	<div class="g_column w_1_1">
		<h3>
			<span class="title">
				<spring:message code="label.profile.common.list.hist"/> (${searchMonth}, ${count}<spring:message code="label.common.total.count"/>)
			</span>
			
			<div class="fr btnArea middle">
				<c:if test="${sessionScope.session_user.usr_grp_id ne '4'}">
					<a href="javaScript:goExcel();" class="amb_btnstyle white middle"><spring:message code="label.common.export.excel"/></a>
				</c:if>
				<c:if test="${sessionScope.session_user.emp_no ne 'admin'}">
					<a href="javascript:goToMyUpdate('${sessionScope.session_user.emp_no}');" class="amb_btnstyle blue middle"><spring:message code="label.common.regist"/></a>
				</c:if>
			</div>
		</h3>
		<div class="unitBox" style="">
			<table id="profileList" class="amb_table center">
				<colgroup>
					<col style="width: 3%" />
					<col style="width: 8%" />
					<col style="width: 8%" />
					<col style="width: 10%" />
					<col style="width: 10%" />
					<col style="width: 8%" />
				</colgroup>
				<thead>
					<tr>
						<th><spring:message code="label.profile.common.count"/></th>
						<th><spring:message code="label.user.empno"/></th>
						<th><spring:message code="label.user.usernm"/></th>
						<th><spring:message code="label.user.dept"/></th>
						<th><spring:message code="label.user.team"/></th>
						<th><spring:message code="label.profile.common.cre.dt"/></th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty profile}">
						<tr>
							<td colspan="6">
								<spring:message code="label.profile.txt.list.empty"/>
							</td>
						</tr>
					</c:if>
					<c:forEach items="${profile}" var="profile" varStatus="status">
						<tr onClick="javascript:goToView(${status.index}, 'popup'+${status.index})">
							<td>${profile.rownum}</td>
							<td>${profile.emp_no}</td>
							<td>
								${profile.usr_nm}
							</td>
							<td>
								${profile.dept_cd}
							</td>
							<td>${profile.team_cd}</td>
							<td data-cre_dt="${profile.cre_dt_st}">
								${profile.cre_dt}
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