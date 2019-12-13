<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>工资信息修改</title>
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

        var hrFiles = null;
        var hrDepartmentBonus = null;

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

        function checkHrDepartmentBonusId() {//可以为空
            //清空部门奖金信息
            hrDepartmentBonus = null;
            //判断是否输入了部门奖金ID
            var hrDepartmentBonusId=$("#HrDepartmentBonusId").val();
            if(hrDepartmentBonusId!=null && hrDepartmentBonusId!='') {//输入了，则判断是否正确
                //获取部门奖金数据
                $.ajax({
                    url:"${pageContext.request.contextPath}/hrDepartmentBonus/findById.do",
                    type:"post",
                    data:{"id":hrDepartmentBonusId},
                    async:false,//是否异步
                    success:function(result){
                        result = eval("("+result+")");
                        hrDepartmentBonus = result;
                    }
                });
                if(hrDepartmentBonus!=null) {//输入正确，提示奖金信息
                    var info="编号："+hrDepartmentBonus.id+" 名称："+hrDepartmentBonus.name+" 部门："+hrDepartmentBonus.hrDepartment.name+" 奖金："+hrDepartmentBonus.bonus+" 人数："+hrDepartmentBonus.number;
                    $("#departmentBonusIdInfo").html(info);
                    return true;
                } else {//输入错误，提示错误
                    $.messager.alert("系统提示","部门奖金编号错误");
                    return false;
                }
            } else {//没有输入，则提示未输入
                $("#departmentBonusIdInfo").html("未输入部门奖金编号，默认奖金为0");
                return true;
            }
        }

        function getByHrFilesBasicWage() {
            if(hrFiles != null) {//如果档案信息不为空
                if(hrFiles.id == $("#HrFilesId").val()) {//且档案编号和输入的编号相等则不用查询
                    $("#basicWage").val(hrFiles.basicWage);
                    return;
                }
            }
            if(checkHrFilesId()) {//查询档案信息
                $("#basicWage").val(hrFiles.basicWage);
                return;
            }
        }

        function getByHrFilesHourlyWage() {
            if(hrFiles != null) {//如果档案信息不为空
                if(hrFiles.id == $("#HrFilesId").val()) {//且档案编号和输入的编号相等则不用查询
                    $("#hourlyWage").val(hrFiles.hrPost.hourlyWage);
                    return;
                }
            }
            if(checkHrFilesId()) {//查询档案信息
                $("#hourlyWage").val(hrFiles.hrPost.hourlyWage);
                return;
            }
        }

        function sumTotalWage() {
            var attendanceLength=$("#attendanceLength").val();
            if(attendanceLength==null || attendanceLength==''){
                $.messager.alert("系统提示","请输入出勤时长");
                return;
            }
            // if(!(/^\d*$/.test(attendanceLength))){
            //     $.messager.alert("系统提示","出勤时长有误");
            //     return;
            // }

            var basicWage=$("#basicWage").val();
            if(basicWage==null || basicWage==''){
                $.messager.alert("系统提示","请输入基础工资");
                return;
            }
            // if(!(/^\d+\.?\d{0,2}$/.test(basicWage))){
            //     $.messager.alert("系统提示","基础工资有误");
            //     return;
            // }

            var hourlyWage=$("#hourlyWage").val();
            if(hourlyWage==null || hourlyWage==''){
                $.messager.alert("系统提示","请输入时薪");
                return;
            }
            // if(!(/^\d+\.?\d{0,2}$/.test(hourlyWage))){
            //     $.messager.alert("系统提示","时薪有误");
            //     return;
            // }

            var personalBonus=$("#personalBonus").val();
            // if(!(/^$|^\d+\.?\d{0,2}$/.test(personalBonus))){
            //     $.messager.alert("系统提示","个人奖金有误");
            //     return;
            // }

            var totalWages=Number(basicWage)+Number(hourlyWage)*Number(attendanceLength)+Number(personalBonus);
            if($("#HrDepartmentBonusId").val() != null && $("#HrDepartmentBonusId").val() != "") {//如果输入的部门奖金编号不为空
                if(hrDepartmentBonus != null) {//且部门奖金信息不为空
                    if(hrDepartmentBonus.id == $("#HrDepartmentBonusId").val()) {//且部门奖金编号和输入的编号相等则不用查询
                        totalWages+=Number(hrDepartmentBonus.bonus)/Number(hrDepartmentBonus.number);
                        var info="编号："+hrDepartmentBonus.id+" 名称："+hrDepartmentBonus.name+" 部门："+hrDepartmentBonus.hrDepartment.name+" 奖金："+hrDepartmentBonus.bonus+" 人数："+hrDepartmentBonus.number;
                        $("#departmentBonusIdInfo").html(info);
                    } else if(checkHrDepartmentBonusId()) {//查询部门奖金信息
                        totalWages+=Number(hrDepartmentBonus.bonus)/Number(hrDepartmentBonus.number);
                    }
                } else if(checkHrDepartmentBonusId()) {//查询部门奖金信息
                    totalWages+=Number(hrDepartmentBonus.bonus)/Number(hrDepartmentBonus.number);
                }
            } else {
                $("#departmentBonusIdInfo").html("未输入部门奖金编号，默认奖金为0");
            }
            $("#totalWages").val(totalWages);

        }

        /**工资信息修改*/
        function submitHrWagesModify() {
            if (!checkHrFilesId()) return;
            if (!checkHrDepartmentBonusId()) return;
            var hrDepartmentBonusId;
            if (hrDepartmentBonus != null){
                hrDepartmentBonusId = hrDepartmentBonus.id;
            }

            var attendanceLength=$("#attendanceLength").val();
            if(attendanceLength==null || attendanceLength==''){
                $.messager.alert("系统提示","请输入出勤时长");
                return;
            }
            // if(!(/^\d*$/.test(attendanceLength))){
            //     $.messager.alert("系统提示","出勤时长有误");
            //     return;
            // }

            var basicWage=$("#basicWage").val();
            if(basicWage==null || basicWage==''){
                $.messager.alert("系统提示","请输入基础工资");
                return;
            }
            // if(!(/^\d+\.?\d{0,2}$/.test(basicWage))){
            //     $.messager.alert("系统提示","基础工资有误");
            //     return;
            // }

            var hourlyWage=$("#hourlyWage").val();
            if(hourlyWage==null || hourlyWage==''){
                $.messager.alert("系统提示","请输入时薪");
                return;
            }
            // if(!(/^\d+\.?\d{0,2}$/.test(hourlyWage))){
            //     $.messager.alert("系统提示","时薪有误");
            //     return;
            // }

            var personalBonus=$("#personalBonus").val();
            // if(!(/^$|^\d+\.?\d{0,2}$/.test(personalBonus))){
            //     $.messager.alert("系统提示","个人奖金有误");
            //     return;
            // }

            var totalWages=$("#totalWages").val();
            if(totalWages==null || totalWages==''){
                $.messager.alert("系统提示","请输入总工资");
                return;
            }
            // if(!(/^\d+\.?\d{0,2}$/.test(totalWages))){
            //     $.messager.alert("系统提示","总工资有误");
            //     return;
            // }

            var date = $("#date").val();
            if(date==null || date==''){
                $.messager.alert("系统提示","请输入日期");
                return;
            }
            if(!(/^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$/.test(date))){
                $.messager.alert("系统提示","日期有误");
                return;
            }

            $.post("${pageContext.request.contextPath}/hrWages/save.do",
                {'id':'${param.id}',
                    'hrFiles.id':hrFiles.id,
                    'hrDepartmentBonus.id':hrDepartmentBonusId,
                    'attendanceLength':attendanceLength,
                    'basicWage':basicWage,
                    'hourlyWage':hourlyWage,
                    'personalBonus':personalBonus,
                    'totalWages':totalWages,
                    'date':date,
                },
                function(result){
                    if(result.success){
                        $.messager.alert("系统提示","工资信息修改成功");
                    }else{
                        $.messager.alert("系统提示","工资信息修改失败");
                    }
                },"json");
        }

    </script>
