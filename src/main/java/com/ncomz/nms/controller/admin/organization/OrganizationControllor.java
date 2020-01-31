package com.ncomz.nms.controller.admin.organization;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.ncomz.nms.service.admin.organization.OrganizationService;

@Controller
@RequestMapping(value = "/admin/org")
public class OrganizationControllor {
	
	private static final Logger logger = LoggerFactory.getLogger(OrganizationControllor.class);
	
	private String thisUrl = "admin/org";
	
	@Autowired
	private OrganizationService OrganizationService;
		
	@RequestMapping(value = "org")
	public String Org(Model model) throws Exception{
		
		try { 
			//0506 전체 직원 리스트 
			model.addAttribute("org", OrganizationService.selectOrg());					 	
			//0506 사업부서 리스트
			model.addAttribute("dept", OrganizationService.getDept()); 		
			//0508 팀 리스트
			model.addAttribute("team",OrganizationService.getTeam());		
			//0509 상무,사업부장 리스트
			model.addAttribute("Honor",OrganizationService.selectHonor());		
			//0509 팀별 직원수 
			model.addAttribute("t_count",OrganizationService.teamCount());
			//0509 사업부서별 직원수 
			model.addAttribute("d_count",OrganizationService.deptCount());
			//0522 대표 이사
			model.addAttribute("ceo",OrganizationService.getCeo());
			
			} catch (Exception e) { 				
				e.printStackTrace(); 
			}
			
		return thisUrl + "/org";
	}
}
