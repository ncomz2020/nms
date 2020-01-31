<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="toDay" class="java.util.Date" />
<style>
.bg_green{
	background-color: honeydew !important;
}

</style>
<script>

	var lastDayPlus = ${lastDay} +1;
	$(document).ready(function() {
		
		workCount();
		inTotheName();
		$('#cardDiv').find('table').find('tbody').find('tr').find('[name="wkTpTd"]').attr('colspan',lastDayPlus);
		
	});
	
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

	
	function workCount() {
		var $targetTbody = $('#cardDiv').find('table').find('tbody');
		var $targetTr = $targetTbody.find('tr');
		var normalWorkCount = 0;
		var nightWorkCount  = 0;
		var dawnWorkCount 	= 0;
		
		$targetTbody.each(function(idx) {
			var $targetTr = $targetTbody.eq(idx).find('tr');
			
			$targetTr.each(function(idx) {
				var totalWkHr  		 = 0;
				var $targetWorkTd 	 = $targetTr.eq(idx).find('[name="tdWkHr"]');
				var $targetPjtTpCdTd =  $targetTr.eq(idx).find('input[name="pjt_type_cd"]');
				var $targetTtlWkHr 	 = $targetTr.eq(idx).find('td[name="tdTotalWkHr"]');

				var strTpCd = $targetPjtTpCdTd.eq(0).val();
				
				$targetWorkTd.each(function(idx){
					var strWorkHr = $targetWorkTd.eq(idx).text();
					if(strTpCd != 'N13'){
						if(strWorkHr > 10){
							dawnWorkCount++;
						}else if(strWorkHr >= 9){
							nightWorkCount++;
						}else if(strWorkHr > 0){
							normalWorkCount++;
						}else{
						}
						
						if(strWorkHr == ''){
							strWorkHr = '0';
						}
					}

					totalWkHr += Number(strWorkHr);
				});
				$targetTtlWkHr.html(totalWkHr);
				
				if($targetTr.eq(idx).find('[name="wkHrSum"]').attr('name') == 'wkHrSum'){
					var $targetTdNormalWk 	 = $targetTr.eq(idx).find('em[name="tdNormalWk"]');
					var $targetTdNightWk 	 = $targetTr.eq(idx).find('em[name="tdNightWk"]');
					var $targetTdDawnWk 	 = $targetTr.eq(idx).find('em[name="tdDawnWk"]');
					$targetTdNormalWk.html(normalWorkCount);
					$targetTdNightWk.html(nightWorkCount);
					$targetTdDawnWk.html(dawnWorkCount);
					
					normalWorkCount = 0;
					nightWorkCount = 0;
					dawnWorkCount = 0;
				}
			});
		});
	}

	function changeDinnVal(obj){
		var dinnYn = $(obj).find('input[name="dinn_yn"]');
		if($(dinnYn).val() == 'Y'){
			$(dinnYn).val('N');
			$(dinnYn).parent().removeClass('bg_green');
			
		}else{
			$(dinnYn).val('Y');
			$(dinnYn).parent().addClass('bg_green');
		}
	}	
	
	function inTotheName(){
		var $targetDiv   = $('#cardDiv').find('h4').find('span');
		var $targetSpan  = '';
		var $targetNm    = $('#cardDiv').find('table').find('tbody');
		var arrName = [];
		var arrEmpNo = [];

		$targetNm.each(function(idx) {
			 arrName[idx] =  $targetNm.eq(idx).find('tr').eq(0).find('input[name="usr_nm"]').val();
			 arrEmpNo[idx] =  $targetNm.eq(idx).find('tr').eq(0).find('input[name="emp_no"]').val();
		});
		$targetDiv.each(function(idx) {
			$targetSpan = $('#cardDiv').find('h4').eq(idx).find('span');
			$targetSpan.html(arrName[idx]+'('+ arrEmpNo[idx]+ ')');
		});
		
	}

