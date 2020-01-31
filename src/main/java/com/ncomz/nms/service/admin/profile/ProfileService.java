package com.ncomz.nms.service.admin.profile;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.multipart.MultipartFile;

import com.ncomz.nms.dao.admin.common.file.FileMapper;
import com.ncomz.nms.dao.admin.profile.ProfileMapper;
import com.ncomz.nms.dao.admin.user.UserMapper;
import com.ncomz.nms.domain.admin.user.User;
import com.ncomz.nms.service.admin.common.file.FileService;
import com.ncomz.nms.utility.StringUtil;

@Service
public class ProfileService {
   
   private Logger logger = Logger.getLogger(this.getClass());
   
   @Autowired
   private ProfileMapper profileMapper;
   
   @Autowired
   private UserMapper userMapper;
   
   @Autowired
   private FileMapper fileMapper;
   
   @Autowired
   private FileService fileService;
   
   // 0521 - 직원 프로필 이력 목록
   public List<User> getProfileHistoryList(User user){
	   Locale locale = LocaleContextHolder.getLocale();
	   List<User> profileHistList = profileMapper.getProfileHistoryList(user);
	   return profileHistList;
   }

   // 0521 - 프로필 이력 상세보기 
   public Map<String, Object> getProfileHist(User user){
	   Map<String,Object> profileHistInfo = new HashMap<String,Object>();
	   
	   try {
		   profileHistInfo.put("profileUser", profileMapper.getProfileUserHist(user));		
		   profileHistInfo.put("profileEdu", profileMapper.getProfileEduHist(user));
		   profileHistInfo.put("profileCert", profileMapper.getProfileCertHist(user));
		   profileHistInfo.put("profileCarr", profileMapper.getProfileCarrHist(user));
		   profileHistInfo.put("profileTask", profileMapper.getProfileTaskHist(user));
	   } catch (Exception e) {
			// TODO Auto-generated catch block
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
	   }

	   return profileHistInfo;	   
   }
   
   // 0523 - 직원 프로필 이력 수 
   public int getProfileHistoryListCount(User user) {
	   return profileMapper.getProfileHistoryListCount(user);
   }
   
   // 0503 - 직원 프로필 목록
   public List<User> getProfileList(User user){
	   Locale locale = LocaleContextHolder.getLocale();
	   List<User> profileList = profileMapper.getProfileList(user);
	   return profileList;
   }
   
   // 0503 - 직원 프로필 수 
   public int getProfileListCount(User user) {
	   return profileMapper.getProfileListCount(user);
   }
   
   // 0507 - 프로필 수정 화면 (상세보기) + 등록 화면 
   public Map<String, Object> getProfile(User user){
	   String empNo = user.getEmp_no();
	   Map<String,Object> profileInfo = new HashMap<String,Object>();
	   
	   try {
		   List<User> userInfo = profileMapper.getProfileUser(empNo);
		   profileInfo.put("profileUser", userInfo);
		   
		   String mari_yn_val = "";
		   if (userInfo.get(0).getMari_yn().equals("N")) 
			   mari_yn_val = "미혼";
		   else 
			   mari_yn_val = "기혼";
		   
		   String mil_cd_val = "";
		   if (userInfo.get(0).getMil_cd().equals("1")) 
			   mil_cd_val = "군필";
		   else if (userInfo.get(0).getMil_cd().equals("2"))
			   mil_cd_val = "미필";
		   else if (userInfo.get(0).getMil_cd().equals("0")) 
			   mil_cd_val = "면제";
		   else 
			   mil_cd_val = "해당없음";

		   profileInfo.put("mari_yn_val", mari_yn_val);
		   profileInfo.put("mil_cd_val", mil_cd_val);
		   
		   profileInfo.put("profileEdu", profileMapper.getProfileEdu(empNo));
		   profileInfo.put("profileCert", profileMapper.getProfileCert(empNo));
		   profileInfo.put("profileCarr", profileMapper.getProfileCarr(empNo));
		   profileInfo.put("profileTask", profileMapper.getProfileTask(empNo));
	   } catch (Exception e) {
			// TODO Auto-generated catch block
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			System.out.println("getProfileHist : error");
	   }

	   return profileInfo;	   
   }
   
