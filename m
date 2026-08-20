Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFC5C5DF87
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F7A210F01A;
	Thu, 20 Aug 2026 13:24:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dowhile0-org.20251104.gappssmtp.com header.i=@dowhile0-org.20251104.gappssmtp.com header.b="R0NDnKvj";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 250B610F01A
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 13:24:50 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c207cb16cf5so382381866b.1
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 06:24:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787232288; cv=none;
 d=google.com; s=arc-20260327;
 b=WgD8iQi4k/+EC3xozc7OfapVwSzsiV1K0sN0Iwo15wfRJyzalndkU47BWP3bYk7Zje
 Fdwjh0+cDXhcX5Ly2bb8l1ah73IbU+f4mq+1F8bEroUsmAIYxhWCLw+vLn+1yOdDJEqq
 +DbCK97BrC56MmrzHCPd7nRYjq/WDxj5k9onaiVoxYlEsT2S9DiL0UANKDkzuHQg/yI3
 qlWQK/FPLGjVFA8Z0OuGYFYv9gEQpEXdQVSHEOVm16b72v0iIrq17T9aJzczb7GMgTCt
 PtJtIsCl9+qRoMlNdZ8JULenLxdcdGC24yePgX6ZvKXCaEm+ZbEyYtzC6NUEh99UpQ69
 sIxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sh/IA4IgJH9flMK/xwgm5kp/HRJXQHmejUDGLKWQVUk=;
 fh=wV73BJwLCdnGxqxxJpEd19y82QG/kmzKp+4qd2lxoEg=;
 b=nM9ba9xj5aDOVFK6F5YFIdtlNboF+Mz9KjQ6h+KNAjE+EUOcgBzpFlSXBUa0kxpQ1B
 ydeGBsPuPd8Pne5zianbmF2jYyK24oRpzajAbK4pXVeboyl+IbvGmgeJeUWtvQ+PhPSa
 PdKVzkd7dV8duI2D92Z6x44VJkKT/u4oHMBxcM6xnxpntu9NWYx35KDiywwAOQE+W1WD
 HJTw5XgP0dxuI6MWuCfTM+aK+J1enNvstwYLGWMEPQ72JB5tFBcuKDDBBTup+GABzr+2
 5vuHXH6htWqe9I/WPVDIh3zuRyhZQ/f2MxYgyO5kYiSmvA03IpimfAHIZBd06s6sV9cr
 wCMg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dowhile0-org.20251104.gappssmtp.com; s=20251104; t=1787232288; x=1787837088;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sh/IA4IgJH9flMK/xwgm5kp/HRJXQHmejUDGLKWQVUk=;
 b=R0NDnKvjzMPD6wQLqtdB7Xv7WvDDMlTMFoc6mO+U/Lo5kpH6b/39y6N3o/RUdjtYoz
 m2p3PjDgGagyu8J61tYOImPXLfMVP+QcMmOsEy52uuBT65LD++RnrYxx/+32H9qoFgsc
 plBoI1jp5ICccSc9Sjfj8Bds8z/2a6iH6fqj9orsIyaTqz2olcnn4ZvrDaoj9ZU0WPgk
 4ttbZ9q4Q2aDapuL8ozKpJuhXx7j+MM3Z1CPLfJqvKrqF0xQuS+5pvWDAgSHpN0OHnEU
 jjdHxaHKyiM7zdVTmvnOHyiyIKYTcEjaTNzibIgqwtB255vV9eSIOP71U9pJrPGgDRo6
 GY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787232288; x=1787837088;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sh/IA4IgJH9flMK/xwgm5kp/HRJXQHmejUDGLKWQVUk=;
 b=KonyJR+Bh/VWKfKP5HR8OyG8MGIeS2DKNvI/MM3ZjH0SNzdxg6vgbbfPa50zc9cgCf
 AKvckDsUFuQIDoYzWbVnLeuhJWy67fmZfvumqUKcDJWx5ra5+qeMWEgousL/G2gt2J2G
 bcHNyulyq1JgDSX+Ptl5o72XejueHcwohjqqlasWCUz1999VPaF544S/977yK95jLxQB
 enYzfNHUtNAEvUOzyZ9jXxxpxaclKN8U+b1rVmiW5Tn60l+IQ8uR93Vt225mO2eNQuTQ
 cvzsI1A+ykjnXw7oxG/eYqrnJPzHX3/a4wehJH7LmkFHs/Y5zix8YTLNJoANs9h+R1u6
 WXYw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpIR6/YzK5AC5hp8oe56G3IvDZwwYOqLF5DJjm7IvTr4Rl9GsDA3EEeSpQW9MglCHR+4vZBlj7Jxsw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdAtHISSXFiuoOMZJ8zjwY7ymDSwk/6YhG9VAR87JsL5ropfO7
 9HPndGTq2ofZrWgGM6P85uEXo53tBIsy4rF1jzI1vCxZvqiS1A/KIY5jhK8+hJ/rLqaaD5irOzD
 bbhNy7TJszZJa0s+SELh+maDRtue7EII+j3TqMb5X6w==
