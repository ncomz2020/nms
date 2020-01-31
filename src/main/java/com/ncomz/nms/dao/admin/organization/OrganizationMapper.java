package com.ncomz.nms.dao.admin.organization;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ncomz.nms.domain.admin.organization.Org;

@Component
public interface OrganizationMapper {
   
   //조직도
   List<Org> selectOrg();	//전체 직원 리스트
   List<Org> getDept();		//사업부 
   List<Org> getTeam();		//팀
   List<Org> selectHonor();	//사업부장
   List<Org> deptCount();	//부서별직원수
   List<Org> teamCount();	//팀별직원수
   List<Org> getCeo();		//대표이사
}