<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<jsp:useBean id="toDay" class="java.util.Date" />
<script>
	$(document).ready(function() {
		selectBoxSetting('100', 'dept_cd');
	    searchList(1);
	    showDate();
	    
	    $("#search").on("click", function(e) {
			checkParam();
		});
	});
	
	function checkParam(){
		if($("#pjt_strtdt").val() == ''){
			swal('<spring:message code="msg.project.valid.chk.dt" />', '','error');
			return false;
		}if($("#pjt_enddt").val() == ''){
			swal('<spring:message code="msg.project.valid.chk.dt" />', '','error');
			return false;
		}if(checkDate() == 0){
			swal('<spring:message code="msg.project.valid.chk.checkdt" />', '', 'error');
			return false;
		}else{
			searchList(1);
		}	
	}
	
	function searchList(page) {
		$("#page").val(page);
		var param = $('#projectListForm').serialize();
		$.ajax({
			url : "projectListAction.ajax",
			type : "POST",
			data : param,
			success : function(data) {
				
				$("#ProjectlistActionDiv").html(data);
			},
			error : function() {
				swal({
		    			title: '<spring:message code="label.common.cancel" />'
				    });
			}
		});
	}
	
	function showDate(){	
		var date = new Date();
	
		var year = date.getFullYear();
		var currentDate = year+ "-" + "01" + "-" + "01";
		var futureDate = year + "-" + "12" + "-" + "31";
		$("#pjt_strtdt").val(currentDate);
		$("#pjt_enddt").val(futureDate);
	}
	
	function checkDate(){
		var strtDate = $("#pjt_strtdt").val();
		var endDate = $("#pjt_enddt").val();
		
		var strtArray = strtDate.split("-");
		var endArray = endDate.split("-");
		
		if(endArray[0] == strtArray[0]){
			if(endArray[1] < strtArray[1] || endArray[2] < strtArray[2]){
				return 0;	
			}
			else if(strtArray[1] > endArray[1]|| strtArray[2] > endArray[2]){
				return 0;
			}
		}else if(endArray[0] < strtArray[0]){
			return 0;
		}else if(strtArray[0] > endArray[0]){
			return 0;
		}	
	}
	

</script>
<!-- rowBox 반복단위 -->
<div class="rowBox mgT20">
	<div class="g_column w_1_1">
		<form id="projectListForm" name="projectListForm">
			<input type="hidden" id="page" name="page">
			<div class="unitBox searchBox" style="">
				<table class="amb_form_table">
					<colgroup>
						<col style="width: 8%;">
						<col style="width: 30%;">
						<col style="width: 8%;">
						<col style="width: ;">
					</colgroup>
					<tbody>
						<tr>
							<th><spring:message code="label.project.checkyn" /></th>
		                    <td>
		                        <select id="search_check_yn" name="search_check_yn" class="inp w90p">
		                        	<option value="ALL"><spring:message code="label.common.all" /></option>
							 		<option value="1"><spring:message code="label.project.new" /></option>
							 		<option value="2"><spring:message code="label.project.add" /></option>
		                        </select>
		                    </td>
		                    <th><spring:message code="label.project.enddt" /></th>
		                    <td>
		                     <span class="datepickerRange">
								<input type="text" id="pjt_strtdt" name="pjt_strtdt" class="inp datepicker startDate" onkeydown="onlyNumber(this)" value=""/>
								~
								<input type="text" id="pjt_enddt" name="pjt_enddt" class="inp datepicker endDate" onkeydown="onlyNumber(this)"/>
							 </span>
		                    </td>
		                 </tr>
		                 
		                 <tr>
		                     <th><spring:message code="label.project.useyn" /></th>
		                     <td>
		                        <select id="search_use_yn" name="search_use_yn" class="inp w90p">
		                        	<option value="ALL"><spring:message code="label.common.all" /></option>
		                        	<option value="1"><spring:message code="label.project.active" /></option>
							 		<option value="2"><spring:message code="label.project.close" /></option>
		                        </select>
		                     </td>
		                     <th><spring:message code="label.project.dept" /></th>
		                     <td>
		                         <select id="dept_cd" name="dept_cd" class="inp w90p"></select>
		                     </td>
                 		</tr>
                 		
						<tr>
							<th><spring:message code="label.project.etcyn" /></th>
							<td>
							 <select id="search_etc_yn" name="search_etc_yn" class="inp w90p">
							 	<option value="ALL"><spring:message code="label.common.all" /></option>
							 	<option value="1"><spring:message code="label.project.delvel" /></option>
							 	<option value="2"><spring:message code="label.project.mainte" /></option>
		                     </select>
							</td>
							<th><spring:message code="label.common.search" /></th>
							<td>
								<select id="search_pjt" name="search_pjt" class="inp w50p">
									<option value="NO"><spring:message code="label.project.pjtno" /></option>
									<option value="NAME"><spring:message code="label.project.pjtname" /></option>
			                    </select>
		                    	<input type="text" id="search_text" name="search_text" class="inp w40p" placeholder='검색' />
		                    </td>
						</tr>
					</tbody>
				</table>
				<span class="searchFormBtn">
					<a id="search" class="amb_btnstyle black middle"><spring:message code="label.common.search" /></a>
				</span>
			</div>
		</form>
	</div>
</div>

<div id="ProjectlistActionDiv" class="nh_conBox"> </div>