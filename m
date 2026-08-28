Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FA8C61DC6
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:46:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D5510E49E;
	Fri, 28 Aug 2026 07:45:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vgujr3Xf";
	dkim-atps=neutral
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com
 [209.85.221.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A280210E2D9
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 04:17:53 +0000 (UTC)
Received: by mail-vk1-f176.google.com with SMTP id
 71dfb90a1353d-5c655961faaso458866e0c.1
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 21:17:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787890672; cv=none;
 d=google.com; s=arc-20260327;
 b=qQ+IB6KMAaJ58N+1fd+rRhad8c06YsUTDvmI9QeNp4Hi9m+aSQJ1DroUNO1BPDErEx
 snEr/Zv1MMLoLIQVJga3MkvfrbOym+Q8Ruf7L+zRVUl5fKEboNkatObA4lKGv8Ogf6oz
 8zFON22b21I2nAFRexBPPWcw3ndBlavI4JFCf+0djYWm3eUu2Gsf2nub+VSJlaRV8f87
 8sJAAKqVfeH2PmeEio4ohJUEZ3RRo/TR+rS1TuuutEaxwMTDNf1ueTktRS/oK2VptX81
 qxmSm1U3XQv53s+CXbnB+kbHWrhSthNnMJ56Ocizz7IdLKfD9Pd9w+F1eNJ6U2yRzwSt
 1EzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zBN51BWWmweo+i154ocyQbhGIJWDzeu7sG13UTEYjck=;
 fh=spuVsCobEnZXW8MH33FnOd8fymVMQeF6YvaFWxI1uuU=;
 b=HoLufg3UxN0DRXInyyGTIYtSYkrT3nPu6CTyZlh+Dxvly3WL1ryvRRay3f7wd4Ldf2
 xa4zRXmCSyANw8wFnzZxG7lMCEdKoN39zYgHl6a4QdoMgaBGzVQ3oRq5R27mJD9uBqo4
 mSC3SeXXxkn/aIWNT4tgjyX2Ds7XHZzZzupadKQsntUmwyr+wgaevJEfrHycoEZeal4C
 A8pQn/vc9a9yAMsAZ4dbAl7i1hchxKXLUy8hWzopnIWvYouMZ923tHon9RQw8nBc/VWb
 i3R8Zr+1NdEgn8oQwYlLW1FFb3LHvYUy3uJ8EnzfVYuxTm76uQU1exngM6Ovod73zA71
 DKwA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787890672; x=1788495472; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zBN51BWWmweo+i154ocyQbhGIJWDzeu7sG13UTEYjck=;
 b=Vgujr3XfghZfN4i7388ZBEUsx3jk/Nk6KZfhYZJwVb5Vh6aKTz2SHQeQRiElwJ4ZdV
 XdFbCUd5IRzZD6MYHQKGBycXqQsHAI6zTa5A4OvPTZWdGLPH55pAGSK8aArF/dihIqoK
 r8pdtQfdZNjI3Qbu6NOuXiBtVXafaiBNMcl4c2SSGZdxEWC7kdpHSHmf92TGT+haFp8+
 3K6Nd9UqLMzLtGhXEPkjwrsJZw4ejyXyI5XHYby8N8IAY0vd3eH2eZUnAhqWis9LZsZE
 BczJKYDcR2DXBgwiQr+4irN9DB17nBiPu/Ai1Zne8+5mUNgVt0TF/CGdvPQWO/Nmx8Xi
 FGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787890672; x=1788495472;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zBN51BWWmweo+i154ocyQbhGIJWDzeu7sG13UTEYjck=;
 b=eGi6PPN6pIr0m6cpTCGL5gCY2/uLyq/Yc5UuBA//S/RH1jm3ARhtUJUvDk/vkf5t2Z
 DEVLK/Vx8Nu6F33/vPpHwfutDXokCQ1cfyXMLrhnxqkESJV8dSLuuLSckNL5zunHqiwP
 a3Y3gYCtq2epihPxgybYl8c8v6/dR8atljUge9qmPu97cP7L+V1VBmRaosreXkg0OzA8
 5MxzQd5xG1oaoVX8HI6/34Ccf9wULe0HHwddWzMlwxg85ET39Znzhm/ppqQPfd6sURwk
 bxuFvJiPhWBgDpYi5SI/a/rxy+IWfjAeeIFR0XMAIo1Dbbtb5hGB4mn7npW9jFbcFswc
 fEKQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrp7oRZKNXzpgkgJIDzpZg2YlvMakia3LZglDzhk1Kor7rZM5MZS1RpYc+hEx/TyIVyk8WtSxbxieA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l2bx3cf+HjXfM94SN6k2jItF3RjT2spSCGVxgxrD/CTgSZswit
 TcOelVyYKpgbbBSMYhegryY9HmyNrAxxEF/QeGzMWoWX6JJD5E9K9CjYZOLbRRUKjeo0nU5mmD/
 wS81vt7Eusun2pSGQp8Pmxd0aAC1hMqQ=
X-Gm-Gg: AR+sD13YI1Tfo/xueWhZqEeS61HRSHSJJhlzaa0DJJBiAL3uuDMZ8G4THTevFWp9G9T
 4O5e5G9Eg+Ji79gkpl9fhmuaiUUaHykIjj11dDVpWh63Sd7azTUit5PWwkFvJQEi1kziZf82ylJ
 N+cjFKNupWnVRpTsVEu9PKRJciAciU2PAB7TowQdbrLNIlw9MiRTX5fu06MLCvPZy0jJ6uxpbk6
 PmomCrUKs5v9PmBFBlYUWth+KDrt/pFVl0r27GJU8eS5SFemR/s7bfE8+JN9JOw/rGHbfYqfxaI
 Cgork/PlqJJYvEJi5h8AmPQk4m8tpScoaF+cPQjF+D8UrJA=
X-Received: by 2002:a05:6123:55a:20b0:55b:d85:5073 with SMTP id
 71dfb90a1353d-5c6815a9470mr1515388e0c.4.1787890672262; Thu, 27 Aug 2026
 21:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260809053253.14537-1-amballip@gmail.com>
 <CAHp75VcFkgrcBKJcvm8Br164MA8jM1xRKahBuZ-WPgEBwfi5Fg@mail.gmail.com>
In-Reply-To: <CAHp75VcFkgrcBKJcvm8Br164MA8jM1xRKahBuZ-WPgEBwfi5Fg@mail.gmail.com>
From: Preetish Amballi <amballip@gmail.com>
Date: Fri, 28 Aug 2026 09:47:41 +0530
X-Gm-Features: AcwNN1UjbncowIGZYI_jbo6zgnrBvm41XQM_zlVVyMla13VDAyMZD9W4-NLQ3mw
Message-ID: <CAEnJ0XJqjTDrV4Leq9ZGBQSRRJ8Gg0Nr9O8ZB90cCQftC5of=w@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: Fix wrong controller name in fb_bd663474
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000006ae103065a13bc27"
X-Mailman-Approved-At: Fri, 28 Aug 2026 07:44:56 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

--0000000000006ae103065a13bc27
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Team,

Could you please merge this.

Regards,
Preetish

On Mon, 10 Aug, 2026, 12:37 pm Andy Shevchenko, <andy.shevchenko@gmail.com>
wrote:

> On Sun, Aug 9, 2026 at 8:33=E2=80=AFAM Preetish Amballi <amballip@gmail.c=
om>
> wrote:
> >
> > The file fb_bd663474.c is a driver for the BD663474 LCD controller,
> > but the comment header and MODULE_DESCRIPTION incorrectly reference
> > 'uPD161704' =E2=80=94 a copy-paste error from fb_upd161704.c.
> >
> > Fix the comment and MODULE_DESCRIPTION to say 'BD663474' instead of
> > 'uPD161704'.
>
> LGTM,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>
> --
> With Best Regards,
> Andy Shevchenko
>

--0000000000006ae103065a13bc27
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Team,<div dir=3D"auto"><br></div><div dir=3D"auto">Cou=
ld you please merge this.</div><div dir=3D"auto"><br></div><div dir=3D"auto=
">Regards,</div><div dir=3D"auto">Preetish=C2=A0</div></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Mon, 10 Aug, 2026, 12:37 pm Andy Shevchenko, &lt;<a href=3D"mailto:and=
y.shevchenko@gmail.com">andy.shevchenko@gmail.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">On Sun, Aug 9, 2026 at 8:33=E2=80=AFAM Preeti=
sh Amballi &lt;<a href=3D"mailto:amballip@gmail.com" target=3D"_blank" rel=
=3D"noreferrer">amballip@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; The file fb_bd663474.c is a driver for the BD663474 LCD controller,<br=
>
&gt; but the comment header and MODULE_DESCRIPTION incorrectly reference<br=
>
&gt; &#39;uPD161704&#39; =E2=80=94 a copy-paste error from fb_upd161704.c.<=
br>
&gt;<br>
&gt; Fix the comment and MODULE_DESCRIPTION to say &#39;BD663474&#39; inste=
ad of<br>
&gt; &#39;uPD161704&#39;.<br>
<br>
LGTM,<br>
Reviewed-by: Andy Shevchenko &lt;<a href=3D"mailto:andy@kernel.org" target=
=3D"_blank" rel=3D"noreferrer">andy@kernel.org</a>&gt;<br>
<br>
-- <br>
With Best Regards,<br>
Andy Shevchenko<br>
</blockquote></div>

--0000000000006ae103065a13bc27--
