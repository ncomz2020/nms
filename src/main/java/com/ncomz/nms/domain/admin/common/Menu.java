package com.ncomz.nms.domain.admin.common;

import java.io.Serializable;
import java.util.Arrays;
import java.util.List;

@SuppressWarnings("serial")
public class Menu implements Serializable {

	String menu_id;
	String parent_id;
	String title;
	String title_en;
	String url;
	String icon;
	String display_order;
	List<Menu> children;
	boolean active;
	String auth_tp;
	String[] languageCode;
	String[] languageTitle;
	String language;
	String usrGrpId;
	
	/* 메뉴 접근 권한 */
	boolean chk_admin;
	boolean chk_dept;
	boolean chk_team;
	boolean chk_user;
	
	public String getMenu_id() {
		return menu_id;
	}
	public void setMenu_id(String menu_id) {
		this.menu_id = menu_id;
	}
	public String getParent_id() {
		return parent_id;
	}
	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getDisplay_order() {
		return display_order;
	}
	public void setDisplay_order(String display_order) {
		this.display_order = display_order;
	}
	public List<Menu> getChildren() {
		return children;
	}
	public void setChildren(List<Menu> children) {
		this.children = children;
	}
	public boolean isActive() {
		return active;
	}
	public void setActive(boolean active) {
		this.active = active;
	}
	public String getAuth_tp() {
		return auth_tp;
	}
	public void setAuth_tp(String auth_tp) {
		this.auth_tp = auth_tp;
	}
	public String[] getLanguageCode() {
		return languageCode;
	}
	public void setLanguageCode(String[] languageCode) {
		this.languageCode = languageCode;
	}
	public String[] getLanguageTitle() {
		return languageTitle;
	}
	public void setLanguageTitle(String[] languageTitle) {
		this.languageTitle = languageTitle;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public void setusrGrpId(String usrGrpId) {
		this.usrGrpId = usrGrpId;
	}

	/* 메뉴 접근 권한 */
	public boolean isChk_admin() {
		return chk_admin;
	}
	public void setChk_admin(boolean chk_admin) {
		this.chk_admin = chk_admin;
	}
	public boolean isChk_dept() {
		return chk_dept;
	}
	public void setChk_dept(boolean chk_dept) {
		this.chk_dept = chk_dept;
	}
	public boolean isChk_team() {
		return chk_team;
	}
	public void setChk_team(boolean chk_team) {
		this.chk_team = chk_team;
	}
	public boolean isChk_user() {
		return chk_user;
	}
	public void setChk_user(boolean chk_user) {
		this.chk_user = chk_user;
	}
	public String getTitle_en() {
		return title_en;
	}
	public void setTitle_en(String title_en) {
		this.title_en = title_en;
	}
	
	@Override
	public String toString() {
		return "Menu [menu_id=" + menu_id + ", parent_id=" + parent_id + ", title=" + title + ", url=" + url + ", icon="
				+ icon + ", display_order=" + display_order + ", children=" + children + ", active=" + active
				+ ", auth_tp=" + auth_tp + ", languageCode=" + Arrays.toString(languageCode) + ", languageTitle="
				+ Arrays.toString(languageTitle) + ", language=" + language + ", usrGrpId=" + usrGrpId + ", chk_admin="
				+ chk_admin + ", chk_dept=" + chk_dept + ", chk_team=" + chk_team + ", chk_user=" + chk_user + "]";
	}
	
	
}
