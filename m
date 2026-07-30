Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F163C55167
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:42:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BD3210F059;
	Thu, 30 Jul 2026 20:42:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oWTQcSKB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 343AE10F059
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 20:42:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E22E041915;
 Thu, 30 Jul 2026 20:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992361F000E9;
 Thu, 30 Jul 2026 20:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785444143;
 bh=AzT4YysgnHW0gNKLyJNjn+mhh5/NYNaN0qxuBV7FYXc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oWTQcSKBXkT55zODPfIj3VIXS3FjyuzSam3cAwdk8wD8gCy+45kbzv6odG+s0Nylb
 CXQwaKic53QviUTe05pwuQxYjCQbXanNWy7j4VuVIop7EjvzjpRw93OPwkdLPyW+rO
 R/WuNz15/ncOaGfk+b/tvXgX1npc9wG4ABBtTW3Dkw+SQEl0JNoPAgPGrzDpyywQI7
 dO6ULthufyJig/rbMRFI1PDWUKIibm0bHEOzNKtdU/B3z886Pa3+qiBt/yu3WE+ANa
 5yr20hH2JNRcbASjPG9WnFYoAQFWDAakgYW6i6lGQPpzBJ23+bYm7AekENSlFsmK07
 rQL3SMCy63D8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] drm/nouveau: Fix drm_driver
 struct/nouveau.atomic parameter handling
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730203015.1572240-4-lyude@redhat.com>
References: <20260730203015.1572240-1-lyude@redhat.com>
 <20260730203015.1572240-4-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 20:42:23 +0000
Message-Id: <20260730204223.992361F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Embedding the `drm_driver` struct inside the dynamically allocated=
 `nouveau_drm` struct causes a Use-After-Free when the device is unplugged =
but userspace holds open DRM file descriptors.

Pre-existing issues:
- [Critical] nouveau_drm_device_new() incorrectly returns 0 (NULL) on succe=
ss, causing an immediate kernel panic during device probe.
--

--- Patch [3]: [PATCH v3 3/5] drm/nouveau: Fix drm_driver struct/nouveau.at=
omic parameter handling ---
commit d192ca1eced4bd2c1c15cea6e0c5ae59ed261add
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau: Fix drm_driver struct/nouveau.atomic parameter handling

The way we handled the nouveau.atomic module parameter before was fairly
broken, and had a number of issues:

[ ... ]

> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> index 6940e774ace07..95daf2643e1df 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
[ ... ]
> @@ -727,8 +725,7 @@ nouveau_drm_device_del(struct nouveau_drm *drm)
>  }
> =20
>  static struct nouveau_drm *
> -nouveau_drm_device_new(const struct drm_driver *drm_driver, struct devic=
e *parent,
> -		       struct nvkm_device *device)
> +nouveau_drm_device_new(struct device *parent, struct nvkm_device *device)
>  {

[Severity: Critical]
This is a pre-existing issue (introduced earlier in the series), but does
nouveau_drm_device_new() incorrectly return 0 (NULL) on success?

At the end of nouveau_drm_device_new(), it returns 0:

	return 0;

err_free_drm:

This causes callers like nouveau_drm_probe() to incorrectly bypass the
IS_ERR() check, as IS_ERR(NULL) is false:

nouveau_drm_probe()
	drm =3D nouveau_drm_device_new(&pdev->dev, device);
	if (IS_ERR(drm)) {
		ret =3D PTR_ERR(drm);
		goto fail_nvkm;
	}

	ret =3D pci_enable_device(pdev);
	if (ret)
		goto fail_drm;

	ret =3D nouveau_drm_device_init(drm);

The NULL pointer is then passed to nouveau_drm_device_init(), which
immediately dereferences it and causes a kernel panic during device probe.

[ ... ]
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouv=
eau/nouveau_drv.h
> index 5fc75dc750ed0..5cc0001134e74 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drv.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
> @@ -216,6 +216,7 @@ struct nouveau_drm {
> =20
>  	struct nouveau_cli client;
>  	struct drm_device *dev;
> +	struct drm_driver drm_driver;

[Severity: High]
Can embedding the drm_driver struct inside the dynamically allocated
nouveau_drm struct cause a use-after-free when the device is unplugged?

When the device is unbound, nouveau_drm_device_del() drops the driver's
reference to the DRM device and then immediately frees the nouveau_drm stru=
ct
using kfree():

drivers/gpu/drm/nouveau/nouveau_drm.c:nouveau_drm_device_del() {
	if (drm->dev)
		drm_dev_put(drm->dev);
	...
	kfree(drm);
}

Because drm_driver is now embedded in nouveau_drm, the drm_driver struct is
also freed here.

If userspace still has an open file descriptor, the drm_device remains aliv=
e.
When userspace later closes the file descriptor, DRM core functions (such as
drm_release) will attempt to dereference dev->driver (e.g.,
dev->driver->postclose), resulting in a use-after-free.

> =20
>  	struct list_head clients;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730203015.1572=
240-1-lyude@redhat.com?part=3D3
