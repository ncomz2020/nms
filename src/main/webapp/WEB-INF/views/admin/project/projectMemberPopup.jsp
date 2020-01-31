<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<script src='/js/tinymce/tinymce.min.js'></script>
<script src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/js/sweetalert/sweetalert.min.js"></script>
<script>
$(document).ready(function(){
	$("#param_dept_cd").on("change",function(e){
		cmbmChange($('#param_dept_cd').val(), $('#param_team_cd').val());
		changeMember($('#param_dept_cd').val(), $('#param_team_cd').val());
	});
	
	$("#param_team_cd").on("change",function(e){
		changeMember($('#param_dept_cd').val(), $('#param_team_cd').val());
	});
	
	$("#memberSave").on("click", function(e) {
		paramCheck();
	});
	
	showDate();
});
	
	function cmbmChange(cmb, teamCd){
		var param = new Object();
		param.dept_cd = cmb;
		param.team_cd = teamCd;
		console.log(param);

 		$.ajax({
			url:"cmbAction.ajax",
			type:'POST',
			data : param,
			dataType: 'json',
			success: function(data){
				var teamList = data.data;
				var teamHtml = '<option value="">-</option>';
				for(var i=0; i<teamList.length; i++){
					teamHtml += '<option value="' + teamList[i].dtl_cd +'">' + teamList[i].dtl_cd_desc + '</option>';
				}
				$("#param_team_cd").html(teamHtml);
			}
		});

	}


	function changeMember(deptCd, teamCd){
	   var param = new Object();
	   param.dept_cd = deptCd;
	   param.team_cd = teamCd;
	   console.log(param);

	   $.ajax({
	      url:"changeMember.ajax",
	      type:'POST',
	      data : param,
	      dataType: 'json',
	      success: function(data){	    	  
	    	  
	         var memberList = data.data;
	         var memberHtml = '<option value="">-</option>';
	         for(var i=0; i<memberList.length; i++){
	            memberHtml += '<option value="' + memberList[i].emp_no +'">' + memberList[i].usr_nm +' ' + memberList[i].rank_cd + '</option>';
	         }
	         $("#param_emp_no").html(memberHtml);
	      }
	   });

	}

   
	function paramCheck(){
		if($("#param_dept_cd").val() == ''){
			swal('<spring:message code="label.project.insert.error" />', '', 'error');
			return false;
		}if($("#param_emp_no").val() == ''){
			swal('<spring:message code="msg.project.valid.chk.peple" />', '', 'error');
			return false;
		}if($("#workEct").val() == ''){
			swal('<spring:message code="msg.project.valid.chk.mm" />', '', 'error');
			return false;
		}if($("#insertMM").val() == ''){
			swal('<spring:message code="msg.project.valid.chk.insertmm" />', '', 'error');
			return false;
		}if($("#mem_strtdt").val() == ''){
			swal('<spring:message code="label.common.chk.startdate" />', '', 'error');
			return false;
		}if($("#mem_enddt").val() == ''){
			swal('<spring:message code="label.common.chk.enddate" />', '', 'error');
			return false;
		}if(dateCheck() == 0){
			swal('<spring:message code="msg.project.valid.chk.checkdt" />', '', 'error');
			return false;
		}else{
			insertMember();
		}
	}

	//날짜 검사
	function dateCheck(){
		var strtDate = $("#mem_strtdt").val();
		var endDate = $("#mem_enddt").val();
	
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

	function onlyNumber(obj) {
    	$(obj).keyup(function(){
        	$(this).val($(this).val().replace(/[^0-9-]/gi,""));
    	});
	}

	function insertMember(){
		swal({
	    	title: "<spring:message code='label.common.save' />",
	     	text: "<spring:message code='label.common.confirm.save' />",
	     	type: "warning",
	     	showCancelButton: true,
	     	confirmButtonClass: "btn-danger",
	     	confirmButtonText: "<spring:message code='label.common.confirm' />",
	     	cancelButtonText: "<spring:message code='label.common.cancel' />",
	     	closeOnConfirm: false
	   	},
	   	function(){   
			var param = $('#memberForm').serialize();
		   	var rowId = 'row'+$("#param_emp_no").val(); 
		   	var rowCount = $('ul.memberList > li[name="'+ rowId +'"]').length;
		   	if(rowCount > 0){
				swal('<spring:message code="msg.project.valid.chk.pepoverlap" />', '', 'error');
					return false;
		   	}

			$.ajax({
				url : "memberAction.ajax",
				type : "POST",
				data : param,
				success : function(data, status) {

					var addNewMemberRow =  '<li id="row'+$("#param_emp_no").val()+'" name="row'+$("#param_emp_no").val() +'" >';
		            	addNewMemberRow += '<i class="ambicon-033_human"></i>';
		            	addNewMemberRow += '<span class="name bold">';
		            	addNewMemberRow += $("#param_emp_no option:selected").text();
		            	addNewMemberRow += '</span>';
		            	addNewMemberRow += '<span class="date">' + ' (' + $("#mem_strtdt").val() + ' ~ ' + $("#mem_enddt").val()+ ')  </span>' ;		            
		            	addNewMemberRow += '<input type="hidden"  name="emp_no" id="emp_no" value="'+$("#param_emp_no").val()+'" />';
		            	addNewMemberRow += '<input type="hidden"  name="work_dt" value="'+$("#insertMM").val()+'" />';
		            	addNewMemberRow += '<input type="hidden"  name="mem_strtdt" value="'+$("#mem_strtdt").val()+'" />';
		            	addNewMemberRow += '<input type="hidden"  name="mem_enddt" value="'+$("#mem_enddt").val()+'" />';
		            	addNewMemberRow += '<input type="hidden"  name="work_ect" value="'+$("#workEct").val()+'" />';
		            	addNewMemberRow += '<span onclick="deleteRow(this)">';	
		            	addNewMemberRow += '<a class="amb_btnstyle gray small onlyIcon"><i class="ambicon-015_mark_times"></i></a></span>';
		            	addNewMemberRow += '</li>';     
		            	$(".memberList").append(addNewMemberRow);
		            	swal({
							title: '',
						  	text: "<spring:message code='label.common.success.save' />",
						  	type: 'success',
						  	showConfirmButton:true,
						  	confirmButtonText: 'OK',
						},function(){
							
						})
				},
				error : function() {
					swal({
			    		title: '<spring:message code="label.common.cancel" />'
					});
				}
			});
	   });
	}
	
	function showDate(){	
		$("#mem_strtdt").val($("#strt_dt").val());
		$("#mem_enddt").val($("#end_dt").val());
	}

</script>
<div class="amb_layout_common amb_admin_layout_temp_01 modal-dialog">
	<div class="modal-content">
	
		<!-- 실제 컨텐츠 작업부분 -->
		<div class="modal_header">
			<span class="title"><spring:message code="label.project.peple" /></span> 
			<a href="#" class="close" onClick="javascript:closeModal(this);"><i class="ambicon-015_mark_times"></i></a>
		</div>
		
		<div class="modal_body content">
			<div class="rowBox">
				<form id="memberForm" name="memberForm" >
					<div class="g_column w_1_1">
						<div class="unitBox " style="">
							<table class="amb_form_table lineAll ">
							<colgroup>
								<col style="width: 20%;">
								<col style="width: ;">
							</colgroup>
								<tbody>
								<tr>
									<th><spring:message code="label.project.name" /></th>
									<td>
										<select id="param_dept_cd" name="param_dept_cd" class="inp w30p">
											<option value=""><spring:message code="label.common.select" /></option>
											<c:forEach items="${getDeptList}" var="getDeptList" varStatus="status">
											<option value="${getDeptList.dtl_cd}">${getDeptList.dtl_cd_desc}</option>
											</c:forEach>
										</select>
		                         		<select id="param_team_cd" name="param_team_cd" class="inp w30p">
		                         		<option value="">-</option>
								 		</select>
										<select id="param_emp_no" name="param_emp_no" class="inp w30p">
										<option value="">-</option>
										</select>
									</td>
								</tr>
								
								<tr>
									<th><spring:message code="label.common.fromto" /></th>
									<td>
										<span class="datepickerRange">
										<input type="text" id="mem_strtdt" name="mem_strtdt" class="inp datepicker startDate w44p" onkeydown="onlyNumber(this)"/>
										~
										<input type="text" id="mem_enddt" name="mem_enddt" class="inp datepicker startDate w44p" onkeydown="onlyNumber(this)"/>
										</span>
		                    		</td>
								</tr>
								
								<tr>
									<th><spring:message code="label.project.mm" /></th>
									<td>
										<select id="workEct" name="workEct" class="inp w30p">
											<option value="-">-</option>
											<option value="N22"><spring:message code="label.project.date" /></option>
											<option value="N21"><spring:message code="label.project.work" /></option>
										</select>
										<input type="text" id="insertMM" class="inp w60p" onkeydown="onlyNumber(this)"/>
									</td>
								</tr>
								
								</tbody>
							</table>
							
						</div>
					</div>
				</form>
			</div>
		</div>
		
		<div class="modal_footer">
			<div class="btnArea right">
				<button type="button" class="amb_btnstyle middle gray" onClick="javascript:closeModal(this);"><span class="text"><spring:message code="label.common.cancel" /></span></button>
				<button type="button" id="memberSave" class="amb_btnstyle middle blue"><span class="text"><spring:message code="label.common.save" /></span></button>
			</div>
		</div>

	</div>
</div>