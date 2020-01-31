package com.ncomz.nms.dao.admin.userGroup;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ncomz.nms.domain.admin.common.UserGroup;
import com.ncomz.nms.domain.admin.user.User;

@Component
public interface UserGroupMapper {
	List<UserGroup> getUserGroupList(UserGroup userGroup);

	int getUserGroupListCount(UserGroup userGroup);

	UserGroup getUserGroup(UserGroup userGroup);

	List<UserGroup> getGroupList();

	UserGroup getusrInfoMap(UserGroup userGroup);

	String updateInfo(UserGroup userGroup);
   
	
}