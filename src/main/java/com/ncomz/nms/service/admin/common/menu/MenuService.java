package com.ncomz.nms.service.admin.common.menu;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.ncomz.nms.dao.admin.common.menu.MenuMapper;
import com.ncomz.nms.domain.admin.common.Menu;
import com.ncomz.nms.domain.admin.common.UserGroup;
import com.ncomz.nms.domain.common.DynatreeNode;
import com.ncomz.nms.utility.MessageUtil;
import com.ncomz.nms.utility.StringUtil;

import net.sf.ehcache.Cache;
import net.sf.ehcache.Ehcache;
import net.sf.ehcache.Element;

@Service
public class MenuService {
	
	@Autowired
	private MenuMapper menuMapper;
	
	@Autowired
	private Ehcache ehcache;
	
	public DynatreeNode getTreeAction() {
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		Menu menu = new Menu();
		menu.setLanguage(language);
		DynatreeNode root = new DynatreeNode();
		root.setKey("0");
		root.setTitle(MessageUtil.getMessage("label.menu.manage"));
		root.setIsFolder(true);
		root.setChildren(this.buildTree(menuMapper.getMenuList(menu), "0"));
		return root;
	}
	
	public DynatreeNode getTreeAction(UserGroup userGroup) {
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		userGroup.setLanguage(language);
		DynatreeNode root = new DynatreeNode();
		root.setKey("0");
		root.setTitle(MessageUtil.getMessage("label.menu.manage"));
		root.setIsFolder(true);
		root.setChildren(this.buildTree(menuMapper.getAllUserGroupMenuList(userGroup), "0"));
		return root;
	}
	
	public List<DynatreeNode> buildTree(List<Menu> menuList, String parentId) {
		List<DynatreeNode> tree = new ArrayList<DynatreeNode>();
		for (int i=0;i<menuList.size();i++) {
			Menu menu = menuList.get(i);
			if (StringUtil.compare(menu.getParent_id(), parentId) == 0) {
				DynatreeNode node = new DynatreeNode();
				node.setKey(menu.getMenu_id());
				
				if(LocaleContextHolder.getLocale().getLanguage().equalsIgnoreCase("en")) {
					node.setTitle(menu.getTitle_en());
				} else {
					node.setTitle(menu.getTitle());
				}
	
				node.setAuth_tp(menu.getAuth_tp());
				List<DynatreeNode> children = this.buildTree(menuList, menu.getMenu_id());
				node.setChildren(children);
				if (children.size() > 0) {
					node.setIsFolder(true);
				}
				tree.add(node);
			}
		}
		return tree;
	}
	
	public List<Menu> buildMenuTree(List<Menu> menuList, String parentId) {
		List<Menu> tree = new ArrayList<Menu>();
		for (int i=0;i<menuList.size();i++) {
			Menu menu = menuList.get(i);
			if (StringUtil.compare(menu.getParent_id(), parentId) == 0) {
				List<Menu> children = this.buildMenuTree(menuList, menu.getMenu_id());
				menu.setChildren(children);
				tree.add(menu);
			}
		}
		return tree;
	}
	
	@Transactional
	public String insertAction(Menu menu) {
		
		System.out.println("Inserted Data -> " + menu);
		
		try {
			//메뉴 id 채번
			menu.setMenu_id(menuMapper.getNextMenuId());
			//메뉴 insert
			menuMapper.insertMenu(menu);
			//메뉴 권한 insert
			menuMapper.insertUserGroupAuth(menu);
			
			this.clearMenuCache();
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	public Menu getMenu(Menu menu) {
		return menuMapper.getMenu(menu);
	}
	
	@Transactional
	public String updateAction(Menu menu) {
		try {
			//메뉴 update
			menuMapper.updateMenuInfo(menu);
			//메뉴 권한 삭제
			menuMapper.deleteUserGroupAuth(menu);
			//메뉴 권한 재부여
			menuMapper.insertUserGroupAuth(menu);
			this.clearMenuCache();
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	@Transactional
	public String moveAction(Menu menu) {
		try {
			Menu old = menuMapper.getMenu(menu);
			// 기존 부모 하위의 display_order 를 업데이트
			menuMapper.updateOldDisplayOrders(old);
			
			// 새로운 부모 하위의 display_order 를 업데이트
			menuMapper.updateNewDisplayOrders(menu);
			
			// category 위치 업데이트
			menuMapper.updateMenuPosition(menu);
			
			this.clearMenuCache();
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	@Transactional
	public String deleteAction(Menu menu) {
		try {
			//메뉴 delete
			menuMapper.deleteMenuInfo(menu);
			//메뉴 권한 delete
			menuMapper.deleteUserGroupAuth(menu);
			this.clearMenuCache();
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	public void clearMenuCache() {
		Cache menuCache = ehcache.getCacheManager().getCache("menuCache");
		menuCache.removeAll();
	}
	
	@SuppressWarnings("unchecked")
	public List<Menu> getUserGroupMenuList(String usr_grp_id) {
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		List<Menu> listMenu = null;
		String key = usr_grp_id+"_"+language;
		Cache menuCache = ehcache.getCacheManager().getCache("menuCache");
		Element menuElement = menuCache.get(key);
		if (menuElement != null && menuElement.getObjectValue() != null) {
			listMenu = (List<Menu>)menuElement.getObjectValue();
		} else {
			UserGroup userGroup = new UserGroup();
			userGroup.setUsr_grp_id(usr_grp_id);
			userGroup.setLanguage(language);
			listMenu = this.buildMenuTree(menuMapper.getUserGroupMenuList(userGroup), "0");
			menuElement = new Element(key, listMenu);
			menuCache.put(menuElement);
		}
		return listMenu;
	}
	
	public int countMenuAuth(Menu menu) {
		return menuMapper.countMenuAuth(menu);
	}
	
}
