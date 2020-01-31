<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script>
	
   // 엑셀 다운로드
   function goExcel() {
      var param = $('#calculDailyListForm').serialize();
      param = decodeURIComponent((param + "").replace(/W+/g,'%20'));
      $.download('exportAction.ajax', param, 'post');
   }
</script>

<div class="rowBox mgT20">
	<div class="g_column w_1_1">
		<h3>
			<span class="title">
			<spring:message code="label.user.emplist"/>(${count}<spring:message code="label.common.total.count"/>)
			</span>
			
			<div class="fr btnArea middle">
				<a href="javaScript:goExcel();" class="amb_btnstyle white middle"><spring:message code="label.file.filelist.download.excel"/></a>
				<c:if test="${sessionScope.session_user.usr_grp_id eq '1'}">
					<a href="javascript:movePage('/admin/user/userInsert.ajax');" class="amb_btnstyle blue middle"><spring:message code="label.user.empinsert"/></a>
				</c:if>
				
			</div>
		</h3>
		<div class="unitBox" style="">
			<table class="amb_table center">
				<colgroup>
					<col style="width: 60px" />
					<col style="width: 80px" />
					<col style="" />
					<col style="" />
					<col style="" />
					<col style="" />
					<col style="" />
					<col style="" />
					<col style="" />
					<col style="" />
					<col style="width: 180px" />
				</colgroup>
				<thead>
					<tr>
						<th class="center"><spring:message code="label.common.seq"/></th>
						<th class="center"><spring:message code="label.user.empno"/></th>
						<th class="center"><spring:message code="label.user.usernm"/></th>
						<th class="center"><spring:message code="label.user.dept"/></th>
						<th class="center"><spring:message code="label.user.team"/></th>
						<th class="center"><spring:message code="label.user.rank"/></th>
						<th class="center"><spring:message code="label.user.psit"/></th>
						<th class="center"><spring:message code="label.user.step"/></th>
						<th class="center"><spring:message code="label.user.comstrt"/></th>
						<th class="center"><spring:message code="label.user.srtno"/></th>
						<th class="center"><spring:message code="label.user.email"/></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${user}" var="info" varStatus="status">
					<tr onClick="javascript:movePage('/admin/user/userUpdate.ajax', {emp_no:'${info.emp_no}'});">
						<td>${info.rownum}</td>
						<td>${info.emp_no}</td>
						<td>${info.usr_nm}</td>
						<td>${info.dept_cd}</td>
						<td>${info.team_cd}</td>
						<td>${info.rank_cd}</td>
						<td>${info.psit_cd}</td>
						<td>${info.step_cd}</td>
						<td>${info.com_strt_dt}</td>
						<td>${info.srt_no}</td>
						<td>${info.email}</td>
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