   // 0520 - 프로필 정보 수정
   @Transactional
   public String updateProfile(User user, MultipartFile file , HttpServletRequest request)  throws Exception {

	   String emp_no = user.getEmp_no().toString();
	   String cre_id = user.getCre_id().toString();
	   String upd_id = user.getUpd_id().toString();
		  
	   if(file != null) {
			fileService.updateFile(file, request, user );
	   }
	   
	   try {
	
		   // 기본 정보, 사내 정보 수정
		   profileMapper.updateProfileUser(user);
		   profileMapper.updateProfileCom(user);
		   
		   // 학력 수정
		   profileMapper.deleteProfileEdu(emp_no);
		   if(!StringUtil.isEmpty(user.getSchl_nm())){
			   String[] edu1 = user.getSchl_nm().toString().split(",");
			   String[] edu2 = user.getEdu_strt_dt().toString().split(",");
			   String[] edu3 = user.getEdu_end_dt().toString().split(",");
			   String[] edu4 = user.getMajor().toString().split(",");
			   String[] edu5 = user.getEdu_remark().toString().split(",");
				
			   User profileEdu = new User(); 
				
			   for(int i=0; i <edu1.length; i++){
					profileEdu = new User(); 
					profileEdu.setEmp_no(emp_no);
					profileEdu.setSchl_nm(edu1[i]);
					profileEdu.setEdu_strt_dt(edu2[i]);
					profileEdu.setEdu_end_dt(edu3[i]);
					profileEdu.setMajor(edu4[i]);
					profileEdu.setEdu_remark(edu5[i]);
					profileEdu.setCre_id(cre_id);
					profileEdu.setUpd_id(upd_id);
					
					profileMapper.insertProfileEdu(profileEdu);
			   }
			}	
		   
		   // 자격증 수정
		   profileMapper.deleteProfileCert(emp_no);
		   if(!StringUtil.isEmpty(user.getCert_nm())){
			   String[] cert1 = user.getCert_nm().toString().split(",");
			   String[] cert2 = user.getCert_remark().toString().split(",");
			   String[] cert3 = user.getGet_dt().toString().split(",");
				
			   User profileCert = new User(); 
				
			   for(int i=0; i <cert1.length; i++){
				   profileCert = new User(); 
				   profileCert.setEmp_no(emp_no);
				   profileCert.setCert_nm(cert1[i]);
				   profileCert.setCert_remark(cert2[i]);
				   profileCert.setGet_dt(cert3[i]);
				   profileCert.setCre_id(cre_id);
				   profileCert.setUpd_id(upd_id);
				   
				   profileMapper.insertProfileCert(profileCert);
			   }
			}
		   
		   // 경력 수정 
		   profileMapper.deleteProfileCarr(emp_no);
		   if(!StringUtil.isEmpty(user.getCarr_com_nm())){
			   String[] carr1 = user.getCarr_com_nm().toString().split(",");
			   String[] carr2 = user.getCarr_strt_dt().toString().split(",");
			   String[] carr3 = user.getCarr_end_dt().toString().split(",");
			   String[] carr4 = user.getCarr_rank_nm().toString().split(",");
			   String[] carr5 = user.getWork().toString().split(",");
	
			   User profileCarr = new User(); 
				
			   for(int i=0; i <carr1.length; i++){
				   profileCarr = new User(); 
				   profileCarr.setEmp_no(emp_no);
				   profileCarr.setCarr_com_nm(carr1[i]);
				   profileCarr.setCarr_strt_dt(carr2[i]);
				   profileCarr.setCarr_end_dt(carr3[i]);
				   profileCarr.setCarr_rank_nm(carr4[i]);
				   profileCarr.setWork(carr5[i]);
				   profileCarr.setCre_id(cre_id);
				   profileCarr.setUpd_id(upd_id);
	
				   profileMapper.insertProfileCarr(profileCarr);
			   }
			}		
		   
		   // 업무 경험 수정
		   profileMapper.deleteProfileTask(emp_no);
		   if(!StringUtil.isEmpty(user.getPrjt_nm())){
				String[] task1 = user.getPrjt_nm().toString().split(",");
				String[] task2 = user.getRltd_com().toString().split(",");
				String[] task3 = user.getDev_strt_dt().toString().split(",");
				String[] task4 = user.getDev_end_dt().toString().split(",");
				String[] task5 = user.getMy_role().toString().split(",");
				String[] task6 = user.getUsed_mdel().toString().split(",");
				String[] task7 = user.getUsed_os().toString().split(",");
				String[] task8 = user.getUsed_lang().toString().split(",");
				String[] task9 = user.getUsed_dbms().toString().split(",");
				String[] task10 = user.getUsed_dc().toString().split(",");
				
				User profileTask = new User(); 
				
				for(int j=0; j<task1.length; j++){
					profileTask = new User(); 
					profileTask.setEmp_no(emp_no);
					profileTask.setPrjt_nm(task1[j]);
					profileTask.setRltd_com(task2[j]);
					profileTask.setDev_strt_dt(task3[j]);
					profileTask.setDev_end_dt(task4[j]);
					profileTask.setMy_role(task5[j]);
					profileTask.setUsed_mdel(task6[j]);
					profileTask.setUsed_os(task7[j]);
					profileTask.setUsed_lang(task8[j]);
					profileTask.setUsed_dbms(task9[j]);
					profileTask.setUsed_dc(task10[j]);
					profileTask.setCre_id(cre_id);
					profileTask.setUpd_id(upd_id);
					
					profileMapper.insertProfileTask(profileTask);
				}
			}
		   
		   return "succ";
		   
	   }
	   catch (Exception e) {
			// TODO Auto-generated catch block
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			System.out.println("updateProfile : error");
			return "fail";
	   }
	   
   }
   