</head>

<body style="margin: 10px">
<div id="p" class="easyui-panel" title="工资信息修改" style="padding: 10px">
    <table cellspacing="20px">
        <tr>
            <td width="100px">档案编号：</td>
            <td><input type="text" id="HrFilesId" name="HrFilesId" style="width: 200px;" maxlength="11" onkeyup="value=value.replace(/[^\d]$/,'')"/></td>
            <td><a href="javascript:checkHrFilesId()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">检查档案信息</a></td>
            <td><span><font id="filesIdInfo"></font></span></td>
        </tr>
        <tr>
            <td width="100px">部门奖金编号：</td>
            <td><input type="text" id="HrDepartmentBonusId" name="HrDepartmentBonusId" style="width: 200px;" maxlength="11" onkeyup="value=value.replace(/[^\d]$/,'')"/></td>
            <td><a href="javascript:checkHrDepartmentBonusId()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">检查奖金信息</a></td>
            <td><span><font id="departmentBonusIdInfo"></font></span></td>
        </tr>
        <tr>
            <td width="100px">出勤时长：</td>
            <td><input type="text" id="attendanceLength" name="attendanceLength" style="width: 200px;" maxlength="11" onkeyup="value=value.replace(/[^\d]$/,'')"/></td>
        </tr>
        <tr>
            <td width="100px">基础工资：</td>
            <td><input type="text" id="basicWage" name="basicWage" style="width: 200px;" maxlength="11" onkeyup="format_input_num(this)"/></td>
            <td><a href="javascript:getByHrFilesBasicWage()" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">从档案中获取</a></td>
        </tr>
        <tr>
            <td width="100px">时薪：</td>
            <td><input type="text" id="hourlyWage" name="hourlyWage" style="width: 200px;" maxlength="11" onkeyup="format_input_num(this)"/></td>
            <td><a href="javascript:getByHrFilesHourlyWage()" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">从档案中获取</a></td>
        </tr>
        <tr>
            <td width="100px">个人奖金：</td>
            <td><input type="text" id="personalBonus" name="personalBonus" style="width: 200px;" maxlength="11" onkeyup="format_input_num(this)"/></td>
        </tr>
        <tr>
            <td width="100px">总工资：</td>
            <td><input type="text" id="totalWages" name="totalWages" style="width: 200px;" maxlength="11" onkeyup="format_input_num(this)"/></td>
            <td><a href="javascript:sumTotalWage()" class="easyui-linkbutton" data-options="iconCls:'icon-sum'">自动计算总值</a></td>
        </tr>
        <tr>
            <td width="100px">日期：</td>
            <td><input type="date" id="date" name="date" style="width: 200px;"/></td>
        </tr>
        <tr>
            <td></td>
            <td><a href="javascript:submitHrWagesModify()" class="easyui-linkbutton" data-options="iconCls:'icon-submit'">修改工资信息</a></td>
        </tr>
    </table>
</div>
<script type="text/javascript">

    $.post("${pageContext.request.contextPath}/hrWages/findById.do",
        {"id":"${param.id}"},
        function(result){
            result = eval("("+result+")");
            $("#HrFilesId").val(result.hrFiles.id);
            if(result.hrDepartmentBonus != null && result.hrDepartmentBonus != "") {
                $("#HrDepartmentBonusId").val(result.hrDepartmentBonus.id);
            }
            $("#attendanceLength").val(result.attendanceLength);
            $("#basicWage").val(result.basicWage);
            $("#hourlyWage").val(result.hourlyWage);
            $("#personalBonus").val(result.personalBonus);
            $("#totalWages").val(result.totalWages);
            var dateToStr = new Date(result.date);
            var year = dateToStr.getFullYear();
            var day = ("0" + dateToStr.getDate()).slice(-2);
            var month = ("0" + (dateToStr.getMonth() + 1)).slice(-2);
            var dateStr = year + "-" + month + "-" + day;
            $("#date").val(dateStr);
        }
    )

</script>
</body>

</html>
