Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA23CC5516D
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F87010F092;
	Thu, 30 Jul 2026 20:54:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bkLph6VO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FA2B88784
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 20:54:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0618D40BEB;
 Thu, 30 Jul 2026 20:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18681F000E9;
 Thu, 30 Jul 2026 20:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785444857;
 bh=oWB7mLhQs5qDRgc87F/Xb8jYRpPDWbWiKuDCJdjV45o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bkLph6VO8ZFO4LGgVtpICFe9bwO49EQ7L33/h+DnHTC/yrJHyN/Y4riFwNpCsyJVh
 3HFmGTVdkw3zF0+i697UDv1Y16Bw6uYIrOb64V4Xr0WXOQpAGnbFv849Vx0xUS0nAL
 TkOdoWI3aaSvKqxv66mNiknBTlg48MCbIXsXzSVTuYZp8uECh5KR0JlmQlHpGFMmRf
 WaCZSmsMK5+BnyCETIzTk0D0IEGFWPuSwTHkFSIa8jX/Hu5PKBSfnlYDn0hSHnRVqP
 MLNSbLwPRrZROgJImNH8tU/VhzMZnGrbYUFnWAqYmCaB2qrmdSm81x1+1lj9TKHp1c
 lSDmOTkfS0+wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] drm/nouveau: Fix drm_driver
 struct/nouveau.atomic parameter handling
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730203723.1649433-4-lyude@redhat.com>
References: <20260730203723.1649433-1-lyude@redhat.com>
 <20260730203723.1649433-4-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 20:54:17 +0000
Message-Id: <20260730205417.B18681F000E9@smtp.kernel.org>
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
- [High] Embedding `drm_driver` in `struct nouveau_drm` introduces an explo=
itable Use-After-Free vulnerability when the device is unplugged or unbound=
 while userspace holds open file descriptors.
--

--- Patch [3]: [PATCH v4 3/5] drm/nouveau: Fix drm_driver struct/nouveau.at=
omic parameter handling ---
commit 6aa4a539bc58f0cd546203fa854c1edf2120c1be
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau: Fix drm_driver struct/nouveau.atomic parameter handling

This commit moves the drm_driver struct from a static global variable
into the dynamically allocated nouveau_drm structure. It also handles
conditionally enabling atomic modesetting per-device.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouv=
eau/nouveau_drv.h
> --- a/drivers/gpu/drm/nouveau/nouveau_drv.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
> @@ -216,6 +216,7 @@ struct nouveau_drm {
> =20
>  	struct nouveau_cli client;
>  	struct drm_device *dev;
> +	struct drm_driver drm_driver;
> =20
>  	struct list_head clients;

[ ... ]

> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
[ ... ]
> @@ -744,12 +741,14 @@ nouveau_drm_device_new(const struct drm_driver *drm=
_driver, struct device *paren
>  	if (!drm)
>  		return ERR_PTR(-ENOMEM);
> =20
> +	drm->drm_driver =3D driver_stub;
>  	drm->nvkm =3D device;
> =20
> -	drm->dev =3D drm_dev_alloc(drm_driver, parent);
> +	drm->dev =3D drm_dev_alloc(&drm->drm_driver, parent);

[Severity: High]
Does embedding drm_driver inside nouveau_drm create a use-after-free
risk if the device is unplugged or unbound while userspace holds an open
file descriptor?

If a user opens the DRM device node, the open file descriptor holds a
reference to the drm_device. If the device is then hot-unplugged or
unbound via sysfs, nouveau_drm_device_del() will unconditionally free
the nouveau_drm struct:

nouveau_drm_device_del()
    ...
    kfree(drm);

However, the drm_device remains alive due to the file descriptor's
reference. When the user later closes the file descriptor, the DRM core
will dereference the dangling dev->driver pointer:

drm_file_free()
    ...
    if (dev->driver->postclose)
        dev->driver->postclose(dev, file);

Could this lead to memory corruption since the drm_driver struct was
already freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730203723.1649=
433-1-lyude@redhat.com?part=3D3
