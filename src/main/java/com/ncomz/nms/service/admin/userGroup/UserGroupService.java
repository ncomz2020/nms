package com.ncomz.nms.service.admin.userGroup;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ncomz.nms.dao.admin.userGroup.UserGroupMapper;
import com.ncomz.nms.domain.admin.common.UserGroup;

@Service
public class UserGroupService {
   
   private Logger logger = Logger.getLogger(this.getClass());
   
   @Autowired
   private UserGroupMapper userGroupMapper;
  
   public List<UserGroup> getUserGroupList(UserGroup userGroup){
      return userGroupMapper.getUserGroupList(userGroup);
   }
   
   public int getUserGroupListCount(UserGroup userGroup) {
      return userGroupMapper.getUserGroupListCount(userGroup);
   }

   
   public UserGroup getUserGroup(UserGroup userGroup) {
	  return userGroupMapper.getUserGroup(userGroup);
   }

   
   public List<UserGroup> getGroupList() {
	return userGroupMapper.getGroupList();
   }

   public UserGroup getusrInfoMap(UserGroup userGroup) {
	   return userGroupMapper.getusrInfoMap(userGroup);
   }

   public String updateInfo(UserGroup userGroup) {
		System.out.println("userGroupuserGroupuserGroupuserGroupuserGroupuserGroupuserGroupuserGroupuserGroup  : " + userGroup.getUsr_grp_id());
	try {
		userGroupMapper.updateInfo(userGroup);
	} catch (Exception e) {
		return "FAIL";
	}

	return "SUCCESS";
   }
   
   
}