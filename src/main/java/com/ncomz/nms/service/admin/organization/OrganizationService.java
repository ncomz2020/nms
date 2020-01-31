package com.ncomz.nms.service.admin.organization;


import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import com.ncomz.nms.dao.admin.organization.OrganizationMapper;
import com.ncomz.nms.domain.admin.organization.Org;


@Service
public class OrganizationService {
   
   private Logger logger = Logger.getLogger(this.getClass());
   
   @Autowired
   private OrganizationMapper OrganizationMapper;
   

   public List<Org> selectOrg( ) throws Exception {

       return OrganizationMapper.selectOrg();
   }
   
   public List<Org> getTeam( ) throws Exception {

       return OrganizationMapper.getTeam();
   }
   
   public List<Org> getDept( ) throws Exception {

       return OrganizationMapper.getDept();
   }
   
   public List<Org> selectHonor() throws Exception {
	   return OrganizationMapper.selectHonor();
   }

	public List<Org> teamCount() {
	
		return OrganizationMapper.teamCount();
	}
	
	public List<Org> deptCount() {
		
		return OrganizationMapper.deptCount();
	}
	
	public List<Org> getCeo() throws Exception {
		
		return OrganizationMapper.getCeo();
	}
   
   
}