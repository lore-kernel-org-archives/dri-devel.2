Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46FCFEEF2D
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 14:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2054610E43F;
	Tue,  7 Apr 2026 14:44:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="axOyr6zk";
	dkim-atps=neutral
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F173910E43F
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 14:44:04 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-8a032383008so68434976d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 07:44:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775573044; cv=none;
 d=google.com; s=arc-20240605;
 b=KCwE4a+fzaHnj8I8lVXqNCX9Zxjs+PBqszrp4vVGndQcy/x/WT7yYdvl87sN7KQphu
 w8U168Bjizcmqfv230yyp7jbYcQtHgvvTni2Tt6vs5sT44STyFvJAGc9sHrp9jkkty/P
 7l4R5qhlA0wsTFcsSawX8xQPrJy+3KffCMZMeaFaFWqKHhyx4BfnHao+dCnI1pU3F60S
 ICctXCz3ONhU+S9U8s8yPDSjljhy2uH9jcaqlX+eOsOWUGFRTrjFGk51g+SRplxj5252
 +LKgH/nRj9JKS1bLeHTGEaXosPt+9ChVuw5uWC0TPZ7Ti1io+jPWysUNQ4KYK6iYSJOd
 VGFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Zl+ybDcUVtik8d9nb2gVdt0WS3xrV20DIN3DouokInQ=;
 fh=+JtYaV44Xp6flwTJbV/0/l5ZI3RPIyPB6DWO8IlVapg=;
 b=T0oDv6Hyit298HhHLm7w4Msm5tw9XYTLDfxyWGxdc4tkNnJDG3p3bPz5y1Bs45fltH
 JnLBrap63VEpcJ38hfeCjqN6qSfL4DK1VpcbUE8xbhEEzHqp/z6BO6mWKSiU8MsnHP8c
 V8QRTwscZR/4XZiMnG76HZjtfPScMTdSfYLmwL89s1j78zCKJQ1VyYjr8SaEvxpM0cr8
 mc+5WByEyGKapL3CXDE5LD25R6IvNKnwq3UFRSUbI7B5CLN6rf8usfRXUF+eYAaI1ahY
 JZh5IM7pL77+B/kzXPrjXQYiyC0MIqVdieIyv6WD+EihBmFEwk9bwjlRiFMIRhlN5+pp
 O+IQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775573044; x=1776177844; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zl+ybDcUVtik8d9nb2gVdt0WS3xrV20DIN3DouokInQ=;
 b=axOyr6zk52NPMaCfmctRECKBIrTY8rzEH+2zyZpKl8Xvxt2Qg1KI3b6XFQfRc54vIY
 GF0KcD8C1SA7wp+iVj3D2oLb3C2gnOzh8T31u7ENCVmVVwBQ733k8mcKQGGZeiRs6+QC
 B9yTl2Or7zXrOQshEycKFcgmhNw/uYd7GcUwvpupnZH0WxeQXx9+m1nszPBnzLixY7+U
 6MavKvjsWgbXfGmYaP7i8YooQpKzO5u6NhexwJB401sosusIkFrACsgb9pD3ODXfhEJu
 u5f3K0i9N9EUh0Rnt/5Pk1jKYZs5ipeXDFHAohyPIqTI3UWE0ceWAdQaKIIhpqiLsCD/
 B9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775573044; x=1776177844;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zl+ybDcUVtik8d9nb2gVdt0WS3xrV20DIN3DouokInQ=;
 b=YeqQkkObpTvO9NqpIuBgw9rIJovESjs3dyxI89Z5vAb3pPbc5tBuSSRU+XojD9bANH
 u0UN980LjDS20dM+ou+Lx8tuYcw7Uu4ESckA0ka6XEOM7YmJpBAe+9l62BBDckwvEaIa
 n8vZ8HizVeoY4ur5//uOySr69553iu+vaxFfKR0dULUQ2JffKTlf/Uhd3841K8F8NQdq
 yV9fOWyRZlwfu7d2Qa4j0ro9JHOiN0ZU/oOHxpq1hzpLt73iPnEg9hrVV3jpBdUmaIXx
 2EevDEkKLym0rVPaz0IMVvT2R7Dwfboz9FI4aa7zYez42+Op/cD1GzuyLfwnubwxe7Mj
 7wmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlnbpMOot75fDdJRxs1d2CMVfMnx1stvK7c8cgaepIwl2uff2HoXBGhesnvR5moezzcOMlN7fLUoc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxY0vaxlF+WiSQ+j2G73H0gW8Nqh83DMaCsmavJalMNBeF+FQX5
 M/cqaQtK92kUqCD4a4ld8koPphbUV8HheahcfdDpsVZgLNRsUNp0pziU7hxgkjicjPD8tIbooUx
 9Rkx0v3eLbz+Hy0iS0w4G/fNnSxSI5gBAnrwUhCw=
