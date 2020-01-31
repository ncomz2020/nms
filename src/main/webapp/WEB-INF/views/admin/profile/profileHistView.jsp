<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<jsp:useBean id="toDay" class="java.util.Date" />

<script type="text/javascript">

$(document).ready(function(){
	// 경력 계산 (년월)
	var career_period = ${profile.profileUser[0].career_period};
	setCareerPeriod(career_period);
});

//경력 default 값 계산
function setCareerPeriod(career_period) {

	var careerTableTr = $('#careerTable tbody').find('tr');
	var eduTableTr = $('#eduTable tbody').find('tr');
	var careerPeriod = career_period; // 일수 저장
	
	// 일수 계산
	var year = 0;
	var month = 0;
	
	if(careerPeriod < 30) {
		year = 0;
		month = 0;
	} else if (careerPeriod < 365) {
		year = 0;
		month = Math.floor(careerPeriod / 30);
	} else if (careerPeriod > 365) {
		year = Math.floor(careerPeriod / 365);
		month = careerPeriod % 365;
		month = Math.floor(month / 30);
	} else {}

	if (year == 0) {
		$("#career_period").html(month+"<spring:message code='label.profile.hist.carr.period.m'/>");
	} else {
		$("#career_period").html(year+"<spring:message code='label.profile.hist.carr.period.y'/> "+month+"<spring:message code='label.profile.hist.carr.period.m'/>");
	}

}

// 날짜 차이 계산
function dateDiff(dateA, dateB) {
    var diffDateA = dateA instanceof Date ? dateA : new Date(dateA);
    var diffDateB = dateB instanceof Date ? dateB : new Date(dateB);
 
    diffDateA = new Date(diffDateA.getFullYear(), diffDateA.getMonth()+1, diffDateA.getDate());
    diffDateB = new Date(diffDateB.getFullYear(), diffDateB.getMonth()+1, diffDateB.getDate());
 
    var diff = Math.abs(diffDateB.getTime() - diffDateA.getTime());
    diff = Math.ceil(diff / (1000 * 3600 * 24));
 
    return diff;
}
	
// 인쇄(출력)
function PrintElem(elem){
   	$("#"+elem).print({
       globalStyles: true,
       mediaPrint: false,
       stylesheet: null,
       noPrintSelector: ".no-print",
       iframe: true,
       append: null,
       prepend: null,
       manuallyCopyFormValues: true,
       deferred: $.Deferred(),
       timeout: 750,
       title: null,
       doctype: '<!doctype html>'
   });
}
</script>

