<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>员工工资管理</title>
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
                url:"${pageContext.request.contextPath}/hrWages/list.do",
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
                    temp[1] = resultList.rows[i].hrFiles.id;
                    temp[2] = resultList.rows[i].hrDepartmentBonus.name;
                    temp[3] = resultList.rows[i].attendanceLength;
                    temp[4] = resultList.rows[i].basicWage;
                    temp[5] = resultList.rows[i].hourlyWage;
                    temp[6] = resultList.rows[i].personalBonus;
                    temp[7] = resultList.rows[i].totalWages;
                    temp[8] = resultList.rows[i].date;
                    sheetData[i]=temp;
                }
                var date = new Date();
                var fileName = "员工工资汇总"+date.getFullYear()+"_"+date.getMonth()+"_"+date.getDay()+"_"+date.getHours()+"_"+date.getMinutes()+"_"+date.getSeconds();
                var option={};
                option.fileName = fileName;
                option.datas=[
                    {
                        sheetData:sheetData,
                        sheetHeader:['编号','档案编号','部门奖金名称','出勤时长','基础工资','时薪','个人奖金','总工资','日期'],
                        //sheetStyle:[]
                    }
                ];
                var toExcel=new ExportJsonExcel(option);
                toExcel.saveExcel();
            } else {
                $.messager.alert("系统提示","错误！请重试...");
            }
        }

        /**返回该行的档案ID*/
        function formatHrFilesId(val,row){
            if(val == null) return "";
            return val.id;
        }

        /**返回该行的部门奖金名称*/
        function formatHrDepartmentBonusName(val,row){
            if(val == null) return "";
            return val.name;
        }

        /**添加一条工资信息*/
        function openHrWagesAddTab() {
            window.parent.openTab("工资信息添加","wages/HrWagesAdd.jsp");
        }

        /**修改一条工资信息*/
        function openHrWagesModifyTab(){
            var selectedRows=$("#dg").datagrid("getSelections");
            if(selectedRows.length!=1){
                $.messager.alert("系统提示","请选择要修改的一条工资信息");
                return;
            }
            var row=selectedRows[0];
            window.parent.openTab("工资信息修改","wages/HrWagesModify.jsp?id="+row.id);
        }

        /**删除工资信息*/
        function deleteHrWages(){
            var selectedRows=$("#dg").datagrid("getSelections");
            if(selectedRows.length==0){
                $.messager.alert("系统提示","请至少选择一条要删除的数据");
                return;
            }
            var strIds=[];
            for(var i=0;i<selectedRows.length;i++){
                strIds.push(selectedRows[i].id);
            }
            var ids = strIds.join(",");
            $.messager.confirm("系统提示","确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
                if(r){
                    $.post("${pageContext.request.contextPath}/hrWages/delete.do",{ids:ids},function(result){
                        if(result.success){
                            $.messager.alert("系统提示","删除数据成功");
                            $("#dg").datagrid("reload");
                        }else{
                            $.messager.alert("系统提示","删除数据失败");
                        }
                    },"json");
                }
            });
        }

    </script>
</head>

<body style="margin: 10px">
<table id="dg" title="员工工资管理" class="easyui-datagrid" fitcolumns="true"
       pagination="true" rownumbers="true" fit="true" toolbar="#tb"
       url="${pageContext.request.contextPath}/hrWages/list.do">
    <thead>
    <tr>
        <th field="cb" checkbox="true" align="center"></th>
        <th field="id" width="20" align="center">编号</th>
        <th field="hrFiles" width="20" align="center" formatter="formatHrFilesId">档案编号</th>
        <th field="hrDepartmentBonus" width="20" align="center" formatter="formatHrDepartmentBonusName">部门奖金名称</th>
        <th field="attendanceLength" width="20" align="center">出勤时长</th>
        <th field="basicWage" width="20" align="center">基础工资</th>
        <th field="hourlyWage" width="20" align="center">时薪</th>
        <th field="personalBonus" width="20" align="center">个人奖金</th>
        <th field="totalWages" width="20" align="center">总工资</th>
        <th field="date" width="20" align="center">日期</th>
    </tr>
    </thead>
</table>

<div id="tb">
    <div>
        <a href="javascript:openHrWagesAddTab()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
        <a href="javascript:openHrWagesModifyTab()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
        <a href="javascript:deleteHrWages()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
        <a href="javascript:print()" class="easyui-linkbutton" iconCls="icon-print" plain="true">打印员工工资汇总表</a>
    </div>
    <input id="ss" class="easyui-searchbox" style="width:260px"
           data-options="searcher:searchHr,prompt:'Please Input Value',menu:'#mm'"/>
    <div id="mm" style="width:160px">
        <div data-options="name:'id'">编号</div>
        <div data-options="name:'hrFiles.id'">档案编号</div>
        <div data-options="name:'dateStr'">日期</div>
    </div>
</div>
</body>

</html>