X-Gm-Gg: AeBDieuBjQ25J/lSg6YVdz8J7KdnHQWb0qkPVlqXrbQbEbR4kZJcSSZOG0wihLW2c/n
 /D0553aHGEz7a4Y4GYkmMnrQenJwqz01KR4MDLuJWKyy7ddDUNH+YTIsO30cpv9R++BY/fcrxyi
 JrYLjj2ZJ2RHyXO0aQ4WrUXkLlu+NETOn5K8gpt3kyntIvz9paSY5vwsiaraP8tn5ncdcSuIy2N
 Rgn3bG5sqpEVJ+/c6Kv0EaPMEtkn1ACA0BtjHYYJjTZ8fCFN/w01tUVE79gmWgPQMg/0iRKYfsz
 ZquMRA==
X-Received: by 2002:ad4:5bc3:0:b0:8a5:fcce:4c with SMTP id
 6a1803df08f44-8a7043edff1mr287526516d6.27.1775573043645; 
 Tue, 07 Apr 2026 07:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260326094308.1161335-1-wenst@chromium.org>
 <20260326094308.1161335-3-wenst@chromium.org>
In-Reply-To: <20260326094308.1161335-3-wenst@chromium.org>
From: Inki Dae <daeinki@gmail.com>
Date: Tue, 7 Apr 2026 23:43:26 +0900
X-Gm-Features: AQROBzBGt340ZHEJc4Xn02uKsIv90vik5xWrVoDE6tBxFh2VJoHTruSbBo3C7_4
Message-ID: <CAAQKjZM5NC6svNX=7QpXzsfS-xAsCV2GdLDDdSTDpArwqg=o7g@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/exynos: Use DRM core dedicated DMA device
 tracking facility
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
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

