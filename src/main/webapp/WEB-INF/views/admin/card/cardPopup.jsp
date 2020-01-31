<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src='/js/tinymce/tinymce.min.js'></script>
<script src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/js/sweetalert/sweetalert.min.js"></script>
<script src="/js/jquery/jquery.print.js"></script>

<style>
.mce-edit-area {
	border-width: 0px !important;
}
.bg_green{
	background-color: honeydew !important;
}

</style>
<script type="text/javascript">
var totalhr = 0;
var lastDayPlus = ${lastDay} +1;


$(document).ready(function() {
	
	$('#cardTable tbody').find('tr').find('[name="work_hr"]').on("propertychange change keyup keydown paste input", function() {
		workCount();
    }); 
     
    
	workCount();
	$('#cardTable tbody').find('tr').find('[name="wkTpTd"]').attr('colspan',lastDayPlus);
});

function workCount(obj) {
	if(obj != ''){
	    $(obj).keyup(function(){
	         $(this).val($(this).val().replace(/[^0-9-]/gi,""));
	    });
	}
	
	var $targetTr = $('#cardTable tbody').find('tr');

	var normalWorkCount = 0;
	var nightWorkCount  = 0;
	var dawnWorkCount 	= 0;
	
	$targetTr.each(function(idx) {
		var totalWkHr  		 = 0;
		var $targetWorkTd 	 = $targetTr.eq(idx).find('input[name="work_hr"]');
		var $targetPjtTpCdTd =  $targetTr.eq(idx).find('input[name="pjt_type_cd"]');
		var $targetTtlWkHr 	 = $targetTr.eq(idx).find('td[name="tdTotalWkHr"]')
			
		var strTpCd = $targetPjtTpCdTd.eq(0).val();
	
		$targetWorkTd.each(function(idx){
			var strWorkHr = $targetWorkTd.eq(idx).val();
			
			if(strTpCd != 'N13'){
				if(strWorkHr > 10){
					dawnWorkCount++;
				}else if(strWorkHr >= 9){
					nightWorkCount++;
				}else if(strWorkHr > 0){
					normalWorkCount++;
				}else{}
				
				if(strWorkHr == ''){
					strWorkHr = '0';
				}
			}
			totalWkHr += Number(strWorkHr);
		});
		$targetTtlWkHr.html(totalWkHr);

	});
	$("#tdNormalWk").html(normalWorkCount);
	$("#tdNightWk").html(nightWorkCount);
	$("#tdDawnWk").html(dawnWorkCount);
	
}


function changeDinnVal(obj){
	var dinnYn = $(obj).find('input[name="dinn_yn"]');
	if($(dinnYn).val() == 'Y'){
		$(dinnYn).val('N');
		$(dinnYn).parent().removeClass('bg_green');
		$(dinnYn).parent().find('input[name="work_hr"]').removeClass('bg_green');
		
	}else{
		$(dinnYn).val('Y');
		$(dinnYn).parent().addClass('bg_green');
		$(dinnYn).parent().find('input[name="work_hr"]').addClass('bg_green');
	}
}	

function checkParam(option){
	var param = new Object();

	param = { cards: [] };

	var strCpltFlag = '';
	strCpltFlag  = option;
	var card;
	var cards = [];
	var $targetTr = $('#cardTable tbody').find('tr');
	
	$targetTr.each(function(idx) {
		var $targetWorkTd = $targetTr.eq(idx).find('input[name="work_hr"]');
		var $targetDinnTd = $targetTr.eq(idx).find('input[name="dinn_yn"]');
		var strDinnHr =  '';
		var strWrokHr =  '';
		
		$targetWorkTd.each(function(idx){
			strWrokHr += $targetWorkTd.eq(idx).val()+',';
			strDinnHr += $targetDinnTd.eq(idx).val()+',';
		});

		strDinnHr =  strDinnHr.substr(0, strDinnHr.length -1);
		strWrokHr =  strWrokHr.substr(0, strWrokHr.length -1);
	
		card = new Object();
		card = {   emp_no: 		$('#cardTable tbody input[name="emp_no"]').eq(idx).val()
				, card_ym: 		$('#cardTable tbody input[name="card_ym"]').eq(idx).val()
				, pjt_no: 		$('#cardTable tbody input[name="pjt_no"]').eq(idx).val()
				, work_hr: 		strWrokHr
				, dinn_yn: 		strDinnHr
				
		}
		cards.push(card);
	});
		param.cplt_flag = strCpltFlag;
		param.emp_no = $('#cardTable tbody input[name="emp_no"]').eq(0).val();
		param.card_ym = $('#cardTable tbody input[name="card_ym"]').eq(0).val();
		param.cards = cards;
		
	return param;
}

function updateAction(option){

	var param = checkParam(option);
	var msg = '<spring:message code="label.common.confirm.save"/>';
	if (option == 'complete') {
		msg = '<spring:message code="msg.card.complete.complete"/>';
	}else if (option == 'cancel'){
		msg = '<spring:message code="msg.card.complete.cancel"/>';
	}
	
	if(param){
		swalConfirm(msg, 'warning', function() {
			$.ajax({ 
				url:'updateAction.json'
				, type:'POST'
				, data : JSON.stringify(param)
				, dataType: 'json'
				, contentType: 'application/json; charset=utf-8'
				, success: function(data) {
					swal({
						  title: '',
						  text: '<spring:message code="label.common.success.save"/>',
						  type: 'success',
						  showConfirmButton:true,
						  confirmButtonText: 'OK',
						  
						},function(){
							movePage('/admin/card/cardList.ajax');
						})
				}
			});
		});
	}
}

	


