Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4015FFF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 10:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EC1210E049;
	Mon, 27 Apr 2026 10:12:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZsW1AGsX";
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2DBD10E049
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 10:12:08 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-65c0891f4e9so16521431a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 03:12:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777284727; cv=none;
 d=google.com; s=arc-20240605;
 b=IoadfRYtLDPDS6rLlq2bfn3/m7j+ktOG1pSG1z1jxda2lNA22DXo+4RP6kDsRhNqUz
 TE6qD9UaUkzqTAqiiiu4GVImnHeMvrHgb9Hqk0fISg9NUY8FS/8KZI6CwLZawajy35J2
 iQ30464DZtpJtL0IIrQHgJ6DCFOEUqH6WcFIUhUJu4CJ4HLJLen60DbriiWchBhG8I6S
 07XlSknIVKu28I3M+QDlu5+3SZm16a/dnTGP7BVHbc77vm4ZiRKI5KjmgQpDz4nnNQoS
 Zi68wPbZ/NbdLdvBAVorSkrRw4je5k77Cv9iNzrfwaCaCfJqRO+0fE3jR86ZP+SU2XlZ
 7Z4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xxVjMAJ5WIDeoH90N0OSa6Q2gvo+dB0qNBxhCOsG7S8=;
 fh=6N2C3Mcc1XH0djtUzpv8S3rdW4VAIrTAJu4531BfNK4=;
 b=Pw/hlykzOFmrDisyJcgeeK4mb2OePxCVHn9YlIdGXgY77r9xSLPe+Qz1GKdLPgnO88
 0q9Vxjvr8irFxdkV9HhtjyzpbZDTGn/n80pb02s/UOTHNb3+NF1neo3b089c/lTLOesZ
 4Q+3Eai41yR7LZGRQ4Ve6bLLpfmq/80bFy3FPIZgNJVAeC/a7l/ldX17YJNd4COW84o/
 QKMLEvgPSgkgvRqh5MOXEFU1aSwWXdsx7pTHXWliRhVm0I8TO1fAweezSzq7QjFcUVsq
 Y7hiBlBn3ir2rsWXtG4mAY9oNriaIbI7ljokOyctHQXAVfLdUQpCgpkvPpokn5kBl+3I
 pfyw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777284727; x=1777889527; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xxVjMAJ5WIDeoH90N0OSa6Q2gvo+dB0qNBxhCOsG7S8=;
 b=ZsW1AGsXxVoc8ki+5PX3AzeZ3+QuGnWvZv+LtOi4Qaq2m2PYMG3nAwLurExnLGFGM5
 NrkxT6zQTnn0rcrV89sjiom9yQc5Tj4MlclLFsoa5J8HVwI3MLIj4PSHP/PBN7Hx6Q+P
 vyqkWs1ibFLxb33reANugKas7412QBtjtLEKm4iwK0gnCyVTqtJhrxSKrigTMbCHEdmp
 B1P7OlZocazLo7inSn5JnRzYILZq9SMrLzv4+eUXzi2ysFaedf8JIaaiEU6qRWWvhRJt
 kOzaehhSaKKdy/RaXqRtuXsyl4lE6EWZ74xE4snrJABZwT0ya+LqEN0F1Aih0mqYVQDB
 Fz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777284727; x=1777889527;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xxVjMAJ5WIDeoH90N0OSa6Q2gvo+dB0qNBxhCOsG7S8=;
 b=WUHu/ij8ULLWKTAwzkpi9t+5+aFH0Whb55IQQvTESxeFwdhE0vKW71G+88lBScca+n
 u1bj37SzeNIkiL7JKwC+L7/RCm98Q3/sjuQBgyYiEIeI82sQOiR0+teSeTfWVCmiYgaO
 86Y9TCmf99I+Vxgn0BBz6LqYPcAb+qQ/uuAKVJt3yWwBWZGxcCUcbtr3Ht2UxBjgS//a
 HKSpwy9hNWP0e200ABOhMTZi1H/kVHBYY8/AHWlDm7TqQ/mqpEdjCu/RQj7pMRU0ppKl
 +dMnOgYPB15pbl6NZmEOBGiuySkDmdTS0ALQKx/InQ5Te5xCWu/hewhBQtZ+qRFr2Yc+
 wbKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ClpgjRA9fIYk6E3wjOgtWDB+Jrk9pJpJwoOLyIsgUsff3Z+7Pv9mgpvrAdzaXGlzyuSimPnIaTdk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxmv9bjTTNsrJHCGVZ8e7MvaDzWTeanDQrFyMKzwUeykbx0Uiy+
 shJufGaSXy4H55HH1QEc2j9uoSbsWhk7XW5Eax90PabU46IXOOhCiUT3a0lmD77o2LAXD1X1jlm
 6YRk4YgWr56p4GHQ/hdXtFPBaQlk50OVrHM8efDvm
