Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A479109E545
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 09:38:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74CEC10ED5C;
	Fri, 27 Mar 2026 09:38:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="coQp3XXH";
	dkim-atps=neutral
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F8A610ED5C
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 09:38:41 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-5a12cd0bd79so2229992e87.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 02:38:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774604320; cv=none;
 d=google.com; s=arc-20240605;
 b=SmfdJx/K0s9S4pZYOQ4D/1WMKdvCVmpdO0x85nAPu6QHRhRMU0l6WmB46UDMslE1kT
 Jegk7NrwM784UBBjT02cXpLTHdzfE17FGuXw1Xd0lljca2iJ+b6mrIEnPCHlMjCIg5eK
 Ok1EHtTklu3Ty1J+1ASFBRQCBr409a9P8iyUVmRO1GV1VZT0Kx39Y3mBjmm+iwJK8Blj
 JD5K2nJwM+Px6iktnzyBxjCq7TqnAaz1Lv8E0AtWpARF2wFz2SsEwlC5mRZoRJ3CNCy8
 OEyFOkb9Bk2k+H7gfYfBxzelcIzqJBMTZJmGlRdvpCJbKxSI2wbtvSDgvz5+e67O9Fa7
 u7ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XCC+EsRtjQScd/hJdX4t8R6GeUfvuSert8Xa/RAjKDA=;
 fh=S3RmMoRPLtjZlE0gEWZSaFJx947guvQ+05aA/31hJHc=;
 b=JXOpQcwlzk3tyjXkqIXY1Be15GsxckgZsJzxVekeNI3VdVY88fx6Xv6qiLM5QZtr2V
 E4PmHFnvntBQQ86W2UnjH6h6RG4zR1Eo38LM4kck08bE7jLuY284DFMPFYYmJxmBjr/O
 7lpzh0awBIb9bzu8lAbdtyHoOG1YBnOWvXEh0cg+U/atb5VsxkKocx76qVSonQ1M0azj
 IQA9P4YxNqYVQHLlee1qTG8aP8Uf2+ag3Bwgzx8n/XqFtY61BPa8SQA3syd+6b8JLqJq
 aBz3JDAQ+N3M2fXDxKsUniu7ewJb5gb+nU6g6/Aiy6V9jeH5pzPihaqGPZyJnbiKcTUo
 /AQw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774604320; x=1775209120;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XCC+EsRtjQScd/hJdX4t8R6GeUfvuSert8Xa/RAjKDA=;
 b=coQp3XXH5D6fieWbyqNrrwC3cNx8hpMiDPIJtQNxJiXCZvTBWLEEgupKOyt7EcF8FL
 t5IMV0OGZe/vVtq0Hra1y0ue03/FmuoMrq8xgatzwHrgEKiTR2kkEx3OTWKWqCO79dKu
 GkX06xhKllojxjtZEKrW8PJTYRXz7HOsWKask=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774604320; x=1775209120;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XCC+EsRtjQScd/hJdX4t8R6GeUfvuSert8Xa/RAjKDA=;
 b=sGrt6If7C1Of/ApTQ0rEgIAXL/9GmchLPMqSHZSjPxqxqm6Qv5lPWKTAx0MnQz1B7C
 DrCdN4xIOKXP+NLDyy4RQnSqfoLWFUS63LlY8hdBZyiUysE0KtvTtxZlb8OcIYBIk8za
 1ztHNTzICR7Y0GyGLSgOYqeEjJiMTyQISM6Nbs+rBBp6/usp/ZLtln7lm8LjW6B3x3UR
 VZyvqarXyKQ+pczkuvYzFCJRNCur+CqoqxM//FMVMRXx/SI5dZym0rq0ckpluRP6LAWM
 mET8EJhSWy+xpHd1frAdiuHb36yvwcxhMi5OkPoTat1scQi5EQD4Lskep4XkQvwTjJVy
 177Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBcS9fx4Pipwi1AxRCW2Z04NBVeCDC7mzlLGcD1438dfEXRu0W8FBwdyD7ljO9zJ05BjKRXIgHXc8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxc192NT7IZY0scWKpbBpmXG+3BizdaZVtXE+dBKAjvNSs3zuIc
 w7XCRXWN4Y2JduJ03DbjwROCjiYAG2Zb6JwF4G3JmhMifnGUCPnBYO3UuvpOMBSpPiLzzcKahBP
 8ed1AL1uoTsQguiz9IRx0Lc2XMYDTeg3SwOu8aUEW
