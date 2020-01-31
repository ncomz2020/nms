package com.ncomz.nms.domain.admin.common;

public class FileInfo {
	
	int file_id;
	String ori_file_nm;
	String phy_file_nm;
	String file_uri;
	public int getFile_id() {
		return file_id;
	}
	public void setFile_id(int file_id) {
		this.file_id = file_id;
	}
	public String getOrg_file_nm() {
		return ori_file_nm;
	}
	public void setOri_file_nm(String org_file_nm) {
		this.ori_file_nm = org_file_nm;
	}
	public String getPhy_file_nm() {
		return phy_file_nm;
	}
	public void setPhy_file_nm(String phy_file_nm) {
		this.phy_file_nm = phy_file_nm;
	}
	public String getFile_uri() {
		return file_uri;
	}
	public void setFile_uri(String file_uri) {
		this.file_uri = file_uri;
	}
	@Override
	public String toString() {
		return "FileInfo [file_id=" + file_id + ", ori_file_nm=" + ori_file_nm + ", phy_file_nm=" + phy_file_nm
				+ ", file_uri=" + file_uri + "]";
	}
	
	
}
