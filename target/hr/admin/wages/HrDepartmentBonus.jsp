<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>部门奖金管理</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/JsonExportExcel-master/dist/JsonExportExcel.min.js"></script>
    <script type="text/javascript">

        var searchHrJson;

        /**搜索*/
        function searchHr(value,name){
            var str = "{ \"" + name + "\":\"" + value + "\" }";
            searchHrJson = eval ("(" + str + ")");
            $("#dg").datagrid('load',searchHrJson);
        }

        function print(){
            var resultList;
            $.ajax({
                url:"${pageContext.request.contextPath}/hrDepartmentBonus/list.do",
                type:"post",
                data:searchHrJson,
                async:false,//是否异步
                success:function(result){
                    result = eval("("+result+")");
                    resultList = result;
                }
            });
            if(resultList != null){//如果返回数据不为空
                var sheetData = new Array();
                for(var i=0;i<resultList.total;i++){
                    var temp = new Array();
                    temp[0] = resultList.rows[i].id;
                    temp[1] = resultList.rows[i].hrDepartment.id;
                    temp[2] = resultList.rows[i].name;
                    temp[3] = resultList.rows[i].bonus;
                    temp[4] = resultList.rows[i].number;
                    temp[5] = resultList.rows[i].date;
                    sheetData[i]=temp;
                }
                var date = new Date();
                var fileName = "部门奖金汇总表"+date.getFullYear()+"_"+date.getMonth()+"_"+date.getDay()+"_"+date.getHours()+"_"+date.getMinutes()+"_"+date.getSeconds();
                var option={};
                option.fileName = fileName;
                option.datas=[
                    {
                        sheetData:sheetData,
                        sheetHeader:['编号','部门名称','奖金名称','奖金','人数','日期'],
                        //sheetStyle:[]
                    }
                ];
                var toExcel=new ExportJsonExcel(option);
                toExcel.saveExcel();
            } else {
                $.messager.alert("系统提示","错误！请重试...");
            }
        }

        /**格式化限制数字文本框输入，只能数字或者两位小数*/
        function format_input_num(obj){
            // 清除"数字"和"."以外的字符
            obj.value = obj.value.replace(/[^\d.]/g,"");
            // 验证第一个字符是数字
            obj.value = obj.value.replace(/^\./g,"");
            // 只保留第一个, 清除多余的
            obj.value = obj.value.replace(/\.{2,}/g,".");
            obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
            // 只能输入两个小数
            obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');
        }

        /**返回该行的部门名称*/
        function formatHrDepartmentName(val,row){
            return val.name;
        }

        /**下拉框创建时加载数据*/
        $("#hrDepartment").ready(function(){
            loadHrDepartment();
        })

        /**加载下拉框数据*/
        function loadHrDepartment() {
            $.ajax({
                url:"${pageContext.request.contextPath}/hrDepartment/countList.do",
                type:"post",
                success:function(result){
                    result = eval("("+result+")");
                    if(result.rows.length > 0){//有数据
                        //定义一个变量存放数据
                        var comboboxData = [{ 'text': '', 'value': '' }];
                        //循环，向变量里添加数据
                        for(var i = 0; i < result.rows.length; i++){
                            comboboxData.push({ "text": result.rows[i].name, "value": result.rows[i].id });//text为元素的文本内容，value为该元素的value值
                        }
                        //在下拉框中加载变量中的数据
                        $('#hrDepartment').combobox("loadData", comboboxData);
                    }
                },
                error:function(){}
            });
        }

        var url;

        /**弹出添加部门奖金信息对话框*/
        function openHrDepartmentBonusAddDialog(){
            resetValue();
            $("#dlg").dialog("open").dialog("setTitle","添加部门奖金信息");
            url="${pageContext.request.contextPath}/hrDepartmentBonus/save.do";
        }

        /**弹出修改部门奖金信息对话框*/
        function openHrDepartmentBonusModifyDialog(){
            resetValue();
            var selectedRows=$("#dg").datagrid("getSelections");
            if(selectedRows.length!=1){
                $.messager.alert("系统提示","请选择一条要编辑的数据");
                return;
            }
            var row = selectedRows[0];
            $("#dlg").dialog("open").dialog("setTitle","修改部门奖金信息");
            $("#fm").form("load",row);
            $("#hrDepartment").combobox("setValue",row.hrDepartment.id);
            url="${pageContext.request.contextPath}/hrDepartmentBonus/save.do?id="+row.id;
        }

        /**重置弹出的对话框*/
        function resetValue(){
            loadHrDepartment();
            $("#name").val("");
            $("#bonus").val("");
            $("#number").val("");
            $("#date").val("");
        }

        /**关闭对话框*/
        function closeHrDepartmentBonusDialog(){
            $("#dlg").dialog("close");
        }

        /**保存部门奖金信息*/
        function saveHrDepartmentBonus(){
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

        /**删除部门奖金信息*/
        function deleteHrDepartmentBonus(){
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
                    $.post("${pageContext.request.contextPath}/hrDepartmentBonus/delete.do",{ids:ids},function(result){
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
<table id="dg" title="部门奖金管理" class="easyui-datagrid" fitcolumns="true" pagination="true" rownumbers="true"
       url="${pageContext.request.contextPath}/hrDepartmentBonus/list.do" fit="true" toolbar="#tb">
    <thead>
    <tr>
        <th field="cb" checkbox="true" align="center"></th>
        <th field="id" width="20" align="center">编号</th>
        <th field="hrDepartment" width="60" align="center" formatter="formatHrDepartmentName">部门名称</th>
        <th field="name" width="60" align="center">奖金名称</th>
        <th field="bonus" width="60" align="center">奖金</th>
        <th field="number" width="60" align="center">人数</th>
        <th field="date" width="60" align="center">日期</th>
    </tr>
    </thead>
</table>

<div id="tb">
    <div>
        <a href="javascript:openHrDepartmentBonusAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
        <a href="javascript:openHrDepartmentBonusModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
        <a href="javascript:deleteHrDepartmentBonus()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
        <a href="javascript:print()" class="easyui-linkbutton" iconCls="icon-print" plain="true">打印部门奖金汇总表</a>
    </div>
    <input id="ss" class="easyui-searchbox" style="width:260px"
           data-options="searcher:searchHr,prompt:'Please Input Value',menu:'#mm'"/>
    <div id="mm" style="width:160px">
        <div data-options="name:'id'">编号</div>
        <div data-options="name:'name'">奖金名称</div>
        <div data-options="name:'dateStr'">日期</div>
    </div>
</div>

<div id="dlg" class="easyui-dialog" style="width:600px;height:260px;padding: 10px 20px"
     closed="true" buttons="#dlg-buttons">
    <form id="fm" method="post">
        <table cellspacing="8px">
            <tr>
                <td>部门：</td>
                <td>
                    <select class="easyui-combobox" id="hrDepartment" name="hrDepartment.id" style="width: 150px;" editable="false" panelHeight="auto" required="true"></select>
                </td>
            </tr>
            <tr>
                <td>奖金名称：</td>
                <td><input type="text" id="name" name="name" class="easyui-validatebox" required="true" maxlength="32"/></td>
            </tr>
            <tr>
                <td>奖金：</td>
                <td><input type="text" id="bonus" name="bonus" class="easyui-validatebox" required="true" maxlength="11" onkeyup="format_input_num(this)"/></td>
                <td>人数：</td>
                <td><input type="text" id="number" name="number" class="easyui-validatebox" required="true" maxlength="11" onkeyup="value=value.replace(/[^\d]$/,'')"/></td>
            </tr>
            <tr>
                <td>日期：</td>
                <td><input type="date" id="date" name="date" class="easyui-validatebox" required="true"/></td>
            </tr>
        </table>
    </form>
</div>

<div id="dlg-buttons">
    <a href="javascript:saveHrDepartmentBonus()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
    <a href="javascript:closeHrDepartmentBonusDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
</body>

</html>
