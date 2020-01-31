/**
* ProfileController.java 
* 차윤지
*/

package com.ncomz.nms.controller.admin.profile;

import java.io.UnsupportedEncodingException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.internet.ParseException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ncomz.nms.domain.Consts;
import com.ncomz.nms.domain.admin.user.User;
import com.ncomz.nms.domain.common.SessionUser;
import com.ncomz.nms.service.admin.code.CodeService;
import com.ncomz.nms.service.admin.profile.ProfileService;

@Controller
@RequestMapping(value = "/admin/profile")
public class ProfileControllor {
	
	private static final Logger logger = LoggerFactory.getLogger(ProfileControllor.class);
	private String thisUrl = "admin/profile";

	@Autowired
	private ProfileService profileService;
	
	@Autowired
	private CodeService codeService;
	
	/**
    * 프로필 이력 조회
    * 0521
    */
	@RequestMapping(value = "profileHistory")
	public String profileHistoryList(Model model, HttpServletRequest request){	
		// 세션값 변수에 담기
		HttpSession session = request.getSession();
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.SessionAttr.USER);
		Map<String, String> paramMap = new HashMap<String, String>();
		String strDeptCd = sessionUser.getDept_cd();
		String strTeamCd = sessionUser.getTeam_cd();
		String strUserGrpId = sessionUser.getUsr_grp_id();
  
		// paramMap 에 부서, 팀 저장
		paramMap.put("dept_cd", strDeptCd);
		paramMap.put("team_cd", strTeamCd);
  
		// 사업부장, 팀장 권한 분기 처리를 위한 정보 입력
		if("1".equals(strUserGrpId)) { // admin
			model.addAttribute("getDeptList", codeService.createComboBox2("100")); 
		} else if("2".equals(strUserGrpId)) { // 사업부장
			model.addAttribute("getDeptList", codeService.createComboBox3(strDeptCd));
		} else if("3".equals(strUserGrpId) || "4".equals(strUserGrpId)) { // 팀장, 사원
			model.addAttribute("getDeptList", codeService.createComboBox4(paramMap));
		}
		
		model.addAttribute("USER_GRP_ID", strUserGrpId);
		