<div id="histPrintZone">	

	<div class="amb_layout_common amb_admin_layout_temp_01 amb_winpopup">
		<div id="content" class="content modalStyleWrap">
			
			<!-- head 영역 -->
			<div class="modalStyleHeader">
				<span class="title">${profile.profileUser[0].usr_nm} ${profile.profileUser[0].cre_dt}</span>
				<div class="fr">			
					<a href="javaScript:PrintElem('histPrintZone');" class="amb_btnstyle white middle"><spring:message code="msg.organization.print"/></a>			
				</div>
			</div>
	
			<!-- Body 영역 -->
			<div class="modalStyleBody">
				
				<!-- rowBox 반복단위 -->
				<div class="rowBox">
					<div class="g_column w_1_1">
						
						<div class="unitBox center" style="">
							
							<!-- 개인 이력 카드 -->
							<div class="profileViewTit"><spring:message code="label.profile.hist.title"/></div>
							<table class="profileViewTable">
								<colgroup>
									<col style="width:60px;" />
									<col style="width:;" />
									<col style="width:60px;" />
									<col style="width:;" />
									<col style="width:90px;" />
									<col style="width:60px;" />
									<col style="width:;" />
									<col style="width:160px;" />
								</colgroup>
								<tbody>
									<tr>
										<th><spring:message code="label.user.usernm"/></th>
										<td>${profile.profileUser[0].usr_nm}</td>
										<th><spring:message code="label.user.gender"/></th>
										<td>
											<c:if test="${profile.profileUser[0].gend_cd eq 'F'}"> <spring:message code="label.user.gender.female"/> </c:if>
											<c:if test="${profile.profileUser[0].gend_cd eq 'M'}"> <spring:message code="label.user.gender.male"/> </c:if>
										</td>
										<th><spring:message code="label.profile.hist.srt"/><br/><spring:message code="label.profile.hist.srt.six"/></th>
										<td colspan="2">${profile.profileUser[0].srt_no}</td>
										<td rowspan="5">
											<span class="photoBox_imgBox" style="width: 120px; height: 154px; cursor:pointer; background:#ffffff; position: relative;">
												<img src="${profile.profileUser[0].file_uri}" />
											</span>
										</td>
									</tr>
									<tr>
										<th><spring:message code="label.common.addr"/></th>
										<td colspan="3" class="left" style="text-indent:10px;">${profile.profileUser[0].addr}</td>
										<th rowspan="2"><spring:message code="label.profile.hist.work.now"/></th>
										<th><spring:message code="label.user.comnm"/></th>
										<td>${profile.profileUser[0].com_cd}</td>
									</tr>
									<tr>
										<th><spring:message code="label.user.email"/></th>
										<td>${profile.profileUser[0].email}</td>
										<th><spring:message code="label.profile.hist.hp"/></th>
										<td>${profile.profileUser[0].cell_no}</td>
										<th><spring:message code="label.profile.carr.rank.nm"/></th>
										<td>${profile.profileUser[0].rank_cd}</td>
									</tr>
	
									<tr>
										<th><spring:message code="label.user.marry"/></th>
										<td>
											<c:if test="${profile.profileUser[0].mari_yn eq 'N'}"> <spring:message code="label.user.marry.single"/> </c:if>
											<c:if test="${profile.profileUser[0].mari_yn eq 'Y'}"> <spring:message code="label.user.marry.married"/> </c:if>
										</td>
										<th><spring:message code="label.user.ability"/></th>
										<td>${profile.profileUser[0].spe_abil}</td>
	
										<th><spring:message code="label.profile.hist.carr.period"/></th>
										<td colspan="2"><span id="career_period"></span></td>
									</tr>
	
									<tr>
										<th><spring:message code="label.user.military"/></th>
										<td  colspan="3">
											<c:if test="${profile.profileUser[0].mil_cd eq '1'}">
												<spring:message code="label.user.military.yes"/> (${profile.profileUser[0].mil_strt_dt} ~ ${profile.profileUser[0].mil_end_dt})
											</c:if>
											<c:if test="${profile.profileUser[0].mil_cd eq '2'}"> <spring:message code="label.user.military.no"/> </c:if>
											<c:if test="${profile.profileUser[0].mil_cd eq '0'}"> <spring:message code="label.user.military.exemption"/> </c:if>
											<c:if test="${profile.profileUser[0].mil_cd eq '3'}"> <spring:message code="label.user.military.none"/> </c:if>
										</td>
										<th><spring:message code="label.user.stmp"/></th>
										<td colspan="2">${profile.profileUser[0].grade} <spring:message code="label.profile.hist.dvlper"/></td>
									</tr>
								</tbody>
							</table>
	
							
							<!-- 학력사항 -->
							<div class="profileViewTit sTit"><spring:message code="label.profile.edu"/></div>
	
							<table class="profileViewTable">
								<colgroup>
									<col style="" />
									<col style="" />
									<col style="" />
									<col style="" />
								</colgroup>
								<thead>
									<tr>
										<th><spring:message code="label.profile.hist.term"/></th>
										<th><spring:message code="label.profile.edu.schl.nm"/></th>
										<th><spring:message code="label.profile.edu.major"/></th>
										<th><spring:message code="label.profile.common.remark"/></th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${empty profile.profileEdu[0]}"> 
										<tr>
											<td colspan="4"><spring:message code="label.profile.hist.empty"/></td>
										</tr> 
									</c:if>
									<c:forEach items="${profile.profileEdu}" var="profileEdu" varStatus="status">
										<tr>
											<td>${profileEdu.edu_strt_dt} ~ ${profileEdu.edu_end_dt}</td>
											<td>${profileEdu.schl_nm}</td>
											<td>${profileEdu.major}</td>
											<td>${profileEdu.edu_remark}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
	
							<!-- 자격사항 -->
							<div class="profileViewTit sTit"><spring:message code="label.profile.cert"/></div>
	
							<table class="profileViewTable">
								<colgroup>
									<col style="" />
									<col style="" />
								</colgroup>
								<thead>
									<tr>
										<th><spring:message code="label.profile.cert.nm"/></th>
										<th><spring:message code="label.profile.cert.get.dt"/></th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${empty profile.profileCert[0]}"> 
										<tr>
											<td colspan="2"><spring:message code="label.profile.hist.empty"/></td>
										</tr> 
									</c:if>
									<c:forEach items="${profile.profileCert}" var="profileCert" varStatus="status">
										<tr>
											<td>${profileCert.cert_nm}</td>
											<td>${profileCert.get_dt}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
	
	
							<!-- 경력사항 -->
							<div class="profileViewTit sTit"><spring:message code="label.profile.carr"/></div>
	
							<table class="profileViewTable">
								<colgroup>
									<col style="" />
									<col style="" />
									<col style="" />
									<col style="" />
								</colgroup>
								<thead>
									<tr>
										<th><spring:message code="label.profile.carr.com.nm"/></th>
										<th><spring:message code="label.profile.hist.term"/></th>
										<th><spring:message code="label.profile.carr.rank.nm"/></th>
										<th><spring:message code="label.profile.carr.work"/></th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${empty profile.profileCarr[0]}"> 
										<tr>
											<td colspan="4"><spring:message code="label.profile.hist.empty"/></td>
										</tr> 
									</c:if>
									<c:forEach items="${profile.profileCarr}" var="profileCarr" varStatus="status">
										<tr>
											<td>${profileCarr.carr_com_nm}</td>
											<td>${profileCarr.carr_strt_dt} ~ ${profileCarr.carr_end_dt}</td>
											<td>${profileCarr.carr_rank_nm}</td>
											<td>${profileCarr.work}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
	
							<hr class="pageBreak">
	
							<!-- 주 요 업 무 경 험 내 역 -->
							<div class="profileViewTit mgT20"><spring:message code="label.profile.hist.task"/></div>
	
							<table class="profileViewTable">
								<colgroup>
									<col style="width:50px;" />
									<col style="width:120px;" />
									<col style="" />
									<col style="width:160px;" />
									<col style="" />
									<col style="" />
									<col style="" />
									<col style="" />
									<col style="" />
									<col style="" />
								</colgroup>
								<thead>
									<tr>
										<th><spring:message code="label.profile.common.count"/></th>
										<th><spring:message code="label.profile.task.prjt.nm"/></th>
										<th><spring:message code="label.profile.task.rltd.com"/></th>
										<th><spring:message code="label.profile.hist.dvlp.term"/></th>
										<th><spring:message code="label.profile.task.my.role"/></th>
										<th><spring:message code="label.profile.task.used.mdel"/></th>
										<th><spring:message code="label.profile.task.used.os"/></th>
										<th><spring:message code="label.profile.task.used.lang"/></th>
										<th><spring:message code="label.profile.task.used.dbms"/></th>
										<th><spring:message code="label.profile.task.used.dc"/></th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${empty profile.profileTask[0]}"> 
										<tr>
											<td colspan="10"><spring:message code="label.profile.hist.empty"/></td>
										</tr> 
									</c:if>
									<c:forEach items="${profile.profileTask}" var="profileTask" varStatus="status">
										<tr>
											<td>${status.count}</td>
											<td>${profileTask.prjt_nm}</td>
											<td>${profileTask.rltd_com}</td>
											<td>${profileTask.dev_strt_dt} ~ ${profileTask.dev_end_dt}</td>
											<td>${profileTask.my_role}</td>
											<td>${profileTask.used_mdel}</td>
											<td>${profileTask.used_os}</td>
											<td>${profileTask.used_lang}</td>
											<td>${profileTask.used_dbms}</td>
											<td>${profileTask.used_dc}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
	
							<!-- 상  기  내  용  은   사  실  과   틀  림  없  음  을   확  인  함 -->
							<div class="profileViewFooter">
								<div class="text"><spring:message code="label.profile.hist.confirm"/></div>
								<div class="date">${today}</div>
	
								<div class="signBox">
									<span class="tit"><spring:message code="label.profile.hist.writer"/></span>
									<span class="name">${profile.profileUser[0].usr_nm}</span>
									<span class="sign"><spring:message code="label.profile.hist.sign"/></span>
								</div>
								<div class="signBox">
									<span class="tit"><spring:message code="label.profile.hist.represent"/></span>
									<span class="name"><spring:message code="label.profile.hist.ceo"/></span>
									<span class="sign"><spring:message code="label.profile.hist.sign"/></span>
								</div>
							</div>
	
							<!-- (주) 엔컴즈 -->
							<div class="profileViewFooter companyName">
								<spring:message code="label.profile.hist.ncomz"/>
							</div>
							
						</div>
						
					</div>
				</div>
				<!-- rowBox 반복단위 -->
			</div>
			
		</div>
	</div>

</div>