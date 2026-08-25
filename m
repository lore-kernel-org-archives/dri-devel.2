Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5316C61CE2
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF34910E9CB;
	Tue, 25 Aug 2026 10:32:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R+o1ifM8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B53910E9CB
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 10:32:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A9E546011F;
 Tue, 25 Aug 2026 10:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2B71F000E9;
 Tue, 25 Aug 2026 10:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787653954;
 bh=dUwB8nkxT5AYI1sTDrEszAuZdXbVyaYmCMpOJE3OgoE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R+o1ifM8mNj2+yvGjRYJ6VZ3UTaDxsHiPLXvHfS3cfO3v/sn/o434GAOHCfFnVhPO
 MiwABvFm4p1R5/5eg0O18bPPqx1elBEGMb2R+RwmvUlOhhvE9QfYcdcqO9KyxR3AFB
 kFD5Pj5QbDNEjsJv7XAnRVk9y2U8SvEu+KHOLufoUJug5jBVRn6pFY4swgF+z9E8gN
 2L5BsAz5IMT/RRwyBcl30ifRln6jTvarv06S7vlQWtMJAkqR/9MVLJb+y5NZFT9cK8
 78waI14hZ47NCIkMuzuLrRDXTnLNbBZEMHpYhn74e4kLhcJFCkCknD7CgyHYlrbDjo
 EjrhMzsiW1CpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/12] drm/bridge: tc358767: select DRM_PANEL_BRIDGE
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260825-drm-bridge-drm_panel-cleanup-v2-10-c6c88ba7ffd2@bootlin.com>
References: <20260825-drm-bridge-drm_panel-cleanup-v2-0-c6c88ba7ffd2@bootlin.com>
 <20260825-drm-bridge-drm_panel-cleanup-v2-10-c6c88ba7ffd2@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 10:32:33 +0000
Message-Id: <20260825103234.3F2B71F000E9@smtp.kernel.org>
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
- [Low] Incomplete Kconfig cleanup in patch series: DRM_TOSHIBA_TC358764 us=
es drm_panel_bridge APIs but does not select DRM_PANEL_BRIDGE.
--

--- Patch [10]: [PATCH v2 10/12] drm/bridge: tc358767: select DRM_PANEL_BRI=
DGE ---
commit 0a2f8ec4febb1e1d377dd7d92fdc0b82006defba
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/bridge: tc358767: select DRM_PANEL_BRIDGE

This driver uses a mixture of drm_panel and drm_panel_bridge APIs, but the
Kconfig symbol only selects DRM_PANEL. Select DRM_PANEL_BRIDGE instead,
which in turn depends on DRM_PANEL.

> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kcon=
fig
> index 7874d3b1e7608..8eaaa3282062a 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -399,7 +399,7 @@ config DRM_TOSHIBA_TC358767
>  	select DRM_KMS_HELPER
>  	select REGMAP_I2C
>  	select DRM_MIPI_DSI
> -	select DRM_PANEL
> +	select DRM_PANEL_BRIDGE

[Severity: Low]
Since you are updating bridge drivers in this series to select
DRM_PANEL_BRIDGE, should DRM_TOSHIBA_TC358764 also be updated?

In drivers/gpu/drm/bridge/tc358764.c:tc358764_probe(), the driver uses
devm_drm_of_get_bridge():

	ctx->next_bridge =3D devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
	if (IS_ERR(ctx->next_bridge))

This API call relies on CONFIG_DRM_PANEL_BRIDGE being enabled, but
config DRM_TOSHIBA_TC358764 doesn't select DRM_PANEL_BRIDGE. If the default
for CONFIG_DRM_PANEL_BRIDGE ever changes, could this cause
devm_drm_of_get_bridge() to silently return -ENODEV and fail probing?

>  	help
>  	  Toshiba TC358767 eDP bridge chip driver.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825-drm-bridge=
-drm_panel-cleanup-v2-0-c6c88ba7ffd2@bootlin.com?part=3D10