X-Gm-Gg: AeBDievw/qz6mUUCLTqY23zazp2hgAOWWyoxkoGFkaTjsAUDnTw4cZ98ThkBeur0XFJ
 ag3Vo7Ibur/S2/Ax9JXqOcG5afdogMQba5A523PtYBEc0fvURw2qzT2uDGJFEwtONkPxg9kU09i
 FWDBqUQzwdebc3n24eOz0RjZsBCqBKTjZn5RLeZWKI+WnC3gK4xHxirN8jdwsreFd5lsO9XG0UK
 dzwEjgq9kKU8COBba1SO0N2vpOXjD3TWJHx5i90GjUOapihn3OH1YI/+4cF6UoUnrB8RkbCy3dv
 OFBQMiSGdWTv3ANYVp0gwKaR0nnQzSO72qcI0OO/UyCJD2k=
X-Received: by 2002:a05:6402:510b:b0:672:92f:fdf5 with SMTP id
 4fb4d7f45d1cf-672bfdd1c84mr18194030a12.14.1777284726747; Mon, 27 Apr 2026
 03:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260424115936.7930-1-mhun512@gmail.com>
 <TY3PR01MB11346F8E6E2B73C32DF73E0B1862B2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB11346F8E6E2B73C32DF73E0B1862B2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 27 Apr 2026 19:11:54 +0900
X-Gm-Features: AVHnY4IlVgwA1QWnMq_Z_I6va9HatMk1P5gIY0mQ6hkxaMzr-w9_BmsM05W57hA
Message-ID: <CAGEsz8Eh11Rqw8jsxQaPuqW=EU91+ohRcGo2ADtWO7A2L7pNTA@mail.gmail.com>
Subject: Re: [PATCH] drm/renesas: rz-du: Fix MIPI DSI host leak on probe
 failure
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/alternative; boundary="000000000000cd753a06506e58d2"
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

--000000000000cd753a06506e58d2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Biju,

Thank you for the quick reply.

I've confirmed that a similar patch has already been posted.

Thanks,
Myeonghun Pak

2026=EB=85=84 4=EC=9B=94 24=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 9:11, B=
iju Das <biju.das.jz@bp.renesas.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Hi Myeonghun Pak,
>
> Thanks for the patch.
>
> > -----Original Message-----
> > From: Myeonghun Pak <mhun512@gmail.com>
> > Sent: 24 April 2026 12:59
> > Subject: [PATCH] drm/renesas: rz-du: Fix MIPI DSI host leak on probe
> failure
> >
> > rzg2l_mipi_dsi_probe() registers the MIPI DSI host before allocating th=
e
> DCS buffer. If
> > dma_alloc_coherent() fails, probe returns -ENOMEM directly and leaves
> the host registered.
> >
> > The remove callback unregisters the host, but remove is only called
> after a successful probe. Add a
> > local unwind path that unregisters the host before disabling runtime PM
> on the DCS buffer allocation
> > failure path.
>
>
> A similar patch [1] already posted
>
> [1]
> https://lore.kernel.org/linux-renesas-soc/TY3PR01MB113464115454EB533EE670=
E81862B2@TY3PR01MB11346.jpnprd01.prod.outlook.com/T/#m3c56399b78f8661ff2b5b=
fc2f2d8a1364a9ebf7d
>
> Cheers,
> Biju
>
> >
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> >  drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> b/drivers/gpu/drm/renesas/rz-
> > du/rzg2l_mipi_dsi.c
> > index 29f2b7d24f..309fae1459 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> > @@ -1476,14 +1476,19 @@ static int rzg2l_mipi_dsi_probe(struct
> platform_device *pdev)
> >
> >       dsi->dcs_buf_virt =3D dma_alloc_coherent(dsi->host.dev,
> RZG2L_DCS_BUF_SIZE,
> >                                              &dsi->dcs_buf_phys,
> GFP_KERNEL);
> > -     if (!dsi->dcs_buf_virt)
> > -             return -ENOMEM;
> > +     if (!dsi->dcs_buf_virt) {
> > +             ret =3D -ENOMEM;
> > +             goto err_host_unregister;
> > +     }
> >
> >       return 0;
> >
> >  err_phy:
> >       dsi->info->dphy_exit(dsi);
> >       pm_runtime_put(dsi->dev);
> > +     goto err_pm_disable;
> > +err_host_unregister:
> > +     mipi_dsi_host_unregister(&dsi->host);
> >  err_pm_disable:
> >       pm_runtime_disable(dsi->dev);
> >       return ret;
> > --
>

