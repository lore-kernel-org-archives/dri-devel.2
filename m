Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753E610BA42D
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 05:46:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF5BA10EC9E;
	Fri, 27 Mar 2026 05:46:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bo4Vvt4m";
	dkim-atps=neutral
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0B7610EC9E
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 05:46:53 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5a279ce9475so2452235e87.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 22:46:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774590412; cv=none;
 d=google.com; s=arc-20240605;
 b=H826bCs0A8VDTinyyXEHvddn7ECkelUHzvEGy1hDcBrpvnHMsr7qOoGnZZ2T8SO+r8
 +4cgrutpz06GvwtlBDeDmFdy/Gr8ZgXzJFxGHVL9vwjMysa7LXzg/kPRE+eu+vnh36r0
 vDPuVsWApjzSBa9fE7OTzQcIVc0xbGgD8GUOlXh3ff1VjS4FdXwjg5H39MbcaWl4h5CG
 ewp5PrZOGSluVVP+xCQxNqKezpQEc7szSC8zxdfikI+xBKFX/cJdjacfbyqtCk/qEn4T
 Ttp1u6i14IE20aFXT2UIkU8GbxKEn/G+Hw2ZPN6s8k9mJSAZTYRVPGS2GKGSWbvvMBAC
 lokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JXJpmZjGD+lAL9xP0NX5d1i3jdt2XrJAmAyQ4hZVZsI=;
 fh=raWkLkIeIdwQcmI7TMOiJBa92YRuBg3EATtJJw0K0Q8=;
 b=at/PAlYqTm+TeIjn/p+cSs1Li9ur8VuBo1beLFWHTherNitsWSviM4ZmuaAYSfDi3c
 kdO/JOrnQIRQmnd2OYS83ffqopPz7OQvpzhaoMCRmtrQenmFOejydZG9Ba6FjoImLeuk
 KtPKE5YwIF3Haedi6iNNSP77UACP5Osx5FkeD4CCkKS63mbM7DHbJSjgloBvvZ7MS8Ae
 uYu5Nhfm9gVD89ZmHCf7Qso9Yj6xiSR5+waSMjN4D9cvgjDsH5HAcj33gcso+WhgH87Q
 nDnhbSBFjBFy8aLJWADs8GCGRhuenYsdpoLJ6jFPdjMi11h+3e2XmsPyWcQFD8NtHGu/
 hNNw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774590412; x=1775195212;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JXJpmZjGD+lAL9xP0NX5d1i3jdt2XrJAmAyQ4hZVZsI=;
 b=Bo4Vvt4m2zln9mgob11EK3vOfR/mc/wI1YWQ/xxLifUNlqnDfoZa7p4UlDsErPXbEj
 ppWai5uA9mRXRx15c7VOac5dfVzyCo1KSzAwU5IFAPEiCUevZGVY+7q6urkN5Nqi3+JY
 br63AD/vo0Aa8uE7e9N95T/IblafRuyih7jTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774590412; x=1775195212;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JXJpmZjGD+lAL9xP0NX5d1i3jdt2XrJAmAyQ4hZVZsI=;
 b=cP/V7YzurCBl/eUao4dW5l54iOr/izy7F5LHdLFS9p2g/Htoe41Atj8DIK+5o4hUV7
 hHK0BXEkf+DIEu4Y2n7FLgjg2RQnQaks696CR2UvRPpdkWJHE8VY2kbrWdSzC31H9OgM
 KqFr4TA0FSlpxZ6hBEySPOXXFOfnKmJ38D6UUSKBCH1uiobOV1tgAwp3IcLSDfYUIZUc
 W94bzgT1lQkimmATTGl5/UXOn3nu10Nq5Zn9v20IjIc3G5cqC2NNdqLz5dnPo3JoS6Xq
 q+Q/p5lgtXOlacFMZ24V/mWv5keJIs8HQ4hbNE3jnK4kl4nsHOBSCwdp7jjDHsvPO7mu
 ccpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWweWj+lzrhyKpoj12iShgpNVp3gbQiW6t8x3+j5/TUIvX96dLeEwPEXBM5UOq8v2pL6g3JLE62vtI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy485PnTrklsjVglCaFh2bHNHp2th/pusm/mIQYCImhuIQp0SoW
 vyovzAS03gB1irMM5+ZotknCz6hflTFr+hQnPm3cGLVyQb3xogbJzd51MfTBnDJb3weghquTq23
 GLben0iDHySYudU/sFjNV7Wdtt2lr5VJtpIO7gbqb6zikh2YMS5M=