   // 0520 - 프로필 정보 히스토리 삽입
   @Transactional
   public String insertProfileHist(User user, MultipartFile file, HttpServletRequest request) throws Exception {
	   
		/*
		 * int fileId = fileMapper.selectFileId();
		 * 
		 * if(file.isEmpty() == false) { fileService.saveFile(file, request, fileId);
		 * user.setFile_id(fileId); }
		 */
		
		try {
			insertProfileUserHist(user);
		  	insertProfileComHist(user);
		   
		  	insertProfileEduHist(user);
		  	insertProfileCertHist(user);
		  	insertProfileCarrHist(user);
		  	insertProfileTaskHist(user);
			
			return "succ";
		}
		catch (Exception e) {
			// TODO Auto-generated catch block
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			System.out.println("insertProfileHist : error");
			return "fail";
		}
			   
   }
   
   // 0509 - 기본 정보 삽입
   public void insertProfileUserHist(User user) throws Exception {
	   profileMapper.insertProfileUserHist(user);
   }
   
   // 0520 - 사내 정보 삽입
   public void insertProfileComHist(User user) throws Exception {
	   profileMapper.insertProfileComHist(user);
   }
   
   // 0509 - 학력 정보 삽입
   public void insertProfileEduHist(User user) throws Exception {
	   String emp_no = user.getEmp_no().toString();
	   String cre_id = user.getCre_id().toString();
	   String upd_id = user.getUpd_id().toString();
	   	
	   // 빈값이 아니면 배열로 받아서 insert (기존 데이터는 다 지우고 시작)
	   if(!StringUtil.isEmpty(user.getSchl_nm())){
		   String[] edu1 = user.getSchl_nm().toString().split(",");
		   String[] edu2 = user.getEdu_strt_dt().toString().split(",");
		   String[] edu3 = user.getEdu_end_dt().toString().split(",");
		   String[] edu4 = user.getMajor().toString().split(",");
		   String[] edu5 = user.getEdu_remark().toString().split(",");
			
		   User profileEdu = new User(); 
		   // profileMapper.deleteProfileEdu(emp_no);
			
		   for(int i=0; i <edu1.length; i++){
				profileEdu = new User(); 
				profileEdu.setEmp_no(emp_no);
				profileEdu.setSchl_nm(edu1[i]);
				profileEdu.setEdu_strt_dt(edu2[i]);
				profileEdu.setEdu_end_dt(edu3[i]);
				profileEdu.setMajor(edu4[i]);
				profileEdu.setEdu_remark(edu5[i]);
				profileEdu.setCre_id(cre_id);
				profileEdu.setUpd_id(upd_id);
				
				profileMapper.insertProfileEduHist(profileEdu);
		   }
		}		
   }
   
   // 0509 - 자격증 정보 삽입
   public void insertProfileCertHist(User user) throws Exception {
	   String emp_no = user.getEmp_no().toString();
	   String cre_id = user.getCre_id().toString();
	   String upd_id = user.getUpd_id().toString();
	   
	   if(!StringUtil.isEmpty(user.getCert_nm())){
		   String[] cert1 = user.getCert_nm().toString().split(",");
		   String[] cert2 = user.getCert_remark().toString().split(",");
		   String[] cert3 = user.getGet_dt().toString().split(",");
			
		   User profileCert = new User(); 
		   // profileMapper.deleteProfileCert(emp_no);
			
		   for(int i=0; i <cert1.length; i++){
			   profileCert = new User(); 
			   profileCert.setEmp_no(emp_no);
			   profileCert.setCert_nm(cert1[i]);
			   profileCert.setCert_remark(cert2[i]);
			   profileCert.setGet_dt(cert3[i]);
			   profileCert.setCre_id(cre_id);
			   profileCert.setUpd_id(upd_id);
			   
			   profileMapper.insertProfileCertHist(profileCert);
		   }
		}		
   }