--000000000000cd753a06506e58d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span class=3D"gmail-rnc2Gd" style=3D"color:rgb(31,31,31);=
font-family:&quot;Google Sans&quot;,Roboto,Arial,sans-serif;font-size:15.75=
px;font-variant-ligatures:no-contextual">Hi Biju,</span><div class=3D"gmail=
-gWqWw gmail-rnc2Gd" style=3D"color:rgb(31,31,31);font-family:&quot;Google =
Sans&quot;,Roboto,Arial,sans-serif;font-size:15.75px;font-variant-ligatures=
:no-contextual"><br></div><span class=3D"gmail-rnc2Gd" style=3D"color:rgb(3=
1,31,31);font-family:&quot;Google Sans&quot;,Roboto,Arial,sans-serif;font-s=
ize:15.75px;font-variant-ligatures:no-contextual">Thank you for the quick r=
eply.</span><div class=3D"gmail-gWqWw gmail-rnc2Gd" style=3D"color:rgb(31,3=
1,31);font-family:&quot;Google Sans&quot;,Roboto,Arial,sans-serif;font-size=
:15.75px;font-variant-ligatures:no-contextual"><br></div><span class=3D"gma=
il-rnc2Gd" style=3D"color:rgb(31,31,31);font-family:&quot;Google Sans&quot;=
,Roboto,Arial,sans-serif;font-size:15.75px;font-variant-ligatures:no-contex=
tual">I&#39;ve confirmed that a similar patch has already been posted.<br><=
br></span><span class=3D"gmail-rnc2Gd" style=3D"color:rgb(31,31,31);font-fa=
mily:&quot;Google Sans&quot;,Roboto,Arial,sans-serif;font-size:15.75px;font=
-variant-ligatures:no-contextual">Thanks,<br></span><span class=3D"gmail-rn=
c2Gd" style=3D"color:rgb(31,31,31);font-family:&quot;Google Sans&quot;,Robo=
to,Arial,sans-serif;font-size:15.75px;font-variant-ligatures:no-contextual"=
>Myeonghun Pak</span></div><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">2026=EB=85=84 4=EC=9B=94 24=EC=
=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 9:11, Biju Das &lt;<a href=3D"mailto:=
biju.das.jz@bp.renesas.com">biju.das.jz@bp.renesas.com</a>&gt;=EB=8B=98=EC=
=9D=B4 =EC=9E=91=EC=84=B1:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hi Myeonghun Pak,<br>
<br>
Thanks for the patch.<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Myeonghun Pak &lt;<a href=3D"mailto:mhun512@gmail.com" target=3D=
"_blank">mhun512@gmail.com</a>&gt;<br>
&gt; Sent: 24 April 2026 12:59<br>
&gt; Subject: [PATCH] drm/renesas: rz-du: Fix MIPI DSI host leak on probe f=
ailure<br>
&gt; <br>
&gt; rzg2l_mipi_dsi_probe() registers the MIPI DSI host before allocating t=
he DCS buffer. If<br>
&gt; dma_alloc_coherent() fails, probe returns -ENOMEM directly and leaves =
the host registered.<br>
&gt; <br>
&gt; The remove callback unregisters the host, but remove is only called af=
ter a successful probe. Add a<br>
&gt; local unwind path that unregisters the host before disabling runtime P=
M on the DCS buffer allocation<br>
&gt; failure path.<br>
<br>
<br>
A similar patch [1] already posted<br>
<br>
[1] <a href=3D"https://lore.kernel.org/linux-renesas-soc/TY3PR01MB113464115=
454EB533EE670E81862B2@TY3PR01MB11346.jpnprd01.prod.outlook.com/T/#m3c56399b=
78f8661ff2b5bfc2f2d8a1364a9ebf7d" rel=3D"noreferrer" target=3D"_blank">http=
s://lore.kernel.org/linux-renesas-soc/TY3PR01MB113464115454EB533EE670E81862=
B2@TY3PR01MB11346.jpnprd01.prod.outlook.com/T/#m3c56399b78f8661ff2b5bfc2f2d=
8a1364a9ebf7d</a><br>
<br>
Cheers,<br>
Biju<br>
<br>
&gt; <br>
&gt; Signed-off-by: Myeonghun Pak &lt;<a href=3D"mailto:mhun512@gmail.com" =
target=3D"_blank">mhun512@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 9 +++++++--<br>
&gt;=C2=A0 1 file changed, 7 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/=
gpu/drm/renesas/rz-<br>
&gt; du/rzg2l_mipi_dsi.c<br>
&gt; index 29f2b7d24f..309fae1459 100644<br>
&gt; --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c<br>
&gt; +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c<br>
&gt; @@ -1476,14 +1476,19 @@ static int rzg2l_mipi_dsi_probe(struct platfor=
m_device *pdev)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dsi-&gt;dcs_buf_virt =3D dma_alloc_coherent(=
dsi-&gt;<a href=3D"http://host.dev" rel=3D"noreferrer" target=3D"_blank">ho=
st.dev</a>, RZG2L_DCS_BUF_SIZE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &amp;dsi-&gt;dcs_buf_phys, GFP_KERNEL);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (!dsi-&gt;dcs_buf_virt)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!dsi-&gt;dcs_buf_virt) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -ENOMEM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_host_unregis=
ter;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; <br>
&gt;=C2=A0 err_phy:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dsi-&gt;info-&gt;dphy_exit(dsi);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pm_runtime_put(dsi-&gt;dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0goto err_pm_disable;<br>
&gt; +err_host_unregister:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mipi_dsi_host_unregister(&amp;dsi-&gt;host);<br>
&gt;=C2=A0 err_pm_disable:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pm_runtime_disable(dsi-&gt;dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; --<br>
</blockquote></div>

--000000000000cd753a06506e58d2--