</script>
<!-- rowBox 반복단위 -->
<div class="rowBox mgT20">
	<form id="cardForm" name="card" >
		<div class="g_column w_1_1">
		<h3>
			<span class="title"><c:out value="${fn:substring(CardYm,0,4)}"/><spring:message code="label.common.year"/> <c:out value="${fn:substring(CardYm,4,6)}"/><spring:message code="label.common.month"/> <spring:message code="label.card.alllist"/></span>
			<div class="fr btnArea middle"> 
				<a href="javascript:PrintElem('cardDiv');" class="amb_btnstyle white middle">인쇄</a>
			</div>
		</h3>
			<div id="cardDiv" class="unitBox" > 
				<c:forEach items="${Cards}" var="Cards" varStatus="status">
					<h4>
						<span name="usr_name" class="title"></span>
					</h4>
					<table name="cardTable" class="amb_table center timeCardTable" >
						<colgroup>
							<col style="width: 50px;">
							<col style="width: 90px;">
							<col style="width: 180px">
							<c:forEach items="${holiDayList}" var="holiDayList" varStatus="status">
								<col style="width: 35px;">
							</c:forEach>
							<col style="width: 35px;">
						</colgroup>
						<thead>
							<tr>
								<th class="center"><spring:message code="label.card.type"/></td>
								<th class="center"><spring:message code="label.project.pjtno"/></td>
								<th class="center"><spring:message code="label.project.pjtname"/></td>
								<c:forEach items="${holiDayList}" var="holiDayList" varStatus="status">
									<c:choose>
										<c:when test="${holiDayList.hldy_yn eq 'Y'}">
											<th class="center"><span class="pColor_red"><c:out value="${holiDayList.sltd_dd}" /></span></td>
										</c:when>
										<c:when test="${holiDayList.hldy_yn eq 'N'}">
											<c:choose>
												<c:when test="${holiDayList.nDay_yn eq 'Y'}">
													<th class="center"><span class="pColor_pink"><c:out value="${holiDayList.sltd_dd}" /></span></td>
												</c:when>
												<c:when test="${holiDayList.nDay_yn eq 'N'}">
													<th class="center"><span ><c:out value="${holiDayList.sltd_dd}" /></span></td>
												</c:when>
											</c:choose>
										</c:when>
									</c:choose>
								</c:forEach>
								<th class="center bold"><spring:message code="label.common.total.sum"/></td>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${Cards}" var="Card" varStatus="status">
								<tr>
									<td class="center">${Card.pjt_type_nm}
									<input type="hidden" name="usr_nm" value="${Card.usr_nm}"/>
									<input type="hidden" name="emp_no" value="${Card.emp_no}"/>
									</td>
									<td class="center">${Card.pjt_no}
									</td>
									<td class="center">${Card.pjt_nm}
									<input type="hidden" name="pjt_no" value="${Card.pjt_no}"/>
									<input type="hidden" name="pjt_type_cd" value="${Card.pjt_type_cd}"/>
									</td>
									<c:forEach var="i" begin="1" end="${lastDay}">
										<c:choose>
											<c:when test="${Card.arr_dinn_yn[i-1] eq 'Y'}">
												<td name="tdWkHr" class="center bg_green">${Card.arr_work_hr[i-1]}
													<c:choose>
														<c:when test="${empty Card.arr_dinn_yn[i-1]}">
															<input type="hidden" name="dinn_yn" value="N">
														</c:when>
														<c:otherwise>
															<input type="hidden" name="dinn_yn" value="${Card.arr_dinn_yn[i-1]}">
														</c:otherwise>
													</c:choose>
												</td>
											</c:when>
											<c:when test="${Card.arr_dinn_yn[i-1] eq 'N'}">
												<td name="tdWkHr" class="center" >${Card.arr_work_hr[i-1]}
													<c:choose>
														<c:when test="${empty Card.arr_dinn_yn[i-1]}">
															<input type="hidden" name="dinn_yn" value="N">
														</c:when>
														<c:otherwise>
															<input type="hidden" name="dinn_yn" value="${Card.arr_dinn_yn[i-1]}">
														</c:otherwise>
													</c:choose>
												</td>
											</c:when>
											<c:otherwise>
												<td name="tdWkHr" class="center">${Card.arr_work_hr[i-1]}
													<input type="hidden" name="dinn_yn" value="N">
												</td>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									<td name="tdTotalWkHr" class="center"></td>
								</tr>
							</c:forEach>
								<tr>
									<td name="wkHrSum" class="center" colspan="3"><spring:message code="label.card.work.type.sum"/></td>
									<td name="wkTpTd" colspan="${lastDay}" class="left">
										<span class="inline pdLR10"><spring:message code="label.card.work.type.normal"/> <em name="tdNormalWk" class="bold">(0)</em></span>
										<span class="inline pdLR10"><spring:message code="label.card.work.type.night"/> <em name="tdNightWk" class="bold">(0)</em></span>
										<span class="inline pdLR10"><spring:message code="label.card.work.type.dawn"/> <em name="tdDawnWk" class="bold">(0)</em></span>
									</td>
								</tr>
						</tbody>
					</table>
				</c:forEach>
			</div>
		</div>
	</form>
</div>