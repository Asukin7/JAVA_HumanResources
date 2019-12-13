<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>部门管理</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript">

        var url;

        /**弹出添加部门信息对话框*/
        function openHrDepartmentAddDialog(){
            $("#dlg").dialog("open").dialog("setTitle","添加部门信息");
            url="${pageContext.request.contextPath}/hrDepartment/save.do";
        }

        /**弹出修改部门信息对话框*/
        function openHrDepartmentModifyDialog(){
            var selectedRows=$("#dg").datagrid("getSelections");
            if(selectedRows.length!=1){
                $.messager.alert("系统提示","请选择一条要编辑的数据");
                return;
            }
            var row = selectedRows[0];
            $("#dlg").dialog("open").dialog("setTitle","修改部门信息");
            $("#fm").form("load",row);
            url="${pageContext.request.contextPath}/hrDepartment/save.do?id="+row.id;
        }

        /**重置弹出的对话框*/
        function resetValue(){
            $("#name").val("");
        }

        /**关闭对话框*/
        function closeHrDepartmentDialog(){
            $("#dlg").dialog("close");
            resetValue();
        }

        /**保存部门信息*/
        function saveHrDepartment(){
            $("#fm").form("submit",{
                url:url,
                onSubmit:function(){
                    return $(this).form("validate");
                },
                success:function(result){
                    var result=eval('('+result+')');
                    if(result.success){
                        $.messager.alert("系统提示","保存成功");
                        resetValue();
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

        /**删除部门信息*/
        function deleteHrDepartment(){
            var selectedRows=$("#dg").datagrid("getSelections");
            if(selectedRows.length==0){
                $.messager.alert("系统提示","请至少选择一条要删除的数据");
                return;
            }
            var strIds=[];
            for(var i=0;i<selectedRows.length;i++){
                strIds.push(selectedRows[i].id);
            }
            var ids=strIds.join(",");
            $.messager.confirm("系统提示","您确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
                if(r){
                    $.post("${pageContext.request.contextPath}/hrDepartment/delete.do",{ids:ids},function(result){
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
<table id="dg" title="部门管理" class="easyui-datagrid" fitcolumns="true" pagination="true" rownumbers="true"
       url="${pageContext.request.contextPath}/hrDepartment/list.do" fit="true" toolbar="#tb">
    <thead>
    <tr>
        <th field="cb" checkbox="true" align="center"></th>
        <th field="id" width="20" align="center">编号</th>
        <th field="name" width="60" align="center">部门名称</th>
    </tr>
    </thead>
</table>

<div id="tb">
    <a href="javascript:openHrDepartmentAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
    <a href="javascript:openHrDepartmentModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
    <a href="javascript:deleteHrDepartment()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
</div>

<div id="dlg" class="easyui-dialog" style="width:500px;height:180px;padding: 10px 20px"
     closed="true" buttons="#dlg-buttons">
    <form id="fm" method="post">
        <table cellspacing="8px">
            <tr>
                <td>部门名称：</td>
                <td><input type="text" id="name" name="name" class="easyui-validatebox" required="true" maxlength="32"/></td>
            </tr>
        </table>
    </form>
</div>

<div id="dlg-buttons">
    <a href="javascript:saveHrDepartment()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
    <a href="javascript:closeHrDepartmentDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
</body>

</html>
