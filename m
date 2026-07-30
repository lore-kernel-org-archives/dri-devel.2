Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306EAC5516D
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7006C10EFB0;
	Thu, 30 Jul 2026 20:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IE+8m9wo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8247210F059
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 20:04:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0E6A942E86;
 Thu, 30 Jul 2026 20:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D451F000E9;
 Thu, 30 Jul 2026 20:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785441880;
 bh=RQccPxPiaRud6OhHNySLeSJfRpEBPb/dEcJVkDdrOlk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IE+8m9woMQfKA/gi0Vyrtia+0WCMT5wtMFrHbUtouGJZVy9S8neOIaP9WjSBl9E30
 rroKnSUfZoatFm7mcDjy8o1aVekdoVeUSo3d9w+4Uw/CtucGHYjzU4rpO/w0ay0dnn
 EOTSyhUzykoRfm/bBH1f8yQIE4he0ackl/PqqdYmJuZHnFxHBTihJ6RUIzxzU9c8xO
 Y1FJLPclRavVHy7clnwe3y/GV8cFTNLhbDlRRX+CursveZtmW+Scs+HPN/bPjZEBj1
 MUkpp1LSFB4RuGcWIXf7cFUpmEUpiEBo2KAgjGHq9wq9DrktDhvPSQ1lE9axgAmoN9
 w4L4AUStcmIgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] drm/nouveau: Fix drm_driver
 struct/nouveau.atomic parameter handling
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730195523.1467423-4-lyude@redhat.com>
References: <20260730195523.1467423-1-lyude@redhat.com>
 <20260730195523.1467423-4-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 20:04:40 +0000
Message-Id: <20260730200440.B9D451F000E9@smtp.kernel.org>
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
- [High] Dynamically allocating `struct drm_driver` with `devm_kzalloc` int=
roduces a Use-After-Free vulnerability when the physical device is unbound.

Pre-existing issues:
- [High] The core driver structure `struct nouveau_drm` is allocated with `=
devm_kzalloc`, leading to a preexisting Use-After-Free when the device is u=
nbound.
--

--- Patch [3]: [PATCH v2 3/5] drm/nouveau: Fix drm_driver struct/nouveau.at=
omic parameter handling ---
commit 9eb1e724469599d6b2baf3bcec061d6d7b31c8bc
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau: Fix drm_driver struct/nouveau.atomic parameter handling

This commit addresses issues with how the nouveau.atomic module parameter is
handled. It replaces shared static drm_driver structures with dynamically
allocated ones using devm_kzalloc to allow safely setting per-device driver
flags.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> index 5565cf2367aa9..ae489dc1b1943 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
[ ... ]
> @@ -737,12 +734,18 @@ nouveau_drm_device_new(const struct drm_driver *drm=
_driver, struct device *paren
>  		{}
>  	};
>  	struct nouveau_drm *drm;
> +	struct drm_driver *drm_driver;
>  	int ret;
> =20
>  	drm =3D devm_kzalloc(parent, sizeof(*drm), GFP_KERNEL);

[Severity: High]
This is a pre-existing issue, but does allocating struct nouveau_drm with
devm_kzalloc() cause a use-after-free on device unbind?

If a userspace process holds a DRM file descriptor open while the physical
device is unbound via sysfs or hot-unplug, devres will free this memory.
Since the DRM device lifetime is reference-counted and extended by the open
descriptor, subsequent ioctls or the final drm_release() might dereference
the freed memory via dev->dev_private.

>  	if (!drm)
>  		return ERR_PTR(-ENOMEM);
> =20
> +	drm_driver =3D devm_kzalloc(parent, sizeof(*drm_driver), GFP_KERNEL);

[Severity: High]
Does allocating drm_driver with devm_kzalloc() introduce a similar
use-after-free vulnerability?

If the device is unbound while a DRM file descriptor is open, devres will
free the drm_driver struct. Since the DRM device outlives the physical
device in this scenario, when userspace eventually closes the file
descriptor, the DRM core cleans up by calling driver hooks (like postclose
or release) through dev->driver, which would now point to freed memory.

Could this be avoided by using the static const struct drm_driver and
modifying the drm->dev->driver_features field instead of allocating a new
driver struct for each device?

> +	if (!drm_driver)
> +		return ERR_PTR(-ENOMEM);
> +	*drm_driver =3D driver_stub;
> +
>  	drm->nvkm =3D device;
> =20
>  	drm->dev =3D drm_dev_alloc(drm_driver, parent);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730195523.1467=
423-1-lyude@redhat.com?part=3D3
