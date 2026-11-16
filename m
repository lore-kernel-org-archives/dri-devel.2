Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECF9606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fXjYVgVj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3F7010E9F8;
	Mon, 16 Nov 2026 15:21:09 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44A5710E9F8
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:21:03 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-86298f9267fso1782808a34.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 07:21:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794842462; cv=none;
 d=google.com; s=arc-20260327;
 b=jSRu3fzE7wEcU1z3xKG9j5Op/CDknP+RiaE3Kk3vv0CzeAQRrywFZE69tOLTTTpn2C
 RqGd3N9MiTgirqvoKuBjkSWeUy4G/iotlNmXgEbfonMfvU19UeUg/L/qXr0hHMC1pIGM
 0kKS++MD97doXed2sEU3yKcE0IHrt9CyyGS6SxqxWMeXsAXgayjJSUv0/8Ynp7XsKKfk
 gSS4MVH9AfjZmKthz32Y8/dO3V06Hu+dTdz1qtTs9t7lfvBMVibk3fwyQu6zhtVdE+kh
 caHbgEL4qksbcXJUz+GW5UskV9nLFXk1Wv6AFDPkMyCwGRdJMP6PTAgxcKR3rFMy5MJA
 ORXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yaRFeuYNCqrpBRnf326QJfCMjIZ+L5Mx9shtOZ662Gs=;
 fh=brprwnxaV0NUtzcbJRxg6Hi+sPzJdu7YK1fCtStMag0=;
 b=MGpGGS4zrFdU63NMyp498rL57h1+6sOaajK+SSqueF6plbKN1svrRFG/ol4fghbSha
 fMMWnk5roV9yaovrojAQMU84Q2N4uLpZ/sz9/PTqYV1pMm7mNrBjcAciqrwxhlU3/Ktb
 hH6XA+/gAk7CiW/fyCTnElxGpbuqSj8TRJytWaS7FBk9jTExV2L3BqlrgOurWmA31G8s
 56lXbu/7AkM49j8IQo4XIZq4m0pqb5cGZQObAQhE5XVV/z2l29OvYlQZ/mxNJGGoHYsB
 anQLiiUi/coUU+3mBFr3luGzsCnLdIzzx/1m7HYkueiXY5tSdr6+ZNRCPovTXYZ7Qo8X
 Te7Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794842462; x=1795447262; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yaRFeuYNCqrpBRnf326QJfCMjIZ+L5Mx9shtOZ662Gs=;
 b=fXjYVgVjAyFrIA56Y5pvPkUp0Xr8oJpIOmMO27TE7JAvcqZjSmrcsxjGUkjNnSoiju
 06KYdNIg1oXdCD6bJrRbe/cQQp5tEtSwCzB7/QNsPVwRE5Mw3Z03VMR5F8lzQ4FNOtfM
 UQ5r87qQuzOjM34MnxprPfSa79D1rIcRrJW9sq1CCaN789qBW0QrZjeys1LENGsWu9uD
 Nfz20bLaAHQnazXEixyMSfJ7Q8ThCKtwIVAGkDMmFCqmtUQXqo/1P+XHcRZkJzlAOUUn
 xGggcgw1j5CosPMJGJy007p60L6BVRwVEBkfeGgsIkL0APtFvOjGK686BAVwJh1N9ENw
 doeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794842462; x=1795447262;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yaRFeuYNCqrpBRnf326QJfCMjIZ+L5Mx9shtOZ662Gs=;
 b=nrMQAD3Gi8Lts9a0thNkG8hfSEam/aIXwY0tEvMCLBlxDkK7H93MbTUzwonwyK0DVL
 4Yf7tMA/84SpaVHPUv0gulR+6ISkf2RpHAowHopefWIdfGXqg2XMbuQ2lO2NJcVrV0jK
 pOGdNW9YYFBGHm3yHj3RvPcpElm1ixbabelHREmQki1d10lV+FArAhwgBSe/A1NOFWiG
 IzKh0RXmd6sDzFKo90/xKp3zzfbwkhqacplLBS6oX48dKBPKmnjUxUc5vZ18y98ASlfX
 f8UjzZ55gjzjr4AIpeZltuDKhqX469b4iiWDOGRC3SzIn66BUltKVhGPEmp4pehAEevw
 mlNw==
