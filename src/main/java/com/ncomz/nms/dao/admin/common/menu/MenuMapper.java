package com.ncomz.nms.dao.admin.common.menu;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ncomz.nms.domain.admin.common.Menu;
import com.ncomz.nms.domain.admin.common.UserGroup;

@Component
public interface MenuMapper {

	List<Menu> getMenuList(Menu menu);
	List<Menu> getAllUserGroupMenuList(UserGroup userGroup);
	List<Menu> getUserGroupMenuList(UserGroup userGroup);
	int insertMenu(Menu menu);
	int insertUserGroupAuth(Menu menu);
	Menu getMenu(Menu menu);
	int updateMenuInfo(Menu menu);
	int updateOldDisplayOrders(Menu old);
	int updateNewDisplayOrders(Menu old);
	int updateMenuPosition(Menu menu);
	int deleteMenuInfo(Menu menu);
	int insertMenuLanguage(Menu menu);
	int deleteMenuLanguage(Menu menu);
	int countMenuAuth(Menu menu);
	int deleteUserGroupAuth(Menu menu);
	String getNextMenuId();
	
}