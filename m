Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F6BCCF2DB
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:12:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EED9010E759;
	Mon, 19 Oct 2026 09:12:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96F2B10E759
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:12:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 990F4600CB;
 Mon, 19 Oct 2026 09:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4251F000C4;
 Mon, 19 Oct 2026 09:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792401140;
 bh=vGGurXG7+5iyyNgACf1dudxKsy/72R+naI3QdcoF6eY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=olRHmqke0qz7Fb4Vxi9i/bpcmns0bU835xCgPykzpkYrXMbShvzCnrHDejpeuNd4H
 S45TrTO2Qo5rpmrarhiMIsTRa6PFtBMNunIBIldBj3NNvQEMwmYGM01pTzAt2aCgPA
 mRWCOEQqk/KA8mjqfXopariETbdeMta1jTabOOhWv9XYLPYM/NFzqHFADp2gTSPQhU
 ApZv8P4rBXntFcVbeDWG/t6QzSBbABN0XDpmya6MFVZYkHIgZoI1968HDDwKRgrXzZ
 UpmKVgaXcZLGBZ7lmgnWcSSypsAIrUttAIjBP0jI7Q7PVqb8I1hXBVMKe6DwqZFJ/J
 wKWWKjKGyT1NA==
Message-ID: <sashiko-outbox-176879@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/14] drm/bridge: analogix_dp: Use
 bridge->next_bridge instead of plat_data field
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261019085836.3065008-12-damon.ding@rock-chips.com>
References: <20261019085836.3065008-1-damon.ding@rock-chips.com>
 <20261019085836.3065008-12-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 09:12:19 +0000
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
- [Medium] drm/bridge: analogix_dp: leak of timings in analogix_dp_aux_done=
_probing()
- [Low] drm/bridge: analogix_dp: missing Kconfig selects for display mode b=
ridge
--

commit a6bc11591ee5c87dfb3184d18836932fc5960d45
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Use bridge->next_bridge instead of plat_data field

This commit replaces dp->plat_data->next_bridge with dp->bridge.next_bridge
in the analogix_dp driver and moves the Exynos display-timings bridge setup
from exynos_dp_probe() into analogix_dp_aux_done_probing().

Link: https://lore.kernel.org/all/5609825.iZASKD2KPV@diego/

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 38857508d9392..853b6a6a7fe4d 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c

[ ... ]

> @@ -1655,37 +1658,34 @@ struct drm_dp_aux *analogix_dp_get_aux(struct ana=
logix_dp_device *dp)
>  }
>  EXPORT_SYMBOL_GPL(analogix_dp_get_aux);
> =20
> -static void analogix_dp_put_bridge(void *data)
> -{
> -	drm_bridge_put(data);
> -}
> -
>  static int analogix_dp_aux_done_probing(struct drm_dp_aux *aux)
>  {
>  	struct analogix_dp_device *dp =3D to_dp(aux);
>  	struct analogix_dp_plat_data *plat_data =3D dp->plat_data;
> +	struct drm_bridge *bridge =3D &dp->bridge, *next_bridge;
>  	int port =3D plat_data->dev_type =3D=3D EXYNOS_DP ? 0 : 1;
> -	int ret;
> +
> +	if (plat_data->dev_type =3D=3D EXYNOS_DP && of_get_display_timings(dp->=
dev->of_node)) {
> +		next_bridge =3D devm_drm_of_display_mode_bridge(dp->dev, dp->dev->of_n=
ode,
> +							      DRM_MODE_CONNECTOR_eDP);

[Severity: Low]
Will moving of_get_display_timings() and devm_drm_of_display_mode_bridge()
into analogix_dp_aux_done_probing() cause undefined symbol errors at link
time when CONFIG_DRM_EXYNOS_DP is not enabled?

Previously these calls lived in drivers/gpu/drm/exynos/exynos_dp.c under
CONFIG_DRM_EXYNOS_DP, where DRM_EXYNOS_DP selects DRM_OF_DISPLAY_MODE_BRIDGE
and DRM_EXYNOS selects VIDEOMODE_HELPERS.

drivers/gpu/drm/bridge/analogix/analogix_dp_core.c is built under
CONFIG_DRM_ANALOGIX_DP, which only selects DRM_DISPLAY_DP_AUX_BUS:

drivers/gpu/drm/bridge/analogix/Kconfig:
config DRM_ANALOGIX_DP
	tristate
	depends on DRM
	depends on OF
	select DRM_DISPLAY_DP_AUX_BUS

Because plat_data->dev_type =3D=3D EXYNOS_DP is evaluated at runtime, the
compiler emits references to both devm_drm_of_display_mode_bridge() (which
has no stub in include/drm/bridge/of-display-mode-bridge.h) and
of_get_display_timings() (declared whenever CONFIG_OF is enabled, while
drivers/video/of_display_timing.o requires CONFIG_VIDEOMODE_HELPERS).

Configurations such as CONFIG_ROCKCHIP_ANALOGIX_DP without
CONFIG_DRM_EXYNOS_DP, or CONFIG_DRM_ANALOGIX_DP=3Dy with CONFIG_DRM_EXYNOS=
=3Dm,
will fail to link unless DRM_ANALOGIX_DP selects DRM_OF_DISPLAY_MODE_BRIDGE
and VIDEOMODE_HELPERS (or stubs are provided).

[Severity: Medium]
Also in analogix_dp_aux_done_probing(), does calling
of_get_display_timings(dp->dev->of_node) directly in the condition leak the
allocated struct display_timings?

In drivers/video/of_display_timing.c, of_get_display_timings() allocates
struct display_timings, disp->timings, and each struct display_timing entry,
expecting the caller to free them with display_timings_release():

drivers/video/of_display_timing.c:of_get_display_timings() {
	...
	timings_np =3D of_get_child_by_name(np, "display-timings");
	if (!timings_np) {
		pr_err("%pOF: could not find display-timings node\n", np);
		return NULL;
	}

	disp =3D kzalloc_obj(*disp);
	...
}

Because the returned pointer is not saved or passed to
display_timings_release(), those allocations are leaked on Exynos DP boards
with a display-timings node (and devm_drm_of_display_mode_bridge() will
parse the node a second time via of_get_drm_display_mode()). In addition,
when no display-timings child node is present on Exynos boards using a panel
or bridge endpoint, of_get_display_timings() prints a spurious error messag=
e.

> +		if (IS_ERR(next_bridge))
> +			return PTR_ERR(next_bridge);
> +		bridge->next_bridge =3D drm_bridge_get(next_bridge);
> +
> +		return component_add(dp->dev, plat_data->ops);
> +	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019085836.3065=
008-1-damon.ding@rock-chips.com?part=3D11
