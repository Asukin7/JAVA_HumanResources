package com.hr.realm;

import com.hr.entity.HrAccount;
import com.hr.service.HrAccountService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

public class MyRealm extends AuthorizingRealm {

    @Resource
    private HrAccountService hrAccountService;

    /**
     * 获取授权信息
     * @param principalCollection
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        //1、获取登录时输入的用户名
        String account = (String)principalCollection.fromRealm(getName()).iterator().next();
        //2、到数据库查是否有此对象
        HrAccount hrAccount = hrAccountService.getByAccount(account);
        if(hrAccount != null) {
            //2.1、权限信息对象info,用来存放查出的用户的所有的角色（role）及权限（permission）
            SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
            //2.2、用户的角色集合
            List<String> rolesList = new ArrayList();
            if(hrAccount.getAdmin() == 1) rolesList.add("admin");
            if(hrAccount.getFiles() == 1) rolesList.add("files");
            if(hrAccount.getPost() == 1) rolesList.add("post");
            if(hrAccount.getTrain() == 1) rolesList.add("train");
            if(hrAccount.getWages() == 1) rolesList.add("wages");
            info.addRoles(rolesList);
            return info;
        }
        return null;
    }

    /**
     * 登录验证
     * @param authenticationToken 令牌，基于账号密码的令牌
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        //从authenticationToken中取出账号
        String account = (String)authenticationToken.getPrincipal();
        //让shiro去验证账号密码
        HrAccount hrAccount = hrAccountService.getByAccount(account);
        if(hrAccount != null) {
            SecurityUtils.getSubject().getSession().setAttribute("currentUser", hrAccount);
            AuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(hrAccount.getAccount(), hrAccount.getPassword(), getName());
            return authenticationInfo;
        }
        return null;
    }

}
