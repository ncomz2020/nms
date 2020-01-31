package com.ncomz.nms.dao.admin.dashboard;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ncomz.nms.domain.admin.dashboard.ProjectCnt;
import com.ncomz.nms.domain.admin.dashboard.TeamCnt;

@Component
public interface DashboardMapper {
	List<TeamCnt> getTeamCount();  //임직원
	List<ProjectCnt> getProjectCount(String currYYYY);  //프로젝트
}
