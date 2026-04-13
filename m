Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47912EBFD15
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:01:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68B8B10E352;
	Mon, 13 Apr 2026 08:01:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QBmrFpTV";
	dkim-atps=neutral
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A664210E32E
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:11:11 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-466ec4c6846so1194136b6e.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 00:11:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776064271; cv=none;
 d=google.com; s=arc-20240605;
 b=hDsfH20C1u3xyjNXiTUbrLyzxY6czdBvP7NB/8iBhgxLXRewpDQBQUTg1QBbejqS+W
 fB3sCeaZYwsn6gA74oGlS89EQJk3KdIvprOUg1oISfgr48pp/RSFyDGvs6evI3eXdy8p
 Pz7pa4vHnTiE9RkR1avitRObaJBMOkEbJrsY9SzWyTjQrppu9NdjU4r65OlYplGu5Vax
 /CjbX/ntaqc0iB9qgf5HqVMZv/ORj7ZKAmOG3bERAhVGDsKGwdg5+b2k2leNvl/bFrOa
 Boa4v9YqhQUu005Dw8rSEN2pPpzTD/iAhzMmZSZnw9m83w4OKW3ftqmbrz6t68tAGoFp
 KMpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zGSCoUdPFVwPN27FrQTHuqyt/EFs1o+i79J34PS+QcU=;
 fh=jWQdDXxO3BjC+0LJQU+owkLMKmAH2qn0mNAzaoOFikc=;
 b=A6VpoMK51oVfnyXzqkV8jePtg6nxOkqHBUSlEVxSOQg9B5dtzaj6s74Yf9A5JLbHF7
 6EF32Rzi35xuBTbNe039FVbjfg5ScykGsIhRokLEjnh86BUg4Nvsn6oGsdHb+Dacq2Ed
 BmkB1s1eJ6lpVuvf7ey9FjVNn3i6jBQTrm1IdraqXw8DLZzk3yFehqEHkhKKONoZmQBu
 5SKO5Kq/Og9pQP4B3jteMeedTeMi599/H1n571fFie+i/5kJ+QRXvlRBpt32z+MTqmFP
 iUrxC3D3IpR5yqsmlRiNY1StfbLFVNgxLj+DZvFSaQuA8VBVDXTeeeFhGLFPRMvDQTVj
 lOaA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776064271; x=1776669071; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zGSCoUdPFVwPN27FrQTHuqyt/EFs1o+i79J34PS+QcU=;
 b=QBmrFpTV9aPjF8vrLc/28xNn+AqPGnrAp4k4xkXQRl2mzR5+KSqOXe/IMbCKoFM9wH
 P1Bvbda8qFN/cmqgWVsKmj6xwYWuJTXdjeuA0tadoQfRyzkq4fg55uut1knT4T6oqlDX
 WOLQ3KKOJIiZtcGD31/88zEhFp4VSBCVtpsLSyoBBEeU4ZQnRQPwwSGW+xupget1IlTc
 XMdWNvrckA++o/yrpA5MJaRKfnC/a9IJcC7ti7S4oataA/Pqbe3lrVGIObzWzvM5vMbS
 ZiFCRcIaPSC9v1z7gRvsgU2XSEPEpQhSsKITpW2AdAiphSL8579aYUitLQCJaWaIcV5S
 l9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776064271; x=1776669071;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zGSCoUdPFVwPN27FrQTHuqyt/EFs1o+i79J34PS+QcU=;
 b=X3w8xlu1I7O1FfK4ujMO6Ono8dEW1Knzyi/kNiCH28CK6rRxqtDtD74Wbv1W0qi7Si
 AXXKbsZdfZx+L1QEwZgSZslqdLjqKqO3u+QRIHB+0KE/qC5Q2oXOhy8kO5orE/TtKTKe
 6haOxq0gJySByctHkGzhwi24eebJqQtr9Dw9eZfjF0/oaBYu+rc2280oKTxT0Mf3dA15
 cJiNqdLUHSDAqeMVmJp+mEfG6IKdy6RzUMcnO+fzB5PJU8TVQ9yY2YKLF5TnPOHKmXz8
 YHtZJcZRKtQoy60NesGKMFz+bEGykGrFfVqZ8oa2GldUgrZNddEPm5HgUypaSNfDvkB+
 jJow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvu7ue2jCDJ0pteGZvUKwWLgtQefcdLEnKpnkaxMFLdKmsZ4weMoJJQ2yfsK1twxMjgFn1bdYb/E0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywq0jnB48AqR4T9WMQVjPOupzpScskmyX547X53pFUja59Jv97e
 8WsDhjq+qbxDJcSTWJRO0SwiR03Ad4ZiSyL0l9MIXalOWlXPoNXfMX9sEwagfYFLVhXbFbDXyDi
 yli6L5qBrValBENSSdYx2fUD6e3RnEe4=
