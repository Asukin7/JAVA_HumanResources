<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>岗位调动管理</title>
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
                url:"${pageContext.request.contextPath}/hrPostTransfer/list.do",
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
                    temp[2] = resultList.rows[i].hrPost.id;
                    temp[3] = resultList.rows[i].content;
                    temp[4] = resultList.rows[i].submitDate;
                    temp[5] = resultList.rows[i].isPass;
                    if(temp[5]=='1') { temp[5]='同意'; }
                    else if(temp[5]=='-1') { temp[5]='不同意'; }
                    else { temp[5]='未审核'; }
                    temp[6] = resultList.rows[i].auditDate;
                    sheetData[i]=temp;
                }
                var date = new Date();
                var fileName = "岗位调动汇总"+date.getFullYear()+"_"+date.getMonth()+"_"+date.getDay()+"_"+date.getHours()+"_"+date.getMinutes()+"_"+date.getSeconds();
                var option={};
                option.fileName = fileName;
                option.datas=[
                    {
                        sheetData:sheetData,
                        sheetHeader:['编号','档案编号','调动岗位编号','岗位调动内容','提交时间','是否同意','审核时间'],
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

        /**返回该行的岗位ID*/
        function formatHrPostId(val,row){
            if(val == null) return "";
            return val.id;
        }

        /**返回该行的是否审核*/
        function formatIsPass(val,row){
            if(val == 0) return "未审核";
            if(val == -1) return "不同意";
            if(val == 1) return "同意";
            return "数据错误";
        }

        /**添加一份岗位调动*/
        function openHrPostTransferAddTab() {
            window.parent.openTab("岗位调动添加","post/HrPostTransferAdd.jsp");
        }

        /**修改一份岗位调动*/
        function openHrPostTransferModifyTab(){
            var selectedRows=$("#dg").datagrid("getSelections");
            if(selectedRows.length!=1){
                $.messager.alert("系统提示","请选择要修改的一份岗位调动");
                return;
            }
            var row=selectedRows[0];
            window.parent.openTab("岗位调动修改","post/HrPostTransferModify.jsp?id="+row.id);
        }

        /**删除岗位调动*/
        function deleteHrPostTransfer(){
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
                    $.post("${pageContext.request.contextPath}/hrPostTransfer/delete.do",{ids:ids},function(result){
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
<table id="dg" title="岗位调动管理" class="easyui-datagrid" fitcolumns="true"
       pagination="true" rownumbers="true" fit="true" toolbar="#tb"
       url="${pageContext.request.contextPath}/hrPostTransfer/list.do">
    <thead>
    <tr>
        <th field="cb" checkbox="true" align="center"></th>
        <th field="id" width="20" align="center">编号</th>
        <th field="hrFiles" width="20" align="center" formatter="formatHrFilesId">档案编号</th>
        <th field="hrPost" width="20" align="center" formatter="formatHrPostId">调动岗位编号</th>
        <th field="content" width="60" align="center">岗位调动内容</th>
        <th field="submitDate" width="20" align="center">提交时间</th>
        <th field="isPass" width="20" align="center" formatter="formatIsPass">是否同意</th>
        <th field="auditDate" width="20" align="center">审核时间</th>
    </tr>
    </thead>
</table>

<div id="tb">
    <div>
        <a href="javascript:openHrPostTransferAddTab()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
        <a href="javascript:openHrPostTransferModifyTab()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
        <a href="javascript:deleteHrPostTransfer()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
        <a href="javascript:print()" class="easyui-linkbutton" iconCls="icon-print" plain="true">打印岗位调动表</a>
    </div>
    <input id="ss" class="easyui-searchbox" style="width:260px"
           data-options="searcher:searchHr,prompt:'Please Input Value',menu:'#mm'"/>
    <div id="mm" style="width:160px">
        <div data-options="name:'id'">编号</div>
        <div data-options="name:'hrFiles.id'">档案编号</div>
        <div data-options="name:'content'">岗位调动内容</div>
        <div data-options="name:'submitDateStr'">提交时间</div>
        <div data-options="name:'isPass'">是否同意</div>
        <div data-options="name:'auditDateStr'">审核时间</div>
    </div>
</div>
</body>

</html>
