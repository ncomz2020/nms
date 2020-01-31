<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page import="com.ncomz.nms.utility.SessionUtil" %>
<%@ page import="com.ncomz.nms.domain.common.SessionUser" %>
<script type="text/javascript">
	function logout() {
		document.frmMenuHandle.action="<%=request.getContextPath()%>/login/admin/logoutAction";
		document.frmMenuHandle.method="post";
		document.frmMenuHandle.submit();
	}
</script>

<div id="header" class="header">
	<div class="wrap">
		<button type="button" class="subMenuIcon close"></button>
		<h1>
			<a href="javascript:movePage('/admin/dash/dashView');">
				<span>NMS</span>
			</a>
		</h1>

		<div class="loginInfo">
			<div class="setting">
				<span class="photo">
					<img src="/img/member_icon_02.png">
				</span>
				<a href="javascript:movePage('/admin/user/userUpdate.ajax', {emp_no:'${sessionScope.session_user.emp_no}'});">
					<i class="ambicon-033_human"></i> 
					<span>${sessionScope.session_user.usr_nm}</span>
				</a>
			</div>
			<div class="logout">
				<a href="javascript:logout();">
					<i class="ambicon-074_get_out"></i>
 					<span>로그아웃</span>
				</a>
			</div>
		</div>
	</div>
</div>