X-Forwarded-Encrypted: i=1;
 AL+hErGwDWiJcOMnCTaT26ZI2YSTCXpInA8bA5kKKTA0wG1MCpNaBv94jmlItlTly8XraouIwXr+/GUrVy8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/AIeRVHB3QM0IuUQ8xggEZd0rRqUDXqNCcgqKPW7lIgn32Tk8n
 40NjDZKkBGpOazaTknGlJ4GIiwpR5nTw1eTyxw7BQTq63ywJKuT/TCZtQpmusR+JNPETvVCtXb5
 hovYwn1+M/YcoZU//ofnOIUH+cISCiTg=
X-Gm-Gg: AYBFou2/D6U1UFMwrarRAhnMuoqe5LnoiVOqTH0RCp/xdJocg2iKltC2v0/qoJtcKTq
 eeYV5o2b5/gqVgIgSU5FNNktL2kgRLbdnt01iu1wDvNjfBWM7Zj6gyoDa+L8V07JJ0/me27X8X/
 tIFxr4ZlTMXAO4MGWiNwNsTF3BXF/byGuoyQ2euqiPsnArR2mlW83RR0iOfIfrReexRAi2RBHgt
 X97ARuqoD9xLOUcw17hyiWpgqLG0W2cpv/2Aqk5mG/RTciPO/7M4D1EChf/y3CqT27MszNR1Rhk
 3JP+pBWTkxjaV6UaagKlWOVK6hZW1VQYZuGAFBFllqs/mLzR57plBI0YS0gWf+7qsYP7oOLpX76
 uF7FKYLv0KUK1JgKUy7vFkjaW7kWVjWLScT+P
X-Received: by 2002:a05:6830:44aa:b0:81b:a5f9:3490 with SMTP id
 46e09a7af769-86289943e4cmr8630778a34.24.1794842462168; Mon, 16 Nov 2026
 07:21:02 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112091630.3947184-1-angelo.compagnucci@gmail.com>
 <20261113110708.927665-1-angelo.compagnucci@gmail.com>
 <556dd1ab-a1af-4c8b-be6e-04382ed0b958@suse.de>
In-Reply-To: <556dd1ab-a1af-4c8b-be6e-04382ed0b958@suse.de>
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Date: Mon, 16 Nov 2026 16:20:25 +0100
X-Gm-Features: AclHuK8Wq_XIQ_2rZb9c7_Iq7CILACZEQVd0aPHW3Sgs6Lur7GDDomI69L08mRQ
Message-ID: <CA+TH9VnN-o94K5i2mC4fe4-z6tWCquqJiYa0BHxXNO98PoDEJQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/fbdev-dma: Copy the shadow buffer on unblank
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Javier Martinez Canillas <javierm@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000062ac030660665331"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000062ac030660665331
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il giorno lun 16 nov 2026 alle ore 08:48 Thomas Zimmermann <
tzimmermann@suse.de> ha scritto:

> Hi
>
> Am 13.11.26 um 12:07 schrieb Angelo Compagnucci:
> > With a shadow buffer, what userspace draws in fbdev reaches the
> > framebuffer memory only when the damage worker runs. Turning the displa=
y
> > on shows the framebuffer memory as it is. So a program that draws its
> > first picture and then unblanks, such as a boot splash, shows an older
> > picture for a moment.
> >
> > Seen on an ILI9341 panel (tinydrm ili9341): enabling the pipe sends the
> > whole framebuffer memory to the panel, still black, and the splash only
> > replaces it once the damage worker runs.
> >
> > Nothing can be flushed to a display that is off. But the copy from the
> > shadow buffer into the framebuffer memory does not need the display. On
> > unblank, copy the whole shadow buffer into the framebuffer memory befor=
e
> > turning the display on. The damage worker still flushes the damage once
> > the display is on.
> >
> > Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> > ---
> > Changes v1 -> v2:
> >    - Do not flush the damage before unblanking: nothing can reach a
> >      display that is off. Instead, in fbdev-dma, copy the whole shadow
> >      buffer into the framebuffer memory on unblank, which needs no
> >      display [Thomas Zimmermann]
>
> That's not really the issue. There's hardware/drivers where we need the
> CRTC to be switched on before we can transfer display data. Search
> drm_atomic_helper_commit_tail_rpm() [1] for that. IDK how much of a
> problem this is in practice. Flushing buffers on such a system might
> give actual errors instead of just some temporary display noise.
>
> What exactly are you trying to achieve?
>