X-Gm-Gg: ATEYQzzS103mbIK9FRhE80WvNNmFayxs6LFEpaY+Xh3+f+T3azBPvR64xwZEodCoptk
 lw7hedYum3C5rGWsQkFf2VFJiA/KGOrsu6ziSy1ZfVZgwTXLXD9mLY12lImiAWXo9LtnD249QxV
 HjWZ8MS+zvteyYp5QWJc/YEctdEQVgmv3+3Ko8URaglVGmTpAFZvvsq9lymcgobuXgRnmTx8ySd
 Q1Tbf+gSAajwdkJjbY3MfhCsV5y3O+N4qpgyagJE9v9G3ffQ6/hIuRRaY5G9SZ6r8BoUXxjA5G3
 NwjVB8my72CNDZwh98+wNyldRrqLeMLHsw9l6Q==
X-Received: by 2002:a05:6512:1599:b0:5a1:182e:1fdd with SMTP id
 2adb3069b0e04-5a2abc20452mr341653e87.0.1774590411989; Thu, 26 Mar 2026
 22:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260326100248.1171828-1-wenst@chromium.org>
 <20260326100248.1171828-4-wenst@chromium.org>
In-Reply-To: <20260326100248.1171828-4-wenst@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 27 Mar 2026 13:46:39 +0800
X-Gm-Features: AQROBzA11nrdWWGkJ_kmjXQVl48ixXKSPO90UOCeo85pY3aqn3lmDV8SL_HlF5U
Message-ID: <CAGXv+5GetFPtCZtQn=khQdkjOVB+A2Sn6_ms88UwHvgLENB9ew@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/gem-dma: Support DRM_MODE_DUMB_KERNEL_MAP flag
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Janne Grunau <j@jannau.net>,
 Liviu Dudau <liviu.dudau@arm.com>, Paul Kocialkowski <paulk@sys-base.io>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
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