		return thisUrl + "/profileHistory";
	}

	/**
    * 프로필 이력 조회 (부서/팀 관련) 
    * 0529
    */
	@RequestMapping(value = "cmbHistoryAction", method = RequestMethod.POST)
	public String cmbHistoryAction(Model model, User user, HttpServletRequest request) {
		String grpCd = user.getDept_cd();
		model.addAttribute("data", codeService.createComboBox2(grpCd));
		return thisUrl + "/profileHistory";
	}
	
	/**
    * 프로필 이력 조회 Action 
    * 0521
    */
	@RequestMapping(value = "profileHistoryAction", method = RequestMethod.POST)
	public String profileHistoryListAction(Model model, User user, HttpServletRequest request) {

		String searchMonth = user.getSearch_month();
		if(searchMonth == "") {
			// 현재 작성년월
			Calendar cal = Calendar.getInstance();
			String year = String.valueOf(cal.get ( cal.YEAR ));
			String month = String.valueOf(cal.get ( cal.MONTH ) + 1) ;	
			if (Integer.parseInt(month) < 10) {
				month = "0" + month;
			}
			searchMonth = year + "-" + month;
		}
		model.addAttribute("searchMonth", searchMonth); 
		
		//세션값 끌어오기
		HttpSession session = request.getSession();
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.SessionAttr.USER);
		String sessionId = sessionUser.getEmp_no();
		user.setEmp_no(sessionId);		
		
		// 권한을 위한 그룹 아이디 get
	    String usrGrpId = sessionUser.getUsr_grp_id();
	    user.setUsr_grp_id(sessionUser.getUsr_grp_id());

	    // 그룹 아이디로 권한 다르게 주기
	    if(usrGrpId.equalsIgnoreCase("2")) {
        	user.setDept_cd(sessionUser.getDept_cd());
	    } else if(usrGrpId.equalsIgnoreCase("3") || usrGrpId.equalsIgnoreCase("4")) {
        	user.setTeam_cd(sessionUser.getTeam_cd());
        	user.setDept_cd(sessionUser.getDept_cd());
	    } 	
		
		int count = profileService.getProfileHistoryListCount(user);
		List<User> profileHistList = profileService.getProfileHistoryList(user);
		
		model.addAttribute("count", count); 
		model.addAttribute("pagingObject", user);
		model.addAttribute("profile", profileHistList);

		return thisUrl + "/profileHistoryAction";
	}
	
	/**
    * 프로필 이력 상세보기
    * 0521
    */
	@RequestMapping(value = "profileHistView")
	public String profileHistView(Model model, User user){

		String param = user.getCre_dt_st();
		String empNo = param.substring(0, param.lastIndexOf(","));
		String creDt = param.substring(param.lastIndexOf(",") + 1);
		 
		// empNo 와 creDt set 하기 (WHERE 조건)
		user.setEmp_no(empNo);
		user.setCre_dt_st(creDt);

		model.addAttribute("profile", profileService.getProfileHist(user));
		
		Calendar cal = Calendar.getInstance();
		String year = String.valueOf(cal.get ( cal.YEAR ));
		String month = String.valueOf(cal.get ( cal.MONTH ) + 1) ;	
		if (Integer.parseInt(month) < 10) { month = "0" + month; }
		String date = String.valueOf(cal.get ( cal.DATE )) ;	
		if (Integer.parseInt(date) < 10) { date = "0" + date; }
		
		model.addAttribute("today", year+"년 "+month+"월 "+date+"일"); 

		return thisUrl + "/profileHistView";
	}
	
	/**
    * 프로필 조회
    * 0503
    * 0529 - 검색창 부서/팀 값 설정
    */
	@RequestMapping(value = "profileList")
	public String profileList(Model model, HttpServletRequest request){	
		
		// 세션값 변수에 담기
		HttpSession session = request.getSession();
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.SessionAttr.USER);
		Map<String, String> paramMap = new HashMap<String, String>();
		String strDeptCd = sessionUser.getDept_cd();
		String strTeamCd = sessionUser.getTeam_cd();
		String strUserGrpId = sessionUser.getUsr_grp_id();
  
		// paramMap 에 부서, 팀 저장
		paramMap.put("dept_cd", strDeptCd);
		paramMap.put("team_cd", strTeamCd);
  
		// 사업부장, 팀장 권한 분기 처리를 위한 정보 입력
		if("1".equals(strUserGrpId)) { // admin
			model.addAttribute("getDeptList", codeService.createComboBox2("100")); 
		} else if("2".equals(strUserGrpId)) { // 사업부장
			model.addAttribute("getDeptList", codeService.createComboBox3(strDeptCd));
		} else if("3".equals(strUserGrpId) || "4".equals(strUserGrpId)) { // 팀장, 사원
			model.addAttribute("getDeptList", codeService.createComboBox4(paramMap));
		}
		
		model.addAttribute("USER_GRP_ID", strUserGrpId);
  
		return thisUrl + "/profileList";
	}

	/**
    * 프로필 조회 (부서/팀 관련) 
    * 0529
    */
	@RequestMapping(value = "cmbAction", method = RequestMethod.POST)
	public String cmbAction(Model model, User user, HttpServletRequest request) {
		String grpCd = user.getDept_cd();
		model.addAttribute("data", codeService.createComboBox2(grpCd));
		return thisUrl + "/profileList";
	}

	/**
    * 프로필 조회 Action 
    * 0503
    */
	@RequestMapping(value = "profileListAction", method = RequestMethod.POST)
	public String profileListAction(Model model, User user, HttpServletRequest request) {
		
		//세션값 끌어오기
		HttpSession session = request.getSession();
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.SessionAttr.USER);
		String sessionId = sessionUser.getEmp_no();
		user.setEmp_no(sessionId);		
		
		// 권한을 위한 그룹 아이디 get
	    String usrGrpId = sessionUser.getUsr_grp_id();
	    user.setUsr_grp_id(sessionUser.getUsr_grp_id());

	    // 그룹 아이디로 권한 다르게 주기
	    if(usrGrpId.equalsIgnoreCase("2")) {
        	user.setDept_cd(sessionUser.getDept_cd());
	    } else if(usrGrpId.equalsIgnoreCase("3") || usrGrpId.equalsIgnoreCase("4")) {
        	user.setTeam_cd(sessionUser.getTeam_cd());
        	user.setDept_cd(sessionUser.getDept_cd());
	    } 
	    
		int count = profileService.getProfileListCount(user);
		List<User> profileList = profileService.getProfileList(user);
	  
		model.addAttribute("count", count); 
		model.addAttribute("pagingObject", user);
		model.addAttribute("profile", profileList);

		return thisUrl + "/profileListAction";
	}
	
	/**
    * 프로필 수정 화면
    * 0529 - 목록 선택, 등록 
    */
	@RequestMapping(value = "profileUpdate")
	public String profileUpdate(Model model, User user){
		model.addAttribute("profile", profileService.getProfile(user));
		return thisUrl + "/profileUpdate";
	}
	
	/**
    * 프로필 수정
    * 0529 - 목록 선택, 등록 
    */
	@RequestMapping(value = "updateProfileAction", produces = "application/json", method = RequestMethod.POST)
	public @ResponseBody String updateProfileAction(User user, MultipartFile file, HttpServletRequest request) throws Exception{

		try {
			// T_USER_HIST ~ 삽입
			String result = profileService.insertProfileHist(user, file, request);
			
			if (result.equals("succ")) {	
				// T_USER ~ 수정, T_EDU ~ 삭제 후 삽입
				profileService.updateProfile(user, file, request);
			}
			
			return "succ";
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			System.out.println("updateProfileAction : error");
			return "fail";
		}
	}
	
	/**
    * 프로필 감추기
    * 0522 - 수정
    */
	@RequestMapping(value = "hideUserAction", produces = "application/json", method = RequestMethod.POST)
	public String hideUserAction(User user) throws Exception{
		
		String emp_no = user.getEmp_no();
		profileService.hideUser(emp_no);

		return "redirect:profileList";
	}
	
	/**
    * 엑셀 다운로드
    * 0513
    */
	@RequestMapping(value = "exportAction", method = RequestMethod.POST)
    public String exportAction(User user, Model model, HttpServletRequest request) throws ParseException, UnsupportedEncodingException {
		
		//세션값 끌어오기
		HttpSession session = request.getSession();
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.SessionAttr.USER);
		String sessionId = sessionUser.getEmp_no();
		user.setEmp_no(sessionId);		
		
		// 권한을 위한 그룹 아이디 get
	    String usrGrpId = sessionUser.getUsr_grp_id();
	    user.setUsr_grp_id(sessionUser.getUsr_grp_id());

	    // 그룹 아이디로 권한 다르게 주기
	    if(usrGrpId.equalsIgnoreCase("2")) {
        	user.setDept_cd(sessionUser.getDept_cd());
	    } else if(usrGrpId.equalsIgnoreCase("3") || usrGrpId.equalsIgnoreCase("4")) {
        	user.setTeam_cd(sessionUser.getTeam_cd());
        	user.setDept_cd(sessionUser.getDept_cd());
	    } 
		
		model.addAttribute("list", profileService.getProfileListExcel(user));
        return "excelViewer";
    }
	
	/**
    * 프로필 이력 엑셀 다운로드
    * 0522
    */
	@RequestMapping(value = "exportHistAction", method = RequestMethod.POST)
    public String exportHistAction(User user, Model model, HttpServletRequest request) throws ParseException, UnsupportedEncodingException {
        
		//세션값 끌어오기
		HttpSession session = request.getSession();
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.SessionAttr.USER);
		String sessionId = sessionUser.getEmp_no();
		user.setEmp_no(sessionId);		
		
		// 권한을 위한 그룹 아이디 get
	    String usrGrpId = sessionUser.getUsr_grp_id();
	    user.setUsr_grp_id(sessionUser.getUsr_grp_id());

	    // 그룹 아이디로 권한 다르게 주기
	    if(usrGrpId.equalsIgnoreCase("2")) {
        	user.setDept_cd(sessionUser.getDept_cd());
	    } else if(usrGrpId.equalsIgnoreCase("3") || usrGrpId.equalsIgnoreCase("4")) {
        	user.setTeam_cd(sessionUser.getTeam_cd());
        	user.setDept_cd(sessionUser.getDept_cd());
	    } 
	    
		model.addAttribute("list", profileService.getProfileHistListExcel(user));
        return "excelViewer";
    }

}
