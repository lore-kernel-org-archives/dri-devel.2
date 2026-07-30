Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F85C5516D
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BD5910E681;
	Thu, 30 Jul 2026 20:10:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ld1gY3od";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2D0B10E681
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 20:10:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 47DDF4209E;
 Thu, 30 Jul 2026 20:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0361F000E9;
 Thu, 30 Jul 2026 20:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785442219;
 bh=gVMnlXmHz6P1nKtQyPP+hcmBdwva0a1E1K3pScCvloc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ld1gY3odsPnlnmhlUcPh7fVeiCwuKf9cWfC2lcPwDRa3laTWtzoWntx0MymPAEg5w
 BR+cPnWe1M1r9GZGWtyvCnMclBxhx7I/9WL6zD+23lic+eem5B+OKjG2bxpsu/GH8r
 q93JnMDNeSnMjKGHKiZkIOKBjKdF/8TMjn5JYACn/dbrfzPveDh9WCgvZKeyjT7cC3
 J/chgcBcmawsTaZprcEOSS/i3MOyMKzzuFtbFYIVBHibH3y3yNaTuU3FqQ0G4rhR1d
 AndK02d9kZJR+qgtE7y9n0hyRVp1x9nFtIsJxZslKoY2BJSt+01blKdJ30lcv3NCkN
 Wktob7PgUHpTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] drm/nouveau/kms: Only allow enabling atomic
 modesetting on nv50+
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730195523.1467423-5-lyude@redhat.com>
References: <20260730195523.1467423-1-lyude@redhat.com>
 <20260730195523.1467423-5-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 20:10:18 +0000
Message-Id: <20260730201018.9B0361F000E9@smtp.kernel.org>
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
- [High] Dynamically allocating `struct drm_driver` with `devm_kzalloc` cre=
ates a Use-After-Free on device unbind.
--

--- Patch [4]: [PATCH v2 4/5] drm/nouveau/kms: Only allow enabling atomic m=
odesetting on nv50+ ---
commit 5c23d4459a380de49a6e089b9ca550a380ff5d97
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/kms: Only allow enabling atomic modesetting on nv50+

Atomic modesetting support was never added for pre-nv50 chipsets, so make
sure we don't allow it to be forced on. Additionally, print a small warning
when it's not supported.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> index ae489dc1b1943..33f60f5d4d9f3 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -770,8 +770,12 @@ nouveau_drm_device_new(struct device *parent, struct=
 nvkm_device *device)
>  		goto done;
>  	}
> =20
> -	if (nouveau_atomic)
> -		drm_driver->driver_features |=3D DRIVER_ATOMIC;
> +	if (nouveau_atomic) {
> +		if (drm->device.info.family >=3D NV_DEVICE_INFO_V0_TESLA)
> +			drm_driver->driver_features |=3D DRIVER_ATOMIC;

[Severity: High]
Earlier in nouveau_drm_device_new(), drm_driver is dynamically allocated
with devm_kzalloc():

	drm_driver =3D devm_kzalloc(parent, sizeof(*drm_driver), GFP_KERNEL);
	if (!drm_driver)
		return ERR_PTR(-ENOMEM);

Can this create a use-after-free on device unbind?

If userspace opens the DRM device node, it takes a reference on the
drm_device object. If the PCI device is hot-unplugged or manually unbound,
devres cleanup frees the drm_driver (along with nouveau_drm).

Later, when userspace closes the DRM file descriptor, drm_release() calls
drm_dev_needs_global_mutex() which evaluates dev->driver->driver_features,
and eventually executes dev->driver->postclose(), dereferencing the freed
memory.

> +		else
> +			NV_WARN(drm, "Atomic modesetting not supported (needs nv50+)\n");
> +	}
> =20
>  	ret =3D nvif_device_map(&drm->device);
>  	if (ret) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730195523.1467=
423-1-lyude@redhat.com?part=3D4
