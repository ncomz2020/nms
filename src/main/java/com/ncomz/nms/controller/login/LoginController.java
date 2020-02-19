package com.ncomz.nms.controller.login;

import java.util.Locale;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ncomz.nms.domain.authorization.User;
import com.ncomz.nms.service.admin.code.CodeService;
import com.ncomz.nms.service.login.LoginService;
import com.ncomz.nms.utility.MessageUtil;
import com.ncomz.nms.utility.SHA256Util;
import com.ncomz.nms.utility.StringUtil;


@Controller
@RequestMapping(value = "/login")
public class LoginController {
	
	/** 로그출력. */
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private LoginService loginService;
	
	
	@Autowired
	private CodeService codeService;
	
	
	private String thisUrl = "login";
	
    final private static char[] possibleCharacters = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };
   	final private static int possibleCharacterCount = possibleCharacters.length;
	   	
	@RequestMapping(value = "admin/login", method = {RequestMethod.POST,RequestMethod.GET})
	public String login(Model model, HttpServletRequest request) {
		Locale locale = null;
		HttpSession session = request.getSession(false);

		if (session == null)
			return thisUrl + "/admin/login";
		
		session.invalidate();
		return thisUrl + "/admin/login";
	}

	
	@RequestMapping(value = "admin/loginAction", method = RequestMethod.POST)
	public @ResponseBody Object loginAction(@RequestParam(required = false) String textId,
											@RequestParam(required = false) String textNm,
											@RequestParam(required = false) String textLang,
											@RequestParam(required = false) String force, Model model, HttpServletRequest request, HttpServletResponse response) {
		
		textId = StringUtil.decode(textId);
		textNm = StringUtil.decode(textNm);
		textLang = StringUtil.decode(textLang);
		
		boolean bForce = Boolean.parseBoolean(force);
		return loginService.login(textId, textNm, bForce, request);
		
	}
	
	
	/**
	 * 로그아웃 프로세스.
	 *
	 * @param model Model
	 * @param request HttpServletRequest
	 * @return String
	 */
	@RequestMapping(value = "admin/logoutAction", method = RequestMethod.POST)
	public String logoutAction(Model model, HttpServletRequest request) {
		//String resultUrl = "index";
		String resultUrl = "redirect:/login/admin/login";
		HttpSession session = request.getSession(false);
        
        if (session == null){
            return resultUrl;
        }
//        SessionUser sessionUser = (SessionUser)SessionUtil.getAttribute(Consts.SessionAttr.USER);
//        if (sessionUser == null){
//            return resultUrl;
//        }
//        System.out.println("세션TEST::" + sessionUser.getUsr_nm());
//        SessionUtil.removeAttribute(request, Consts.SessionAttr.USER);
		session.invalidate();
		return resultUrl;
	}
	
	@RequestMapping(value = "/admin/goSignIn", method = RequestMethod.POST)
	public String goSignIn(Model model, HttpServletRequest request){
		return thisUrl + "/admin/goSignIn";
	}
	
	@RequestMapping(value = "joinMemberAction", method = RequestMethod.POST)
	public @ResponseBody String joinMemberAction(User user, HttpServletRequest request){
		String resultMsg = "";
		
		user.setUsr_id(request.getParameter("usr_id"));
		user.setPwd(SHA256Util.getEncrypt(request.getParameter("pwd")));
		user.setChk_pwd(request.getParameter("chk_pwd"));
		user.setUsr_nm(request.getParameter("usr_nm"));
		user.setEmail(request.getParameter("email"));
		user.setTel_no(request.getParameter("tel_no"));
		user.setMobile_no(request.getParameter("mobile_no"));
		user.setBase_addr(request.getParameter("comp_addr"));
		user.setDtl_addr(request.getParameter("comp_addr2"));
		user.setZip_cd(request.getParameter("post_num"));
		user.setGender(request.getParameter("gender"));
		user.setBirth(request.getParameter("birth"));
		user.setUsr_grp_id(request.getParameter("usr_grp_id"));
		
		String usrId = request.getParameter("usr_id");
		String storeId = usrId;
		
		user.setStore_id(storeId);
		
		resultMsg = loginService.joinMemeberAction(user);
		
		return resultMsg;
	}
	
	/**
	 * @param numberLength 	랜덤으로 생성할 길이
	 */
	private String randomNumber(int numberLength) {
		Random rnd = new Random();
		StringBuffer randomBuf = new StringBuffer(numberLength);

		for (int i = numberLength; i > 0; i -- ) {
			randomBuf.append(possibleCharacters[rnd.nextInt(possibleCharacterCount)]);
		}

		return randomBuf.toString();
	}
	
}
