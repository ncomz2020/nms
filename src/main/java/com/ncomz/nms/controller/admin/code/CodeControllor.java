package com.ncomz.nms.controller.admin.code;

import javax.servlet.http.HttpServletRequest;
import com.ncomz.nms.domain.common.SessionUser;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ncomz.nms.domain.admin.code.Code;
import com.ncomz.nms.service.admin.code.CodeService;
import com.ncomz.nms.domain.Consts;


@Controller
@RequestMapping(value = "/admin/code")
public class CodeControllor {
   
   private static final Logger logger = LoggerFactory.getLogger(CodeControllor.class);
   private String thisUrl = "admin/code";
   
   @Autowired
   private CodeService codeService;
   
   
   /**
    * �듃由� 遺덈윭�삤湲�
    */
   @RequestMapping(value = "getTreeAction", method = RequestMethod.POST)
   public @ResponseBody Object getTreeAction() {
         
       return codeService.getTreeAction();
   }
   
   /**
    * �빐�떦 URL 遺덈윭�삤湲�
    * @return
    */
   @RequestMapping(value = "codeList", method = RequestMethod.POST)
   public String codelist() {
       return thisUrl + "/codeList";
   }

   /**
    * selectbox 遺덈윭�삤湲�
    * @param code
    * @return
    */
   @RequestMapping(value = "createComboBox", method = RequestMethod.POST)
   public @ResponseBody List<Code> createComboBox(Code code) {
      return codeService.createComboBox(code);
   }
	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public String insert(Model model, Code parent) {
		model.addAttribute("languageCodeList", codeService.getLanguageList());
		model.addAttribute("parent", codeService.getCode(parent));
		return thisUrl + "/insert";
	}
	
	@RequestMapping(value = "insertAction", method = RequestMethod.POST)
	public @ResponseBody String insertAction(Model model, Code code, HttpServletRequest request) {
		try {
			SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.SessionAttr.USER);
			code.setCreate_user_id(sessionUser.getUsr_id());
			model.addAttribute("result", codeService.insertAction(code));
			
			return "succ";
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String update(Model model, Code code, HttpServletRequest request) {
		SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.SessionAttr.USER);
		code.setUpdate_user_id(sessionUser.getUsr_id());
		//model.addAttribute("languageCodeList", codeService.getLanguageList());
		model.addAttribute("code", codeService.getCode(code));
		/*
		 * model.addAttribute("codeLanguageList",
		 * codeService.getCodeLanguageList(code));
		 */
		return thisUrl + "/update";
	}

	@RequestMapping(value = "updateAction", method = RequestMethod.POST)
	public void updateAction(Model model, Code code) {
		model.addAttribute("result", codeService.updateAction(code));
	}
	
	@RequestMapping(value = "moveAction", method = RequestMethod.POST)	
	public void moveAction(Model model, Code code) {
		model.addAttribute("result", codeService.moveAction(code));
	}
	
	@RequestMapping(value = "deleteAction", method = RequestMethod.POST)
	public void deleteAction(Model model, Code code) {
		model.addAttribute("result", codeService.deleteAction(code));
	}
	
	@RequestMapping(value = "updateUseYnAction", method = RequestMethod.POST)
	public void updateUseYnAction(Model model, Code code) {
		model.addAttribute("result", codeService.updateUseYnAction(code));
	}
}