On Thu, Mar 26, 2026 at 6:03=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> From: Rob Herring <robh@kernel.org>
>
> Add support in DMA helpers to handle callers specifying
> DRM_MODE_DUMB_KERNEL_MAP flag. Existing behavior is maintained with this
> change. drm_gem_dma_dumb_create() always creates a kernel mapping as
> before. drm_gem_dma_dumb_create_internal() lets the caller set the flags
> as desired.
>
> drm_gem_dma_dumb_create_internal() users have DRM_MODE_DUMB_KERNEL_MAP
> added to preserve existing behavior.
>
> A dumb buffer allocated from these devices can be shared (exported) to
> another device. The consuming device may require the kernel mapping to
> scan out the buffer to its own display. Such devices include DisplayLink
> and various MIPI DBI based displays. Therefore altering the behavior
> should be given much consideration.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> [wenst@chromium.org: Rebase onto renamed GEM DMA helpers]
> [wenst@chromium.org: show "vaddr=3D(no mapping)" in drm_gem_dma_print_inf=
o()]
> [wenst@chromium.org: Add DRM_MODE_DUMB_KERNEL_MAP to new drivers]
> [wenst@chromium.org: Add flags field to drm_gem_dma_create_with_handle()
>                      kerneldoc]
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v2:
> - Added back DRM_MODE_DUMB_KERNEL_MAP flag to all drivers calling
>   drm_gem_dma_dumb_create_internal()
> - Expanded commit message to cover display drivers needing the kernel
>   mapping to do scan out
>
> Changes since v1:
> - Rebased onto renamed GEM DMA helpers
> - Added check in drm_fb_dma_get_scanout_buffer() and drm_gem_dma_vmap().
> - Made drm_gem_dma_print_info() show "vaddr=3D(no mapping)" for objects
>   allocated without kernel mapping
> - Dropped existing DRM_MODE_DUMB_KERNEL_MAP flag addition in various
>   drivers
> - Added DRM_MODE_DUMB_KERNEL_MAP flag to adp_drm_gem_dumb_create()
> - Added flags field kerneldoc for drm_gem_dma_create_with_handle()
>
> Cc: Sasha Finkelstein <fnkl.kernel@gmail.com>
> Cc: Janne Grunau <j@jannau.net>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Paul Kocialkowski <paulk@sys-base.io>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Yannick Fertre <yannick.fertre@foss.st.com>
> Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> Cc: Philippe Cornu <philippe.cornu@foss.st.com>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Cc: "Ma=C3=ADra Canal" <mcanal@igalia.com>
> Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/adp/adp_drv.c                 |  1 +
>  .../gpu/drm/arm/display/komeda/komeda_kms.c   |  1 +
>  drivers/gpu/drm/arm/malidp_drv.c              |  1 +
>  drivers/gpu/drm/drm_fb_dma_helper.c           |  4 ++
>  drivers/gpu/drm/drm_gem_dma_helper.c          | 67 ++++++++++++-------
>  drivers/gpu/drm/logicvc/logicvc_drm.c         |  1 +
>  drivers/gpu/drm/meson/meson_drv.c             |  1 +
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c |  2 +
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c  |  1 +
>  drivers/gpu/drm/stm/drv.c                     |  3 +-
>  drivers/gpu/drm/sun4i/sun4i_drv.c             |  1 +
>  drivers/gpu/drm/vc4/vc4_drv.c                 |  2 +
>  drivers/gpu/drm/verisilicon/vs_drm.c          |  2 +
>  drivers/gpu/drm/xlnx/zynqmp_kms.c             |  2 +
>  14 files changed, 63 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/adp/adp_drv.c b/drivers/gpu/drm/adp/adp_drv.=
c
> index 4554cf75565e..c549b44b3814 100644
> --- a/drivers/gpu/drm/adp/adp_drv.c
> +++ b/drivers/gpu/drm/adp/adp_drv.c
> @@ -95,6 +95,7 @@ static int adp_drm_gem_dumb_create(struct drm_file *fil=
e_priv,
>  {
>         args->height =3D ALIGN(args->height, 64);
>         args->size =3D args->pitch * args->height;
> +       args->flags =3D DRM_MODE_DUMB_KERNEL_MAP;
>
>         return drm_gem_dma_dumb_create_internal(file_priv, drm, args);
>  }
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_kms.c
> index 6ed504099188..2c096ebaea33 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -29,6 +29,7 @@ static int komeda_gem_dma_dumb_create(struct drm_file *=
file,
>         struct komeda_dev *mdev =3D dev->dev_private;
>         u32 pitch =3D DIV_ROUND_UP(args->width * args->bpp, 8);
>
> +       args->flags =3D DRM_MODE_DUMB_KERNEL_MAP;
>         args->pitch =3D ALIGN(pitch, mdev->chip.bus_width);
>
>         return drm_gem_dma_dumb_create_internal(file, dev, args);
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malid=
p_drv.c
> index b765f6c9eea4..5519f48a27c0 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -464,6 +464,7 @@ static int malidp_dumb_create(struct drm_file *file_p=
riv,
>         /* allocate for the worst case scenario, i.e. rotated buffers */
>         u8 alignment =3D malidp_hw_get_pitch_align(malidp->dev, 1);
>
> +       args->flags =3D DRM_MODE_DUMB_KERNEL_MAP;
>         args->pitch =3D ALIGN(DIV_ROUND_UP(args->width * args->bpp, 8), a=
lignment);
>
>         return drm_gem_dma_dumb_create_internal(file_priv, drm, args);
> diff --git a/drivers/gpu/drm/drm_fb_dma_helper.c b/drivers/gpu/drm/drm_fb=
_dma_helper.c
> index fd71969d2fb1..12a44accc48c 100644
> --- a/drivers/gpu/drm/drm_fb_dma_helper.c
> +++ b/drivers/gpu/drm/drm_fb_dma_helper.c
> @@ -187,6 +187,10 @@ int drm_fb_dma_get_scanout_buffer(struct drm_plane *=
plane,
>         if (!dma_obj->vaddr)
>                 return -ENODEV;
>
> +       /* Buffer was allocated with NO_KERNEL_MAPPING */
> +       if (dma_obj->dma_attrs & DMA_ATTR_NO_KERNEL_MAPPING)
> +               return -ENODEV;
> +
>         iosys_map_set_vaddr(&sb->map[0], dma_obj->vaddr);
>         sb->format =3D fb->format;
>         sb->height =3D fb->height;
> diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_g=
em_dma_helper.c
> index 9722c9fc86f3..281fb563f061 100644
> --- a/drivers/gpu/drm/drm_gem_dma_helper.c
> +++ b/drivers/gpu/drm/drm_gem_dma_helper.c
> @@ -116,26 +116,8 @@ __drm_gem_dma_create(struct drm_device *drm, size_t =
size, bool private)
>         return ERR_PTR(ret);
>  }
>
> -/**
> - * drm_gem_dma_create - allocate an object with the given size
> - * @drm: DRM device
> - * @size: size of the object to allocate
> - *
> - * This function creates a DMA GEM object and allocates memory as backin=
g store.
> - * The allocated memory will occupy a contiguous chunk of bus address sp=
ace.
> - *
> - * For devices that are directly connected to the memory bus then the al=
located
> - * memory will be physically contiguous. For devices that access through=
 an
> - * IOMMU, then the allocated memory is not expected to be physically con=
tiguous
> - * because having contiguous IOVAs is sufficient to meet a devices DMA
> - * requirements.
> - *
> - * Returns:
> - * A struct drm_gem_dma_object * on success or an ERR_PTR()-encoded nega=
tive
> - * error code on failure.
> - */
> -struct drm_gem_dma_object *drm_gem_dma_create(struct drm_device *drm,
> -                                             size_t size)
> +static struct drm_gem_dma_object *
> +drm_gem_dma_create_flags(struct drm_device *drm, size_t size, u32 flags)
>  {
>         struct drm_gem_dma_object *dma_obj;
>         int ret;
> @@ -146,6 +128,9 @@ struct drm_gem_dma_object *drm_gem_dma_create(struct =
drm_device *drm,
>         if (IS_ERR(dma_obj))
>                 return dma_obj;
>
> +       if (!(flags & DRM_MODE_DUMB_KERNEL_MAP))
> +               dma_obj->dma_attrs |=3D DMA_ATTR_NO_KERNEL_MAPPING;
> +
>         if (dma_obj->map_noncoherent) {
>                 dma_obj->vaddr =3D dma_alloc_noncoherent(drm_dev_dma_dev(=
drm),
>                                                        size,
> @@ -171,6 +156,30 @@ struct drm_gem_dma_object *drm_gem_dma_create(struct=
 drm_device *drm,
>         drm_gem_object_put(&dma_obj->base);
>         return ERR_PTR(ret);
>  }
> +
> +/**
> + * drm_gem_dma_create - allocate an object with the given size
> + * @drm: DRM device
> + * @size: size of the object to allocate
> + *
> + * This function creates a DMA GEM object and allocates memory as backin=
g store.
> + * The allocated memory will occupy a contiguous chunk of bus address sp=
ace.
> + *
> + * For devices that are directly connected to the memory bus then the al=
located
> + * memory will be physically contiguous. For devices that access through=
 an
> + * IOMMU, then the allocated memory is not expected to be physically con=
tiguous
> + * because having contiguous IOVAs is sufficient to meet a devices DMA
> + * requirements.
> + *
> + * Returns:
> + * A struct drm_gem_dma_object * on success or an ERR_PTR()-encoded nega=
tive
> + * error code on failure.
> + */
> +struct drm_gem_dma_object *drm_gem_dma_create(struct drm_device *drm,
> +                                             size_t size)
> +{
> +       return drm_gem_dma_create_flags(drm, size, DRM_MODE_DUMB_KERNEL_M=
AP);
> +}
>  EXPORT_SYMBOL_GPL(drm_gem_dma_create);
>
>  /**
> @@ -179,6 +188,7 @@ EXPORT_SYMBOL_GPL(drm_gem_dma_create);
>   * @file_priv: DRM file-private structure to register the handle for
>   * @drm: DRM device
>   * @size: size of the object to allocate
> + * @flags: DRM_MODE_DUMB_* flags if any
>   * @handle: return location for the GEM handle
>   *
>   * This function creates a DMA GEM object, allocating a chunk of memory =
as
> @@ -194,14 +204,14 @@ EXPORT_SYMBOL_GPL(drm_gem_dma_create);
>   */
>  static struct drm_gem_dma_object *
>  drm_gem_dma_create_with_handle(struct drm_file *file_priv,
> -                              struct drm_device *drm, size_t size,
> +                              struct drm_device *drm, size_t size, u32 f=
lags,
>                                uint32_t *handle)
>  {
>         struct drm_gem_dma_object *dma_obj;
>         struct drm_gem_object *gem_obj;
>         int ret;
>
> -       dma_obj =3D drm_gem_dma_create(drm, size);
> +       dma_obj =3D drm_gem_dma_create_flags(drm, size, DRM_MODE_DUMB_KER=
NEL_MAP);

Sashiko pointed out an obvious (to me now) error here: this should pass
`flags`, not the flag directly.

ChenYu