Thanks, I misread your remark on v1. The changelog and the commit
message of v2 are wrong on this, and I will fix them.

v2 does not transfer display data, though. The damage worker does two
things in drm_fbdev_dma_helper_fb_dirty():

  1. drm_fbdev_dma_damage_blit(): a memcpy from the shadow buffer into
     the GEM buffer;
  2. fb->funcs->dirty(): the call into the driver.

On unblank, v2 calls only the first one. It does not call
fb->funcs->dirty(), it commits nothing, and it touches no hardware. The
damage worker already does this same copy whatever the state of the
display, when userspace draws while the display is blanked.

So I think a device that needs the CRTC on is not affected. Do you
agree, or do I miss a case?

> What exactly are you trying to achieve?

A boot splash on a small SPI panel (ILI9341, tinydrm), through fbdev.
The splash maps the framebuffer, draws its first frame while the display
is still blanked, and then unblanks with FBIOBLANK.

What happens today:

  1. The frame is in the shadow buffer. The deferred I/O work is
     scheduled 50 ms later (fbdefio.delay =3D HZ / 20).
  2. FBIOBLANK turns the CRTC on. The driver sends the GEM buffer to the
     panel and turns the backlight on. The GEM buffer is still black.
  3. The deferred I/O and the damage work run, and the frame replaces
     the black picture.

So the panel shows a black picture for a moment before the splash, a
visible flash at each boot. The aim is that the first picture the panel
shows after an unblank is the one that userspace drew before it.

If you think this is better fixed somewhere else, I am happy to rework
it.

Best regards,
Angelo

