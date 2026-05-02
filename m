Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E273CCD3424
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 05:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E236410E077;
	Sat,  2 May 2026 05:02:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CuSjaDrN";
	dkim-atps=neutral
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 329F110E077
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 05:02:53 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-67be41d5eeeso1349608a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 22:02:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777698172; cv=none;
 d=google.com; s=arc-20240605;
 b=B6cq109OMZPUJgVjR3dPQGjrFkiwl1HmOwAZDPBUvaVuWPtT/QSh0kPKEfZ5jmtVo4
 1z9i+VHGDWoyuhPl7po9Oxy1xVxsnKT7tWc4xKY8aR/pD/xvf7p6TPk3g6VDJ2rY8PpO
 0T1yxXjB3+BhW7RaZuC+XCE6sBOPaKzhIFMdq/MhBUxB5Aj8YIM6wHnd9ZEVp/23HKaf
 4w18R1828Oo/w2z7ek9uk45Rg2dmL6sOyn+TjA11ef9NeCfirgXf/ctxX0bRfHHVDU4a
 3m/YqLcJSl/+EbQGCQm5udrmtlmGLwYPHB3mV6BL4ViCeO4rd4i0dhskDuOsLNi8TibW
 taxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VHYgQXBk/vwwD93bho/ZMYkDXyOoDIhxXr13W+hXsLo=;
 fh=VaU9qWnpHkO9s6JnH41LnK1tRmRo0Zuom322HGGlTwg=;
 b=K0eczQe/cINQWxvKp6BeD/osvGIe5aF6JDpQYzPTCiLziES7vNmeeSwYDbEgAa0ciL
 yPHtsXsjZxfgUBWXq3ShUZCyFqo/+4alRgY4O5CZmgiUxQ0cBqjXeMItu32wVsGHZBjS
 i3zvOa6UL0qHl+PXmB3IeW3kFkc1f8i6QXXOHZISgMRK2pYLQjDfEGJ0qh4QZv9ok/qi
 WiFOuoA7mrmllFB0oel4JyPFs4OQqlM9rg+tV0ZBmcvOhv0kaE/Qh9SMd77/kURw45yP
 7X4VYDGrlNIFXnHYLlfVpH/DpMXnD9SGRC+nRAY8I/UgBLmV+JuYkmwTlGDClG926JqQ
 KhLQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777698172; x=1778302972; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VHYgQXBk/vwwD93bho/ZMYkDXyOoDIhxXr13W+hXsLo=;
 b=CuSjaDrNoU+9LqcWP47TJA3OVx9FQiNmKBeFrV7F4e/Cctp0L1Yql9y09V7lDUCc7Q
 HEp+MwWgEzaYC+CdNP8YpxUDItEagKJ9YzJT8o3TguiDpdi/PMwMCjupb8+gvXrqjVPs
 3ghM+uUT3xm51t+oOLVeP3xb/Tx27hj+voEnjhUKH7O+lcgzwhrOcIA4JVin4FqoEIXU
 Obh2abhjfgCpGGsu/ir9R5eXescuutmCRTEpW487ztupe7d3geJlSHvq/FXSup+f/WWt
 7MiFia9hMFbPZ0RlFM0ZfclCxPyVKSTF86mrMBBNPoScdVSKq2SHnIL2Eid9OcBNSQuY
 QGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777698172; x=1778302972;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VHYgQXBk/vwwD93bho/ZMYkDXyOoDIhxXr13W+hXsLo=;
 b=NZPfr5OBecT1LYTNpiEw13VUhcBSRTOisobDUanjseDM3Yn1x9oMEti7AyOMkhsp5E
 UXPs30LFvbT0lh4BZyp/WfHcTxqXykFGAhsvHtIbXHfCbmZatf8+9PVtc17fxwK3Qbtl
 pYO+MeY4YXvrp89ao+gsZU4RkdVu8M8QQ7fs5Jn64cNdzDy7ZFVfY0ttqW5hN+tPzrEt
 04//cHEq5U56msDB7Udi+/88EsiH8WutamHHW1TPafbpHoM8hqPEhUhhexavP+eTnUHB
 cvDsbAf/w5pQGcAmLSSeJ3+9sjLLpBPcJJcZx57eMNY9OX2sPML0ZeLPkAk6uAoR4Rmz
 Lfww==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ne/R0sAbN9Jv4Ie6iUCBcJqE0IGqQT6zuuekHHBnEIpxHhi/Rj+YJ5qR1P9Y9dHej3rtzMfIOJEg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzdcvajM7JhHGCCNESj2jYxip9D2falmzBypYMJykuhlgSXJzM+
 hZsnOOsiZmiaQ7BkJNTxbbYfrU3iRSH8MEtoOcp7J6IHiu9/vROKu7zoPxhIkqCupFlhOcxRgGH
 gjWMHrs4lwpTwGC9r6XVDi0nOt9jnxQ==
