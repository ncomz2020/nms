package com.ncomz.nms.service.admin.project;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ncomz.nms.dao.admin.project.ProjectMapper;
import com.ncomz.nms.domain.admin.project.Project;
import com.ncomz.nms.domain.admin.project.ProjectUser;
import com.ncomz.nms.domain.admin.user.User;
import com.ncomz.nms.utility.StringUtil;

@Service
public class ProjectService {

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private ProjectMapper projectMapper;
	
	//프로젝트 리스트
	public List<Project> getProjectList(Project project){	
		List<Project> projectList = projectMapper.getProjectList(project);
		
		return projectList;
	}
	
	//프로젝트 카운트
	public int getProjesctListCount(Project project) {
		return projectMapper.getProjectListCount(project);
	}
	
	//프로젝트 등록 +인원추가
	@Transactional
	public boolean insertProjectInfo(Project project, ProjectUser projectUser, HttpServletRequest request) {
		String pjt_no = project.getPjt_no().toString();
		String team_cd = "";
	      try {
	         team_cd = project.getTeam_cd().toString();
	      } catch (NullPointerException ne) {
	         project.setTeam_cd(null);
	      }
		
		try {
			
			if(projectMapper.chkPjtNo(pjt_no) > 0) {
			
				return false;
			}
			projectMapper.insertProjectInfo(project);
			if(!StringUtil.isEmpty(projectUser.getEmp_no())) {
				String[] member1 = projectUser.getEmp_no().toString().split(",");
				String[] member2 = projectUser.getWork_dt().toString().split(",");
				String[] member3 = projectUser.getWork_ect().toString().split(",");
				String[] member4 = projectUser.getMem_strtdt().toString().split(",");
				String[] member5 = projectUser.getMem_enddt().toString().split(",");
			
				ProjectUser insertMember = new ProjectUser();
			
				for(int i=0; i < member1.length; i++) {	
					insertMember = new ProjectUser();
					insertMember.setPjt_no(pjt_no);
					insertMember.setEmp_no(member1[i]);
					insertMember.setWork_dt(member2[i]);
					insertMember.setWork_ect(member3[i]);
					insertMember.setMem_strtdt(member4[i]);
					insertMember.setMem_enddt(member5[i]);
					insertMember.setCre_id(project.getCre_id());
									
					projectMapper.insertMember(insertMember);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return true;
	}
	
	//프로젝트 정보
	public Map<String, Object> getProjectInfo(Project project){
		Map<String, Object> projectInfo = new HashMap<String, Object>();
		
		projectInfo.put("projectInfo", projectMapper.getProjectInfo(project));
		
		return projectInfo;
	}
	
	//투입인력 정보
	public Map<String, Object> getmemberInfo(ProjectUser projectUser){
		Map<String, Object> memberInfo = new HashMap<String, Object>();
		memberInfo.put("memberInfo", projectMapper.getMemberInfo(projectUser));
		
		return memberInfo;
	}
	
	//프로젝트 정보 update
	@Transactional
	public boolean projectUpdate(Project project, ProjectUser projectUser, HttpServletRequest request) {
		String pjt_no = projectUser.getPjt_no().toString();
		String pre_pjt_no = project.getPre_pjt_no().toString();
		
		try {
			
			if(projectMapper.chkPjtNo(pjt_no) > 1) {
			
				return false;
			}
		
			projectMapper.projectUpdate(project);
			projectMapper.deleteMember(pre_pjt_no);
			if(!StringUtil.isEmpty(projectUser.getEmp_no())) {
				String[] member1 = projectUser.getEmp_no().toString().split(",");
				String[] member2 = projectUser.getWork_dt().toString().split(",");
				String[] member3 = projectUser.getWork_ect().toString().split(",");
				String[] member4 = projectUser.getMem_strtdt().toString().split(",");
				String[] member5 = projectUser.getMem_enddt().toString().split(",");
		
				ProjectUser insertMember = new ProjectUser();
				
				for(int i=0; i < member1.length; i++) {	
					insertMember = new ProjectUser();
					insertMember.setPjt_no(pjt_no);
					insertMember.setEmp_no(member1[i]);
					insertMember.setWork_dt(member2[i]);
					insertMember.setWork_ect(member3[i]);
					insertMember.setMem_strtdt(member4[i]);
					insertMember.setMem_enddt(member5[i]);
					insertMember.setCre_id(project.getCre_id());
			
					projectMapper.insertMember(insertMember);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return true;
	}
	
	//엑셀파일 다운로드
	public List<Project> getProjectListExcel(Project project){
		return projectMapper.getProjectListExcel(project);
		
	}
	
	//프로젝트 삭제
	public void projectDelete(String pjt_no) {
		projectMapper.projectDelete(pjt_no);
		projectMapper.deleteMember(pjt_no);
	}
	
	//투입인원 출력
	public List<User> memberview(HashMap<String, Object> map) {
		  List<User> memberView = projectMapper.memberview(map);
		  return memberView; 
	}
	
	//투입인력 정보
	public String memberInfo(String param_emp_no) {
		return projectMapper.memberInfo(param_emp_no);
	}

}