>
> [1]
>
> https://elixir.bootlin.com/linux/v7.3.1/source/drivers/gpu/drm/drm_atomic=
_helper.c#L2009
>
> Best regards
> Thomas
>
>
> >    - The fbdev helpers are unchanged, so the title changed too; v1 was
> >      "drm/fb-helper: flush damage before unblanking"
> >
> >   drivers/gpu/drm/drm_fbdev_dma.c | 44 ++++++++++++++++++++++++++------=
-
> >   1 file changed, 35 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_fbdev_dma.c
> b/drivers/gpu/drm/drm_fbdev_dma.c
> > index 452f84400350..cc8813538bd9 100644
> > --- a/drivers/gpu/drm/drm_fbdev_dma.c
> > +++ b/drivers/gpu/drm/drm_fbdev_dma.c
> > @@ -93,15 +93,6 @@ static void drm_fbdev_dma_shadowed_fb_destroy(struct
> fb_info *info)
> >       drm_client_release(&fb_helper->client);
> >   }
> >
> > -static const struct fb_ops drm_fbdev_dma_shadowed_fb_ops =3D {
> > -     .owner =3D THIS_MODULE,
> > -     .fb_open =3D drm_fbdev_dma_fb_open,
> > -     .fb_release =3D drm_fbdev_dma_fb_release,
> > -     FB_DEFAULT_DEFERRED_OPS(drm_fbdev_dma_shadowed),
> > -     DRM_FB_HELPER_DEFAULT_OPS,
> > -     .fb_destroy =3D drm_fbdev_dma_shadowed_fb_destroy,
> > -};
> > -
> >   /*
> >    * struct drm_fb_helper
> >    */
> > @@ -196,6 +187,41 @@ static const struct drm_fb_helper_funcs
> drm_fbdev_dma_helper_funcs =3D {
> >    * struct drm_fb_helper
> >    */
> >
> > +static int drm_fbdev_dma_shadowed_fb_blank(int blank, struct fb_info
> *info)
> > +{
> > +     struct drm_fb_helper *fb_helper =3D info->par;
> > +     struct drm_clip_rect clip =3D {
> > +             .x2 =3D fb_helper->fb->width,
> > +             .y2 =3D fb_helper->fb->height,
> > +     };
> > +
> > +     /*
> > +      * Turning the display on shows the framebuffer memory. Copy the
> > +      * shadow buffer into it first, so it holds what was drawn. This
> > +      * does not need the display; the damage worker still flushes the
> > +      * damage once the display is on.
> > +      */
> > +     if (blank =3D=3D FB_BLANK_UNBLANK)
> > +             drm_fbdev_dma_damage_blit(fb_helper, &clip);
> > +
> > +     return drm_fb_helper_blank(blank, info);
> > +}
> > +
> > +static const struct fb_ops drm_fbdev_dma_shadowed_fb_ops =3D {
> > +     .owner =3D THIS_MODULE,
> > +     .fb_open =3D drm_fbdev_dma_fb_open,
> > +     .fb_release =3D drm_fbdev_dma_fb_release,
> > +     FB_DEFAULT_DEFERRED_OPS(drm_fbdev_dma_shadowed),
> > +     /* DRM_FB_HELPER_DEFAULT_OPS, with a blank that copies the shadow
> */
> > +     .fb_check_var =3D drm_fb_helper_check_var,
> > +     .fb_set_par =3D drm_fb_helper_set_par,
> > +     .fb_setcmap =3D drm_fb_helper_setcmap,
> > +     .fb_blank =3D drm_fbdev_dma_shadowed_fb_blank,
> > +     .fb_pan_display =3D drm_fb_helper_pan_display,
> > +     .fb_ioctl =3D drm_fb_helper_ioctl,
> > +     .fb_destroy =3D drm_fbdev_dma_shadowed_fb_destroy,
> > +};
> > +
> >   static int drm_fbdev_dma_driver_fbdev_probe_tail(struct drm_fb_helper
> *fb_helper,
> >                                                struct
> drm_fb_helper_surface_size *sizes)
> >   {
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG N=C3=BCrnbe=
rg)
>
>
>

--=20
Profile: http://it.linkedin.com/in/compagnucciangelo

--00000000000062ac030660665331
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Il giorno lun 1=
6 nov 2026 alle ore 08:48 Thomas Zimmermann &lt;<a href=3D"mailto:tzimmerma=
nn@suse.de">tzimmermann@suse.de</a>&gt; ha scritto:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Hi<br>
<br>
Am 13.11.26 um 12:07 schrieb Angelo Compagnucci:<br>
&gt; With a shadow buffer, what userspace draws in fbdev reaches the<br>
&gt; framebuffer memory only when the damage worker runs. Turning the displ=
ay<br>
&gt; on shows the framebuffer memory as it is. So a program that draws its<=
br>
&gt; first picture and then unblanks, such as a boot splash, shows an older=
<br>
&gt; picture for a moment.<br>
&gt;<br>
&gt; Seen on an ILI9341 panel (tinydrm ili9341): enabling the pipe sends th=
e<br>
&gt; whole framebuffer memory to the panel, still black, and the splash onl=
y<br>
&gt; replaces it once the damage worker runs.<br>
&gt;<br>
&gt; Nothing can be flushed to a display that is off. But the copy from the=
<br>
&gt; shadow buffer into the framebuffer memory does not need the display. O=
n<br>
&gt; unblank, copy the whole shadow buffer into the framebuffer memory befo=
re<br>
&gt; turning the display on. The damage worker still flushes the damage onc=
e<br>
&gt; the display is on.<br>
&gt;<br>
&gt; Signed-off-by: Angelo Compagnucci &lt;<a href=3D"mailto:angelo.compagn=
ucci@gmail.com" target=3D"_blank">angelo.compagnucci@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; Changes v1 -&gt; v2:<br>
&gt;=C2=A0 =C2=A0 - Do not flush the damage before unblanking: nothing can =
reach a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 display that is off. Instead, in fbdev-dma, copy t=
he whole shadow<br>
&gt;=C2=A0 =C2=A0 =C2=A0 buffer into the framebuffer memory on unblank, whi=
ch needs no<br>
&gt;=C2=A0 =C2=A0 =C2=A0 display [Thomas Zimmermann]<br>
<br>
That&#39;s not really the issue. There&#39;s hardware/drivers where we need=
 the <br>
CRTC to be switched on before we can transfer display data. Search <br>
drm_atomic_helper_commit_tail_rpm() [1] for that. IDK how much of a <br>
problem this is in practice. Flushing buffers on such a system might <br>
give actual errors instead of just some temporary display noise.<br>
<br>
What exactly are you trying to achieve?<br></blockquote><div><br></div><div=
>Thanks, I misread your remark on v1. The changelog and the commit<br>messa=
ge of v2 are wrong on this, and I will fix them.<br><br>v2 does not transfe=
r display data, though. The damage worker does two<br>things in drm_fbdev_d=
ma_helper_fb_dirty():<br><br>=C2=A0 1. drm_fbdev_dma_damage_blit(): a memcp=
y from the shadow buffer into<br>=C2=A0 =C2=A0 =C2=A0the GEM buffer;<br>=C2=
=A0 2. fb-&gt;funcs-&gt;dirty(): the call into the driver.<br><br>On unblan=
k, v2 calls only the first one. It does not call<br>fb-&gt;funcs-&gt;dirty(=
), it commits nothing, and it touches no hardware. The<br>damage worker alr=
eady does this same copy whatever the state of the<br>display, when userspa=
ce draws while the display is blanked.<br><br>So I think a device that need=
s the CRTC on is not affected. Do you<br>agree, or do I miss a case?<br><br=
>&gt; What exactly are you trying to achieve?<br><br>A boot splash on a sma=
ll SPI panel (ILI9341, tinydrm), through fbdev.<br>The splash maps the fram=
ebuffer, draws its first frame while the display<br>is still blanked, and t=
hen unblanks with FBIOBLANK.<br><br>What happens today:<br><br>=C2=A0 1. Th=
e frame is in the shadow buffer. The deferred I/O work is<br>=C2=A0 =C2=A0 =
=C2=A0scheduled 50 ms later (fbdefio.delay =3D HZ / 20).<br>=C2=A0 2. FBIOB=
LANK turns the CRTC on. The driver sends the GEM buffer to the<br>=C2=A0 =
=C2=A0 =C2=A0panel and turns the backlight on. The GEM buffer is still blac=
k.<br>=C2=A0 3. The deferred I/O and the damage work run, and the frame rep=
laces<br>=C2=A0 =C2=A0 =C2=A0the black picture.<br><br>So the panel shows a=
 black picture for a moment before the splash, a<br>visible flash at each b=
oot. The aim is that the first picture the panel<br>shows after an unblank =
is the one that userspace drew before it.<br><br>If you think this is bette=
r fixed somewhere else, I am happy to rework<br>it.<br><br>Best regards,<br=
>Angelo=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
[1] <br>
<a href=3D"https://elixir.bootlin.com/linux/v7.3.1/source/drivers/gpu/drm/d=
rm_atomic_helper.c#L2009" rel=3D"noreferrer" target=3D"_blank">https://elix=
ir.bootlin.com/linux/v7.3.1/source/drivers/gpu/drm/drm_atomic_helper.c#L200=
9</a><br>
<br>
Best regards<br>
Thomas<br>
<br>
<br>
&gt;=C2=A0 =C2=A0 - The fbdev helpers are unchanged, so the title changed t=
oo; v1 was<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;drm/fb-helper: flush damage before unblankin=
g&quot;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/drm_fbdev_dma.c | 44 +++++++++++++++++++++=
+++++-------<br>
&gt;=C2=A0 =C2=A01 file changed, 35 insertions(+), 9 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/drm_fbdev_dma.c b/drivers/gpu/drm/drm_fbd=
ev_dma.c<br>
&gt; index 452f84400350..cc8813538bd9 100644<br>
&gt; --- a/drivers/gpu/drm/drm_fbdev_dma.c<br>
&gt; +++ b/drivers/gpu/drm/drm_fbdev_dma.c<br>
&gt; @@ -93,15 +93,6 @@ static void drm_fbdev_dma_shadowed_fb_destroy(struc=
t fb_info *info)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_client_release(&amp;fb_helper-&gt;client=
);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -static const struct fb_ops drm_fbdev_dma_shadowed_fb_ops =3D {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0.owner =3D THIS_MODULE,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0.fb_open =3D drm_fbdev_dma_fb_open,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0.fb_release =3D drm_fbdev_dma_fb_release,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0FB_DEFAULT_DEFERRED_OPS(drm_fbdev_dma_shadowed),<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0DRM_FB_HELPER_DEFAULT_OPS,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0.fb_destroy =3D drm_fbdev_dma_shadowed_fb_destroy=
,<br>
&gt; -};<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 * struct drm_fb_helper<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt; @@ -196,6 +187,41 @@ static const struct drm_fb_helper_funcs drm_fbdev=
_dma_helper_funcs =3D {<br>
&gt;=C2=A0 =C2=A0 * struct drm_fb_helper<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static int drm_fbdev_dma_shadowed_fb_blank(int blank, struct fb_info =
*info)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct drm_fb_helper *fb_helper =3D info-&gt;par;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct drm_clip_rect clip =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.x2 =3D fb_helper-&gt=
;fb-&gt;width,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.y2 =3D fb_helper-&gt=
;fb-&gt;height,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Turning the display on shows the framebuffer m=
emory. Copy the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * shadow buffer into it first, so it holds what =
was drawn. This<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * does not need the display; the damage worker s=
till flushes the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * damage once the display is on.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (blank =3D=3D FB_BLANK_UNBLANK)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_fbdev_dma_damage_=
blit(fb_helper, &amp;clip);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return drm_fb_helper_blank(blank, info);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct fb_ops drm_fbdev_dma_shadowed_fb_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.owner =3D THIS_MODULE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.fb_open =3D drm_fbdev_dma_fb_open,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.fb_release =3D drm_fbdev_dma_fb_release,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0FB_DEFAULT_DEFERRED_OPS(drm_fbdev_dma_shadowed),<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* DRM_FB_HELPER_DEFAULT_OPS, with a blank that c=
opies the shadow */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.fb_check_var =3D drm_fb_helper_check_var,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.fb_set_par =3D drm_fb_helper_set_par,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.fb_setcmap =3D drm_fb_helper_setcmap,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.fb_blank =3D drm_fbdev_dma_shadowed_fb_blank,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0.fb_pan_display =3D drm_fb_helper_pan_display,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0.fb_ioctl =3D drm_fb_helper_ioctl,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.fb_destroy =3D drm_fbdev_dma_shadowed_fb_destroy=
,<br>
&gt; +};<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static int drm_fbdev_dma_driver_fbdev_probe_tail(struct dr=
m_fb_helper *fb_helper,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_fb_helper_surface_size *sizes)<br>
&gt;=C2=A0 =C2=A0{<br>
<br>
-- <br>
--<br>
Thomas Zimmermann<br>
Graphics Driver Developer<br>
SUSE Software Solutions Germany GmbH<br>
Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, <a href=3D"http://www.suse.c=
om" rel=3D"noreferrer" target=3D"_blank">www.suse.com</a><br>
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG N=C3=BCrnberg=
)<br>
<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Pr=
ofile: <a href=3D"http://it.linkedin.com/in/compagnucciangelo" target=3D"_b=
lank">http://it.linkedin.com/in/compagnucciangelo</a></div></div>

--00000000000062ac030660665331--
