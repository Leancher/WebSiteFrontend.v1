﻿<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="Page_Default" %>
<%
    Dim Link As String
    Link = Request.Url.GetLeftPart(UriPartial.Authority) + "\Page\" + Config.ContentPage + ".aspx?NumberPage=1"
    Response.Redirect(Link)
%>