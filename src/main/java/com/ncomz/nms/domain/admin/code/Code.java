package com.ncomz.nms.domain.admin.code;

import java.io.Serializable;
import java.util.List;

@SuppressWarnings("serial")
public class Code implements Serializable {

   String grp_cd;
   String grp_cd_desc;
   String dtl_cd;
   String dtl_cd_desc;
   List<Code> children;
   String algn_ord;
   String use_yn;
   String update_user_id;
   String create_user_id;  
   String depth;
   

   public String getGrp_cd() {
      return grp_cd;
   }
   public void setGrp_cd(String grp_cd) {
      this.grp_cd = grp_cd;
   }
   public String getGrp_cd_desc() {
      return grp_cd_desc;
   }
   public void setGrp_cd_desc(String grp_cd_desc) {
      this.grp_cd_desc = grp_cd_desc;
   }
   public String getDtl_cd() {
      return dtl_cd;
   }
   public void setDtl_cd(String dtl_cd) {
      this.dtl_cd = dtl_cd;
   }
   public String getDtl_cd_desc() {
      return dtl_cd_desc;
   }
   public void setDtl_cd_desc(String dtl_cd_desc) {
      this.dtl_cd_desc = dtl_cd_desc;
   }
   public List<Code> getChildren() {
      return children;
   }
   public void setChildren(List<Code> children) {
      this.children = children;
   }
   public String getAlgn_ord() {
      return algn_ord;
   }
   public void setAlgn_ord(String algn_ord) {
      this.algn_ord = algn_ord;
   }
   public String getUse_yn() {
      return use_yn;
   }
   public void setUse_yn(String use_yn) {
      this.use_yn = use_yn;
   }

   public String getUpdate_user_id() {
	return update_user_id;
   }
   public void setUpdate_user_id(String update_user_id) {
	 this.update_user_id = update_user_id;
   }
   public String getCreate_user_id() {
		return create_user_id;
	}
	public void setCreate_user_id(String create_user_id) {
		this.create_user_id = create_user_id;
	}
   public String getDepth() {
      return depth;
   }
   public void setDepth(String depth) {
      this.depth = depth;
   }
   

   
   @Override
   public String toString() {
      return "Code [grp_cd=" + grp_cd + ", grp_cd_desc=" + grp_cd_desc + ", dtl_cd=" + dtl_cd + ", dtl_cd_desc="
            + dtl_cd_desc + ", children=" + children + ", algn_ord=" + algn_ord + ", use_yn=" + use_yn + ", update_user_id=" + update_user_id + ", create_user_id=" + create_user_id + ", depth="
            + depth + "]";
   }
   
}