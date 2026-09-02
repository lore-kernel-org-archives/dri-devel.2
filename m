Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A714CC624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 20:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C181910F344;
	Wed,  2 Sep 2026 20:27:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="if78KRWh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38F2410F344
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 20:27:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 08980439D5;
 Wed,  2 Sep 2026 20:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CE71F000E9;
 Wed,  2 Sep 2026 20:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788380847;
 bh=ohY7UvPWIjKc+e6gBiaAnd4UiIP7bpQTFLLHbCw9gUE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=if78KRWhmJ7eyzrBVRLa1nWLYCGHv9Qd5pwyfbwAeee/rgU0ExC9hsha78sHWmP4q
 WnPMZ1jPg9zYfVyxrXu4YKOZmJutbGO8VSGQJCr61GfILAfu7WdbjfyiUxFVzkgVdE
 L/O4IMp+o5vxhiEKTk3KjVvzKhpz+Szu0+QMq6dAVYwJS1IlL7PbmsrQi5ne8Nc+9u
 yfcseTDmjyLbT+ZiSWRXsr/DuDzd4P9LBQoXoVbbSfJ9/W7Ydr76slM6USx9xi9Ofv
 WdmtsP/5zrusc/5JQKP9fX8OWjAGfBcrEPjKpYbJTWIwQ/wZ2iXPoc/Tob0WdwV1p6
 AYUGnhur37mjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/11] drm: ingenic: Use
 devm_of_reserved_mem_device_init()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260902201640.2024648-7-mukesh.ojha@oss.qualcomm.com>
References: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
 <20260902201640.2024648-7-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 20:27:27 +0000
Message-Id: <20260902202727.B4CE71F000E9@smtp.kernel.org>
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
- [High] Using devres (`devm_*`) allocations in a component bind callback c=
auses resource leaks and rebind failures.
- [High] Hardware clocks are disabled before shutting down the DRM pipeline=
, causing a bus hang on unbind.
- [High] `component_unbind_all()` is executed from a devres cleanup action =
without holding `component_mutex`, triggering a kernel warning and data rac=
e.
--

commit c7a21593821addf1c793b56266b4eca7b14e1ad2
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

drm: ingenic: Use devm_of_reserved_mem_device_init()

Replace the hand-rolled devm wrapper (ingenic_drm_release_rmem +
devm_add_action_or_reset) with the standard
devm_of_reserved_mem_device_init(), letting the device resource
manager handle cleanup automatically.

> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/=
ingenic/ingenic-drm-drv.c
> index 738a80b2550ff..2c4dd6ed2d413 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -1060,11 +1060,6 @@ static void ingenic_drm_unbind_all(void *d)
>  	component_unbind_all(priv->dev, &priv->drm);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but is component_unbind_all()
executed from a devres cleanup action without holding component_mutex?

The driver registers ingenic_drm_unbind_all() as a devres action via
devm_add_action_or_reset(). When the platform device is removed, the driver
core executes devres cleanup actions after ->remove() returns.

At this point, the component framework is inactive and component_mutex is n=
ot
held, but ingenic_drm_unbind_all() directly calls component_unbind_all(),
which strictly requires this mutex.

Could this trigger a kernel warning (WARN_ON(!mutex_is_locked(&component_mu=
tex))),
and potential list corruption or use-after-free due to concurrent modificat=
ion
of the component lists without proper serialization?

[ ... ]

> @@ -1127,16 +1122,10 @@ static int ingenic_drm_bind(struct device *dev, b=
ool has_components)
>  	}
> =20
>  	if (IS_ENABLED(CONFIG_OF_RESERVED_MEM)) {
> -		ret =3D of_reserved_mem_device_init(dev);
> +		ret =3D devm_of_reserved_mem_device_init(dev);
> =20
>  		if (ret && ret !=3D -ENODEV)
>  			dev_warn(dev, "Failed to get reserved memory: %d\n", ret);
> -
> -		if (!ret) {
> -			ret =3D devm_add_action_or_reset(dev, ingenic_drm_release_rmem, dev);
> -			if (ret)
> -				return ret;
> -		}
>  	}
> =20
>  	priv =3D devm_drm_dev_alloc(dev, &ingenic_drm_driver_data,

[Severity: High]
This is a pre-existing issue, but does using devres (devm_*) allocations in=
 a
component bind callback cause resource leaks and rebind failures?

When the component framework unbinds a device (e.g., if the IPU component is
removed), ingenic_drm_unbind() is called, but it does not trigger devres cl=
eanup
since devres is tied to the platform device, not the component.

When it binds again, ingenic_drm_bind() runs, leaking previous devres
allocations like devm_drm_dev_alloc(). This also causes failures when reque=
sting
exclusive resources again, such as:

ingenic_drm_bind()
    ...
    base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);

This will fail on rebind because the MMIO region remains held by the leaked
previous allocation. Can this be triggered locally by a privileged user
unbinding the IPU component or the display driver via sysfs?


While reviewing this file, I noticed another pre-existing issue:

[Severity: High]
This isn't a bug introduced by this patch, but are hardware clocks disabled
before shutting down the DRM pipeline, causing a bus hang on unbind?

In ingenic_drm_unbind():

    clk_disable_unprepare(priv->pix_clk);

    drm_dev_unregister(&priv->drm);
    drm_atomic_helper_shutdown(&priv->drm);

When the driver is unbound while the display is active, it first disables
lcd_clk and pix_clk. Immediately after, it calls drm_atomic_helper_shutdown=
(),
which iterates over active CRTCs and planes to disable them.

These disable callbacks (like ingenic_drm_bridge_atomic_disable() and
ingenic_drm_plane_disable()) perform MMIO writes via regmap_update_bits() a=
nd
regmap_clear_bits().

Will accessing MMIO registers while the peripheral's clock is gated cause a
system bus hang (hard freeze or kernel panic) when a privileged user unloads
the driver module or unbinds the device via sysfs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902201640.2024=
648-1-mukesh.ojha@oss.qualcomm.com?part=3D6
