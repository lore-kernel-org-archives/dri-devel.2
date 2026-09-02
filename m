Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2AAFC624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 20:33:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02D1410F346;
	Wed,  2 Sep 2026 20:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ivATJMVP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 339A010F346
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 20:33:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 60012600D4;
 Wed,  2 Sep 2026 20:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17AE1F000E9;
 Wed,  2 Sep 2026 20:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788381193;
 bh=DDYgPJXD4YbwqSD5NKKXpdEe2rfK1n6sFedryatBgmk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ivATJMVPvIl24x/jTvZiuzqfm3Ask5v+FggBu3gszYVJrhsrXl/uyRreKL1c/eRdg
 WpY0s+WkXopkweypithyNZJsIVkcd6O92XPqPYBo+TzSzHet3JpnHvF6NoQKmsuT/z
 mGJywLn5H2JQHjU2MrknNaLPP8bNaNhDVTizV2XMiHzvtyBWjRX+QCPt7KFtG5j1cZ
 /W5Ne0tVMWImsDxzgmM9j16og6FbhI55f/dGHJix9/6eBemrB00FIVfbTG2RRpdyIE
 Gq1dTtgeEoYRSbESpQ1ZtVrxMR216k7ZUsS10p3zpBWKMzkNjRLltuJaRYKECuWwnx
 z3uwBwd/2yE/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/11] drm: pl111: Use devm_of_reserved_mem_device_init()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260902201640.2024648-4-mukesh.ojha@oss.qualcomm.com>
References: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
 <20260902201640.2024648-4-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 20:33:12 +0000
Message-Id: <20260902203312.E17AE1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing use-after-free and memory corruption risks due to tyi=
ng resource lifetimes (`priv` structure and reserved memory) to `devres` (d=
river unbind) while the `drm_device` can outlive the unbind.
- [High] The `drm_panel_bridge` allocated via `drm_panel_bridge_add_typed()=
` in `pl111_modeset_init()` is leaked if `drm_dev_register()` fails.
- [High] When `INTEGRATOR_CLCD_CM` is matched, `pl111_versatile_init()` ove=
rwrites `np` without dropping the original reference. If the second match f=
ails, probe incorrectly fails.
--

commit 76a1e18802677a9e3db4c051729d253910d2a13c
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

drm: pl111: Use devm_of_reserved_mem_device_init()

This patch converts the driver to use devm_of_reserved_mem_device_init,
allowing the reserved memory region to be released automatically on
probe failure or device removal. It removes the explicit cleanup calls.

> diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl=
111_drv.c
> index 8ec659b3c08eb..a07b17261961c 100644
> --- a/drivers/gpu/drm/pl111/pl111_drv.c
> +++ b/drivers/gpu/drm/pl111/pl111_drv.c
> @@ -255,7 +255,7 @@ static int pl111_amba_probe(struct amba_device *amba_=
dev,
>  	drm->dev_private =3D priv;
>  	priv->variant =3D variant;
> =20
> -	ret =3D of_reserved_mem_device_init(dev);
> +	ret =3D devm_of_reserved_mem_device_init(dev);

[Severity: High]
This is a pre-existing issue, but does tying resource lifetimes to devres
here expose a use-after-free risk?

The priv structure is allocated via devm_kzalloc() and the reserved
memory is now managed via devres, tying their lifetimes to the driver
unbind lifecycle. However, the drm_device is allocated without devres via
drm_dev_alloc() and tied to a refcount.

If a local user holds an open DRM file descriptor (like /dev/dri/card0)
and the driver is unbound via sysfs, devres will free priv and the reserved
memory while the DRM device persists. Because pl111_amba_remove() calls
drm_dev_unregister() instead of drm_dev_unplug(), the device is not
marked as unplugged and subsequent ioctls are not blocked.

An ioctl like DRM_IOCTL_PRIME_FD_TO_HANDLE will call
pl111_gem_import_sg_table(), which accesses dev->dev_private (priv),
potentially causing a use-after-free. Should the driver be migrated to
drm_dev_unplug() and devm_drm_dev_alloc() to prevent this?

[ ... ]

> @@ -314,7 +314,6 @@ static int pl111_amba_probe(struct amba_device *amba_=
dev,
> =20
>  dev_put:
>  	drm_dev_put(drm);
> -	of_reserved_mem_device_release(dev);
> =20
>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but does this error path leak the panel
bridge?

During probe, a bridge is created by calling drm_panel_bridge_add_typed()
inside pl111_modeset_init(), which adds the bridge to the global DRM bridge
list with a reference count of 2.

If drm_dev_register() subsequently fails, the probe function jumps to
the dev_put label. The error path calls drm_dev_put(drm) but fails to
call drm_panel_bridge_remove(priv->bridge). When the panel device is
eventually unbound, its devres cleanup drops one reference on the bridge,
but the bridge is never removed from the global list, leaving a dangling
pointer. Does this need an explicit drm_panel_bridge_remove() call here?

Also, while reviewing the probe path, I noticed a potential node reference
issue in pl111_versatile_init() called earlier in this function:

drivers/gpu/drm/pl111/pl111_versatile.c:pl111_versatile_init() {
    ...
    np =3D of_find_matching_node_and_match(NULL, versatile_clcd_of_match,
                                         &clcd_id);
    ...
    if (clcd_id =3D=3D INTEGRATOR_CLCD_CM) {
        np =3D of_find_matching_node_and_match(NULL, impd1_clcd_of_match,
                                             &clcd_id);
}

[Severity: High]
This is a pre-existing issue, but does overwriting np without dropping the
original reference cause a memory leak?

For the INTEGRATOR_CLCD_CM type, a second call to
of_find_matching_node_and_match() is made, and its result overwrites np
without calling of_node_put() on the original node. If the IM-PD1 syscon
is not found, the second call returns NULL. The probe then calls
syscon_node_to_regmap(NULL), which fails and returns an error, preventing
the driver from probing successfully on valid standard Integrator AP
hardware. Should of_node_put() be called before reassigning np?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902201640.2024=
648-1-mukesh.ojha@oss.qualcomm.com?part=3D3
