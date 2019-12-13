<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>档案添加</title>
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

        /**下拉框创建时加载数据*/
        $("#hrPost").ready(function(){
            loadHrPost();
        })

        /**加载下拉框数据*/
        function loadHrPost() {
            $.ajax({
                url:"${pageContext.request.contextPath}/hrPost/countList.do",
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
                        $('#hrPost').combobox("loadData", comboboxData);
                    }
                },
                error:function(){}
            });
        }

        /**档案添加*/
        function submitHrFilesAdd() {
            var name=$("#name").val();
            if(name==null || name==''){
                $.messager.alert("系统提示","请输入姓名");
                return;
            }

            var sex=$("#sex").combobox("getValue");
            if(sex==null || sex==''){
                $.messager.alert("系统提示","请输入性别");
                return;
            }

            var phone=$("#phone").val();
            if(phone==null || phone==''){
                $.messager.alert("系统提示","请输入联系方式");
                return;
            }
            if(!(/^1(3|4|5|6|7|8|9)\d{9}$/.test(phone))){
                $.messager.alert("系统提示","联系方式有误");
                return;
            }

            var remark=$("#remark").val();

            var joinDate = $("#joinDate").val();
            if(joinDate==null || joinDate==''){
                $.messager.alert("系统提示","请输入入职日期");
                return;
            }
            if(!(/^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$/.test(joinDate))){
                $.messager.alert("系统提示","入职日期有误");
                return;
            }

            var basicWage=$("#basicWage").val();
            if(basicWage==null || basicWage==''){
                $.messager.alert("系统提示","请输入基础工资");
                return;
            }

            var postId=$("#hrPost").combobox("getValue");
            if(postId==null || postId==''){
                $.messager.alert("系统提示","请输入岗位");
                return;
            }

            $.post("${pageContext.request.contextPath}/hrFiles/save.do",
                {'name':name,
                    'sex':sex,
                    'phone':phone,
                    'remark':remark,
                    'joinDate':joinDate,
                    'basicWage':basicWage,
                    'hrPost.id':postId,
                },
                function(result){
                    if(result.success){
                        $.messager.alert("系统提示","档案添加成功！");
                    }else{
                        $.messager.alert("系统提示","档案添加失败！");
                    }
                },"json");
        }

    </script>
</head>

<body style="margin: 10px">
<div id="p" class="easyui-panel" title="档案添加" style="padding: 10px">
    <table cellspacing="20px">
        <tr>
            <td width="100px">姓名：</td>
            <td><input type="text" id="name" name="name" style="width: 200px;" maxlength="32"/></td>
            <td width="100px">性别：</td>
            <td>
                <select class="easyui-combobox" id="sex" name="sex" style="width: 200px;" editable="false" panelHeight="auto">
                    <option value="">请选择性别</option>
                    <option value="男">男</option>
                    <option value="女">女</option>
                </select>
            </td>
        </tr>
        <tr>
            <td width="100px">电话：</td>
            <td><input type="text" id="phone" name="phone" style="width: 200px;" maxlength="11"/></td>
            <td width="100px">备注：</td>
            <td><input type="text" id="remark" name="remark" style="width: 200px;" maxlength="512"/></td>
        </tr>
        <tr>
            <td width="100px">入职日期：</td>
            <td><input type="date" id="joinDate" name="joinDate" style="width: 200px;"/></td>
            <td width="100px">基础工资：</td>
            <td><input type="text" id="basicWage" name="basicWage" style="width: 200px;" maxlength="11" onkeyup="format_input_num(this)"/></td>
        </tr>
        <tr>
            <td width="100px">岗位名称：</td>
            <td><select class="easyui-combobox" id="hrPost" name="hrPost.id" style="width: 150px;" editable="false" panelHeight="auto"></select></td>
        </tr>
        <tr>
            <td></td>
            <td><a href="javascript:submitHrFilesAdd()" class="easyui-linkbutton" data-options="iconCls:'icon-submit'">添加档案</a></td>
        </tr>
    </table>
</div>
</body>

</html>
