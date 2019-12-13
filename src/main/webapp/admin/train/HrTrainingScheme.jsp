<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>培训方案管理</title>
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
            if(name == "isPass"){
                if(value == "未审核"){ value = "0"; }
                else if(value == "同意"){ value = "1"; }
                else if(value == "不同意"){ value = "-1"; }
            }
            var str = "{ \"" + name + "\":\"" + value + "\" }";
            searchHrJson = eval ("(" + str + ")");
            $("#dg").datagrid('load',searchHrJson);
        }

        function print(){
            var resultList;
            $.ajax({
                url:"${pageContext.request.contextPath}/hrTrainingScheme/list.do",
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
                    temp[1] = resultList.rows[i].content;
                    temp[2] = resultList.rows[i].isPass;
                    if(temp[2]=='1') { temp[2]='同意'; }
                    else if(temp[2]=='-1') { temp[2]='不同意'; }
                    else { temp[2]='未审核'; }
                    temp[3] = resultList.rows[i].startDate;
                    temp[4] = resultList.rows[i].endDate;
                    sheetData[i]=temp;
                }
                var date = new Date();
                var fileName = "培训方案汇总"+date.getFullYear()+"_"+date.getMonth()+"_"+date.getDay()+"_"+date.getHours()+"_"+date.getMinutes()+"_"+date.getSeconds();
                var option={};
                option.fileName = fileName;
                option.datas=[
                    {
                        sheetData:sheetData,
                        sheetHeader:['编号','培训方案内容','是否同意','开始日期','结束日期'],
                        //sheetStyle:[]
                    }
                ];
                var toExcel=new ExportJsonExcel(option);
                toExcel.saveExcel();
            } else {
                $.messager.alert("系统提示","错误！请重试...");
            }
        }

        /**返回该行的是否同意*/
        function formatIsPass(val,row){
            if(val == 0) return "未审核";
            if(val == -1) return "不同意";
            if(val == 1) return "同意";
            return "数据错误";
        }

        /**返回该行的参与人员管理*/
        function formatHrTrainingSchemeFiles(val,row){
            if(row.isPass == 1) return "<a href='javascript:openHrTrainingSchemeFilesTab("+row.id+")'>管理</a>";
            return "";
        }

        /**打开培训方案参与人员管理页面*/
        function openHrTrainingSchemeFilesTab(id) {
            window.parent.openTab("培训方案参与人员管理","train/HrTrainingSchemeFiles.jsp?id="+id);
        }

        /**添加一份培训方案*/
        function openHrTrainingSchemeAddTab() {
            window.parent.openTab("培训方案添加","train/HrTrainingSchemeAdd.jsp");
        }

        /**修改一份培训方案*/
        function openHrTrainingSchemeModifyTab(){
            var selectedRows=$("#dg").datagrid("getSelections");
            if(selectedRows.length!=1){
                $.messager.alert("系统提示","请选择要修改的一份培训方案");
                return;
            }
            var row=selectedRows[0];
            window.parent.openTab("培训方案修改","train/HrTrainingSchemeModify.jsp?id="+row.id);
        }

        /**删除培训方案*/
        function deleteHrTrainingScheme(){
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
                    $.post("${pageContext.request.contextPath}/hrTrainingScheme/delete.do",{ids:ids},function(result){
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
<table id="dg" title="培训方案管理" class="easyui-datagrid" fitcolumns="true"
       pagination="true" rownumbers="true" fit="true" toolbar="#tb"
       url="${pageContext.request.contextPath}/hrTrainingScheme/list.do">
    <thead>
    <tr>
        <th field="cb" checkbox="true" align="center"></th>
        <th field="id" width="20" align="center">编号</th>
        <th field="content" width="60" align="center">培训方案内容</th>
        <th field="startDate" width="20" align="center">开始日期</th>
        <th field="endDate" width="20" align="center">结束日期</th>
        <th field="isPass" width="20" align="center" formatter="formatIsPass">是否同意</th>
        <th field="hrTrainingSchemeFiles" width="20" align="center" formatter="formatHrTrainingSchemeFiles">参与人员管理</th>
    </tr>
    </thead>
</table>

<div id="tb">
    <div>
        <a href="javascript:openHrTrainingSchemeAddTab()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
        <a href="javascript:openHrTrainingSchemeModifyTab()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
        <a href="javascript:deleteHrTrainingScheme()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
        <a href="javascript:print()" class="easyui-linkbutton" iconCls="icon-print" plain="true">打印培训方案汇总表</a>
    </div>
    <input id="ss" class="easyui-searchbox" style="width:260px"
           data-options="searcher:searchHr,prompt:'Please Input Value',menu:'#mm'"/>
    <div id="mm" style="width:160px">
        <div data-options="name:'id'">编号</div>
        <div data-options="name:'content'">培训方案内容</div>
        <div data-options="name:'startDateStr'">开始日期</div>
        <div data-options="name:'endDateStr'">结束日期</div>
        <div data-options="name:'isPass'">是否同意</div>
    </div>
</div>
</body>

</html>
