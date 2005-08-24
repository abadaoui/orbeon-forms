<?xml version="1.0" encoding="iso-8859-1"?>
<!--
    Copyright (C) 2005 Orbeon, Inc.

    This program is free software; you can redistribute it and/or modify it under the terms of the
    GNU Lesser General Public License as published by the Free Software Foundation; either version
    2.1 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
    without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    See the GNU Lesser General Public License for more details.

    The full text of the license is available at http://www.gnu.org/copyleft/lesser.html
-->
<html xsl:version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xforms="http://www.w3.org/2002/xforms"
    xmlns:ev="http://www.w3.org/2001/xml-events"
    xmlns:xxforms="http://orbeon.org/oxf/xml/xforms"
    xmlns:xi="http://www.w3.org/2003/XInclude"
    xmlns:f="http://orbeon.org/oxf/xml/formatting"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml">

    <head>
        <title>Users</title>
        <xforms:model>
            <xforms:instance id="users-instance">
                <xsl:copy-of select="/*"/>
            </xforms:instance>
            <xforms:instance id="add-user-request">
                <query xmlns="">
                    <username/>
                    <password/>
                    <password2/>
                </query>
            </xforms:instance>
            <xforms:instance id="delete-user-request">
                <query xmlns="">
                    <username/>
                </query>
            </xforms:instance>
            <xforms:bind nodeset="instance('add-user-request')">
                <xforms:bind nodeset="username" constraint="normalize-space(.) != ''"/>
                <xforms:bind nodeset="password" constraint="normalize-space(.) != ''"/>
                <xforms:bind nodeset="password2" constraint="normalize-space(.) != '' and . = ../password"/>
            </xforms:bind>
            <xforms:submission id="add-submission" ref="instance('add-user-request')" replace="instance" instance="users-instance" method="post" action="/blog/admin/add-user">
                <xforms:action ev:event="xforms-submit-done">
                    <xforms:setvalue ref="instance('add-user-request')/username"/>
                    <xforms:setvalue ref="instance('add-user-request')/password"/>
                    <xforms:setvalue ref="instance('add-user-request')/password2"/>
                </xforms:action>
            </xforms:submission>
            <xforms:submission id="delete-submission" ref="instance('delete-user-request')" replace="instance" instance="users-instance" method="post" action="/blog/admin/delete-user">

            </xforms:submission>
        </xforms:model>
    </head>
    <body>
        <h2>Existing Blog Users</h2>
        <table class="gridtable">
            <tr>
                <th>Username</th>
                <th>Home</th>
                <th>Groups</th>
                <th>Action</th>
            </tr>
            <xforms:repeat nodeset="user" id="usersRepeat">
                <tr>
                    <td>
                        <xforms:output ref="@name"/>
                    </td>
                    <td>
                        <xforms:output value="@home"/>
                    </td>
                    <td>
                        <xforms:output value="string-join(group, ', ')"/>
                    </td>
                    <td>
                        <xforms:trigger>
                            <xforms:label>Delete</xforms:label>
                            <xforms:action ev:event="DOMActivate">
                                <xforms:setvalue ref="instance('delete-user-request')/username" value="instance('users-instance')/user[index('usersRepeat')]/@name"/>
                                <xforms:send submission="delete-submission"/>
                            </xforms:action>
                        </xforms:trigger>
                    </td>
                </tr>
            </xforms:repeat>
        </table>
        <h2>Add New User</h2>
        <table>
            <tr>
                <th style="text-align: right">Username</th>
                <td>
                    <xforms:input ref="instance('add-user-request')/username"/>
                </td>
            </tr>
            <tr>
                <th style="text-align: right">Password</th>
                <td>
                    <xforms:secret ref="instance('add-user-request')/password"/>
                </td>
            </tr>
            <tr>
                <th style="text-align: right">Password Check</th>
                <td>
                    <xforms:secret ref="instance('add-user-request')/password2"/>
                </td>
            </tr>
            <tr>
                <td>
                    <xforms:trigger>
                        <xforms:label>Add</xforms:label>
                        <xforms:action ev:event="DOMActivate">
                            <xforms:send submission="add-submission"/>
                        </xforms:action>
                    </xforms:trigger>
                </td>
            </tr>
        </table>
        <p>
            <a href="/blog">Back Home</a>
        </p>
    </body>
</html>
