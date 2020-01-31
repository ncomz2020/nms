package com.ncomz.nms.dao.admin.project;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.ncomz.nms.domain.admin.code.Code;
import com.ncomz.nms.domain.admin.project.Project;
import com.ncomz.nms.domain.admin.project.ProjectUser;
import com.ncomz.nms.domain.admin.user.User;

@Component
public interface ProjectMapper {
	
	//프로젝트 리스트 조회
	List<Project> getProjectList(Project project);
	int getProjectListCount(Project project);
	List<ProjectUser> getProjectUser(ProjectUser projectUser);
	
	//프로젝트 등록
	void insertProjectInfo(Project project);
	
	//중복체크
	int chkPjtNo(String pjt_no);
	
	//프로젝트 수정
	void projectUpdate(Project project);
	List<Project> getProjectInfo(Project project);
	List<ProjectUser> getMemberInfo(ProjectUser projectUser);
	List<User> memberview(HashMap<String, Object> map);
	String memberInfo(String param_emp_no);
	
	//투입인원 삭제
	void deleteMember(String pjt_no);
	
	//프로젝트 삭제
	void projectDelete(String pjt_no);
	
	//투입인원 추가
	void insertMember(ProjectUser projectuser);
	
	//엑셀파일 다운로드
	List<Project> getProjectListExcel(Project project);
	
}
