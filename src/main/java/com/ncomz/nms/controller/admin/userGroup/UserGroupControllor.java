package com.ncomz.nms.controller.admin.userGroup;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ncomz.nms.domain.Consts;
import com.ncomz.nms.domain.admin.card.Card;
import com.ncomz.nms.domain.admin.common.UserGroup;
import com.ncomz.nms.domain.admin.user.User;
import com.ncomz.nms.domain.common.SessionUser;
import com.ncomz.nms.service.admin.code.CodeService;
import com.ncomz.nms.service.admin.user.UserService;
import com.ncomz.nms.service.admin.userGroup.UserGroupService;

@Controller
@RequestMapping(value = "/admin/userGroup")
public class UserGroupControllor {
	
	private static final Logger logger = LoggerFactory.getLogger(UserGroupControllor.class);
	private String thisUrl = "admin/userGroup";
	
	@Autowired
	private UserService UserService;
	
	@Autowired
	private UserGroupService userGroupService;

	@Autowired
	private CodeService codeService;
	
	@RequestMapping(value = "userGroupList")
	public String list(Model model, HttpServletRequest request){
		
		model.addAttribute("getDeptList", codeService.createComboBox2("100"));
		model.addAttribute("getUsrGroupList", userGroupService.getGroupList());
		
		return thisUrl + "/userGroupList";
	}
	
	@RequestMapping(value = "userGroupListAction", method = RequestMethod.POST)
	public String listAction(Model model, User user, HttpServletRequest request) {
		
		//세션값 끌어오기
		
		HttpSession session = request.getSession();
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.SessionAttr.USER);
		
		user.setEmp_no(sessionUser.getEmp_no());
		user.setUsr_grp_id(user.getSearch_usr_grp_id()); 
		

		int count = UserService.getUserListCount(user);
		model.addAttribute("count", count); 
		model.addAttribute("pagingObject", user);
		model.addAttribute("user", UserService.getUserList(user));
		
		return thisUrl + "/userGroupListAction";
	}
	
	@RequestMapping(value = "cmbAction", method = RequestMethod.POST)
	public String cmbAction(Model model, UserGroup userGroup, HttpServletRequest request) {
		String grpCd = userGroup.getDept_cd();
		
		model.addAttribute("data", codeService.createComboBox2(grpCd));

		return thisUrl + "/userGroupList";
	}
	
	@RequestMapping(value = "groupPopup", method = RequestMethod.POST)
	public String customerPopup(UserGroup userGroup, Model model, HttpServletRequest request) throws Exception {
		
		//세션값 끌어오기
		HttpSession session = request.getSession();
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.SessionAttr.USER);

		model.addAttribute("sessionUserId", sessionUser.getEmp_no().toString());
		model.addAttribute("getUsrInfo", userGroupService.getusrInfoMap(userGroup));
		model.addAttribute("getUsrGroupList", userGroupService.getGroupList());
		model.addAttribute("request", request);
		return thisUrl + "/groupPopup"; 
	}
	
	@RequestMapping(value = "updateAction", produces = "application/json", method = RequestMethod.POST)
	public String updateAction(UserGroup userGroup, HttpServletRequest request ) throws Exception  {
		return userGroupService.updateInfo(userGroup);
		
	}
	
}
