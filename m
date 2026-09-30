Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFBACA5FCB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 855BD10E26D;
	Wed, 30 Sep 2026 16:12:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="CU37LvTh";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 891EB10E26D
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790784772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M+dxZTH3iw64+A4SADC+aNxDgk+TIwRPbCXbn1FTzYc=;
 b=CU37LvThp1cv2w7Cvob9kEtCeBL+kWjtp02kVas+r0FDzbyj+dcdan9odGQ8pBSJ1W6QvE
 jzz/nIrAnLrBbIVQVz9Df+8anbgW/8rCAKKtZC501ud0sZabTQYAX3y8/lVI7DtTH8XBCB
 44337YsAqZ22kCl/FzNdGuc7decyFuY=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-hb9oA7UoOjqxTxiETZNhyw-1; Wed, 30 Sep 2026 12:12:51 -0400
X-MC-Unique: hb9oA7UoOjqxTxiETZNhyw-1
X-Mimecast-MFC-AGG-ID: hb9oA7UoOjqxTxiETZNhyw_1790784770
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-674098a3b87so10204641d50.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 09:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790784770; x=1791389570;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=M+dxZTH3iw64+A4SADC+aNxDgk+TIwRPbCXbn1FTzYc=;
 b=BXMKE0j7dD5ikRVAbygvdUFUsUHapT7rcXa9gofWp1yx/pXmZQTC8MjMXs1e1LgwSh
 SYZkJrOfas16NoZMsIHuJaf81O7zgqlLKSZxmWnRf/3lXyefgOtZ2xu5VGnHEZYea6MA
 xp/bA5UVa0RWPWZaQ/oLv3V6iTE8N6JqdsUCvk7ZfTIrCn9kbKxReCH2Y8JgYfXn4GfL
 CmKnmwtCElmE1iU5FY3B76p07GWNdcfPbgWskhAIrMI7xaAtti559I29G/ZrGxxxpfud
 7znlO43+z5oiwpegIygdiIvByT3r83Sx5oktXJlJLg4l/68Pgd/vz8XjXSXjKU81NiEW
 Mq3g==
X-Gm-Message-State: AFq9FYJmvCfx4CcBv+iNpdbjKoMgfLfgzT0sr+iuy8uuegSSu8+r0keS
 tuV2Owg0rhgmmjVHODKagt5H40oTbFcRA8vtZ6OBJDQ5gKyJH4DOnSyzRdlQlCnnYDkSMLtupA4
 0Zk/ApywLnSpXPLwfW9gER6unKFuzV3y8S63s6RK0lwjNnPi8qJky0fjfkxyAP0KOPaCePaieDA
 Z7VX52uHOpt4NWMzp5La8FBxS5M1dSIEgYzBXoejSNeJjmkJ3RAK8iNy/xFA==
X-Gm-Gg: AYBFou1wA2swrCIum50zs/imLtkn2McQCQegS5svURfFHDyPmoJczoJ7gUoes75so70
 wIQiMijUsq5e/ptKp1lzTVuvaZgFDeH6805vEwgG6qo1D+9himPvOfRh8s5EeNKUv8O24wmLrav
 Y/UpXYbQ3d2bPmWa0ODf5pyTh8piDmpeYZKLdzWDHZFpQZntzZgpH1oe3a3ySTb1uVhEyfZ0jyO
 113Pokl2l8lxzt8XalSke/JysbJh/5n3GGYXnB0AdilPw==
X-Received: by 2002:a05:690e:1288:b0:675:3d40:3c34 with SMTP id
 956f58d0204a3-6768345690amr844647d50.68.1790784770255; 
 Wed, 30 Sep 2026 09:12:50 -0700 (PDT)
X-Received: by 2002:a05:690e:1288:b0:675:3d40:3c34 with SMTP id
 956f58d0204a3-6768345690amr844585d50.68.1790784768804; Wed, 30 Sep 2026
 09:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260930132707.500748-1-dbassey@redhat.com>
 <94f11a7e-7563-4480-8b00-6e3374865669@suse.de>
In-Reply-To: <94f11a7e-7563-4480-8b00-6e3374865669@suse.de>
From: Dorinda Bassey <dbassey@redhat.com>
Date: Wed, 30 Sep 2026 18:12:37 +0200
X-Gm-Features: AclHuK8PDx_8R1vtJ9G35XQA4acmFJx-utQ_yJu2US_Viwkj8F1fydwdzIBhUkk
Message-ID: <CACzuRywG=AcFkXp6vw4ExzBz1Z2SA=mr7oJBEKB3_zTnTMsh0w@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: add ARGB8888 support for primary planes
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
 kraxel@redhat.com, airlied@redhat.com, dmitry.osipenko@collabora.com, 
 slp@redhat.com, mhrica@redhat.com, gurchetansingh@chromium.org, 
 mripard@kernel.org, simona@ffwll.ch, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KLc57T7DqD0nfPLJX-lAHONXshUSe6-rLUzZ0RbMXtI_1790784770
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000003e332065cb5927e"
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

--00000000000003e332065cb5927e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

But does the host also support ARGB on the primary plane? We usually
> don't export formats that are not available in (virtual) hardware.


If you're asking about the hypervisor side providing the Virtual GPU,
Yes the host supports ARGB on primary plane. QEMU's virtio-gpu
supports this see qemu's include/hw/virtio/virtio-gpu-pixman.h:26
libkrun's virtio-gpu includes `B8G8R8A8_UNORM` in its
ResourceFormat enum and maps it to display backend formats.
Virglrenderer, which vhost-device-gpu also uses, maps
`GBM_FORMAT_ARGB8888` to `VIRGL_FORMAT_B8G8R8A8_UNORM`.
Other VMMs I've tested also support this format.