   // 0509 - 경력 정보 삽입
   public void insertProfileCarrHist(User user) throws Exception {
	   String emp_no = user.getEmp_no().toString();
	   String cre_id = user.getCre_id().toString();
	   String upd_id = user.getUpd_id().toString();
	   
	   if(!StringUtil.isEmpty(user.getCarr_com_nm())){
		   String[] carr1 = user.getCarr_com_nm().toString().split(",");
		   String[] carr2 = user.getCarr_strt_dt().toString().split(",");
		   String[] carr3 = user.getCarr_end_dt().toString().split(",");
		   String[] carr4 = user.getCarr_rank_nm().toString().split(",");
		   String[] carr5 = user.getWork().toString().split(",");

		   User profileCarr = new User(); 
		   // profileMapper.deleteProfileCarr(emp_no);
			
		   for(int i=0; i <carr1.length; i++){
			   profileCarr = new User(); 
			   profileCarr.setEmp_no(emp_no);
			   profileCarr.setCarr_com_nm(carr1[i]);
			   profileCarr.setCarr_strt_dt(carr2[i]);
			   profileCarr.setCarr_end_dt(carr3[i]);
			   profileCarr.setCarr_rank_nm(carr4[i]);
			   profileCarr.setWork(carr5[i]);
			   profileCarr.setCre_id(cre_id);
			   profileCarr.setUpd_id(upd_id);

			   profileMapper.insertProfileCarrHist(profileCarr);
		   }
		}		
   }
   
   // 0509 - 업무 경험 정보 삽입
   public void insertProfileTaskHist(User user) throws Exception {
	   String emp_no = user.getEmp_no().toString();
	   String cre_id = user.getCre_id().toString();
	   String upd_id = user.getUpd_id().toString();
	   
	   if(!StringUtil.isEmpty(user.getPrjt_nm())){
			String[] task1 = user.getPrjt_nm().toString().split(",");
			String[] task2 = user.getRltd_com().toString().split(",");
			String[] task3 = user.getDev_strt_dt().toString().split(",");
			String[] task4 = user.getDev_end_dt().toString().split(",");
			String[] task5 = user.getMy_role().toString().split(",");
			String[] task6 = user.getUsed_mdel().toString().split(",");
			String[] task7 = user.getUsed_os().toString().split(",");
			String[] task8 = user.getUsed_lang().toString().split(",");
			String[] task9 = user.getUsed_dbms().toString().split(",");
			String[] task10 = user.getUsed_dc().toString().split(",");
			
			User profileTask = new User(); 
			// profileMapper.deleteProfileTask(emp_no);
			
			for(int j=0; j<task1.length; j++){
				profileTask = new User(); 
				profileTask.setEmp_no(emp_no);
				profileTask.setPrjt_nm(task1[j]);
				profileTask.setRltd_com(task2[j]);
				profileTask.setDev_strt_dt(task3[j]);
				profileTask.setDev_end_dt(task4[j]);
				profileTask.setMy_role(task5[j]);
				profileTask.setUsed_mdel(task6[j]);
				profileTask.setUsed_os(task7[j]);
				profileTask.setUsed_lang(task8[j]);
				profileTask.setUsed_dbms(task9[j]);
				profileTask.setUsed_dc(task10[j]);
				profileTask.setCre_id(cre_id);
				profileTask.setUpd_id(upd_id);
				
				profileMapper.insertProfileTaskHist(profileTask);
			}
		}
	   
   }
	  
   // 0510 - 목록에서 직원 감추기
   public void hideUser(String emp_no) throws Exception {
		try {
		   profileMapper.hideUser(emp_no);
		}
		catch (Exception e) {
			// TODO Auto-generated catch block
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			System.out.println("insertProfileHist : error");
		}
   }
   	
   // 0513 - 엑셀 다운로드
   public List<User> getProfileListExcel(User user){
	   Locale locale = LocaleContextHolder.getLocale();
	   return profileMapper.getProfileListExcel(user);
   }

   // 0522 - 프로필 이력 엑셀 다운로드
   public List<User> getProfileHistListExcel(User user){
	   Locale locale = LocaleContextHolder.getLocale();
	   return profileMapper.getProfileHistListExcel(user);
   }
   
}