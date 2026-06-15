Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A086CCD98CE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 06:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E44310E1F7;
	Mon, 15 Jun 2026 06:40:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IY0baVte";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2560B10E1F8
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 06:40:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D70E643A92;
 Mon, 15 Jun 2026 06:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7192E1F000E9;
 Mon, 15 Jun 2026 06:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781505642;
 bh=7yNAmv61JvbQHkwqcWNf6ZNYI3rUcJOTchHFJDRbC1s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IY0baVteZOrScnI5uuLiQ+1eE5dWKF24/NSGGToEp4CkkJEOc3bvXHzSaTlIUnrGI
 Mx2ijSMEB0LFtbMCgjw3P+xhiMq52YB1sYDP/X8zCOkH7+t53u1SV+fwf4L6Ma89pm
 uV1aXZcsJftvMA8CoU6D5tx6ADtFcFYslCbxUUd8Rd7TWY17Y+6NmaqFKwStoFx1eW
 Cj3XLNZtT4UbLkX72Mz5F5Xck8Am8Jyhsc7Q/XBm3q5Jg+xrJO92smLB7rtyOlS0Ue
 AsoEvL5f3ZYaV59xXKFPEhOoYBwjwvtztzR09k7v+EUKrXjQQHeaNJ9whaIiLeydgn
 KZXAunq95wUfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/7] drm/rcar-du: dsc: Add rudimentary Renesas R-Car
 V4H DSC driver
To: "Tomi Valkeinen" <tomi.valkeinen+renesas@ideasonboard.com>
Cc: robh@kernel.org, wsa+renesas@sang-engineering.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260615-rcar-du-dsc-v4-3-93096a1b56a3@ideasonboard.com>
References: <20260615-rcar-du-dsc-v4-3-93096a1b56a3@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 06:40:42 +0000
Message-Id: <20260615064042.7192E1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] `WARN_ON(pm_runtime_get_sync(dsc->dev))` incorrectly warns on succ=
ess and mishandles errors.
- [High] Mixing devm-managed bridge registration with manual runtime PM man=
ipulation creates race conditions during probe and removal.
- [Low] The driver calls `of_drm_get_bridge_by_endpoint()`, which does not =
exist anywhere in the kernel, causing a build failure.
- [Low] Dead Kconfig dependency prevents `DRM_RCAR_DSC` from ever compiling=
 under `COMPILE_TEST`.
--

commit 6b399ab87555498e65f4bb3171342804aa8feb3a
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

drm/rcar-du: dsc: Add rudimentary Renesas R-Car V4H DSC driver

The Renesas DSC Display Stream Compression is a bridge embedded in the
Renesas R-Car V4H SoC. The bridge performs VESA DSC encoding of up to
8k or 400 Mpixel/s. Add rudimentary driver, which currently acts as a
pass-through bridge and allows DSI1 to be operational on R-Car V4H.

> diff --git a/drivers/gpu/drm/renesas/rcar-du/Kconfig b/drivers/gpu/drm/re=
nesas/rcar-du/Kconfig
> index 840305fdeb49a..80bd770ae0f68 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/Kconfig
> +++ b/drivers/gpu/drm/renesas/rcar-du/Kconfig
[ ... ]
> @@ -25,6 +25,18 @@ config DRM_RCAR_CMM
>  	def_tristate DRM_RCAR_DU
>  	depends on DRM_RCAR_USE_CMM
> =20
> +config DRM_RCAR_USE_DSC
> +	bool "R-Car DU DSC Encoder Support"
> +	depends on DRM_BRIDGE && OF
> +	depends on DRM_RCAR_DU || COMPILE_TEST
> +	default DRM_RCAR_DU
> +	help
> +	  Enable support for the R-Car Display Unit embedded DSC encoder.
> +
> +config DRM_RCAR_DSC
> +	def_tristate DRM_RCAR_DU
> +	depends on DRM_RCAR_USE_DSC
> +

[Severity: Low]
Will this Kconfig setup prevent compile testing?

Since DRM_RCAR_USE_DSC depends on DRM_RCAR_DU || COMPILE_TEST, it can be
enabled when DRM_RCAR_DU=3Dn. However, DRM_RCAR_DSC defaults to
def_tristate DRM_RCAR_DU.

This means when DRM_RCAR_DU=3Dn during a COMPILE_TEST, DRM_RCAR_DSC will be
forced to 'n' and rcar_dsc.c will never actually be compiled.

> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c b/drivers/gpu/drm=
/renesas/rcar-du/rcar_dsc.c
> new file mode 100644
> index 0000000000000..5a2ff31491360
> --- /dev/null
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c
[ ... ]
> +static void rcar_dsc_atomic_enable(struct drm_bridge *bridge,
> +				   struct drm_atomic_commit *commit)
> +{
> +	struct rcar_dsc *dsc =3D bridge_to_rcar_dsc(bridge);
> +
> +	WARN_ON(pm_runtime_get_sync(dsc->dev));
> +}

[Severity: High]
Does this WARN_ON trigger on success?

pm_runtime_get_sync() returns 1 when the device is already active
(RPM_ACTIVE). By wrapping it directly in WARN_ON(), wouldn't this trigger
a false-positive stack trace on every successful modeset?

[ ... ]
> +static int rcar_dsc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct rcar_dsc *dsc;
> +	int ret;
[ ... ]
> +	dsc->bridge.next_bridge =3D of_drm_get_bridge_by_endpoint(dev->of_node,
> +								1, 0);

[Severity: Low]
Does this function exist?

Calling of_drm_get_bridge_by_endpoint() causes a build failure because it
doesn't exist anywhere in the kernel. Was this intended to be
devm_drm_of_get_bridge()?

> +	if (IS_ERR(dsc->bridge.next_bridge))
> +		return PTR_ERR(dsc->bridge.next_bridge);
> +
> +	dsc->bridge.of_node =3D dev->of_node;
> +
> +	ret =3D devm_drm_bridge_add(dev, &dsc->bridge);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_enable(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static void rcar_dsc_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_disable(&pdev->dev);
> +}

[Severity: High]
Can these devres and manual pm_runtime calls race?

In rcar_dsc_probe(), devm_drm_bridge_add() exposes the bridge to the DRM
subsystem before pm_runtime_enable() is called.

On teardown, rcar_dsc_remove() manually calls pm_runtime_disable(), but the
devres-managed bridge isn't removed until devres_release_all() runs later.

Doesn't this create a window where the bridge is fully accessible via DRM
but its PM runtime is disabled, potentially causing hardware access faults
during concurrent operations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-rcar-du-ds=
c-v4-0-93096a1b56a3@ideasonboard.com?part=3D3
