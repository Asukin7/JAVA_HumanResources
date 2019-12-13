<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>账号管理</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript">

        function formatQX(val,row){
            if(val == "1") return "开";
            return "关";
        }

        var url;

        /**弹出添加账号信息对话框*/
        function openHrAccountAddDialog(){
            resetValue();
            $("#dlg").dialog("open").dialog("setTitle","添加账号信息");
            $("#account").attr("readonly",false);
            url="${pageContext.request.contextPath}/hrAccount/add.do";
        }

        /**弹出修改账号信息对话框*/
        function openHrAccountModifyDialog(){
            resetValue();
            var selectedRows=$("#dg").datagrid("getSelections");
            if(selectedRows.length!=1){
                $.messager.alert("系统提示","请选择一条要编辑的数据");
                return;
            }
            var row = selectedRows[0];
            $("#dlg").dialog("open").dialog("setTitle","修改账号信息");
            $("#fm").form("load",row);
            $("#account").attr("readonly",true);
            $("#admin").combobox("setValue",row.admin);
            $("#files").combobox("setValue",row.files);
            $("#post").combobox("setValue",row.post);
            $("#wages").combobox("setValue",row.wages);
            $("#train").combobox("setValue",row.train);
            url="${pageContext.request.contextPath}/hrAccount/update.do";
        }

        /**重置弹出的对话框*/
        function resetValue(){
            $("#account").val("");
            $("#filesId").val("");
            $("#admin").combobox("setValue",-1);
            $("#files").combobox("setValue",-1);
            $("#post").combobox("setValue",-1);
            $("#wages").combobox("setValue",-1);
            $("#train").combobox("setValue",-1);
        }

        /**关闭对话框*/
        function closeHrAccountDialog(){
            $("#dlg").dialog("close");
        }

        /**保存账号信息*/
        function saveHrAccount(){
            $("#fm").form("submit",{
                url:url,
                onSubmit:function(){
                    return $(this).form("validate");
                },
                success:function(result){
                    var result=eval('('+result+')');
                    if(result.success){
                        $.messager.alert("系统提示","保存成功");
                        //关闭对话框
                        $("#dlg").dialog("close");
                        //刷新查询结果
                        $("#dg").datagrid("reload");
                    }else{
                        $.messager.alert("系统提示","保存失败");
                        return;
                    }
                }
            });
        }

        /**删除账号信息*/
        function deleteHrAccount(){
            var selectedRows=$("#dg").datagrid("getSelections");
            if(selectedRows.length==0){
                $.messager.alert("系统提示","请至少选择一条要删除的数据");
                return;
            }
            var strIds=[];
            for(var i=0;i<selectedRows.length;i++){
                strIds.push(selectedRows[i].account);
            }
            var ids=strIds.join(",");
            $.messager.confirm("系统提示","您确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
                if(r){
                    $.post("${pageContext.request.contextPath}/hrAccount/delete.do",{ids:ids},function(result){
                        if(result.success){
                            if(result.exist){
                                $.messager.alert("系统提示",result.exist);
                            }else{
                                $.messager.alert("系统提示","数据已成功删除");
                            }
                            $("#dg").datagrid("reload");
                        }else{
                            $.messager.alert("系统提示","数据删除失败");
                        }
                    },"json");
                }
            });
        }

    </script>
</head>

<body style="margin: 10px">
<table id="dg" title="账号管理" class="easyui-datagrid" fitcolumns="true" pagination="true" rownumbers="true"
       url="${pageContext.request.contextPath}/hrAccount/list.do" fit="true" toolbar="#tb">
    <thead>
    <tr>
        <th field="cb" checkbox="true" align="center"></th>
        <th field="account" width="20" align="center">账号</th>
        <th field="filesId" width="60" align="center">档案编号</th>
        <th field="admin" width="60" align="center" formatter="formatQX">系统账号管理权限</th>
        <th field="files" width="60" align="center" formatter="formatQX">档案合同管理权限</th>
        <th field="post" width="60" align="center" formatter="formatQX">部门岗位管理权限</th>
        <th field="wages" width="60" align="center" formatter="formatQX">奖金工资管理权限</th>
        <th field="train" width="60" align="center" formatter="formatQX">培训技能管理权限</th>
    </tr>
    </thead>
</table>

<div id="tb">
    <a href="javascript:openHrAccountAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
    <a href="javascript:openHrAccountModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
    <a href="javascript:deleteHrAccount()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
</div>

<div id="dlg" class="easyui-dialog" style="width:600px;height:300px;padding: 10px 20px"
     closed="true" buttons="#dlg-buttons">
    <form id="fm" method="post">
        <table cellspacing="8px">
            <tr>
                <td>账号：</td>
                <td><input type="text" id="account" name="account" class="easyui-validatebox" required="true" maxlength="11"/></td>
                <td>档案编号：</td>
                <td><input type="text" id="filesId" name="filesId" class="easyui-validatebox" required="true" maxlength="11"/></td>
            </tr>
            <tr>
                <td>系统账号管理权限：</td>
                <td><select class="easyui-combobox" id="admin" name="admin" style="width: 150px;" editable="false" panelHeight="auto" required="true">
                    <option value="-1">关</option><option value="1">开</option></select>
                </td>
            </tr>
            <tr>
                <td>档案合同管理权限：</td>
                <td><select class="easyui-combobox" id="files" name="files" style="width: 150px;" editable="false" panelHeight="auto" required="true">
                    <option value="-1">关</option><option value="1">开</option></select>
                </td>
                <td>部门岗位管理权限：</td>
                <td><select class="easyui-combobox" id="post" name="post" style="width: 150px;" editable="false" panelHeight="auto" required="true">
                    <option value="-1">关</option><option value="1">开</option></select>
                </td>
            </tr>
            <tr>
                <td>奖金工资管理权限：</td>
                <td><select class="easyui-combobox" id="wages" name="wages" style="width: 150px;" editable="false" panelHeight="auto" required="true">
                    <option value="-1">关</option><option value="1">开</option></select>
                </td>
                <td>培训技能管理权限：</td>
                <td><select class="easyui-combobox" id="train" name="train" style="width: 150px;" editable="false" panelHeight="auto" required="true">
                    <option value="-1">关</option><option value="1">开</option></select>
                </td>
            </tr>
        </table>
    </form>
</div>

<div id="dlg-buttons">
    <a href="javascript:saveHrAccount()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
    <a href="javascript:closeHrAccountDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
</body>

</html>
