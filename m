Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635F1C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 03:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A0B710E547;
	Wed,  8 Jul 2026 03:40:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Pml7N8IV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7312810E547
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 03:40:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0E665437E2;
 Wed,  8 Jul 2026 03:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61C01F000E9;
 Wed,  8 Jul 2026 03:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783482056;
 bh=eAb66SN6wm3499R03QEHmsNvbBCzcXsLYV4h6djXQAk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Pml7N8IVdZ+Cteoyys82XU8nrw9S0mhmAfxebCyHg65HDwwKjvetOACmSM8OCJ4aj
 W2xkExRElXR+UI/Iyh9PyFlWBcfTJJP4qIe47cxs8UIy4keU60bkHpIYbw7OZiNUty
 setpvyLVjkfQ+hxKcyNNFAsTp3qwDWITO1IwzZB0N6wOo0GItdqJ2+SvGD+D0YnVZf
 729FKbrns3+s2ZC9I7qGdCiHyyvYW6IPIfPPZsgqtZ+T8dtZM6POs8VzplnSiNSB7F
 p/Efpy0FxPIioVTd1FcCWYs2DfUX195eqGR1jCJst+Nj5A4/kJQuQ/TVh1drS9qeBP
 7VpGE21s4F50g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/exynos: vidi: fix EDID leak on concurrent
 connection ioctl
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260708032847.712897-1-lgs201920130244@gmail.com>
References: <20260708032847.712897-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 03:40:56 +0000
Message-Id: <20260708034056.B61C01F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent execution of `vidi_connection_ioctl` and device removal=
 leads to a Use-After-Free of `ctx`.
--

--- Patch [1]: [PATCH] drm/exynos: vidi: fix EDID leak on concurrent connec=
tion ioctl ---
commit a672572794a1e16312bff77e391a1da1f3e7e9fe
Author: Guangshuo Li <lgs201920130244@gmail.com>

drm/exynos: vidi: fix EDID leak on concurrent connection ioctl

This commit fixes a memory leak in vidi_connection_ioctl() caused by
concurrent connection requests. It ensures the connection state check
and the EDID assignment are protected by the same critical section to
prevent a second request from overwriting an already allocated EDID.

> diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/e=
xynos/exynos_drm_vidi.c
> index 67bbf9b8bc0ef..bc0af9e6bc810 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c

[ ... ]

> @@ -293,21 +284,37 @@ int vidi_connection_ioctl(struct drm_device *drm_de=
v, void *data,
>  					  "edid data is invalid.\n");
>  			return -EINVAL;
>  		}
> +
>  		mutex_lock(&ctx->lock);

[Severity: High]
This is a pre-existing issue, but can this result in a Use-After-Free if
the device is unbound concurrently?

Looking at the start of vidi_connection_ioctl(), ctx is resolved locklessly:

	struct device *dev =3D priv ? priv->vidi_dev : NULL;
	struct vidi_context *ctx =3D dev ? dev_get_drvdata(dev) : NULL;

If an authenticated client calls this ioctl, it can sleep earlier in this
function during copy_from_user() or drm_edid_alloc().

If the exynos-drm-vidi platform device is concurrently unbound via sysfs,
vidi_remove() could complete and devres may free the ctx structure while
the ioctl is sleeping.

Since Exynos DRM uses drm_dev_unregister() instead of drm_dev_unplug()
during teardown, in-flight ioctls are not blocked by the DRM core's
drm_dev_is_unplugged() check.

When the ioctl wakes up and reaches this mutex_lock(&ctx->lock), will it
dereference the freed ctx pointer?

> +		if (ctx->connected =3D=3D vidi->connection) {
> +			mutex_unlock(&ctx->lock);
> +			drm_edid_free(drm_edid);
> +			DRM_DEV_DEBUG_KMS(ctx->dev,
> +					  "same connection request.\n");
> +			return -EINVAL;
> +		}
> +
> +		drm_edid_free(ctx->raw_edid);
> +
>  		ctx->raw_edid =3D drm_edid;
> +		ctx->connected =3D vidi->connection;
>  		mutex_unlock(&ctx->lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708032847.7128=
97-1-lgs201920130244@gmail.com?part=3D1
