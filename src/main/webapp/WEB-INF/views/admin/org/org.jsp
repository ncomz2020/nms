<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<jsp:useBean id="toDay" class="java.util.Date" />
<script type="text/javascript">
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
	 
	 function cellNoFormatter(num){
	    var formattedNum = '';
	    
	    if(num.length==11)
            formattedNum = num.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
	    else
	    	formattedNum = num.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
	    
	    return formattedNum;
	}


</script>
<div class="rowBox mgT20">
	<div class="g_column w_1_1">
		<h3>
			<span class="title">
				<spring:message code="msg.organization.title" />
			</span>
			<div class="fr btnArea middle">
				<a href="javascript:PrintElem('printArea');" class="amb_btnstyle white middle"><spring:message code="msg.organization.print"/></a>
			</div>
		</h3>
			<div id="printArea">
				<div class="unitBox orgWrap" style="">							
					<!-- 대표이사 ///////////////////// -->
					<div class="orgRowUnit">
						<!-- 기본 단위 -->
						<c:forEach items="${ceo}" var="ceo" > 
							<div class="unit headUnit">
								<div class="boxUnit">
									<span class="tit">${ceo.psrt}</span>
									<span class="man"><em class="rank">${ceo.rank_nm}</em> <em class="name">${ceo.usr_nm}</em></span>
									<span class="phone">${ceo.cell_no}</span>
								</div>
							</div>
						</c:forEach>
						<!-- //기본 단위 -->
					</div>
					<!-- 대표이사 ///////////////////// -->							
					<!-- svg를 통한 라인 영역 부분 //////// -->
					<div class="lineWrap"></div>
					<!-- svg를 통한 라인 영역 부분 //////// -->											
					<!-- 부서 리스트 //////////////////-->
					<div class="orgRowUnit">			
						<c:forEach items="${dept}" var="dept" >   							
							<!-- 부서 단위 -->
							<div class="columUnit">
								<!-- 부서명 -->
								<div class="unit headUnit partUnit">
									<div class="boxUnit">
										<span class="tit">${dept.dept}
										<c:forEach items="${d_count}" var="d_count" >
											<c:if test="${d_count.dept_cd eq dept.dtl_cd}"> 
												(${d_count.d_count}) 
											</c:if>	
										</c:forEach><br/>
										<c:forEach items="${Honor}" var="Honor" >  
											<c:if test="${Honor.dtl_cd_desc eq dept.dept}">
												${Honor.usr_nm} ${Honor.rank_nm}<br/>${Honor.cell_no}<br/>																							
											</c:if>
										</c:forEach>
										</span>
									</div>
								</div>							
								<div class="orgRowUnit teamWrap">
									<!-- 팀 단위 //////////////////--->
									<c:forEach items="${team}" var="team" >								
										<c:if test="${dept.dept eq team.grp_cd_desc}">
											<div class="columUnit">
												<c:choose>
													<c:when test="${team.dtl_cd_desc == (NULL)}">
														<!-- NULL팀명 -->
														<div class="unit headUnit" style=" visibility:hidden;">
															<div class="boxUnit">
																<span class="tit">${team.dtl_cd_desc}
																	<c:forEach items="${t_count}" var="t_count" >
																		<c:if test="${t_count.dtl_cd_desc eq team.dtl_cd_desc}"> 
																			(${t_count.t_count}) 
																		</c:if>	
																	</c:forEach>
																</span>
															</div>
														</div>
														<!-- NULL팀명 -->														
													</c:when>
													<c:otherwise>
														<!-- 팀명 -->
														<div class="unit headUnit" >
															<div class="boxUnit">
																<span class="tit">${team.dtl_cd_desc}
																	<c:forEach items="${t_count}" var="t_count" >
																		<c:if test="${t_count.dtl_cd_desc eq team.dtl_cd_desc}"> 
																			(${t_count.t_count}) 
																		</c:if>	
																	</c:forEach>
																</span>
															</div>
														</div>	
														<!-- 팀명 -->											 
													</c:otherwise>
												</c:choose>	
												<!-- 기본 반복 단위 // 팀원 단위 -->
												<c:forEach items="${org}" var="org" >
													<c:if test="${org.dtl_cd_desc eq team.grp_cd_desc}">
														<c:if test="${org.team eq team.dtl_cd_desc}">
															<div class="unit defaultUnit">
																<div class="boxUnit">
																	<span class="man"><em class="rank">${org.rank_nm}</em> <em class="name">${org.usr_nm}</em></span>
																	<span class="phone">${org.emp_no} /${org.cell_no}</span>
																</div>
															</div>
														</c:if>
													</c:if>
												</c:forEach>		
												<!-- 기본 반복 단위 // 팀원 단위 -->										
											</div>
										</c:if>										
									</c:forEach>
									<!-- 팀 단위 //////////////////--->
								</div>
							</div>
							<!-- 부서 단위 -->
						</c:forEach>
					</div>
					<!-- 부서 리스트 //////////////////-->
				</div>
		</div>
	</div>
</div>