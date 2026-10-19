Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC5ACCF2DA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:29:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A26ED10E91C;
	Mon, 19 Oct 2026 09:28:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A10710E946
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:28:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DC44560207;
 Mon, 19 Oct 2026 09:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076D61F000C5;
 Mon, 19 Oct 2026 09:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792402126;
 bh=loUi/yjEnEh6QfOCmdYmzxAXN/YMRzkvd7EEQR4sFFI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=benBw7+slggds1nn/nGaklx3y8HWklynArV3TnMHNk5NjB9/9d9iX0os5Pl3b/Srg
 5lTV0JjWrOmLDDdJvNuKxdwrIG/y0Wnr6fTV2324sZvBdmHve4qu3v170rbLn5MXS1
 U+jZ11Z1v0vZ5ez0TlVbAN7p3MSVTundM/ljoohtV9kWBHoZxT1gzrsvpd8ClL5y68
 TJ9d4ybjWE7L4HLyAv6cIZVw4vs5mQ97dRM1b4u5Gk6c4v5fj9h0qe3jqjPXSEdxHf
 c27A6EmCPLWzn8dNn97UV2bg97IZyqtN8fp97kcmWDwmzyRySq5xQMxhYdYr6HEeZO
 kj4/7NDPVp0bw==
Message-ID: <sashiko-outbox-176904@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/14] drm/bridge: analogix_dp: Manage pm runtime and
 IRQ for native HPD pin detection
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261019085836.3065008-11-damon.ding@rock-chips.com>
References: <20261019085836.3065008-1-damon.ding@rock-chips.com>
 <20261019085836.3065008-11-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 09:28:45 +0000
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
- [High] drm/bridge: analogix_dp: AUX powered down after analogix_dp_bridge=
_disable()
- [High] drm/bridge: analogix_dp: unmasked native IRQ active across runtime=
 suspend
- [Medium] drm/bridge: analogix_dp: analogix_dp_require_pm_for_hpd_irq() bl=
ocks eDP runtime suspend
- [Medium] drm/bridge: analogix_dp: missing DRM_BRIDGE_OP_HPD in analogix_d=
p_bind()
--

commit 084692aff33ec03020fcf182af076977c2df993a
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Manage pm runtime and IRQ for native HPD pin detec=
tion

This commit acquires a runtime PM reference in analogix_dp_bind() and
releases it in analogix_dp_unbind() for Rockchip native HPD pin mode so
the DP controller stays powered and clocked to detect hotplug interrupts
while the display pipeline is inactive.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index addd319719de4..38857508d9392 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -39,6 +39,12 @@
> =20
>  static const bool verify_fast_training;
> =20
> +static bool analogix_dp_require_pm_for_hpd_irq(struct analogix_dp_device=
 *dp)
> +{
> +	return analogix_dp_is_rockchip(dp->plat_data->dev_type) && !dp->hpd_gpi=
od &&
> +	       !dp->force_hpd;
> +}

[Severity: Medium]
Does analogix_dp_require_pm_for_hpd_irq() also return true on Rockchip boar=
ds
with a fixed eDP panel that do not specify force-hpd or hpd-gpios in Device
Tree (such as rk3399-gru-kevin.dts, rk3399-gru-bob.dts,
rk3399-sapphire-excavator.dts, and rk3288-veyron-jaq/jerry/minnie/tiger.dts=
)?

On those systems, analogix_dp_bridge_detect() unconditionally returns
connector_status_connected when dp->plat_data->next_bridge is present:

drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:analogix_dp_bridge_detec=
t() {
	if (dp->plat_data->next_bridge)
		return connector_status_connected;
}

Later in the series, commit "drm/bridge: analogix_dp: Handle HPD notificati=
on
from downstream bridge" adds !dp->hpd_notify_mode to
analogix_dp_require_pm_for_hpd_irq(), and commit "drm/bridge: analogix_dp:
Restrict forced connected status to panel endpoints" introduces
dp->force_connected_mode for fixed panel endpoints where
analogix_dp_get_plug_in_status() unconditionally returns 0. However,
analogix_dp_require_pm_for_hpd_irq() is not updated to exclude
dp->force_connected_mode (or dp->plat_data->next_bridge here).

