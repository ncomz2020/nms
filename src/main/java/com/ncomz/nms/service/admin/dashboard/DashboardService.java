package com.ncomz.nms.service.admin.dashboard;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ncomz.nms.dao.admin.dashboard.DashboardMapper;
import com.ncomz.nms.domain.admin.dashboard.ProjectCnt;
import com.ncomz.nms.domain.admin.dashboard.TeamCnt;


@Service
public class DashboardService {
	 private Logger logger = Logger.getLogger(this.getClass());
	 
	 @Autowired
	 private DashboardMapper DashboardMapper;
	 
	 
	 /*
	  * 팀별 인원수 조회
	  */
	 public List<TeamCnt> getTeamCount(){
	      List<TeamCnt> teamCntList = DashboardMapper.getTeamCount();     
	      return teamCntList;
	 }
	 
	 /*
	  * 프로젝트 건수 조회
	  */
	 public List<ProjectCnt> getProjectCount(String currYYYY){
	      List<ProjectCnt> projectCntList = DashboardMapper.getProjectCount(currYYYY);     
	      return projectCntList;
	 }
}