2026=EB=85=84 3=EC=9B=94 26=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 6:51, C=
hen-Yu Tsai <wenst@chromium.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> The exynos driver tracks a dedicated DMA device in its private data.
> The DRM core already has facilities to do this, and it is integrated
> into DRM PRIME imports and GEM DMA helpers.
>
> Convert the exynos driver to use the core's dedicated DMA device
> tracking facility. Also get rid of exynos_drm_gem_prime_import() as
> it is identical to drm_gem_prime_import() after the conversion.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_dma.c | 11 +++++-----
>  drivers/gpu/drm/exynos/exynos_drm_drv.c |  1 -
>  drivers/gpu/drm/exynos/exynos_drm_drv.h |  8 --------
>  drivers/gpu/drm/exynos/exynos_drm_g2d.c | 11 +++++-----
>  drivers/gpu/drm/exynos/exynos_drm_gem.c | 27 ++++++++++---------------
>  drivers/gpu/drm/exynos/exynos_drm_gem.h |  2 --
>  6 files changed, 23 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dma.c b/drivers/gpu/drm/ex=
ynos/exynos_drm_dma.c
> index ccc6b852ee7d..734741c80cbe 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dma.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dma.c
> @@ -8,6 +8,7 @@
>  #include <linux/iommu.h>
>  #include <linux/platform_device.h>
>
> +#include <drm/drm_device.h>
>  #include <drm/drm_print.h>
>  #include <drm/exynos_drm.h>
>
> @@ -41,7 +42,7 @@ static int drm_iommu_attach_device(struct drm_device *d=
rm_dev,
>         struct exynos_drm_private *priv =3D drm_dev->dev_private;
>         int ret =3D 0;
>
> -       if (get_dma_ops(priv->dma_dev) !=3D get_dma_ops(subdrv_dev)) {
> +       if (get_dma_ops(drm_dev_dma_dev(drm_dev)) !=3D get_dma_ops(subdrv=
_dev)) {
>                 DRM_DEV_ERROR(subdrv_dev, "Device %s lacks support for IO=
MMU\n",
>                           dev_name(subdrv_dev));
>                 return -EINVAL;
> @@ -93,8 +94,8 @@ int exynos_drm_register_dma(struct drm_device *drm, str=
uct device *dev,
>  {
>         struct exynos_drm_private *priv =3D drm->dev_private;
>
> -       if (!priv->dma_dev) {
> -               priv->dma_dev =3D dev;
> +       if (drm_dev_dma_dev(drm) =3D=3D drm->dev) {
> +               drm_dev_set_dma_dev(drm, dev);
>                 DRM_INFO("Exynos DRM: using %s device for DMA mapping ope=
rations\n",
>                          dev_name(dev));
>         }
> @@ -109,7 +110,7 @@ int exynos_drm_register_dma(struct drm_device *drm, s=
truct device *dev,
>                         mapping =3D arm_iommu_create_mapping(dev,
>                                 EXYNOS_DEV_ADDR_START, EXYNOS_DEV_ADDR_SI=
ZE);
>                 else if (IS_ENABLED(CONFIG_IOMMU_DMA))
> -                       mapping =3D iommu_get_domain_for_dev(priv->dma_de=
v);
> +                       mapping =3D iommu_get_domain_for_dev(dev);
>
>                 if (!mapping)
>                         return -ENODEV;
> @@ -135,5 +136,5 @@ void exynos_drm_cleanup_dma(struct drm_device *drm)
>
>         arm_iommu_release_mapping(priv->mapping);
>         priv->mapping =3D NULL;
> -       priv->dma_dev =3D NULL;
> +       drm_dev_set_dma_dev(drm, NULL);
>  }
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/ex=
ynos/exynos_drm_drv.c
> index 2101a74dc1ed..9ee30086879f 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
> @@ -109,7 +109,6 @@ static const struct drm_driver exynos_drm_driver =3D =
{
>         .open                   =3D exynos_drm_open,
>         .postclose              =3D exynos_drm_postclose,
>         .dumb_create            =3D exynos_drm_gem_dumb_create,
> -       .gem_prime_import       =3D exynos_drm_gem_prime_import,
>         .gem_prime_import_sg_table      =3D exynos_drm_gem_prime_import_s=
g_table,
>         EXYNOS_DRM_FBDEV_DRIVER_OPS,
>         .ioctls                 =3D exynos_ioctls,
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/ex=
ynos/exynos_drm_drv.h
> index 06c29ff2aac0..1ab7195d09ae 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
> @@ -198,7 +198,6 @@ struct drm_exynos_file_private {
>   */
>  struct exynos_drm_private {
>         struct device *g2d_dev;
> -       struct device *dma_dev;
>         struct device *vidi_dev;
>         void *mapping;
>
> @@ -208,13 +207,6 @@ struct exynos_drm_private {
>         wait_queue_head_t       wait;
>  };
>
> -static inline struct device *to_dma_dev(struct drm_device *dev)
> -{
> -       struct exynos_drm_private *priv =3D dev->dev_private;
> -
> -       return priv->dma_dev;
> -}
> -
>  static inline bool is_drm_iommu_supported(struct drm_device *drm_dev)
>  {
>         struct exynos_drm_private *priv =3D drm_dev->dev_private;
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/ex=
ynos/exynos_drm_g2d.c
> index 348603262af0..85a3a247dfca 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> @@ -20,6 +20,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/workqueue.h>
>
> +#include <drm/drm_device.h>
>  #include <drm/drm_file.h>
>  #include <drm/drm_print.h>
>  #include <drm/exynos_drm.h>
> @@ -278,7 +279,7 @@ static int g2d_init_cmdlist(struct g2d_data *g2d)
>
>         g2d->cmdlist_dma_attrs =3D DMA_ATTR_WRITE_COMBINE;
>
> -       g2d->cmdlist_pool_virt =3D dma_alloc_attrs(to_dma_dev(g2d->drm_de=
v),
> +       g2d->cmdlist_pool_virt =3D dma_alloc_attrs(drm_dev_dma_dev(g2d->d=
rm_dev),
>                                                 G2D_CMDLIST_POOL_SIZE,
>                                                 &g2d->cmdlist_pool, GFP_K=
ERNEL,
>                                                 g2d->cmdlist_dma_attrs);
> @@ -311,7 +312,7 @@ static int g2d_init_cmdlist(struct g2d_data *g2d)
>         return 0;
>
>  err:
> -       dma_free_attrs(to_dma_dev(g2d->drm_dev), G2D_CMDLIST_POOL_SIZE,
> +       dma_free_attrs(drm_dev_dma_dev(g2d->drm_dev), G2D_CMDLIST_POOL_SI=
ZE,

to_dma_dev returns only the dedicated DMA device explicitly stored by
the Exynos driver, whereas drm_dev_dma_dev falls back to the DRM
master device when no dedicated DMA device has been set. So this does
change the existing behavior, but it does not look problematic to me.

Thanks,
Inki Dae
