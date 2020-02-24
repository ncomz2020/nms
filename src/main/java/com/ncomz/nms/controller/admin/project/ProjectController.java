package com.ncomz.nms.controller.admin.project;


import java.io.UnsupportedEncodingException;
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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ncomz.nms.domain.Consts;
import com.ncomz.nms.domain.admin.code.Code;
import com.ncomz.nms.domain.admin.common.Paging;
import com.ncomz.nms.domain.admin.project.Project;
import com.ncomz.nms.domain.admin.project.ProjectUser;
import com.ncomz.nms.domain.admin.user.User;
import com.ncomz.nms.domain.common.SessionUser;
import com.ncomz.nms.service.admin.code.CodeService;
import com.ncomz.nms.service.admin.project.ProjectService;
import com.ncomz.nms.service.admin.user.UserService;

@Controller
@RequestMapping(value = "/admin/project")
public class ProjectController {

	private static final Logger logger = LoggerFactory.getLogger(ProjectController.class);
	private String thisUrl = "admin/project";
	
	@Autowired
	private ProjectService projectService;

	@Autowired
	private CodeService codeService;
	
	//프로젝트 리스트 페이지
	@RequestMapping(value = "projectList")
	public String projectList(Model model) {
		return thisUrl + "/projectList";
	}
	
	//프로젝트 리스트 출력
	@RequestMapping(value = "projectListAction", method = RequestMethod.POST)
	public String projectListAction(Model model, Project project,Paging paging, HttpServletRequest request) {
  
		int count = projectService.getProjesctListCount(project);
		
		//세션값 끌어오기
		HttpSession session = request.getSession();
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.SessionAttr.USER);
		project.setCre_id(sessionUser.getEmp_no());
		
		model.addAttribute("count", count); 
		model.addAttribute("pagingObject", project); 
		model.addAttribute("project", projectService.getProjectList(project));
		model.addAttribute("paging", paging);
  
		return thisUrl + "/projectListAction"; 
	}
	
	//프로젝트 등록 페이지
	@RequestMapping(value = "projectInsert", method = RequestMethod.POST)
	public String projectInsert(Model model, HttpServletRequest request, Code code) {
		model.addAttribute("getDeptList", codeService.createComboBox2("100"));
		return thisUrl + "/projectInsert";
	}
	
	@RequestMapping(value = "cmbAction", method = RequestMethod.POST)
	public String cmbAction(Model model, Project project, HttpServletRequest request) {
		String grpCd = project.getDept_cd();
		String teamCd = project.getTeam_cd();
		
		model.addAttribute("data", codeService.createComboBox2(grpCd));

		return thisUrl + "/projectInsert";
	}
	
	//투입인력 불러오기
	@RequestMapping(value = "changeMember", method = RequestMethod.POST)
	   public String changeMember(Model model, Project project, HttpServletRequest request) {
	      try {
	    	  
	         String param_dept_cd = project.getDept_cd();
	         String param_team_cd = project.getTeam_cd();
	         HashMap<String, Object> memberMap = new HashMap();
	         
	         memberMap.put("param_dept_cd", param_dept_cd);
	         memberMap.put("param_team_cd", param_team_cd);
	               
	         List<User> result = projectService.memberview(memberMap);
	         
	         model.addAttribute("data", result);

	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	            
	      return thisUrl + "/projectMemberPopup";
	   }
	
	//프로젝트 등록
	@RequestMapping(value = "projectInsertAction", produces = "application/josn", method = RequestMethod.POST)
	public @ResponseBody String projectInsertAction( Project project, ProjectUser projectUser, HttpServletRequest request) throws Exception {
		
			//세션값 끌어오기
			HttpSession session = request.getSession();
			SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.SessionAttr.USER);
			project.setCre_id(sessionUser.getEmp_no());
			
			projectUser.setPjt_no(project.getPjt_no());
			boolean result = projectService.insertProjectInfo(project, projectUser, request);
			
			String res = "SUC";
			if(!result) {
				res = "FAIL";
	
			}
		
		return res;	
	}

	//프로젝트 수정 페이지
	@RequestMapping(value = "projectUpdate", method = RequestMethod.POST)
	public String projectUpdate(Model model, Project project,ProjectUser ProjectUser, HttpServletRequest request) {
		List<ProjectUser> memberInfo = projectService.getmemberInfo(ProjectUser);
		List<Project> projectInfo = projectService.getProjectInfo(project);
		System.out.println("                   %%%% " + memberInfo.get(0).getUsr_nm());
		System.out.println("                   %%%% " + projectInfo.get(0).getDept_cd());
		
		model.addAttribute("getDeptList", codeService.createComboBox2("100"));
		
		model.addAttribute("project", projectInfo);
		model.addAttribute("member", memberInfo);
		
		return thisUrl + "/projectUpdate";
	}
	
	//프로젝트 수정
	@RequestMapping(value = "projectUpdateAction", produces = "application/json", method = RequestMethod.POST)
	public @ResponseBody String projectUpdateAction(Project project, ProjectUser projectUser, HttpServletRequest request) {
		
		//세션값 끌어오기
		HttpSession session = request.getSession();
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.SessionAttr.USER);
		project.setCre_id(sessionUser.getEmp_no());
		
		projectUser.setPjt_no(project.getPjt_no());
		boolean result = projectService.projectUpdate(project, projectUser, request);
		
		String res = "SUC";
		if(!result) {
			res = "FAIL";
		}
		
		return res;
	}
	
	
	//인력등록 modal
	@RequestMapping(value = "projectMemberPopup", method = RequestMethod.POST)
	public String projectMemberPopup(Project project, Model model, HttpServletRequest request) {
		model.addAttribute("getDeptList", codeService.createComboBox2("100"));
		return thisUrl + "/projectMemberPopup";
	}
	
	//인력 추가
	@RequestMapping(value = "memberAction", method = RequestMethod.POST)
	public String memberAction(ProjectUser projectuser, Model model, HttpServletRequest request) {
		return thisUrl + "/projectMemberPopup";
	}
	
	//프로젝트 삭제
	@RequestMapping(value = "projectDeleteAction", method= RequestMethod.POST)
	public void projectDelete(Project project, HttpServletRequest request) {
		String pjt_no = project.getPjt_no();
		projectService.projectDelete(pjt_no);
	}
	
	
	//엑셀파일 다운로드
	@RequestMapping(value = "exportAction", method = RequestMethod.POST) public
  	String exportAction(Project project, Model model, HttpServletRequest request) throws ParseException, UnsupportedEncodingException {
		model.addAttribute("list", projectService.getProjectListExcel(project));
	  
		return "excelViewer"; 
	  }
}