X-Gm-Gg: AeBDietR8V/dnLINJqlGyFmAFOKdf0zL517e6PkaxVR9j4md+HjNfzZg6CDcNYV331F
 PmYQBSd4w/jTKwUsLwjzSjjv511CnQzDKuaE/R5tXFjVtT4s8hmR3M03KIcZSwia2OY230GQjIl
 uj7bMWpCJEtltZe217JjRR5RDa5nVZR9UOlo7jrfink8LbPWHa1YGXkAafMfnvGCN06rtbpZacu
 yO5rUZioQm7xh3aYnPngG3rnNvRm8Dg+2i6ciTex1UDunz2OI6uTEeIxAsnhNYC4MVKw87UCp90
 MOHrkFQu7s94GGBD8WfGf/1i/FWYI3X8PiwJ+BlaynZZ+88=
X-Received: by 2002:a05:6402:428c:b0:672:75b2:e8dc with SMTP id
 4fb4d7f45d1cf-67c1b2a153dmr585189a12.24.1777698171399; Fri, 01 May 2026
 22:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260424112543.57819-1-mhun512@gmail.com>
 <cd4ef74f-13db-4b4f-8f72-1b675dd19095@suse.de>
In-Reply-To: <cd4ef74f-13db-4b4f-8f72-1b675dd19095@suse.de>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Sat, 2 May 2026 14:02:40 +0900
X-Gm-Features: AVHnY4JyGB8mYGwFZQ0FVoRGH2zG4C4DGmyXAKsZjRBVj8uapL8VauOTxXaeBWI
Message-ID: <CAGEsz8GJMF7nkCFcUqwEXAfrNy+O5POFXVBKO1Ksc2P5QmdM0g@mail.gmail.com>
Subject: Re: [PATCH] drm/qxl: Fix missing KMS poll cleanup
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 virtualization@lists.linux.dev, 
 spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000000632910650ce9ccc"
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

--0000000000000632910650ce9ccc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Thomas,

Thanks for the review. I appreciate the Fixes tag, and the suggestion for
stable.

Best regards,

Myeonghun Pak

2026=EB=85=84 4=EC=9B=94 27=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 5:46, T=
homas Zimmermann <tzimmermann@suse.de>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:

> Thanks for your patch.
>
> Am 24.04.26 um 13:25 schrieb Myeonghun Pak:
> > drm_kms_helper_poll_init() initializes the output polling work and
> > enables polling for the DRM device. qxl enables polling before calling
> > drm_dev_register(), but the drm_dev_register() failure path tears down
> > the modeset and device state without disabling the polling helper.
> >
> > The remove path also unregisters and shuts down the DRM device without
> > first disabling the polling helper. Add matching
> drm_kms_helper_poll_fini()
> > calls in both paths so the delayed polling work is cancelled before qxl
> > tears down the associated modeset/device state.
> >
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> Fixes: 5ff91e442652 ("qxl: use drm helper hotplug support")
> Cc: <stable@vger.kernel.org> # v3.11+
>
>
> > ---
> >   drivers/gpu/drm/qxl/qxl_drv.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/qxl/qxl_drv.c
> b/drivers/gpu/drm/qxl/qxl_drv.c
> > index 2bbb1168a3..1e6a2392d7 100644
> > --- a/drivers/gpu/drm/qxl/qxl_drv.c
> > +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> > @@ -118,12 +118,13 @@ qxl_pci_probe(struct pci_dev *pdev, const struct
> pci_device_id *ent)
> >       /* Complete initialization. */
> >       ret =3D drm_dev_register(&qdev->ddev, ent->driver_data);
> >       if (ret)
> > -             goto modeset_cleanup;
> > +             goto poll_fini;
> >
> >       drm_client_setup(&qdev->ddev, NULL);
> >       return 0;
> >
> > -modeset_cleanup:
> > +poll_fini:
> > +     drm_kms_helper_poll_fini(&qdev->ddev);
> >       qxl_modeset_fini(qdev);
> >   unload:
> >       qxl_device_fini(qdev);
> > @@ -154,6 +155,7 @@ qxl_pci_remove(struct pci_dev *pdev)
> >   {
> >       struct drm_device *dev =3D pci_get_drvdata(pdev);
> >
> > +     drm_kms_helper_poll_fini(dev);
> >       drm_dev_unregister(dev);
> >       drm_atomic_helper_shutdown(dev);
> >       if (pci_is_vga(pdev) && pdev->revision < 5)
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG
> N=C3=BCrnberg)
>
>
>

--0000000000000632910650ce9ccc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><span class=3D"gmail-rnc2Gd" style=3D"mas=
k-repeat: no-repeat;">Hello Thomas,</span><div class=3D"gmail-gWqWw gmail-r=
nc2Gd" style=3D"mask-repeat: no-repeat;"><br><span style=3D"color:rgb(31,31=
,31);font-family:&quot;Google Sans&quot;,Roboto,Arial,sans-serif;font-size:=
15.75px;font-variant-ligatures:no-contextual">Thanks for the review. I appr=
eciate the Fixes tag, and the suggestion for stable.</span></div><div class=
=3D"gmail-gWqWw gmail-rnc2Gd" style=3D"mask-repeat: no-repeat;"><span style=
=3D"color:rgb(31,31,31);font-family:&quot;Google Sans&quot;,Roboto,Arial,sa=
ns-serif;font-size:15.75px;font-variant-ligatures:no-contextual"><br></span=
></div><div class=3D"gmail-gWqWw gmail-rnc2Gd" style=3D"mask-repeat: no-rep=
eat;"><span class=3D"gmail-rnc2Gd" style=3D"color:rgb(31,31,31);font-family=
:&quot;Google Sans&quot;,Roboto,Arial,sans-serif;font-size:15.75px;font-var=
iant-ligatures:no-contextual">Best regards,</span><div class=3D"gmail-gWqWw=
 gmail-rnc2Gd" style=3D"color:rgb(31,31,31);font-family:&quot;Google Sans&q=
