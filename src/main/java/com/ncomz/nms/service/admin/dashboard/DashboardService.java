package com.ncomz.nms.service.admin.dashboard;

import java.util.List;
import java.util.Locale;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;

import com.ncomz.nms.dao.admin.dashboard.DashboardMapper;
import com.ncomz.nms.domain.admin.dashboard.ProjectCnt;
import com.ncomz.nms.domain.admin.dashboard.TeamCnt;
import com.ncomz.nms.domain.admin.user.User;


@Service
public class DashboardService {
	 private Logger logger = Logger.getLogger(this.getClass());
	 
	 @Autowired
	 private DashboardMapper DashboardMapper;
	 
	 
	 /*
	  * 팀별 인원수 조회
	  */
	 public List<TeamCnt> getTeamCount(){
		 Locale locale = LocaleContextHolder.getLocale();
	      List<TeamCnt> teamCntList = DashboardMapper.getTeamCount();     
	      TeamCnt teamInfo = new TeamCnt();

		  if(locale.getLanguage().equals("en")) {
			  for (int i=0; i<teamCntList.size(); i++) {
				  teamInfo = teamCntList.get(i);
				  teamInfo.setTeam_nm(teamInfo.getTeam_nm_en());
	    	  }
	      }
		  
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
