﻿<%@ Control Language="VB" AutoEventWireup="false" CodeFile="PhotoViewer.ascx.vb" Inherits="Page_ViewerPhotoAlbum" %>
<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', ShowContent);

    var PhotoPlace, SinglePhoto, LinkFullSize;
    var CurrentDocument;
    var NumberAlbum;
    var CategoryAlbum;
    var ListPhotos;
    var BtNext, BtPrev, ReturnBack, CurrentNumberPhoto;
    
    function ShowContent() {
        CurrentDocument = document;
        Content = document.getElementById("Content");
        BtNext = document.getElementById("BtNext");
        BtPrev = document.getElementById("BtPrev");
        ReturnBack = document.getElementById("ReturnBack");
        GetQueryString();
        ShowGallery();
    }

    function GetQueryString() {
        var pairs = location.search.substring(1).split("&");
        for (var i = 0; i < pairs.length; i++)
        {
            var pos = pairs[i].indexOf('=');
		    if (pos == -1) continue;
            var name = pairs[i].substring(0, pos);
            var value = pairs[i].substring(pos + 1);
            if (name == 'category') CategoryAlbum = value;
            if (name == 'ID') NumberAlbum = value;
        }
    }
   
    function ShowGallery() {
        var Request = new XMLHttpRequest();
        Request.open('GET', 'Page/GetPhotos.aspx?Command=ListPhoto&Category=' + CategoryAlbum + '&Album=' + NumberAlbum, true);
        Request.onreadystatechange = function () {
            if (Request.readyState == 4) {
                var ResponseString = Request.responseText;
                ListPhotos = ResponseString.split(";");
                //Если файлов нет и строка пустая, список равен нулю
                if (ResponseString == '') ListPhotos = 0;               
                SetPhotoGrid();
            }
        }
        Request.send();
    }

    function SetPhotoGrid(event) {
        BtPrev.style.display = 'none';
        BtNext.style.display = 'none';
        ReturnBack.style.display = 'none';
        //Если блок с фотками уже существует, то удаляем его
        if (PhotoPlace != undefined) Content.removeChild(PhotoPlace);
        //Создаем пустой блок
        PhotoPlace = CurrentDocument.createElement('div');
        //Если список фоток пуст, то пишем, что нет картинок
        if (ListPhotos == 0)
        {
            PhotoPlace.innerText = "В этом альбоме нет картинок";
        }
        else
        {
            //Если картинки есть, то создаем сетку с фотками
            for (var i = 0; i < ListPhotos.length; i++) {
                var PhotoCell = CurrentDocument.createElement('div');
                PhotoCell.className = 'PhotoCell';
                var img = CurrentDocument.createElement('img');
                img.src = 'Pictures/' + CategoryAlbum + '/album' + NumberAlbum + 'Preview/' + ListPhotos[i];
                var lnk = CurrentDocument.createElement('a');
                //Через хэш в адресной строке пережаем номер картинки
                lnk.href = '#' + i;
                lnk.onclick = function () {
                    var PhotoNumber = this.hash.substring(1);
                    ShowPhoto(event,PhotoNumber);
                    event.preventDefault();
                }
                lnk.appendChild(img);       
                PhotoCell.appendChild(lnk);
                PhotoPlace.appendChild(PhotoCell);
            }
        }
        Content.appendChild(PhotoPlace);
        event.preventDefault();        
    }

    function ShowPhoto(event, PhotoNumber) {
        BtPrev.style.display = 'block';
        BtNext.style.display = 'block';
        ReturnBack.style.display = 'block';
        CurrentNumberPhoto = +PhotoNumber; // + означет, что переменная число
        Content.removeChild(PhotoPlace);
        PhotoPlace = CurrentDocument.createElement('div');
        //Создаем ссылку на картинку в полном размере
        LinkFullSize = CurrentDocument.createElement('a');
        LinkFullSize.href = 'Pictures/' + CategoryAlbum + '/album' + NumberAlbum + '/' + ListPhotos[PhotoNumber];
        //Создаем картинку
        SinglePhoto = CurrentDocument.createElement('img');
        SinglePhoto.className = 'CurrentPhoto';
        SinglePhoto.src = 'Pictures/' + CategoryAlbum + '/album' + NumberAlbum + '/' + ListPhotos[PhotoNumber];
        //Добавляем в тело ссылки каринку
        LinkFullSize.appendChild(SinglePhoto);
        PhotoPlace.appendChild(LinkFullSize);
        Content.appendChild(PhotoPlace);
        event.preventDefault();
    }

    function BtNext_Click(event) {
        CurrentNumberPhoto = CurrentNumberPhoto + 1;  
        if (CurrentNumberPhoto > ListPhotos.length - 1) CurrentNumberPhoto = ListPhotos.length - 1;
        LinkFullSize.href = 'Pictures/' + CategoryAlbum + '/album' + NumberAlbum + '/' + ListPhotos[CurrentNumberPhoto];
        SinglePhoto.src = 'Pictures/' + CategoryAlbum + '/album' + NumberAlbum + '/' + ListPhotos[CurrentNumberPhoto];
        event.preventDefault();        
    }
    function BtPrev_Click(event) {
        CurrentNumberPhoto = CurrentNumberPhoto - 1;
        if (CurrentNumberPhoto < 0) CurrentNumberPhoto = 0;
        LinkFullSize.href = 'Pictures/' + CategoryAlbum + '/album' + NumberAlbum + '/' + ListPhotos[CurrentNumberPhoto];
        SinglePhoto.src = 'Pictures/' + CategoryAlbum + '/album' + NumberAlbum + '/' + ListPhotos[CurrentNumberPhoto];
        event.preventDefault();
    }
</script>
<a href ="/" id="ReturnBack" onclick="SetPhotoGrid(event)" style="display:none" class="HeaderMenu">Вернуться в галлерею</a>         
<div style ="display:flex">
    <div class="Button">
        <a href ="/" id="BtPrev" onclick ="BtPrev_Click(event)" style="display:block">         
            <img src="Pictures/Util/ArrowLDis.png" onmousemove="this.src='Pictures/Util/ArrowLEn.png'" onmouseout="this.src='Pictures/Util/ArrowLDis.png'" />
        </a>
    </div>
    <div id="Content" class="PhotoPlace">
        
    </div>
    <div class="Button">
        <a href ="/" id="BtNext" onclick ="BtNext_Click(event)" style="display:block">         
            <img src="Pictures/Util/ArrowRDis.png" onmousemove="this.src='Pictures/Util/ArrowREn.png'" onmouseout="this.src='Pictures/Util/ArrowRDis.png'" />
        </a>
    </div>
</div>