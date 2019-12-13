<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>档案管理</title>
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
                url:"${pageContext.request.contextPath}/hrFiles/list.do",
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
                    temp[1] = resultList.rows[i].hrPost.name;
                    temp[2] = resultList.rows[i].name;
                    temp[3] = resultList.rows[i].sex;
                    temp[4] = resultList.rows[i].phone;
                    temp[5] = resultList.rows[i].remark;
                    temp[6] = resultList.rows[i].joinDate;
                    temp[7] = resultList.rows[i].basicWage;
                    sheetData[i]=temp;
                }
                var date = new Date();
                var fileName = "档案资料"+date.getFullYear()+"_"+date.getMonth()+"_"+date.getDay()+"_"+date.getHours()+"_"+date.getMinutes()+"_"+date.getSeconds();
                var option={};
                option.fileName = fileName;
                option.datas=[
                    {
                        sheetData:sheetData,
                        sheetHeader:['编号','岗位名称','姓名','性别','联系方式','备注','入职日期','基础工资'],
                        //sheetStyle:[]
                    }
                ];
                var toExcel=new ExportJsonExcel(option);
                toExcel.saveExcel();
            } else {
                $.messager.alert("系统提示","错误！请重试...");
            }
        }

        /**返回该行的岗位名称*/
        function formatHrPostName(val,row){
            return val.name;
        }

        /**添加一份档案*/
        function openHrFilesAddTab() {
            window.parent.openTab("档案添加","files/HrFilesAdd.jsp");
        }

        /**修改一份档案*/
        function openHrFilesModifyTab(){
            var selectedRows=$("#dg").datagrid("getSelections");
            if(selectedRows.length!=1){
                $.messager.alert("系统提示","请选择要修改的一份档案");
                return;
            }
            var row=selectedRows[0];
            window.parent.openTab("档案修改","files/HrFilesModify.jsp?id="+row.id);
        }

        /**删除档案*/
        function deleteHrFiles(){
            var selectedRows=$("#dg").datagrid("getSelections");
            if(selectedRows.length==0){
                $.messager.alert("系统提示","请选择要删除的档案");
                return;
            }
            var strIds=[];
            for(var i=0;i<selectedRows.length;i++){
                strIds.push(selectedRows[i].id);
            }
            var ids = strIds.join(",");
            $.messager.confirm("系统提示","确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
                if(r){
                    $.post("${pageContext.request.contextPath}/hrFiles/delete.do",{ids:ids},function(result){
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
<table id="dg" title="档案管理" class="easyui-datagrid" fitcolumns="true"
       pagination="true" rownumbers="true" fit="true" toolbar="#tb"
       url="${pageContext.request.contextPath}/hrFiles/list.do">
    <thead>
    <tr>
        <th field="cb" checkbox="true" align="center"></th>
        <th field="id" width="20" align="center">编号</th>
        <th field="hrPost" width="20" align="center" formatter="formatHrPostName">岗位名称</th>
        <th field="name" width="20" align="center">姓名</th>
        <th field="sex" width="20" align="center">性别</th>
        <th field="phone" width="20" align="center">联系方式</th>
        <th field="remark" width="60" align="center">备注</th>
        <th field="joinDate" width="20" align="center">入职日期</th>
        <th field="basicWage" width="20" align="center">基础工资</th>
    </tr>
    </thead>
</table>

<div id="tb">
    <div>
        <a href="javascript:openHrFilesAddTab()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
        <a href="javascript:openHrFilesModifyTab()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
        <a href="javascript:deleteHrFiles()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
        <a href="javascript:print()" class="easyui-linkbutton" iconCls="icon-print" plain="true">打印档案资料表</a>
    </div>
    <input id="ss" class="easyui-searchbox" style="width:260px"
           data-options="searcher:searchHr,prompt:'Please Input Value',menu:'#mm'"/>
    <div id="mm" style="width:160px">
        <div data-options="name:'id'">编号</div>
        <div data-options="name:'name'">姓名</div>
        <div data-options="name:'joinDateStr'">入职日期</div>
    </div>
</div>
</body>

</html>
