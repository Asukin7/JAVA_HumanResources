<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>人力资源系统</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript">

		var url;

		function openTab(text,url,iconCls){
			if($("#tabs").tabs("exists",text)){
				$("#tabs").tabs("select",text);
			}else{
				var content="<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%' src='${pageContext.request.contextPath}/admin/"+url+"'></iframe>";
				$("#tabs").tabs("add",{
					title:text,
					iconCls:iconCls,
					closable:true,
					content:content
				});
			}
		}

		/**打开修改密码对话框*/
		function openPasswordModifyDialog(){
			$("#dlg").dialog("open").dialog("setTitle","修改密码");
			url="${pageContext.request.contextPath}/hrAccount/modifyPassword.do";
		}

		/**修改密码*/
		function modifyPassword(){
			$("#fm").form("submit",{
				url:url,
				onSubmit:function(){
					var newPassword = $("#newPassword").val();
					var newPassword2 = $("#newPassword2").val();
					if(!$(this).form("validate")){
						return false;
					}
					if(newPassword.length<6){
						$.messager.alert("系统提示","密码位数不能少于6位");
						return false;
					}
					if(newPassword!=newPassword2){
						$.messager.alert("系统提示","两次密码输入不一致");
						return false;
					}
					return true;
				},
				success:function(result){
					var result = eval('('+result+')');
					if(result.success){
						$.messager.alert("系统提示","密码修改成功，请重新登录");
						window.location.href="${pageContext.request.contextPath}/hrAccount/logout.do";
					}else{
						$.messager.alert("系统提示","密码修改失败");
						return;
					}
				}
			});
		}

		/**清空俩新密码*/
		function resetValue(){
			$("#newPassword").val("");
			$("#newPassword2").val("");
		}

		/**关闭密码修改对话框*/
		function closePasswordModifyDialog(){
			resetValue();
			$("#dlg").dialog("close");
		}

		/**退出*/
		function logout(){
			$.messager.confirm("系统提示","您确定要退出系统吗？",function(r){
				if(r){
					window.location.href="${pageContext.request.contextPath}/hrAccount/logout.do";
				}
			});
		}

	</script>
</head>

<body class="easyui-layout">

<div region="north" style="height: 60px;background-color: #E0ECFF;overflow:hidden">
	<table style="padding: 5px" width="100%">
		<tr>
			<td valign="middle" align="left" width="50%">
				<h2><strong>人力资源系统</strong></h2>
			</td>
			<td valign="middle" align="right" width="50%">
				<a href="javascript:openPasswordModifyDialog()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-modifyPassword'">修改密码</a>
				<a href="javascript:logout()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-exit'">退出</a>
			</td>
		</tr>
	</table>
</div>

<div region="center">
	<div class="easyui-tabs" fit="true" border="false" id="tabs">
		<div title="首页" data-options="iconCls:'icon-home'">
			<div align="center" style="padding-top: 100px"><font color="red" size="10">欢迎使用</font></div>
		</div>
	</div>
</div>

<div region="west" style="width: 200px" title="导航菜单" split="true">
	<div class="easyui-accordion" data-options="fit:true,border:false">
		<div title="档案合同管理" style="padding:10px;">
			<a href="javascript:openTab('档案管理','files/HrFiles.jsp')" class="easyui-linkbutton" data-options="plain:true" style="width: 150px;">档案管理</a>
			<a href="javascript:openTab('合同管理','files/HrContract.jsp')" class="easyui-linkbutton" data-options="plain:true" style="width: 150px;">合同管理</a>
		</div>
		<div title="部门岗位管理" style="padding:10px;">
			<a href="javascript:openTab('部门管理','post/HrDepartment.jsp')" class="easyui-linkbutton" data-options="plain:true" style="width: 150px;">部门管理</a>
			<a href="javascript:openTab('岗位管理','post/HrPost.jsp')" class="easyui-linkbutton" data-options="plain:true" style="width: 150px;">岗位管理</a>
			<a href="javascript:openTab('调动管理','post/HrPostTransfer.jsp')" class="easyui-linkbutton" data-options="plain:true" style="width: 150px;">调动管理</a>
		</div>
		<div title="奖金工资管理" style="padding:10px;">
			<a href="javascript:openTab('部门奖金管理','wages/HrDepartmentBonus.jsp')" class="easyui-linkbutton" data-options="plain:true" style="width: 150px;">部门奖金管理</a>
			<a href="javascript:openTab('员工工资管理','wages/HrWages.jsp')" class="easyui-linkbutton" data-options="plain:true" style="width: 150px;">员工工资管理</a>
		</div>
		<div title="培训技能管理" style="padding:10px;">
			<a href="javascript:openTab('培训方案管理','train/HrTrainingScheme.jsp')" class="easyui-linkbutton" data-options="plain:true" style="width: 150px;">培训方案管理</a>
			<a href="javascript:openTab('技能鉴定管理','train/HrSkillAppraisal.jsp')" class="easyui-linkbutton" data-options="plain:true" style="width: 150px;">技能鉴定管理</a>
		</div>
		<div title="系统账号管理" style="padding:10px">
			<a href="javascript:openTab('系统账号管理','admin/HrAccount.jsp')" class="easyui-linkbutton" data-options="plain:true" style="width: 150px;">系统账号管理</a>
		</div>
	</div>
</div>

<div region="south" style="height: 1px;padding: 1px" align="center"></div>

<div id="dlg" class="easyui-dialog" style="width:400px;height:200px;padding:10px 20px" closed="true" buttons="#dlg-buttons">
	<form id="fm" method="post">
		<table cellspacing="8px">
			<tr>
				<td>账号：</td>
				<td><input type="text" id="account" name="account" readonly="readonly" value="${currentUser.account}" style="width:200px"/></td>
			</tr>
			<tr>
				<td>新密码：</td>
				<td><input type="password" id="newPassword" name="newPassword" clas="easyui-validatebox" required="true" style="width:200px" maxlength="20"/></td>
			</tr>
			<tr>
				<td>确认新密码：</td>
				<td><input type="password" id="newPassword2" name="newPassword2" clas="easyui-validatebox" required="true" style="width:200px" maxlength="20"/></td>
			</tr>
		</table>
	</form>
</div>
<div id="dlg-buttons">
	<a href="javascript:modifyPassword()" class="easyui-linkbutton" iconCls="icon-ok">修改</a>
	<a href="javascript:closePasswordModifyDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>

</body>

</html>