X-Gm-Gg: AeBDiesKXe/ARqu4rGkEUuaE+K3iX05sbyGyqVmTch0lAjWtbTwsOWDOdgzTW8qxuA8
 w6YkNABPvshA6QX8zvwI/WcKGP5Q9lA0VxlSJ/BKSpV+F2szW9xP4NQaP3fH5Hf8yA5MnsIsXT+
 0ns0jgwJ94jatCcNN+uQalbCGIdDjWbMb+2+KC1FkMI5+aEBlpDPo9E7lr1E5HXsGTVJZnLX1kL
 UHnExFR/CFruX5qV6VGEWEdmFXEP+3Cb3tKqVWB1nNAaJxVi3J6+mPskn1mlGBBOqEg3SPZWVXp
 de3qIvaDxLSabvHLRuC8My5LPWGSiVOWizbj84/Y
X-Received: by 2002:a05:6808:5293:b0:468:2a6:e32c with SMTP id
 5614622812f47-4789e42ba5amr5566104b6e.10.1776064270811; Mon, 13 Apr 2026
 00:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20251218061406.8043-1-arjunchangla7@gmail.com>
 <2025121827-lubricant-salad-860c@gregkh>
 <CALO5-psPGGxo9bu4Yjs54Sj=Hpq4x4Zgvp6tEY2MzV+utUfGpA@mail.gmail.com>
 <CAHp75VeZyn+55A3T2_VCGUrvsRwODp2hJpL21Z46UeyOeYyQbg@mail.gmail.com>
In-Reply-To: <CAHp75VeZyn+55A3T2_VCGUrvsRwODp2hJpL21Z46UeyOeYyQbg@mail.gmail.com>
From: Arjun Changla <arjunchangla7@gmail.com>
Date: Mon, 13 Apr 2026 12:40:58 +0530
X-Gm-Features: AQROBzBnFKdo87rBxPW0uA3pJyv8SDAZU4XrzcZ8I8Vfi8n-qxoshQi1-RL63Qg
Message-ID: <CALO5-ptpdYs_YEKwhfKdVhz4yxgNxa41=xoC8ydoP1C0A9xzEA@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: fix spacing before close parenthesis
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, andy@kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000f5c873064f522f66"
X-Mailman-Approved-At: Mon, 13 Apr 2026 08:01:34 +0000
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

--000000000000f5c873064f522f66
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Apr 2026 at 12:30, Andy Shevchenko <andy.shevchenko@gmail.com>
wrote:

> On Mon, Apr 13, 2026 at 9:58=E2=80=AFAM Arjun Changla <arjunchangla7@gmai=
l.com>
> wrote:
> >
> >
> >
> > On Thu, 18 Dec 2025 at 11:50, Greg KH <gregkh@linuxfoundation.org>
> wrote:
> >>
> >> On Thu, Dec 18, 2025 at 06:14:06AM +0000, Arjun Changla wrote:
> >> > Fix checkpatch error "space prohibited before that close parenthesis=
"
> >> > on line 65 by removing the extra space.
> >> >
> >> > Signed-off-by: Arjun Changla <arjunchangla7@gmail.com>
> >> > ---
> >> >  drivers/staging/fbtft/fbtft-bus.c | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/drivers/staging/fbtft/fbtft-bus.c
> b/drivers/staging/fbtft/fbtft-bus.c
> >> > index 30e436ff19e4..2f7c891177fb 100644
> >> > --- a/drivers/staging/fbtft/fbtft-bus.c
> >> > +++ b/drivers/staging/fbtft/fbtft-bus.c
> >> > @@ -62,7 +62,7 @@ out:
>                               \
> >> >  }
>          \
> >> >  EXPORT_SYMBOL(func);
> >> >
> >> > -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> >> > +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
> >>
> >> But you just changed the function definition, does this still work now=
?
> >> If so, how?
> >>
> >> confused,
> >>
> >> greg k-h
> >
> >
> > Hi Greg,
> >
> > Thank you for the review. The change only removes extra spacing in
> > the function parameter - no functional changes were made.
> >
> > Before:
> >     const struct ia_css_output1_configuration *from ,
> >
> > After:
> >     const struct ia_css_output1_configuration *from,
> >
> > I verified the module builds successfully with no errors:
> >     make M=3Ddrivers/staging/fbtft
>
> What are you talking about?
> The original patch we are discussing is totally wrong. Please, compile
> the code before submitting.
>
> --
> With Best Regards,
> Andy Shevchenko
>