X-Gm-Gg: ATEYQzy1T5qB6YAArX7gpr3M+u4YRYkZnxZTcNnJA+j8WkGJpPB+Yj+TedCxs2SPnQv
 tVBQ3tgbrVF2wTXHE3kUFQe98GbCpouseKr5RclU/aIoMlwG1hXfiFOnfruK5HsA4ICzlPFUl31
 IPweqScXMz5v2ycUCVZDyjSHYTXA9dfzoGIekWDgj9EXRBgyM+rT9ALcrw2tPPPawjozlZdUWQT
 euepw1p9WWLEmg3+5Z0n+9suZp6lwCwXfwr/6W/wQKKxMNoJrL4u02B1PQY0oe/gkVv2dKPZQfK
 /kUPXOFqToSGi/cnlBj2HW/GfoZH9bQsklMxIA==
X-Received: by 2002:a05:6512:32c8:b0:5a1:26f7:71b with SMTP id
 2adb3069b0e04-5a2ab581efbmr751468e87.0.1774604319512; Fri, 27 Mar 2026
 02:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260326100248.1171828-1-wenst@chromium.org>
 <20260326100248.1171828-2-wenst@chromium.org>
 <243dbc45-cb11-4dfe-b8d1-e08f1b5f73b6@suse.de>
In-Reply-To: <243dbc45-cb11-4dfe-b8d1-e08f1b5f73b6@suse.de>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 27 Mar 2026 17:38:28 +0800
X-Gm-Features: AQROBzDiHdcvNsL4pOfZZU-Zs3-uFT9qrpPHFMaWbGHA7E62ZL_HdfLvhmVWRwU
Message-ID: <CAGXv+5F+F9oHjuUPwf-r2qKxDdXFuNV7w5Q8qogW=GXxE0GT3A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm: Introduce DRM_MODE_DUMB_KERNEL_MAP flag
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Mar 27, 2026 at 3:21=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Hi
>
> Am 26.03.26 um 11:01 schrieb Chen-Yu Tsai:
> > From: Rob Herring <robh@kernel.org>
> >
> > Introduce a new flag, DRM_MODE_DUMB_KERNEL_MAP, for struct
> > drm_mode_create_dumb. This flag is for internal kernel use to indicate
> > if dumb buffer allocation needs a kernel mapping. This is needed only f=
or
> > GEM DMA where creating a kernel mapping or not has to be decided at
> > allocation time because creating a mapping on demand (with vmap()) is n=
ot
> > guaranteed to work.
>
> I still don't understand what you're trying to achieve. As I pointed
> out, ever driver's memory manager potentially requires a vmap. Passing
> around flags will not solve that problem. If vmap is not possible, the
> driver should not provide the vmap callbacks in the first place.

I'm trying to convert the Rockchip and Exynos drivers to the GEM DMA
helpers. Both have their reasons for not using the helpers, one of them
being that the DRM device is not the DMA device. This is already fixed
by my other series. Both drivers also set DMA_ATTR_NO_KERNEL_MAPPING
for buffer allocations other than the one used by fb_helper.

Exynos's GEM implementation also sets extra DMA attributes at the
allocation phase for their custom GEM create ioctl. But otherwise
exynos is just reimplementing all the GEM DMA helpers in almost
identical fashion. And to your point, exynos does not provide the
vmap callback.

Rockchip's GEM implementation splits the code path between DMA and
IOMMU usage as it needs to attach and detach the DMA device from the
IOMMU domain on the fly. This predates the DMA IOMMU framework. This
GEM implementation provides the vmap callback, which will fail for
direct DMA allocations without the kernel mapping.

There's also something fishy about Rockchip's DRM driver. It's using
fbdev-dma, even though it's not based on the GEM DMA helpers or even
drm_gem_dma_object.

As you are against changing the existing *_dumb_create() interface,
I will look into reusing drm_gem_dma_object with driver-specific
functions. I believe I will need to keep patch 2 adding dma_attrs
though. Would that be acceptable?

Once again, thank you for your patience.


ChenYu


