package com.ncomz.nms.controller.admin.user;

import java.io.UnsupportedEncodingException;

import javax.mail.internet.ParseException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ncomz.nms.domain.Consts;
import com.ncomz.nms.domain.admin.code.Code;
import com.ncomz.nms.domain.admin.user.User;
import com.ncomz.nms.domain.common.SessionUser;
import com.ncomz.nms.service.admin.code.CodeService;
import com.ncomz.nms.service.admin.user.UserService;
import com.ncomz.nms.utility.SHA256Util;

@Controller
@RequestMapping(value = "/admin/user")
public class UserControllor {
	
	private static final Logger logger = LoggerFactory.getLogger(UserControllor.class);
	private String thisUrl = "admin/user";
	
	@Autowired
	private UserService UserService;

	@Autowired
	private CodeService codeService;
	
	@RequestMapping(value = "userList")
	public String list(Model model){
		return thisUrl + "/userList";
	}
	
	@RequestMapping(value = "userInsert", method = RequestMethod.POST)
	public String userInsert(Model model, HttpServletRequest request, Code code){
		
		model.addAttribute("getDeptList", codeService.createComboBox2("100"));
		model.addAttribute("getPsitList", codeService.createComboBox2("200"));
		model.addAttribute("getRankList", codeService.createComboBox2("300"));
		model.addAttribute("getGradeList", codeService.createComboBox2("400"));
		model.addAttribute("getStepList", codeService.createComboBox2("500"));
		model.addAttribute("newEmpNo", UserService.newEmpNo());
		
		return thisUrl + "/userInsert";
	}
	
	@RequestMapping(value = "cmbAction", method = RequestMethod.POST)
	public String cmbAction(Model model, User user, HttpServletRequest request) {
		String grpCd = user.getDept_cd();
		
		model.addAttribute("data", codeService.createComboBox2(grpCd));

		return thisUrl + "/userInsert";
	}
	
	@RequestMapping(value = "insertAction", produces = "application/json", method = RequestMethod.POST)
	public @ResponseBody String insertAction(User user,MultipartFile file ,	HttpServletRequest request ) throws Exception  {
		
		return UserService.insertInfo(user, file, request);
		
	}
	
	@RequestMapping(value = "updateUseYnAction", produces = "application/json", method = RequestMethod.POST)
	public String updateUseYnAction(User user) throws Exception  {
		
		return UserService.updateUseYnAction(user);
		
	}
	
	@RequestMapping(value = "userListAction", method = RequestMethod.POST)
	public String listAction(Model model, User user, HttpServletRequest request) {
		
		//세션값 끌어오기
		HttpSession session = request.getSession();
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.SessionAttr.USER);
		user.setEmp_no(sessionUser.getEmp_no());
		
		int count = UserService.getUserListCount(user);
		
		model.addAttribute("count", count); 
		model.addAttribute("pagingObject", user);
		model.addAttribute("user", UserService.getUserList(user));

		return thisUrl + "/userListAction";
	}
	
	@RequestMapping(value = "userUpdate", method = RequestMethod.POST)
	public String update(Model model, User user, HttpServletRequest request) throws Exception {

		model.addAttribute("getDeptList", codeService.createComboBox2("100"));
		model.addAttribute("getPsitList", codeService.createComboBox2("200"));
		model.addAttribute("getRankList", codeService.createComboBox2("300"));
		model.addAttribute("getGradeList", codeService.createComboBox2("400"));
		model.addAttribute("getStepList", codeService.createComboBox2("500"));
		
		model.addAttribute("user", UserService.getUserInfo(user));
		
		return thisUrl + "/userUpdate"; 
	}
	

	@RequestMapping(value = "updateAction", produces = "application/json", method = RequestMethod.POST)
	public @ResponseBody String updateAction(User user,MultipartFile file ,	HttpServletRequest request ) throws Exception  {
		
		return UserService.updateInfo(user, file, request);
		
	}
	
   /**
    * �뿊�� �떎�슫濡쒕뱶
    * @param deliveryInfoMgmt
    * @param model
    * @param request
    * @return
    * @throws ParseException
    * @throws UnsupportedEncodingException
    */
    @RequestMapping(value = "exportAction", method = RequestMethod.POST)
    public String exportAction(User user, Model model, HttpServletRequest request) throws ParseException, UnsupportedEncodingException {
          
        model.addAttribute("list", UserService.getUserListExcel(user));
        
        return "excelViewer";
    }
    

	@RequestMapping(value = "passwordPopup", method = RequestMethod.POST)
	public String passwordPopup(User user, Model model, HttpServletRequest request) throws Exception {
		
		model.addAttribute("User", user);
		model.addAttribute("request", request);
		return thisUrl + "/passwordPopup";
	}

	@RequestMapping(value = "updatePasswordAction", produces = "application/json", method = RequestMethod.POST)
	public @ResponseBody String updatePasswordAction(@RequestBody User user, Model model, HttpServletRequest request ) throws Exception  {
		
		user.setPwd_asis(SHA256Util.getEncrypt(user.getPwd_asis()));
		user.setPwd_tobe(SHA256Util.getEncrypt(user.getPwd_tobe()));
		
		return UserService.updatePasswordAction(user);
	}
	

}
