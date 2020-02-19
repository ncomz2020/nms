<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
//쿠키 가져오기
function getCookie(cookieName){
	console.log(cookieName);				
	cookieName = cookieName + '=';
	var cookieData = document.cookie;
	var start = cookieData.indexOf(cookieName);
	var cookieValue = '';
	  if(start != -1){
		start += cookieName.length;
		var end = cookieData.indexOf(';',start);
		if(end == -1) end = cookieData.length;
		cookieValue = cookieData.substring(start,end);
	} 
	return unescape(cookieValue);
}

$(document).ready(function() {
	var subMenu = $("#menu_${activeMenuId}").addClass("active");
	var gnb = $(subMenu).parentsUntil(".subDepth").parent("li");
	$(gnb).addClass("active open");
	
	// title, path
	var activeGnbLi = $("#nav_aside li.active");
	var activeSnbLi = $(".subDepth").filter(".open").find('span');
	var sHtml = "";
	sHtml += "<h2>";
	sHtml += "<span class=\"title\">"+subMenu.find(">a>span").text()+"</span>";
	sHtml += "<div class=\"location\">";
	sHtml += "<a href=\"javascript:;\">Home</a>";
	sHtml += ">";
	sHtml += "<a href=\"javascript:;\">"+gnb.find(">a>span").text()+"</a>";
	sHtml += ">";
	sHtml += "<a href=\"javascript:;\">"+subMenu.find(">a>span").text()+"</a>";
	sHtml += "</div>";
	sHtml += "</h2>";
	$("#content").prepend(sHtml);
});
</script>

<div id="nav_aside" class="nav_aside open">
	<ul class="depth_1 mgT30">
		<c:forEach items="${userGroupMenuList}" var="menu" varStatus="status">
			<li>
				<a href="#" data-num="s_${status.index}">
					<i class="<c:out value="${menu.icon}"/>"></i>
					<span>
						<c:choose>
							<c:when test="${cookie.nmsLanguage.value eq 'en'}">
								<c:out value="${menu.title_en}"/>
							</c:when>
							<c:otherwise>
								<c:out value="${menu.title}"/>	
							</c:otherwise>
						</c:choose>				
					</span>
				</a>
			<ul class="depth_2">
				<c:forEach items="${menu.children}" var="subMenu" varStatus="subStatus">
					<li id="menu_${subMenu.menu_id}">
						<a href="javascript:movePage('<c:out value="${subMenu.url}"/>');">
							<i class="<c:out value="${subMenu.icon}"/>"></i>
							<span>
								<c:choose>
									<c:when test="${cookie.nmsLanguage.value eq 'en'}">
										<c:out value="${subMenu.title_en}"/>
									</c:when>
									<c:otherwise>
										<c:out value="${subMenu.title}"/>	
									</c:otherwise>
								</c:choose>
							</span>
						</a>
					</li>
				</c:forEach>
			</ul>
			</li>
			</c:forEach>		
	</ul>
	<span class="asideSlider">
		<i></i>
	</span>
</div>

