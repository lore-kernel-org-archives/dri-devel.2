Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A7ECCF2DB
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:25:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ACDD10E4CB;
	Mon, 19 Oct 2026 09:25:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9738A10E4CB
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:25:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8DF3260207;
 Mon, 19 Oct 2026 09:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230521F000C9;
 Mon, 19 Oct 2026 09:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792401944;
 bh=3J5rWxcSBzi1BW7UoohFU/JFSJ2Mco3VbfiFgrxGRbA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XwOJOhuGpfmZDDqQNv1cYG7CNO2dbX52qsn09E14bHxiPeUBXvp2jDVKvHAIwjGSx
 ArnXaHZxY/Hs+FsN88wdPsYj121+eWXQhcexjNz1BwkNP4j8S7Es5tyIXHMvziigT2
 2pBF91WL2ge2jMaeSnUMO5xE4XmPMkOz+aeWg8gxFn9+8LhI8rszHShquGU+mJAEzb
 MjiG1kLUFQIAJ5l7jhBoPY9JCV4OIrJaJ1Rf5/08SFJmB6Dxmox0nz2bRxnCYUBd6D
 Y2br72Qe1R08JFFnSfXaVoffyD8K3tUVPXJjK/0dZ3i4ieumMQblWLRZM6ir5TdryS
 EmknYUrwZWKHw==
Message-ID: <sashiko-outbox-176895@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/14] drm/bridge: analogix_dp: Restrict forced
 connected status to panel endpoints
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261019085836.3065008-13-damon.ding@rock-chips.com>
References: <20261019085836.3065008-1-damon.ding@rock-chips.com>
 <20261019085836.3065008-13-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 09:25:43 +0000
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
- [High] drm/bridge: analogix_dp: force_connected_mode breaks analogix_dp_d=
etect_hpd()
- [High] drm/bridge: analogix_dp: unclocked MMIO access in analogix_dp_brid=
ge_detect()
--

commit 3f124dede2fd813765bd376dfd69c3031ce42a2c
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Restrict forced connected status to panel endpoints

This commit restricts the forced connected status in the Analogix DP bridge
driver so that it only applies when the bridge chain ends with a panel and =
no
downstream bridge supports DRM_BRIDGE_OP_DETECT, relying on
analogix_dp_detect_hpd() for other configurations.

Link: https://lore.kernel.org/all/5209243.oAaWjsssbx@diego/

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 853b6a6a7fe4d..df898f3142549 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -912,15 +912,30 @@ analogix_dp_bridge_detect(struct drm_bridge *bridge=
, struct drm_connector *conne
>  	struct analogix_dp_device *dp =3D to_dp(bridge);
>  	enum drm_connector_status status =3D connector_status_disconnected;
> =20
> -	if (dp->bridge.next_bridge)
> -		return connector_status_connected;
> -
>  	if (!analogix_dp_detect_hpd(dp))
>  		status =3D connector_status_connected;
> =20
>  	return status;
>  }
> =20
> +static bool analogix_dp_bridge_force_connected(struct analogix_dp_device=
 *dp)
