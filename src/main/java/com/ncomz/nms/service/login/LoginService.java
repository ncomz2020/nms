package com.ncomz.nms.service.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.ncomz.nms.dao.login.LoginMapper;
import com.ncomz.nms.domain.Consts;
import com.ncomz.nms.domain.authorization.User;
import com.ncomz.nms.domain.common.SessionUser;
import com.ncomz.nms.utility.LoginManager;
import com.ncomz.nms.utility.SHA256Util;

@Service
public class LoginService {
	
	/** 로그 출력. */
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private LoginMapper loginMapper;
	
	/** 로그인 실패 제한 횟수. */
	private String limit = "9";
	
	/**
	 * Ryu
	 * 
	 * @return
	 */
	public String login(String textId, String textNm, boolean bForce, HttpServletRequest request){
		
		String resultMsg = "";
		
		if(loginMapper.countPresenceId(textId)>0){
			// input data null check
			if ("".equals(StringUtils.defaultString(textId)) || "".equals(StringUtils.defaultString(textNm))) {
				
				return "ERROR_INPUT_NULL";
			}
			
			String remoteAddress = request.getRemoteAddr();
			//login check
			SessionUser sessionUser = getSessionUser(textId, textNm, remoteAddress);
			
			if (sessionUser != null) { //로그인 성공
				logger.info("==>> login success!!! : {}", textId);
				
				
				//session create
				HttpSession session = request.getSession(true);
				session.removeAttribute(Consts.SessionAttr.USER);
				session.setAttribute(Consts.SessionAttr.USER, sessionUser);
				System.out.println("testtesttest"+session.getAttribute("session_user"));
				String userId = sessionUser.getEmp_no();
				LoginManager loginManager = LoginManager.getInstance();
				if (bForce) {
					if (loginManager.isUsing(userId)) {
						loginManager.getUserSession(userId).invalidate();
					}
				} else {
					if (loginManager.isUsing(userId)) {
						return "ALREADY_LOGGED_IN";
					}
				}
				loginManager.setSession(session);
				resultMsg = "GO_MAIN";
				
			} else { //로그인 실패
				logger.info("==>> login fail!!! : " + textId);

				resultMsg = "LOGIN_FAIL";
			}
			
		}else{
			resultMsg = "ID_DOES_NOT_EXIST";
		}
		
		return resultMsg;
		
	}	

	
	/**
	 * 로그인 검증 및 세션정보 생성.
	 *
	 * @param usrId 사용자ID
	 * @param password 비밀번호
	 * @param loginGatewayIp 로그인IP
	 * @return SessionUser
	 */
	private SessionUser getSessionUser(String usrId, String password, String loginGatewayIp) {
		SessionUser sessionUser = loginMapper.login(usrId, SHA256Util.getEncrypt(password));
		//SessionUser sessionUser = loginMapper.login(usrId, password);
		
		if (sessionUser != null) {
			/**
			 * DB에서 처리 가능하나, 여러 종류의 DBMS와의 일관성을 위해서 프로그램에서 처리
			 * 프로젝트 성격에 맞도록 SQL을 수정해서 사용 가능
			 *
			 */
			if (sessionUser.getLst_login_dt() != null && sessionUser.getLst_login_dt().indexOf("|") > -1) {
				sessionUser.setLst_login_dt(sessionUser.getLst_login_dt().substring(sessionUser.getLst_login_dt().indexOf("|")+1));
			}
			if (sessionUser.getLst_login_tm() != null && sessionUser.getLst_login_tm().indexOf("|") > -1) {
				sessionUser.setLst_login_tm(sessionUser.getLst_login_tm().substring(sessionUser.getLst_login_tm().indexOf("|")+1));
			}
			
			//set client ip
			sessionUser.setLogin_gw_ip(loginGatewayIp);
			
			logger.debug("{}", sessionUser);

		}
		
		return sessionUser;
	}
	

	public void logout(SessionUser sessionUser) {
		
	}

	@Transactional
	public String joinMemeberAction(User user) {
		String resultMsg = "";
		try {
			if(loginMapper.insertNewMember(user)){
				resultMsg = "successNewMember";
			}else{
				resultMsg = "failNewMember";
			}
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			return e.getMessage();
		}
		return resultMsg;
	}

}
