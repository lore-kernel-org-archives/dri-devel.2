Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C24CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E905510E32B;
	Thu,  1 Oct 2026 13:17:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nk97Hn3r";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D35F10E32B
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 13:17:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B835C6021D;
 Thu,  1 Oct 2026 13:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB731F000FF;
 Thu,  1 Oct 2026 13:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790860650;
 bh=9uGtGQQfRBYTKFwaOE6ov9AA7SQc8yEr4sgofNwG2HM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nk97Hn3rewJ2aRnWzIwAA+Sa78PoIQfL3wm6N4G4qlvRMuiwVD8je3XxdtZnZdqNW
 kytqMCKlsVlOI3ROmZvkSnsD8ls8ilzje0Gvo3X4nNWmNJaIPXJn7eHB1rBOblwzfq
 EDIP22gqo2Uh6zLDY7fmU3fGRjVcTUSB2U3CsFvljzWYM/4qqsaj9/Bbz6ouv4c/Zg
 L7wisN2J4yE80AMl/8fmW0L02PTd5w4x5XeGb6aimvyD93O0xaLHVOeHt17h2UvEyi
 jASnejoE6RQlDu+7YPEjllkE9FxFVQvXeCem38HMqmBB3spQfH+haV+39qPUaiMNt6
 UXoU8jAX0Fbyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 13/24] drm/mipi-dsi: turn DRM_MIPI_DSI into a
 tristate
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: imx@lists.linux.dev, dri-devel@lists.freedesktop.org, Frank.Li@kernel.org
In-Reply-To: <20261001-drm-bridge-hotplug-v2-13-8e34986dcb68@bootlin.com>
References: <20261001-drm-bridge-hotplug-v2-0-8e34986dcb68@bootlin.com>
 <20261001-drm-bridge-hotplug-v2-13-8e34986dcb68@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 13:17:29 +0000
Message-Id: <20261001131730.2CB731F000FF@smtp.kernel.org>
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
- [Medium] module: drm_mipi_dsi cannot be unloaded and leaks bus registrati=
on
- [Low] kbuild: Linker error due to IS_ENABLED(CONFIG_DRM_MIPI_DSI) when bu=
ilt as module
--

commit 33f0d16c5b1d57480468538aae543a48ddad02aa
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/mipi-dsi: turn DRM_MIPI_DSI into a tristate

DRM_MIPI_DSI is currently a bool, but there's no reason to not be allowed
to build it as a loadable module.

> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 65d46dfa72661..9bdd9110e754b 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -39,7 +39,7 @@ config DRM_MIPI_DBI
>  	select DRM_KMS_HELPER
> =20
>  config DRM_MIPI_DSI
> -	bool
> +	tristate

[Severity: Low]
Will this cause a linker error when CONFIG_DRM=3Dy and CONFIG_DRM_MIPI_DSI=
=3Dm?

Since IS_ENABLED(CONFIG_DRM_MIPI_DSI) is true for both 'y' and 'm',
built-in code will attempt to call exported symbols from the now-loadable
drm_mipi_dsi module, leading to undefined references during the build.
For example, in drivers/gpu/drm/drm_of.c:

drm_of_get_dsi_bus() {
    ...
    #if IS_ENABLED(CONFIG_DRM_MIPI_DSI)
    ...
    dsi_host =3D of_find_mipi_dsi_host_by_node(dsi_host_node);
    ...
}

[Severity: Medium]
Does the drm_mipi_dsi module need a module_exit() cleanup function now that
it can be built as a loadable module?

Currently, mipi_dsi_bus_init() in drivers/gpu/drm/drm_mipi_dsi.c registers
the bus during initialization, but there is no corresponding module_exit()
to unregister it:

static int __init mipi_dsi_bus_init(void)
{
	return bus_register(&mipi_dsi_bus_type);
}
postcore_initcall(mipi_dsi_bus_init);

If the module is forcefully unloaded, it will leave a dangling
mipi_dsi_bus_type registration in the driver core.

[Severity: Low]
This is a pre-existing issue, but does changing this to a tristate still
leave an unmet dependency warning when selected by boolean configs?

For example, config DRM_MSM_DSI in drivers/gpu/drm/msm/Kconfig is a bool
that selects DRM_MIPI_DSI:

config DRM_MSM_DSI
	bool "Enable DSI support in MSM DRM driver"
	depends on DRM_MSM
	depends on DRM_MSM_KMS
	select DRM_PANEL
	select DRM_MIPI_DSI

If CONFIG_DRM=3Dm and CONFIG_DRM_MSM_DSI=3Dy, this forces CONFIG_DRM_MIPI_D=
SI
to 'y', violating its 'depends on DRM' restriction.

>  	depends on DRM
> =20
>  config DRM_KMS_HELPER

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-drm-bridge=
-hotplug-v2-0-8e34986dcb68@bootlin.com?part=3D13