Hi Greg,

Thank you for catching this! You're absolutely right - my patch was wrong.

After looking at the macro definition, I now understand that the trailing
comma and space represent an empty 4th parameter (modifier) which is
required by the macro. Removing it breaks the macro invocation.

I apologize for not understanding the code properly before submitting.
I've learned an important lesson about analyzing macros carefully.

I'm withdrawing this patch.

Best regards,
Arjun

--000000000000f5c873064f522f66
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 13 Apr =
2026 at 12:30, Andy Shevchenko &lt;<a href=3D"mailto:andy.shevchenko@gmail.=
com">andy.shevchenko@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On Mon, Apr 13, 2026 at 9:58=E2=80=AFAM Arjun=
 Changla &lt;<a href=3D"mailto:arjunchangla7@gmail.com" target=3D"_blank">a=
rjunchangla7@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Thu, 18 Dec 2025 at 11:50, Greg KH &lt;<a href=3D"mailto:gregkh@lin=
uxfoundation.org" target=3D"_blank">gregkh@linuxfoundation.org</a>&gt; wrot=
e:<br>
&gt;&gt;<br>
&gt;&gt; On Thu, Dec 18, 2025 at 06:14:06AM +0000, Arjun Changla wrote:<br>
&gt;&gt; &gt; Fix checkpatch error &quot;space prohibited before that close=
 parenthesis&quot;<br>
&gt;&gt; &gt; on line 65 by removing the extra space.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: Arjun Changla &lt;<a href=3D"mailto:arjunchang=
la7@gmail.com" target=3D"_blank">arjunchangla7@gmail.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 drivers/staging/fbtft/fbtft-bus.c | 2 +-<br>
&gt;&gt; &gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/stag=
ing/fbtft/fbtft-bus.c<br>
&gt;&gt; &gt; index 30e436ff19e4..2f7c891177fb 100644<br>
&gt;&gt; &gt; --- a/drivers/staging/fbtft/fbtft-bus.c<br>
&gt;&gt; &gt; +++ b/drivers/staging/fbtft/fbtft-bus.c<br>
&gt;&gt; &gt; @@ -62,7 +62,7 @@ out:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 \<br>
&gt;&gt; &gt;=C2=A0 }=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<=
br>
&gt;&gt; &gt;=C2=A0 EXPORT_SYMBOL(func);<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )<br>
&gt;&gt; &gt; +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)<br>
&gt;&gt;<br>
&gt;&gt; But you just changed the function definition, does this still work=
 now?<br>
&gt;&gt; If so, how?<br>
&gt;&gt;<br>
&gt;&gt; confused,<br>
&gt;&gt;<br>
&gt;&gt; greg k-h<br>
&gt;<br>
&gt;<br>
&gt; Hi Greg,<br>
&gt;<br>
&gt; Thank you for the review. The change only removes extra spacing in<br>
&gt; the function parameter - no functional changes were made.<br>
&gt;<br>
&gt; Before:<br>
&gt;=C2=A0 =C2=A0 =C2=A0const struct ia_css_output1_configuration *from ,<b=
r>
&gt;<br>
&gt; After:<br>
&gt;=C2=A0 =C2=A0 =C2=A0const struct ia_css_output1_configuration *from,<br=
>
&gt;<br>
&gt; I verified the module builds successfully with no errors:<br>
&gt;=C2=A0 =C2=A0 =C2=A0make M=3Ddrivers/staging/fbtft<br>
<br>
What are you talking about?<br>
The original patch we are discussing is totally wrong. Please, compile<br>
the code before submitting.<br>
<br>
-- <br>
With Best Regards,<br>
Andy Shevchenko<br></blockquote><div>=C2=A0</div>Hi Greg,<br><br>Thank you =
for catching this! You&#39;re absolutely right - my patch was wrong.<br><br=
>After looking at the macro definition, I now understand that the trailing =
<br>comma and space represent an empty 4th parameter (modifier) which is <b=
r>required by the macro. Removing it breaks the macro invocation.<br><br>I =
apologize for not understanding the code properly before submitting. <br>I&=
#39;ve learned an important lesson about analyzing macros carefully.<br><br=
>I&#39;m withdrawing this patch.<br><br>Best regards,<br><div>Arjun=C2=A0</=
div></div></div>

--000000000000f5c873064f522f66--