> Best regards
> Thomas
>
> >
> > Several drivers are using reimplementing the GEM DMA helpers because
> > they distinguish between kernel and userspace allocations to create a
> > kernel mapping or not. Adding a flag allows migrating these drivers
> > to the helpers while preserving their existing behavior. These include
> > exynos, rockchip, and previously mediatek.
> >
> > Update the callers of drm_mode_dumb_create() to set
> > drm_mode_dumb_create.flags to appropriate defaults. Currently, flags ca=
n
> > be set to anything by userspace, but is unused within the kernel. Let's
> > force flags to zero (no kernel mapping) for userspace callers by defaul=
t.
> > For in kernel clients, set DRM_MODE_DUMB_KERNEL_MAP by default. Drivers
> > can override this as needed.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > [wenst@chromium.org: Emit warning (once) if args->flags is not zero]
> > [wenst@chromium.org: Moved flag def. to include/drm/drm_dumb_buffers.h]
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since v2:
> > - Switched to drm_warn_once()
> > - Moved flag definition from include/uapi/ to include/drm/drm_dumb_buff=
ers.h
> > - Reworded commit message
> >
> > Changes since v1:
> > - Emit warning if args->flags is not zero
> > ---
> >   drivers/gpu/drm/drm_client.c       | 2 ++
> >   drivers/gpu/drm/drm_dumb_buffers.c | 4 ++++
> >   include/drm/drm_dumb_buffers.h     | 3 +++
> >   3 files changed, 9 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.=
c
> > index 46c465bce98c..3d3e61823cc1 100644
> > --- a/drivers/gpu/drm/drm_client.c
> > +++ b/drivers/gpu/drm/drm_client.c
> > @@ -14,6 +14,7 @@
> >   #include <drm/drm_client_event.h>
> >   #include <drm/drm_device.h>
> >   #include <drm/drm_drv.h>
> > +#include <drm/drm_dumb_buffers.h>
> >   #include <drm/drm_file.h>
> >   #include <drm/drm_fourcc.h>
> >   #include <drm/drm_framebuffer.h>
> > @@ -404,6 +405,7 @@ drm_client_buffer_create_dumb(struct drm_client_dev=
 *client, u32 width, u32 heig
> >       dumb_args.width =3D width;
> >       dumb_args.height =3D height;
> >       dumb_args.bpp =3D drm_format_info_bpp(info, 0);
> > +     dumb_args.flags =3D DRM_MODE_DUMB_KERNEL_MAP;
> >       ret =3D drm_mode_create_dumb(dev, &dumb_args, client->file);
> >       if (ret)
> >               return ERR_PTR(ret);
> > diff --git a/drivers/gpu/drm/drm_dumb_buffers.c b/drivers/gpu/drm/drm_d=
umb_buffers.c
> > index e2b62e5fb891..60f4c2d08641 100644
> > --- a/drivers/gpu/drm/drm_dumb_buffers.c
> > +++ b/drivers/gpu/drm/drm_dumb_buffers.c
> > @@ -233,6 +233,10 @@ int drm_mode_create_dumb_ioctl(struct drm_device *=
dev,
> >       struct drm_mode_create_dumb *args =3D data;
> >       int err;
> >
> > +     if (args->flags)
> > +             drm_warn_once(dev, "drm_mode_create_dumb.flags is not zer=
o.\n");
> > +     args->flags =3D 0;
> > +
> >       err =3D drm_mode_create_dumb(dev, args, file_priv);
> >       if (err) {
> >               args->handle =3D 0;
> > diff --git a/include/drm/drm_dumb_buffers.h b/include/drm/drm_dumb_buff=
ers.h
> > index 1f3a8236fb3d..4657e44533f4 100644
> > --- a/include/drm/drm_dumb_buffers.h
> > +++ b/include/drm/drm_dumb_buffers.h
> > @@ -6,6 +6,9 @@
> >   struct drm_device;
> >   struct drm_mode_create_dumb;
> >
> > +/* drm_mode_create_dumb flags for internal use */
> > +#define DRM_MODE_DUMB_KERNEL_MAP     (1<<0)
> > +
> >   int drm_mode_size_dumb(struct drm_device *dev,
> >                      struct drm_mode_create_dumb *args,
> >                      unsigned long hw_pitch_align,
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG N=C3=
=BCrnberg)
>
>
