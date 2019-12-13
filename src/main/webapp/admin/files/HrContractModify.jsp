<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>合同修改</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

    <script type="text/javascript" charset="gbk" src="${pageContext.request.contextPath}/static/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="gbk" src="${pageContext.request.contextPath}/static/ueditor/ueditor.all.min.js"></script>
    <!-- 手动加载语言，避免在IE下有时因为加载语言导致编辑器加载失败 -->
    <!-- 在这里加载的语言会覆盖在配置项目里添加的语言类型，比如在配置项目里配置的是英文，这里加载的是中文，那最后就是中文  -->
    <script type="text/javascript" charset="gbk" src="${pageContext.request.contextPath}/static/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript">

        var hrFiles = null;

        function checkHrFilesId() {//不可为空
            //清空档案数据
            hrFiles = null;
            //判断是否输入了档案ID
            var hrFilesId=$("#HrFilesId").val();
            if(hrFilesId!=null && hrFilesId!='') {//输入了，则判断是否正确
                //获取档案数据
                $.ajax({
                    url:"${pageContext.request.contextPath}/hrFiles/findById.do",
                    type:"post",
                    data:{"id":hrFilesId},
                    async:false,//是否异步
                    success:function(result){
                        result = eval("("+result+")");
                        hrFiles = result;
                    }
                });
                if(hrFiles!=null) {//输入正确，提示档案信息
                    var info="编号："+hrFiles.id+" 姓名："+hrFiles.name+" 部门："+hrFiles.hrPost.hrDepartment.name+" 基础工资："+hrFiles.basicWage+" 时薪："+hrFiles.hrPost.hourlyWage;
                    $("#filesIdInfo").html(info);
                    return true;
                } else {//输入错误，提示错误
                    $.messager.alert("系统提示","档案编号错误");
                    return false;
                }
            } else {//没有输入，则提示未输入
                $.messager.alert("系统提示","请输入档案编号");
                return false;
            }
        }

        /**合同修改*/
        function submitHrContractModify() {
            if (!checkHrFilesId()) return;

            var content=$("#content").val();
            if(content==null || content==''){
                $.messager.alert("系统提示","请输入合同内容");
                return;
            }

            var startDate = $("#startDate").val();
            if(startDate==null || startDate==''){
                $.messager.alert("系统提示","请输入开始日期");
                return;
            }
            if(!(/^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$/.test(startDate))){
                $.messager.alert("系统提示","开始日期有误");
                return;
            }

            var endDate = $("#endDate").val();
            if(endDate==null || endDate==''){
                $.messager.alert("系统提示","请输入结束日期");
                return;
            }
            if(!(/^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$/.test(endDate))){
                $.messager.alert("系统提示","结束日期有误");
                return;
            }

            if((new Date(startDate)).getTime() > (new Date(endDate)).getTime()){
                $.messager.alert("系统提示","结束日期不能比开始日期早");
                return;
            }

            $.post("${pageContext.request.contextPath}/hrContract/save.do",
                {'id':'${param.id}',
                    'hrFiles.id':hrFiles.id,
                    'content':content,
                    'startDate':startDate,
                    'endDate':endDate,
                },
                function(result){
                    if(result.success){
                        $.messager.alert("系统提示","合同修改成功");
                    }else{
                        $.messager.alert("系统提示","合同修改失败");
                    }
                },"json");
        }

    </script>
</head>

<body style="margin: 10px">
<div id="p" class="easyui-panel" title="合同修改" style="padding: 10px">
    <table cellspacing="20px">
        <tr>
            <td width="100px">档案编号：</td>
            <td>
                <input type="text" id="HrFilesId" name="HrFilesId" style="width: 200px;" maxlength="11" onkeyup="value=value.replace(/[^\d]$/,'')"/>
                <a href="javascript:checkHrFilesId()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">检查档案信息</a>
                <span><font id="filesIdInfo"></font></span>
            </td>
        </tr>
        <tr>
            <td width="100px">合同内容：</td>
            <td><textarea id="content" name="content" rows="30" cols="100"></textarea></td>
        </tr>
        <tr>
            <td width="100px">开始日期：</td>
            <td><input type="date" id="startDate" name="startDate" style="width: 200px;"/></td>
        </tr>
        <tr>
            <td width="100px">结束日期：</td>
            <td><input type="date" id="endDate" name="endDate" style="width: 200px;"/></td>
        </tr>
        <tr>
            <td></td>
            <td><a href="javascript:submitHrContractModify()" class="easyui-linkbutton" data-options="iconCls:'icon-submit'">修改合同</a></td>
        </tr>
    </table>
</div>
<script type="text/javascript">

    $.post("${pageContext.request.contextPath}/hrContract/findById.do",
        {"id":"${param.id}"},
        function(result){
            result = eval("("+result+")");
            $("#HrFilesId").val(result.hrFiles.id);
            $("#content").val(result.content);
            var dateToStr = new Date(result.startDate);
            var year = dateToStr.getFullYear();
            var day = ("0" + dateToStr.getDate()).slice(-2);
            var month = ("0" + (dateToStr.getMonth() + 1)).slice(-2);
            var dateStr = year + "-" + month + "-" + day;
            $("#startDate").val(dateStr);
            var dateToStr = new Date(result.endDate);
            var year = dateToStr.getFullYear();
            var day = ("0" + dateToStr.getDate()).slice(-2);
            var month = ("0" + (dateToStr.getMonth() + 1)).slice(-2);
            var dateStr = year + "-" + month + "-" + day;
            $("#endDate").val(dateStr);
        }
    )

</script>
</body>

</html>
