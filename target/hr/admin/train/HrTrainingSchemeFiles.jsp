<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>培训方案参与人员管理</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript">

        /**返回该行的档案ID*/
        function formatHrFilesId(val,row){
            return row.hrFiles.id;
        }

        /**返回该行的档案姓名*/
        function formatHrFilesName(val,row){
            return row.hrFiles.name;
        }

        var url;

        /**弹出添加培训方案参与人员信息对话框*/
        function openHrTrainingSchemeFilesAddDialog(){
            $("#dlg").dialog("open").dialog("setTitle","添加参与人员信息");
            url="${pageContext.request.contextPath}/hrTrainingSchemeFiles/save.do?hrTrainingSchemeID=${param.id}";
        }

        /**重置弹出的对话框*/
        function resetValue(){
            $("#hrFilesId").val("");
        }

        /**关闭对话框*/
        function closeHrTrainingSchemeFilesDialog(){
            $("#dlg").dialog("close");
            resetValue();
        }

        /**保存培训方案参与人员信息*/
        function saveHrTrainingSchemeFiles(){
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

        /**删除培训方案参与人员信息*/
        function deleteHrTrainingSchemeFiles(){
            var selectedRows=$("#dg").datagrid("getSelections");
            if(selectedRows.length!=1){
                $.messager.alert("系统提示","请选择一条要删除的数据");
                return;
            }
            var row=selectedRows[0];
            $.post("${pageContext.request.contextPath}/hrTrainingSchemeFiles/delete.do?hrTrainingSchemeID=${param.id}",{'hrFiles.id':row.hrFiles.id},function(result){
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

    </script>
</head>

<body style="margin: 10px">
<table id="dg" title="培训方案参与人员管理" class="easyui-datagrid" fitcolumns="true" pagination="true" rownumbers="true"
       url="${pageContext.request.contextPath}/hrTrainingSchemeFiles/list.do?hrTrainingSchemeID=${param.id}" fit="true" toolbar="#tb">
    <thead>
    <tr>
        <th field="cb" checkbox="true" align="center"></th>
        <th field="hrTrainingSchemeID" width="20" align="center">培训方案编号</th>
        <th field="hrFilesId" width="20" align="center" formatter="formatHrFilesId">档案编号</th>
        <th field="hrFilesName" width="20" align="center" formatter="formatHrFilesName">档案姓名</th>
    </tr>
    </thead>
</table>

<div id="tb">
    <a href="javascript:openHrTrainingSchemeFilesAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
    <a href="javascript:deleteHrTrainingSchemeFiles()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
</div>

<div id="dlg" class="easyui-dialog" style="width:500px;height:180px;padding: 10px 20px"
     closed="true" buttons="#dlg-buttons">
    <form id="fm" method="post">
        <table cellspacing="8px">
            <tr>
                <td>参与人员档案编号：</td>
                <td><input type="text" id="hrFilesId" name="hrFiles.id" class="easyui-validatebox" required="true" maxlength="32"/></td>
            </tr>
        </table>
    </form>
</div>

<div id="dlg-buttons">
    <a href="javascript:saveHrTrainingSchemeFiles()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
    <a href="javascript:closeHrTrainingSchemeFilesDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
</body>

</html>
