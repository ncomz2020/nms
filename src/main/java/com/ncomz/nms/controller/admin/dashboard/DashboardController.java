package com.ncomz.nms.controller.admin.dashboard;

import java.awt.Color;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ncomz.nms.service.admin.dashboard.DashboardService;
import com.ibm.icu.util.Calendar;
import com.ncomz.nms.domain.admin.dashboard.ProjectCnt;
import com.ncomz.nms.domain.admin.dashboard.TeamCnt;

/*
 * 작성자 : 김인수
 * 작성일자 : 2019-05-08
 */

@Controller
@RequestMapping(value = "/admin/dash")
public class DashboardController {
	private static final Logger logger = LoggerFactory.getLogger(DashboardController.class);
	private String thisUrl = "admin/dashboard";
	
	@Autowired
	private DashboardService dashboardService;
   	
	
	@RequestMapping(value = "dashView", method = RequestMethod.POST)
	public String dashView(Model model, HttpServletRequest request) {		
		//1. 프로젝트 현황 조회
		List<String> labelList =  new ArrayList<String>();
		List<Integer> ncCntList = new ArrayList<Integer>();
		List<Integer> ycCntList = new ArrayList<Integer>();
		List<Integer> yciCntList = new ArrayList<Integer>();
		List<Integer> yccCntList = new ArrayList<Integer>();
		List<Object> resultList1 = new ArrayList<Object>();
						
		try {
			//현재 연도 계산
			Calendar cal = Calendar.getInstance();
			int year = cal.get ( cal.YEAR );
						
			List<ProjectCnt> projectResultList = dashboardService.getProjectCount(String.valueOf(year));
			
			//chart 데이터에 바로 넣기위한 데이터 형식 생성				
			for(int i=0; i<projectResultList.size(); i++) {
				//라벨값은 리스트에 넣어줄떄, ' 를 꼭 삽입시켜 줘야한다.
				labelList.add("'" + projectResultList.get(i).getCur_yymm() +"'");
				ncCntList.add(projectResultList.get(i).getNc_cnt());
				ycCntList.add(projectResultList.get(i).getYc_cnt());
				yciCntList.add(projectResultList.get(i).getYci_cnt());
				yccCntList.add(projectResultList.get(i).getYcc_cnt());
								
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
			
		resultList1.add(ycCntList);
		resultList1.add(yciCntList);
		resultList1.add(yccCntList);
		resultList1.add(ncCntList);
		resultList1.add(labelList);

				
		model.addAttribute("projectResultList", resultList1);	
		
		//2. 팀별 인원 조회
		List<String> teamNmList = new ArrayList<String>();
		List<Integer> teamCntList = new ArrayList<Integer>();
		List<String> teamColorList = new ArrayList<String>();
		List<Object> resultList2 = new ArrayList<Object>();
		
		int totalCnt = 0;
		try {
			List<TeamCnt> teamResultList = dashboardService.getTeamCount();
			
			//chart 데이터에 바로 넣기위한 데이터 형식 생성				
			for(int i=0; i<teamResultList.size(); i++) {
				//라벨값은 리스트에 넣어줄떄, ' 를 꼭 삽입시켜 줘야한다.
				teamNmList.add("'" + teamResultList.get(i).getTeam_nm() +"'");
				teamCntList.add(teamResultList.get(i).getTeam_capa());
				totalCnt = teamResultList.get(i).getTotal_capa();
				teamColorList.add(makeRandomColor());
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		resultList2.add(teamNmList);
		resultList2.add(teamCntList);
		resultList2.add(teamColorList);
		
		model.addAttribute("teamResultList", resultList2);
		model.addAttribute("total_cnt", totalCnt);
		
		return thisUrl + "/dashView";
	}
	
	
	public String makeRandomColor() {
		int r = (int) (Math.random() * 255) + 1 ;
		int g = (int) (Math.random() * 255) + 2 ;
		int b = (int) (Math.random() * 255) + 3 ;
		
		return "'rgb(" + r + "," + g + "," + b +")'";
	}
}