Because analogix_dp_bind() holds a runtime PM reference until
analogix_dp_unbind(), pm_runtime_put_sync(dp->dev) in
analogix_dp_bridge_disable() only drops the usage counter from 2 to 1 during
DPMS off. Doesn't this prevent rockchip_dp_suspend() and
analogix_dp_suspend() from running when the screen is blanked, leaving the =
DP
PHY, dp->clock, dp->pclk, and the SoC power domain (RK3399_PD_EDP /
RK3288_PD_VIO) powered on and leaving DP_IRQ_TYPE_HP_CHANGE unmuted while
panel_edp_suspend() turns off the panel power supply?

> +
>  static void analogix_dp_init_dp(struct analogix_dp_device *dp)
>  {
>  	analogix_dp_reset(dp);
> @@ -1571,6 +1577,12 @@ int analogix_dp_bind(struct analogix_dp_device *dp=
, struct drm_device *drm_dev)
>  		goto err_unregister_aux;
>  	}
> =20
> +	if (analogix_dp_require_pm_for_hpd_irq(dp)) {
> +		ret =3D pm_runtime_resume_and_get(dp->dev);
> +		if (ret)
> +			goto err_unregister_aux;
> +	}

[Severity: High]
When analogix_dp_require_pm_for_hpd_irq(dp) is true, can DisplayPort AUX
transactions fail after the bridge has been enabled and then disabled (for
example, on DPMS off or cable unplug and replug)?

In analogix_dp_bridge_disable(), disabling the bridge powers down all
internal analog blocks before dropping its runtime PM reference:

drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:analogix_dp_bridge_disab=
le() {
	...
	analogix_dp_set_analog_power_down(dp, POWER_ALL, 1);

	pm_runtime_put_sync(dp->dev);
	...
}

drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c:analogix_dp_set_analog_po=
wer_down() {
	...
	case POWER_ALL:
		if (enable) {
			reg =3D DP_ALL_PD;
			writel(reg, dp->reg_base + phy_pd_addr);
		} else {
	...
}

Writing DP_ALL_PD (0xff) to ANALOGIX_DP_PD asserts both RK_AUX_PD (BIT(5))
and DP_INC_BG (BIT(7), the internal PHY bandgap on Rockchip).

Previously, pm_runtime_put_sync(dp->dev) in analogix_dp_bridge_disable()
dropped the usage count to 0 and suspended the device, so the next AUX
transfer in analogix_dpaux_transfer() called pm_runtime_get_sync(dp->dev),
running analogix_dp_resume() -> rockchip_dp_poweron() and
analogix_dp_init_dp() -> analogix_dp_init_aux() to reset the controller and
clear ANALOGIX_DP_PD.

With the persistent runtime PM reference held in analogix_dp_bind(),
pm_runtime_put_sync(dp->dev) in analogix_dp_bridge_disable() only decrements
the usage count from 2 to 1, keeping dp->dev in RPM_ACTIVE. When a sink is
subsequently probed while dpms_mode is DRM_MODE_DPMS_OFF:

drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:analogix_dpaux_transfer(=
) {
	...
	pm_runtime_get_sync(dp->dev);

	ret =3D analogix_dp_detect_hpd(dp);
	if (ret)
		goto out;

	ret =3D analogix_dp_transfer(dp, msg);
	...
}

pm_runtime_get_sync(dp->dev) is a no-op because dp->dev is already active, =
so
analogix_dp_transfer() attempts AUX transactions while ANALOGIX_DP_PD is st=
ill
DP_ALL_PD (0xff). Even when analogix_dp_transfer() times out after 500 ms a=
nd
calls analogix_dp_init_aux(dp) in its aux_error path, analogix_dp_init_aux()
only clears AUX_BLOCK (RK_AUX_PD) and leaves DP_INC_BG asserted. Should
analogix_dp_bridge_disable() or analogix_dpaux_transfer() keep the AUX block
and bandgap powered when the controller remains runtime-active?

[Severity: Medium]
Also, will native HPD interrupts actually be processed by
drm_helper_hpd_irq_event() without DRM_BRIDGE_OP_HPD set in bridge->ops?

Earlier in analogix_dp_bind(), bridge->ops is initialized to:

	bridge->ops =3D DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT;

Both rockchip_dp_bind() and exynos_dp_bind() create the connector via
drm_bridge_connector_init():

drivers/gpu/drm/display/drm_bridge_connector.c:drm_bridge_connector_init() {
	...
	if (bridge_connector->bridge_hpd)
		connector->polled =3D DRM_CONNECTOR_POLL_HPD;
	else if (bridge_connector->bridge_detect)
		connector->polled =3D DRM_CONNECTOR_POLL_CONNECT
				  | DRM_CONNECTOR_POLL_DISCONNECT;
	...
}

In native HPD pin mode (and internal hpd_gpiod mode), no bridge in the chain
sets DRM_BRIDGE_OP_HPD, so bridge_connector->bridge_hpd is NULL and
connector->polled does not have DRM_CONNECTOR_POLL_HPD set. When the HPD IRQ
fires and analogix_dp_irq_thread() calls drm_helper_hpd_irq_event(dp->drm_d=
ev),
drm_helper_hpd_irq_event() skips any connector without DRM_CONNECTOR_POLL_H=
PD:

drivers/gpu/drm/drm_probe_helper.c:drm_helper_hpd_irq_event() {
	...
	drm_for_each_connector_iter(connector, &conn_iter) {
		/* Only handle HPD capable connectors. */
		if (!(connector->polled & DRM_CONNECTOR_POLL_HPD))
			continue;
	...
}

Doesn't this cause native HPD interrupts to be ignored and fall back to the
10-second periodic poll worker?

> +
>  	enable_irq(dp->irq);

[Severity: High]
Is it safe to unconditionally call enable_irq(dp->irq) here when
analogix_dp_require_pm_for_hpd_irq(dp) is false and !dp->hpd_gpiod (for
example, when dp->force_hpd is true on Rockchip, or on EXYNOS_DP without
hpd-gpios)?

In those configurations, dp->irq is the native DP controller interrupt, and
dp->dev is allowed to runtime-suspend. Whenever dp->dev runtime-resumes (su=
ch
as in analogix_dpaux_transfer() or analogix_dp_set_bridge()),
analogix_dp_init_dp() calls analogix_dp_config_interrupt():

drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c:analogix_dp_config_interr=
upt() {
	if (dp->hpd_gpiod) {
		analogix_dp_mute_hpd_interrupt(dp, HPD_IRQ_ALL);
		return;
	}

	if (analogix_dp_is_rockchip(dp->plat_data->dev_type))
		analogix_dp_unmute_hpd_interrupt(dp, DP_IRQ_TYPE_HP_CHANGE);
	else
		analogix_dp_unmute_hpd_interrupt(dp, HPD_IRQ_ALL);
}

Because analogix_dp_config_interrupt() does not check dp->force_hpd, it
unmasks the controller's HPD interrupts. In force-HPD mode,
analogix_dp_init_hpd() clears F_HPD | HPD_CTRL in ANALOGIX_DP_SYS_CTL_3 and
analogix_dp_detect_hpd() calls analogix_dp_force_hpd() to set F_HPD |
HPD_CTRL, generating HPD transitions that fire the unmasked controller
interrupt.

Furthermore, because analogix_dp_suspend() does not disable or synchronize
dp->irq before disabling dp->pclk and dp->clock, if analogix_dp_hardirq()
wakes analogix_dp_irq_thread() right before dp->dev runtime-suspends (at the
end of analogix_dpaux_transfer() or in analogix_dp_bridge_disable()),
analogix_dp_irq_thread() will access the controller registers while unclock=
ed:

drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:analogix_dp_irq_thread()=
 {
	...
	irq_type =3D analogix_dp_get_irq_type(dp);
	if (!dp->hpd_gpiod && irq_type)
		analogix_dp_clear_hotplug_interrupts(dp, irq_type);
	...
}

Can this cause unclocked MMIO reads and writes to ANALOGIX_DP_COMMON_INT_ST=
A_4
and ANALOGIX_DP_INT_STA (resulting in a synchronous external abort / SError
on ARM/ARM64) as well as spurious hotplug events?

> =20
>  	return 0;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019085836.3065=
008-1-damon.ding@rock-chips.com?part=3D10
