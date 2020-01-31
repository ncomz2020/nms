package com.ncomz.nms.service.admin.common.file;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ncomz.nms.dao.admin.common.file.FileMapper;
import com.ncomz.nms.domain.admin.common.FileInfo;
import com.ncomz.nms.domain.admin.user.User;
import com.ncomz.nms.utility.StringUtil;


@Service
public class FileService {
   
   @Value("#{configuration['filePath']}")
   private String filePath;
   
   @Autowired
      private FileMapper fileMapper;
   
   public FileInfo saveFile(MultipartFile file, HttpServletRequest request, int fileId ) throws Exception {
      try {
//         String root_path = request.getSession().getServletContext().getRealPath("/");
         String root_path = "/home";
         String ori_filename = file.getOriginalFilename();
         String phy_filename = StringUtil.getUUID() + "." + StringUtil.getFileExt(ori_filename);
          
         
         File f = new File(root_path + filePath);
         
         if(!f.exists()) {
            f.mkdirs();
         }
         
         File f01 = new File(root_path + filePath  + phy_filename);
         
         try {
               file.transferTo(f01);
            } catch (Exception e) {
               System.out.println(e.getMessage());
          }  
         
         
         FileInfo fileInfo = new FileInfo();
         fileInfo.setOri_file_nm(ori_filename);
         fileInfo.setPhy_file_nm(phy_filename);
         fileInfo.setFile_uri(filePath  + phy_filename);
         fileInfo.setFile_id(fileId);
         
         if (fileMapper.insertFile(fileInfo) <= 0) {
            throw new Exception("파일 정보를 데이터베이스에 저장하는 도중 오류가 발생하였습니다. 관리자에게 문의하세요.");
         }

         /*int nSubDir = Integer.parseInt(fileInfo.getFile_id()) / 100;
         String sSubDir = fileDirectoryPath + "/" + nSubDir + "/";
         File fSubDir = new File(sSubDir);
         if (!fSubDir.exists()) {
            fSubDir.mkdirs();
         }
         
         String sFilePath =sSubDir + fileInfo.getPhy_filename();
         File file = new File(sFilePath);
         multipartFile.transferTo(file);*/

         return fileInfo;
      } catch (Exception ex) {	
         ex.printStackTrace();
         throw new Exception(ex.getMessage());
      }
   }
   
   public String updateFile(MultipartFile file, HttpServletRequest request, User user ) throws Exception {
	   try {
//	         String root_path = request.getSession().getServletContext().getRealPath("/");
	         String root_path = "/home";
	         String ori_filename = file.getOriginalFilename();
	         String phy_filename = StringUtil.getUUID() + "." + StringUtil.getFileExt(ori_filename);
	          
	         
	         File f = new File(root_path + filePath);
	         
	         if(!f.exists()) {
	            f.mkdirs();
	         }
	         
	         File f01 = new File(root_path + filePath  + phy_filename);
	         
	         try {
	               file.transferTo(f01);
	            } catch (Exception e) {
	               System.out.println(e.getMessage());
	          }  
	         
	         
	         FileInfo fileInfo = new FileInfo();
	         
	         fileInfo.setOri_file_nm(ori_filename);
	         fileInfo.setPhy_file_nm(phy_filename);
	         fileInfo.setFile_uri(filePath  + phy_filename);
	         fileInfo.setFile_id(user.getFile_id());
	         
	         if (fileMapper.updateFile(fileInfo) <= 0) {
	            throw new Exception("파일 정보를 데이터베이스에 저장하는 도중 오류가 발생하였습니다. 관리자에게 문의하세요.");
	         }
	         
	      } catch (Exception ex) {	
	         ex.printStackTrace();
	         throw new Exception(ex.getMessage());
	      }
	   
	   return "SUCC";
   }
   
}