Also I see the cursor plane in the virtio-gpu driver already exposes
`DRM_FORMAT_HOST_ARGB8888`, confirming existing ARGB support
in backends. I tested this with the vhost-user-gpu backend from -
https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-gpu
and the libkrun guest, glmark2-drm renders correctly with it.

BR,
Dorinda.


On Wed, Sep 30, 2026 at 5:04=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de>
wrote:

> Hi
>
> Am 30.09.26 um 15:27 schrieb Dorinda Bassey:
> > Add DRM_FORMAT_HOST_ARGB8888 to the list of supported formats for
> > virtio-gpu primary planes. Without this, glmark2-drm fails at
> > startup because it selects ARGB visual configs by default, which
> > don't match the XRGB-only plane capabilities. This causes
> > drmModeSetCrtc to fail with EINVAL.
>
> But does the host also support ARGB on the primary plane? We usually
> don't export formats that are not available in (virtual) hardware.
>
> Best regards
> Thomas
>
> >
> > The virtio_gpu_translate_format() function already handles
> > ARGB8888 translation to VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM,
> > so this just exposes the existing capability to userspace.
> >
> > Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> > ---
> >   drivers/gpu/drm/virtio/virtgpu_plane.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c
> b/drivers/gpu/drm/virtio/virtgpu_plane.c
> > index b422eba42a5f..5f0bc1b1931b 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> > @@ -37,6 +37,7 @@
> >
> >   static const uint32_t virtio_gpu_formats[] =3D {
> >       DRM_FORMAT_HOST_XRGB8888,
> > +     DRM_FORMAT_HOST_ARGB8888,
> >   };
> >
> >   static const uint32_t virtio_gpu_cursor_formats[] =3D {
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

--00000000000003e332065cb5927e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi=C2=A0Thomas,</div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">But does the host also support ARGB on the=
 primary plane? We usually<br>don&#39;t export formats that are not availab=
le in (virtual) hardware.</blockquote><div><br></div><div>If you&#39;re ask=
ing about the hypervisor side providing the Virtual GPU,</div><div>Yes the =
host supports ARGB on primary plane. QEMU&#39;s virtio-gpu=C2=A0</div><div>=
supports this see qemu&#39;s include/hw/virtio/virtio-gpu-pixman.h:26</div>=
<div>libkrun&#39;s virtio-gpu=C2=A0includes `B8G8R8A8_UNORM` in its=C2=A0</=
div><div>ResourceFormat enum and maps it to display backend formats.</div><=
div>Virglrenderer, which vhost-device-gpu also uses, maps</div><div>`GBM_FO=
RMAT_ARGB8888` to `VIRGL_FORMAT_B8G8R8A8_UNORM`.</div><div>Other VMMs I&#39=
;ve tested also support this format.</div><div><br></div><div>Also I see th=
e cursor plane in the virtio-gpu driver already exposes</div><div>`DRM_FORM=
AT_HOST_ARGB8888`, confirming existing ARGB support</div><div>in backends. =
I tested this with the vhost-user-gpu backend from -</div><div><a href=3D"h=
ttps://github.com/rust-vmm/vhost-device/tree/main/vhost-device-gpu">https:/=
/github.com/rust-vmm/vhost-device/tree/main/vhost-device-gpu</a><br>and the=
 libkrun guest, glmark2-drm renders correctly with it.</div><div><br></div>=
<div>BR,</div><div>Dorinda.</div></div><br><br><div class=3D"gmail_quote gm=
ail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 30, =
2026 at 5:04=E2=80=AFPM Thomas Zimmermann &lt;<a href=3D"mailto:tzimmermann=
@suse.de">tzimmermann@suse.de</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">Hi<br>
<br>
Am 30.09.26 um 15:27 schrieb Dorinda Bassey:<br>
&gt; Add DRM_FORMAT_HOST_ARGB8888 to the list of supported formats for<br>
&gt; virtio-gpu primary planes. Without this, glmark2-drm fails at<br>
&gt; startup because it selects ARGB visual configs by default, which<br>
&gt; don&#39;t match the XRGB-only plane capabilities. This causes<br>
&gt; drmModeSetCrtc to fail with EINVAL.<br>
<br>
But does the host also support ARGB on the primary plane? We usually <br>
don&#39;t export formats that are not available in (virtual) hardware.<br>
<br>
Best regards<br>
Thomas<br>
<br>
&gt;<br>
&gt; The virtio_gpu_translate_format() function already handles<br>
&gt; ARGB8888 translation to VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM,<br>
&gt; so this just exposes the existing capability to userspace.<br>
&gt;<br>
&gt; Signed-off-by: Dorinda Bassey &lt;<a href=3D"mailto:dbassey@redhat.com=
" target=3D"_blank">dbassey@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/virtio/virtgpu_plane.c | 1 +<br>
&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/=
virtio/virtgpu_plane.c<br>
&gt; index b422eba42a5f..5f0bc1b1931b 100644<br>
&gt; --- a/drivers/gpu/drm/virtio/virtgpu_plane.c<br>
&gt; +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c<br>
&gt; @@ -37,6 +37,7 @@<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static const uint32_t virtio_gpu_formats[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_FORMAT_HOST_XRGB8888,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0DRM_FORMAT_HOST_ARGB8888,<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static const uint32_t virtio_gpu_cursor_formats[] =3D {<br=
>
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
</blockquote></div>

--00000000000003e332065cb5927e--

