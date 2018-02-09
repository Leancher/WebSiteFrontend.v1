﻿<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Cat-MyPhoto.ascx.vb" Inherits="Page_04_MyPhoto" %>
    <div class="TileGrid">
        <%
            Dim CurrentTile As Integer
            Dim NumberTable As Integer = 3
            Dim Database As New DatabaseConnect()
            Database.DatabaseOpen()
            For CurrentTile = 1 To Database.GetCountRow(Config.TableAlbumPhoto)
                Response.Write("<div class='TileCell'>")
                Response.Write("<a href ='./" + Config.ContentPage + ".aspx?ShowAlbum=" + CurrentTile.ToString + "'>")

                Response.Write("<div>")
                Response.Write("<img src='../" + Config.PreviewAlbumFolder + "/Album0" + CurrentTile.ToString + ".jpg' />")
                Response.Write(Database.GetRecordDB(Config.TableAlbumPhoto, CurrentTile, 1))
                Response.Write("</div>")

                Response.Write("</a>")
                Response.Write("</div>")
            Next CurrentTile
            Database.DatabaseClose()
        %>
    </div>