> +{
> +	struct drm_bridge *last_bridge;
> +	bool force_connected =3D false;
> +
> +	drm_for_each_bridge_in_chain_from(dp->bridge.next_bridge, bridge) {
> +		if (bridge->ops & DRM_BRIDGE_OP_DETECT)
> +			return false;
> +	}
> +
> +	last_bridge =3D drm_bridge_chain_get_last_bridge(dp->encoder);
> +	if (last_bridge)
> +		force_connected =3D drm_bridge_is_panel(last_bridge);
> +	drm_bridge_put(last_bridge);

[Severity: High]
What happens on Exynos boards with a legacy display-timings node (such as
exynos5250-smdk5250.dts and exynos5420-smdk5420.dts) or on non-panel endpoi=
nts
when analogix_dp_bridge_detect() runs while the controller is
runtime-suspended?

In analogix_dp_aux_done_probing(), Exynos boards with display-timings attac=
h a
bridge created via devm_drm_of_display_mode_bridge():

drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:analogix_dp_aux_done_pro=
bing() {
	if (plat_data->dev_type =3D=3D EXYNOS_DP && of_get_display_timings(dp->dev=
->of_node)) {
		next_bridge =3D devm_drm_of_display_mode_bridge(dp->dev, dp->dev->of_node,
							      DRM_MODE_CONNECTOR_eDP);
		if (IS_ERR(next_bridge))
			return PTR_ERR(next_bridge);
		bridge->next_bridge =3D drm_bridge_get(next_bridge);

		return component_add(dp->dev, plat_data->ops);
	}
}

Because devm_drm_of_display_mode_bridge() uses of_display_mode_bridge_funcs
rather than panel_bridge_bridge_funcs, drm_bridge_is_panel(last_bridge)
returns false and dp->force_connected_mode is set to false.

In analogix_dp_bind(), a runtime PM reference is only kept when
analogix_dp_require_pm_for_hpd_irq(dp) is true:

drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:analogix_dp_require_pm_f=
or_hpd_irq() {
	return analogix_dp_is_rockchip(dp->plat_data->dev_type) && !dp->hpd_gpiod =
&&
	       !dp->force_hpd;
}

On Exynos platforms (and on any non-panel endpoint with force-hpd), the DP
controller remains runtime-suspended with dp->clock disabled when the displ=
ay
is off.

Unlike analogix_dp_set_bridge(), analogix_dpaux_transfer(), and
analogix_dpaux_wait_hpd_asserted(), analogix_dp_bridge_detect() does not ca=
ll
pm_runtime_get_sync(dp->dev). When drm_bridge_connector_detect_ctx() calls
analogix_dp_bridge_detect() -> analogix_dp_detect_hpd() ->
analogix_dp_get_plug_in_status() while the display is disabled, won't
readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_3) (and analogix_dp_force_hpd())
access unclocked MMIO registers and cause an external abort?

[ ... ]

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/=
gpu/drm/bridge/analogix/analogix_dp_reg.c
> index af5e5a8ec88d6..abbcdba1a4385 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> @@ -533,6 +533,9 @@ int analogix_dp_get_plug_in_status(struct analogix_dp=
_device *dp)
>  {
>  	u32 reg;
> =20
> +	if (dp->force_connected_mode)
> +		return 0;
> +
>  	if (dp->hpd_gpiod) {
>  		if (gpiod_get_value(dp->hpd_gpiod))
>  			return 0;

[Severity: High]
Does returning 0 early in analogix_dp_get_plug_in_status() when
dp->force_connected_mode is true break hardware HPD handling in
analogix_dp_detect_hpd() and analogix_dpaux_wait_hpd_asserted() for eDP
panels?

In analogix_dp_detect_hpd() (called from analogix_dp_set_bridge() during
bridge .atomic_enable and from analogix_dpaux_transfer() during AUX
transfers), the loop checks analogix_dp_get_plug_in_status(dp) before reach=
ing
the dp->force_hpd fallback:

drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:analogix_dp_detect_hpd()=
 {
	while (timeout_loop < DP_TIMEOUT_LOOP_COUNT) {
		if (analogix_dp_get_plug_in_status(dp) =3D=3D 0)
			return 0;

		timeout_loop++;
		usleep_range(1000, 1100);
	}
	...
	if (!dp->force_hpd)
		return -ETIMEDOUT;
	...
	analogix_dp_force_hpd(dp);
}

Because dp->force_connected_mode is true for panel endpoints,
analogix_dp_get_plug_in_status(dp) now always returns 0 on the first
iteration. As a result, analogix_dp_detect_hpd() returns 0 immediately with=
out
ever calling analogix_dp_force_hpd(dp) to set F_HPD | HPD_CTRL in
ANALOGIX_DP_SYS_CTL_3. On eDP panel boards that use the force-hpd DT proper=
ty,
hardware HPD_STATUS(RO) remains 0 after analogix_dp_init_dp(), which preven=
ts
the AUX channel hardware from working.

In addition, for eDP panels with a physical HPD line (!dp->force_hpd), both
analogix_dp_detect_hpd() and analogix_dpaux_wait_hpd_asserted():

drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:analogix_dpaux_wait_hpd_=
asserted() {
	...
	ret =3D readx_poll_timeout(analogix_dp_get_plug_in_status, dp, val, !val,
				 wait_us / 100, wait_us);
}

will return immediately without polling dp->hpd_gpiod or HPD_STATUS to wait
for the panel to assert HPD after power-on. Should the force_connected_mode
check be kept in analogix_dp_bridge_detect() instead of
analogix_dp_get_plug_in_status()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019085836.3065=
008-1-damon.ding@rock-chips.com?part=3D12
