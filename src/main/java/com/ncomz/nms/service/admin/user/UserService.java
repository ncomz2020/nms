package com.ncomz.nms.service.admin.user;

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
import com.ncomz.nms.dao.admin.user.UserMapper;
import com.ncomz.nms.domain.admin.user.User;
import com.ncomz.nms.service.admin.common.file.FileService;
import com.ncomz.nms.utility.SHA256Util;

@Service
public class UserService {
   
   private Logger logger = Logger.getLogger(this.getClass());
   
   @Autowired
   private UserMapper UserMapper;
   
   @Autowired
   private FileMapper fileMapper;
   
   @Autowired
   private FileService fileService;
   
   public List<User> getUserList(User user){
      Locale locale = LocaleContextHolder.getLocale();
      List<User> userList = UserMapper.getUserList(user);
      User userInfo = new User();

	  if(locale.getLanguage().equals("en")) {
		  for (int i=0; i<userList.size(); i++) {
			  userInfo = userList.get(i);
			  
			  userInfo.setSrt_no(userInfo.getSrt_no_en());
    		  userInfo.setExpln(userInfo.getExpln_en());
    		  userInfo.setDept_cd(userInfo.getDept_cd_en());
    		  userInfo.setTeam_cd(userInfo.getTeam_cd_en());
    		  userInfo.setRank_cd(userInfo.getRank_cd_en());
    		  userInfo.setPsit_cd(userInfo.getPsit_cd_en());
    		  userInfo.setStep_cd(userInfo.getStep_cd_en());
    	  }
      }
      
      return userList;
   }
   
   public int getUserListCount(User user) {
      return UserMapper.getUserListCount(user);
   }
   
   /*�쉶�썝 �깉�눜泥섎━*/
	@Transactional
	public String deleteUser(String emp_no){
		
		try {
			if(UserMapper.deleteUser(String.format("%05d",Integer.parseInt(emp_no))) == 1){
				return "success";
			}
			else{
				System.out.println("AAAAAAAAAAAAAer");
				return "error";
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			System.out.println("AAAAAAAAAAAAAerror");
			return "error";
		}	
	}
	
	public String newEmpNo() {
		return UserMapper.newEmpNo();
	}
	
	public String updateUseYnAction(User user) {
		try {
			UserMapper.updateUseYnAction(user);
		} catch (Exception e) {
			return "FAIL";
		}
		
		return "succ";
	}
	
	@Transactional
	public String insertInfo(User user, MultipartFile file , HttpServletRequest request)  throws Exception {
		String emp_no = user.getEmp_no().toString();
		
		if(UserMapper.chkUserEmpNo(emp_no) > 0) {
			return "FAIL";
		}else if(UserMapper.chkComEmpNo(emp_no) > 0) {			
			return "FAIL";
		}
		
		int fileId = fileMapper.selectFileId();
		
		try {
			if(file.isEmpty() == false) {
				fileService.saveFile(file, request, fileId);
				user.setFile_id(fileId);
			}
		} catch (NullPointerException e) {
			System.out.println("no 사진");
		}
		
		user.setPwd_tobe(SHA256Util.getEncrypt(user.getEmp_no()));
		UserMapper.insertUserInfo(user);
		UserMapper.insertComInfo(user);
		
		// �꽦怨듭떆 
		return "succ";
	}
	
	@Transactional
	public String updateInfo(User user, MultipartFile file , HttpServletRequest request)  throws Exception {
		String emp_no = user.getEmp_no().toString();
		
		if(file != null) {
			fileService.updateFile(file, request, user );
		}
		
		UserMapper.updateUserInfo(user);
		UserMapper.updateComInfo(user);
		
		// �꽦怨듭떆 
		return "succ";
	}
	
	public Map<String, Object> getUserInfo(User user){
		Locale locale = LocaleContextHolder.getLocale();
		
		Map<String,Object> userInfo = new HashMap<String,Object>();
		
		userInfo.put("userInfo",UserMapper.getUserInfo(user));
		userInfo.put("userEdu",UserMapper.getUserEdu(user));
		userInfo.put("userCert",UserMapper.getUserCert(user));
		userInfo.put("userCarr",UserMapper.getUserCarr(user));
		userInfo.put("userTask",UserMapper.getUserTask(user));
		
		return userInfo;
	}
	
	@Transactional
	public String userUpdate(User user){
		String resultMsg="";
		
		
		
		return resultMsg;
	}
	
  /**
    * �뿊�� �떎�슫濡쒕뱶
    * @param user
    * @return
    */
   public List<User> getUserListExcel(User user){
      
	   Locale locale = LocaleContextHolder.getLocale();
	   
	   return UserMapper.getUserListExcel(user);
   }

   /**
    * wsPark
    * 
    * @param user
    * @return String
    */
	public String updatePasswordAction(User user) {
		if (!user.getPwd_asis().equals(UserMapper.getUserPassword(user))) 
			return "FAIL";
		
		UserMapper.updateUserPassword(user);
		
		return "succ";
	}


}