</script>

<div class="amb_layout_common amb_admin_layout_temp_01 modal-dialog" style="width: 99%; margin-top: -136.5px;">
	<div class="modal-content">
		<!-- 실제 컨텐츠 작업부분 -->
		<div class="modal_header">
			<span class="title"><c:out value="${fn:substring(CardYm,0,4)}"/><spring:message code="label.common.year"/> <c:out value="${fn:substring(CardYm,4,6)}"/><spring:message code="label.common.month"/> <spring:message code="label.card.insert"/></span> 
			<a href="#" class="close"onClick="javascript:closeModal(this);"><i class="ambicon-015_mark_times"></i></a>
		</div><%-- <c:out value="${fn:substring(${TextValue},4,2)}" /> --%>
		
		<div class="modal_body content" style="max-height: 825px; overflow-y: auto;">
			<div class="rowBox">
				<div class="g_column w_1_1">
					<div id="" class="unitBox"> 
						<table class="amb_table center timeCardTable" id="cardTable">
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
								<tr id="headerTr">
									<th class="center"><spring:message code="label.card.type"/></td>
									<th class="center"><spring:message code="label.project.pjtno"/></td>
									<th class="center"><spring:message code="label.project.pjtname"/></td>
									<c:forEach items="${holiDayList}" var="holiDayList" varStatus="status">
										<c:choose>
											<c:when test="${holiDayList.hldy_yn eq 'Y'}">
												<th class="center"><span style="color:red"><c:out value="${holiDayList.sltd_dd}" /></span></td>
											</c:when>
											<c:when test="${holiDayList.hldy_yn eq 'N'}">
												<c:choose>
													<c:when test="${holiDayList.nDay_yn eq 'Y'}">
														<th class="center"><span style="color:lightpink"><c:out value="${holiDayList.sltd_dd}" /></span></td>
													</c:when>
													<c:when test="${holiDayList.nDay_yn eq 'N'}">
														<th class="center"><span style="color:blue"><c:out value="${holiDayList.sltd_dd}" /></span></td>
													</c:when>
												</c:choose>
											</c:when>
										</c:choose>
									</c:forEach>
									<th class="center"><spring:message code="label.common.total.sum"/></td>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${Card}" var="Card" varStatus="status">
								<tr>
									<td class="center">${Card.pjt_type_nm}
									<input type="hidden" name="emp_no" value="${Card.emp_no}"/>
									</td>
									<td class="center">${Card.pjt_no}
									<input type="hidden" name="card_ym" value="${Card.card_ym}"/>
									</td>
									<td class="center">${Card.pjt_nm}
									<input type="hidden" name="pjt_no" value="${Card.pjt_no}"/>
									<input type="hidden" name="pjt_type_cd" value="${Card.pjt_type_cd}"/>
									</td>
									<c:forEach var="i" begin="1" end="${lastDay}">
										<c:choose>
											<c:when test="${Card.arr_dinn_yn[i-1] eq 'Y'}">
												<td class="center bg_green" ondblclick="changeDinnVal(this)">
													<input type="text" id="" name="work_hr" class="inp center w100p bg_green" value="${Card.arr_work_hr[i-1]}" maxlength="2" />
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
												<td class="center" ondblclick="changeDinnVal(this)">
													<input type="text" id="" name="work_hr" class="inp center w100p" value="${Card.arr_work_hr[i-1]}" maxlength="2" />
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
												<td class="center" ondblclick="changeDinnVal(this)">
													<input type="text" id="" name="work_hr" class="inp center w100p" value="${Card.arr_work_hr[i-1]}" maxlength="2" />
													<input type="hidden" name="dinn_yn" value="N">
												</td>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									<td name="tdTotalWkHr" class="center"></td>
								</tr>
							</c:forEach>
								 <tr>
									<td class="center" colspan="3"><spring:message code="label.card.work.type.sum"/></td>
									<td name="wkTpTd" colspan="${lastDay}" class="left">
										<span class="inline pdLR10"><spring:message code="label.card.work.type.normal"/> <em id="tdNormalWk" class="bold">(0)</em></span>
										<span class="inline pdLR10"><spring:message code="label.card.work.type.night"/> <em id="tdNightWk" class="bold">(0)</em></span>
										<span class="inline pdLR10"><spring:message code="label.card.work.type.dawn"/> <em id="tdDawnWk" class="bold">(0)</em></span>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="modal_footer">
			<div class="btnArea right">
				<button type="button" class="amb_btnstyle middle blue" onclick="javascript:updateAction('save');">
					<span class="text"><spring:message code="label.common.save"/></span>
				</button>
				<c:choose>
					<c:when test="${CpltYn eq 'N'}">
						<button type="button" class="amb_btnstyle middle blue" onclick="javascript:updateAction('complete');">
							<span class="text"><spring:message code="label.common.regist.complete"/></span>
						</button>
					</c:when>
					<c:when test="${CpltYn eq 'Y'}">
						<button type="button" class="amb_btnstyle middle red" onclick="javascript:updateAction('cancel');">
							<span class="text"><spring:message code="label.common.complete.cancel"/></span>
						</button>
					</c:when>
				</c:choose>
				<button type="button" class="amb_btnstyle middle gray" onclick="closeModal(this);">
					<span class="text"><spring:message code="label.common.cancel"/></span>
				</button>
			</div>
		</div>
	</div>
</div>