X-Gm-Gg: AR+sD13STyQYYMIcMPOwLhEnbBPye0Bzg6pGz+4YJ/SzjWI0QemTT8jTCS5s2ZbRRww
 WqovDyMSvBBynKgDMjjES4tW5xAv1HBO5YgFYj1U8g9yNjjjkOCMb1wMsg8SrPEhPhX//oWSJWS
 cyVRoolCgh280BS1CuxVO3eFl9BeLXhBJNnF7pHxZmKvXqDg6O8TBVfFvXW9Uz/FS+SvUBTOgsy
 Kzd1JYPqoeOs6jYp3/9jkO/O4aIkmGjWMDk8CCiClgLdApVwG2yRVqsy/60TBzR0zdPOJdxg/rY
 0lpWI6fq2tDp+c1mXNGGKOqZgx3roLabOlRWyG6IeTFiBA==
X-Received: by 2002:a17:907:c80f:b0:c21:8723:276 with SMTP id
 a640c23a62f3a-c2403c76f78mr1064627466b.15.1787232286168; Thu, 20 Aug 2026
 06:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260818080626.30430-1-amit.barzilai22@gmail.com>
 <20260818080626.30430-5-amit.barzilai22@gmail.com>
 <aoQalR40NMFSg8zS@ashevche-desk.local>
 <CAOEgbEoMOR+WS7TzY5+k6G464uUdp+rHJqvhY+6gRE8nCaT=gQ@mail.gmail.com>
 <CAOEgbEq7D4mkie=DUqrE-Q_bN49ekoCFiyB7ihPS5T=A=kCoVw@mail.gmail.com>
In-Reply-To: <CAOEgbEq7D4mkie=DUqrE-Q_bN49ekoCFiyB7ihPS5T=A=kCoVw@mail.gmail.com>
From: Javier Martinez Canillas <javier@dowhile0.org>
Date: Thu, 20 Aug 2026 10:24:35 -0300
X-Gm-Features: AcwNN1V0h_QEG0pihmyTWzq2pAkjx-UlCfKU-wvKLnxAYrQMgS7pQHhEa8L_eiQ
Message-ID: <CABxcv=m2L_N+WOLX8SP2ia=FWUqvB8aqFWON5kc-zoBxuMp-SA@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] drm/ssd130x: Replace positional ssd130x_spi_id[]
 initialization with C99
To: Amit Barzilai <amit.barzilai22@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Fabio Piparo <holofermes@gmail.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000008c7e0906597a717d"
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

--0000000000008c7e0906597a717d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Amit,

On Thu, Aug 20, 2026 at 06:06 Amit Barzilai <amit.barzilai22@gmail.com>
wrote:

> On Tue, Aug 18, 2026 at 10:25=E2=80=AFPM Amit Barzilai
> <amit.barzilai22@gmail.com> wrote:
> >
> > On Tue, Aug 18, 2026 at 11:41=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> >
> > > >  static const struct spi_device_id ssd130x_spi_id[] =3D {
> > > >       /* ssd130x family */
> > > > +     { .name =3D "sh1106", .driver_data =3D SH1106_ID },
> > >
> > > Hmm... Is the comment correct for sh1106?
> > >
> > > >       /* ssd132x family */
> > > >       /* ssd133x family */
> > >
> > > Overall, what do these comment bring us? Are those families have
> something in
> > > common? Because the driver data is unique for each device, so I assum=
e
> it's not
> > > that compatible inside even the same families.
> > >
> > > TL;DR: Perhaps simply drop those comments for once?
> >
> > Agreed, I'll remove the comments in v5.
>
> Having looked closer, I'd rather keep the comments in v5.
>
> The same grouping comments are used throughout ssd130x.c,
> ssd130x-spi.c, ssd130x.h and ssd130x-i2c.c. Dropping them from
> ssd130x_spi_id[] alone would leave the driver inconsistent, and
> dropping them everywhere is a cleanup of its own rather than
> something this series should carry.
>
> The comment is correct for sh1106: ssd130x_variants[SH1106_ID] sets
> .family_id =3D SSD130X_FAMILY.
>
> And the families do mean something concrete here. family_id is what
> indexes the plane, CRTC and encoder helper vtables and the backlight
> ops.


I=E2=80=99m on vacation for a few weeks and I can=E2=80=99t review your pat=
ches but I do
agree with you.

Please leave the comments.

Best regards,
Javier

--0000000000008c7e0906597a717d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hello Amit,</div><div><br><div class=3D"gmail_quote gmail=
_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 20, 202=
6 at 06:06 Amit Barzilai &lt;<a href=3D"mailto:amit.barzilai22@gmail.com">a=
mit.barzilai22@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">On Tue, Aug 18, 2026 at 10:25=E2=80=AFPM Amit Barzi=
lai<br>
&lt;<a href=3D"mailto:amit.barzilai22@gmail.com" target=3D"_blank">amit.bar=
zilai22@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Tue, Aug 18, 2026 at 11:41=E2=80=AFAM Andy Shevchenko<br>
&gt; &lt;<a href=3D"mailto:andriy.shevchenko@intel.com" target=3D"_blank">a=
ndriy.shevchenko@intel.com</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; &gt;=C2=A0 static const struct spi_device_id ssd130x_spi_id[] =3D=
 {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* ssd130x family */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0{ .name =3D &quot;sh1106&quot;, .driver=
_data =3D SH1106_ID },<br>
&gt; &gt;<br>
&gt; &gt; Hmm... Is the comment correct for sh1106?<br>
&gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* ssd132x family */<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* ssd133x family */<br>
&gt; &gt;<br>
&gt; &gt; Overall, what do these comment bring us? Are those families have =
something in<br>
&gt; &gt; common? Because the driver data is unique for each device, so I a=
ssume it&#39;s not<br>
&gt; &gt; that compatible inside even the same families.<br>
&gt; &gt;<br>
&gt; &gt; TL;DR: Perhaps simply drop those comments for once?<br>
&gt;<br>
&gt; Agreed, I&#39;ll remove the comments in v5.<br>
<br>
Having looked closer, I&#39;d rather keep the comments in v5.<br>
<br>
The same grouping comments are used throughout ssd130x.c,<br>
ssd130x-spi.c, ssd130x.h and ssd130x-i2c.c. Dropping them from<br>
ssd130x_spi_id[] alone would leave the driver inconsistent, and<br>
dropping them everywhere is a cleanup of its own rather than<br>
something this series should carry.<br>
<br>
The comment is correct for sh1106: ssd130x_variants[SH1106_ID] sets<br>
.family_id =3D SSD130X_FAMILY.<br>
<br>
And the families do mean something concrete here. family_id is what<br>
indexes the plane, CRTC and encoder helper vtables and the backlight<br>
ops.</blockquote><div dir=3D"auto"><br></div><div dir=3D"auto">I=E2=80=99m =
on vacation for a few weeks and I can=E2=80=99t review your patches but I d=
o agree with you.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Please=
 leave the comments.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Bes=
t regards,</div><div dir=3D"auto">Javier</div></div></div>

--0000000000008c7e0906597a717d--
