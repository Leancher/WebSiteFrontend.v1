﻿<%@ Control Language="VB" AutoEventWireup="false" CodeFile="RepairCar01.ascx.vb" Inherits="Content_RepairCar01" %>

<div class="ContentCaption">
    Кнопка открывания багажника
</div>
<div style="width:1000px;margin:0 auto;">

        <br />
        Установка актуатора замка и кнопки в дверь багажника. 
        При снятии с охраны, с помощью кнопки разблокировать замок и затем рукой открыть дверь.
        <br />
        <br />
        <%
                Response.Write("<img src='../" + Config.ContentPhotoFolder + "/RepairCar01-01.jpg' />")
        %>
        <br />
        <%
                Response.Write("<img src='../" + Config.ContentPhotoFolder + "/RepairCar01-02.jpg' />")
        %>
        <br />
        <%
                Response.Write("<img src='../" + Config.ContentPhotoFolder + "/RepairCar01-03.jpg' />")
        %>
        <br />
</div>

