<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script>

$(document).on('click', '#insertProject', function(){
	var sessionId = '${sessionScope.session_user.usr_grp_id}'; 
	if( sessionId != '1') {
		swal('<spring:message code="label.project.insert.error" />', '<spring:message code="msg.project.insert.error" />', 'error');
		return false;
	}
});

// 엑셀 다운로드
function goExcel() {
   var param = $('#projectListForm').serialize();
   param = decodeURIComponent((param + "").replace(/W+/g,'%20'));
   $.download('exportAction.ajax', param, 'post');
   
}

</script>
<div class="rowBox mgT20">
	<div class="g_column w_1_1">
		<h3>
			<span class="title"><spring:message code="label.project.projectlist" />(${count}<spring:message code="label.common.total.count" />)</span>
			<div class="fr btnArea middle">
				<a href="javaScript:goExcel();" class="amb_btnstyle white middle"><spring:message code="label.common.export.excel" /></a>
				<a href="javascript:movePage('/admin/project/projectInsert');" id="insertProject" class="amb_btnstyle blue middle"><spring:message code="label.common.regist" /></a>
			</div>
			
		</h3>
		<div class="unitBox" style="">
			<table class="amb_table center">
				<colgroup>
					<col style="width: 60px;"/>
					<col style=""/>
					<col style=""/>
					<col style=""/>
					
					<col style=""/>
					<col style=""/>
					<col style=""/>
					<col style=""/>
					
					<col style="width:100px;" />
					<col style="width:100px;" />
					<col style="width:100px;" />
				</colgroup>
				<thead>
					<tr>
						<th><spring:message code="label.project.checkyn" /></th>
						<th><spring:message code="label.project.pjtno" /></th>
						<th><spring:message code="label.project.pjtname" /></th>
						<th><spring:message code="label.project.custnm" /></th>
						
						<th><spring:message code="label.project.pmnm" /></th>
						<th><spring:message code="label.project.dept" /></th>
						<th><spring:message code="label.project.contyn" /></th>
						<th><spring:message code="label.project.useyn" /></th>
						
						<th><spring:message code="label.project.strtdt" /></th>
						<th><spring:message code="label.project.enddt" /></th>
						<th><spring:message code="label.project.etcyn" /></th>
					</tr>
				</thead>
				<tbody>
				 <c:forEach items="${project}" var="info" varStatus="num">
					<tr onclick="javascript:movePage('/admin/project/projectUpdate.ajax', {pjt_no:'${info.pjt_no}'});">
						<td>${info.check_yn}</td>
						<td>${info.pjt_no}</td>
						<td>${info.pjt_name}</td>
						<td>${info.cust_nm}</td>
						<td>${info.pm_nm}</td>
						<td>${info.dept_cd}</td>
						<td>${info.cont_yn}</td>
						<td>${info.use_yn}</td>
						<td>${info.strt_dt}</td>
						<td>${info.end_dt}</td>
						<td>${info.etc_yn}</td>
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