uot;,Roboto,Arial,sans-serif;font-size:15.75px;font-variant-ligatures:no-co=
ntextual"><br></div><span class=3D"gmail-rnc2Gd" style=3D"color:rgb(31,31,3=
1);font-family:&quot;Google Sans&quot;,Roboto,Arial,sans-serif;font-size:15=
.75px;font-variant-ligatures:no-contextual">Myeonghun Pak</span><span style=
=3D"color:rgb(31,31,31);font-family:&quot;Google Sans&quot;,Roboto,Arial,sa=
ns-serif;font-size:15.75px;font-variant-ligatures:no-contextual"></span></d=
iv></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"l=
tr" class=3D"gmail_attr">2026=EB=85=84 4=EC=9B=94 27=EC=9D=BC (=EC=9B=94) =
=EC=98=A4=ED=9B=84 5:46, Thomas Zimmermann &lt;<a href=3D"mailto:tzimmerman=
n@suse.de">tzimmermann@suse.de</a>&gt;=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Thanks for you=
r patch.<br>
<br>
Am 24.04.26 um 13:25 schrieb Myeonghun Pak:<br>
&gt; drm_kms_helper_poll_init() initializes the output polling work and<br>
&gt; enables polling for the DRM device. qxl enables polling before calling=
<br>
&gt; drm_dev_register(), but the drm_dev_register() failure path tears down=
<br>
&gt; the modeset and device state without disabling the polling helper.<br>
&gt;<br>
&gt; The remove path also unregisters and shuts down the DRM device without=
<br>
&gt; first disabling the polling helper. Add matching drm_kms_helper_poll_f=
ini()<br>
&gt; calls in both paths so the delayed polling work is cancelled before qx=
l<br>
&gt; tears down the associated modeset/device state.<br>
&gt;<br>
&gt; Signed-off-by: Myeonghun Pak &lt;<a href=3D"mailto:mhun512@gmail.com" =
target=3D"_blank">mhun512@gmail.com</a>&gt;<br>
<br>
Reviewed-by: Thomas Zimmermann &lt;<a href=3D"mailto:tzimmermann@suse.de" t=
arget=3D"_blank">tzimmermann@suse.de</a>&gt;<br>
<br>
Fixes: 5ff91e442652 (&quot;qxl: use drm helper hotplug support&quot;)<br>
Cc: &lt;<a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank">stable@=
vger.kernel.org</a>&gt; # v3.11+<br>
<br>
<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/qxl/qxl_drv.c | 6 ++++--<br>
&gt;=C2=A0 =C2=A01 file changed, 4 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_d=
rv.c<br>
&gt; index 2bbb1168a3..1e6a2392d7 100644<br>
&gt; --- a/drivers/gpu/drm/qxl/qxl_drv.c<br>
&gt; +++ b/drivers/gpu/drm/qxl/qxl_drv.c<br>
&gt; @@ -118,12 +118,13 @@ qxl_pci_probe(struct pci_dev *pdev, const struct=
 pci_device_id *ent)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Complete initialization. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D drm_dev_register(&amp;qdev-&gt;ddev,=
 ent-&gt;driver_data);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto modeset_cleanup;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto poll_fini;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_client_setup(&amp;qdev-&gt;ddev, NULL);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -modeset_cleanup:<br>
&gt; +poll_fini:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0drm_kms_helper_poll_fini(&amp;qdev-&gt;ddev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qxl_modeset_fini(qdev);<br>
&gt;=C2=A0 =C2=A0unload:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qxl_device_fini(qdev);<br>
&gt; @@ -154,6 +155,7 @@ qxl_pci_remove(struct pci_dev *pdev)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_device *dev =3D pci_get_drvdata(p=
dev);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0drm_kms_helper_poll_fini(dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_dev_unregister(dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_atomic_helper_shutdown(dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pci_is_vga(pdev) &amp;&amp; pdev-&gt;rev=
ision &lt; 5)<br>
<br>
-- <br>
--<br>
Thomas Zimmermann<br>
Graphics Driver Developer<br>
SUSE Software Solutions Germany GmbH<br>
Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, <a href=3D"http://www.suse.c=
om" rel=3D"noreferrer" target=3D"_blank">www.suse.com</a><br>
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG N=C3=BCr=
nberg)<br>
<br>
<br>
</blockquote></div></div>

--0000000000000632910650ce9ccc--
