Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCB2C55162
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A6D10E0F2;
	Thu, 30 Jul 2026 01:48:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bQhnw86V";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C110610E0F2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:48:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 827F943D9F;
 Thu, 30 Jul 2026 01:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DBD1F000E9;
 Thu, 30 Jul 2026 01:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785376103;
 bh=ly437AdX5E5kKzXqL5w45v8tqhUMN3mpfh17s9iQu9Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bQhnw86VU4R7rQDmlPwPLAHe6Y9DXS3VM1EBkVHVXNSuF3d1xFJmCuTHOItKnshld
 64G6daGWsaWFKGrNgtxzc7d4T7TI9+XKJA1njGBxoXbvSvyT+QUzq0y1wpLFDUeQzQ
 uB++iPsNvrVsO3I8eUjqT37+ebxBnB+WWDQSgWF4pflgLNEMyuUKGEtsmeRJL2G+17
 0U20GzNGVwV+xJZpP1z4YEG3s4UIecs3J8CnjB6YIuMEKnbWDUeNlE49m1TrXX/jxD
 X4B+i5HOfdzrTZdmaKHFWigW8pJm9URSbPIHpnrzYFTuyizcMEDhDHw/E3R4ClzpvC
 3vB5Ltn9bFTWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/6] drm/rockchip: cdn-dp: Add multiple bridges to
 support PHY port selection
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: linux-phy@lists.infradead.org, vkoul@kernel.org, neil.armstrong@linaro.org,
 olteanv@gmail.com, dri-devel@lists.freedesktop.org
In-Reply-To: <20260730013349.51-7-kernel@airkyi.com>
References: <20260730013349.51-1-kernel@airkyi.com>
 <20260730013349.51-7-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 01:48:22 +0000
Message-Id: <20260730014823.30DBD1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] Stale pointers in `dp->next_bridge_list` cause a double free / ref=
count underflow on repeated or failed bind cycles.
- [High] `cdn_dp_switch_port` unconditionally configures video, breaking ED=
ID reads for newly connected monitors.
- [High] Missing `atomic_check` allows simultaneous activation of multiple =
conflicting encoders.
- [High] `cdn_dp_connected_port` bypasses the physical lane check for extco=
n configurations, breaking hotplug detection.
- [High] Index mismatch between packed PHY ports and DT endpoints causes un=
initialized memory reads and guaranteed NULL dereferences.
- [Medium] Device tree endpoint iteration lacks a bounds check against `MAX=
_PHY`, leading to a heap buffer overflow.

Pre-existing issues:
- [High] Extcon notifiers can schedule work after `cancel_work_sync()`, lea=
ding to Use-After-Free.
--

--- Patch [6]: [PATCH v5 6/6] drm/rockchip: cdn-dp: Add multiple bridges to=
 support PHY port selection ---
commit 8377956184d44f77846e2394e562e31ea5099865
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/rockchip: cdn-dp: Add multiple bridges to support PHY port selection

This commit adds support for multiple bridges in the Rockchip CDN-DP
driver to enable PHY port selection via the DRM AUX HPD bridge framework.
It parses device tree endpoints to register one or two bridges and handles
switching the DP controller output between them based on plug states.

> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/roc=
kchip/cdn-dp-core.c
> index 74e1f5422a6e2..5e513f6930cb9 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
[ ... ]
> @@ -192,14 +193,27 @@ static int cdn_dp_get_sink_count(struct cdn_dp_devi=
ce *dp, u8 *sink_count)
>  static struct cdn_dp_port *cdn_dp_connected_port(struct cdn_dp_device *d=
p)
>  {
>  	struct cdn_dp_port *port;
> -	int i, lanes;
> +	int i, lanes[MAX_PHY];
> =20
>  	for (i =3D 0; i < dp->ports; i++) {
>  		port =3D dp->port[i];
> -		lanes =3D cdn_dp_get_port_lanes(port);
> -		if (lanes)
> +		lanes[i] =3D cdn_dp_get_port_lanes(port);
> +		if (!dp->next_bridge_valid)
>  			return port;

[Severity: High]
Does this break hotplug detection for legacy extcon-based devices?

If dp->next_bridge_valid is false, this loop unconditionally returns
dp->port[0] on the first iteration without verifying if the physical lanes
are greater than zero. This causes the driver to perpetually report the
display as connected.

>  	}
> +
> +	if (dp->next_bridge_valid) {
> +		/* If more than one port is available, pick the last active port */
> +		if (dp->active_port >=3D 0 && lanes[dp->active_port])
> +			return dp->port[dp->active_port];
> +
> +		/* If the last active port is not available, pick an available port in=
 order */
> +		for (i =3D 0; i < dp->bridge_count; i++) {
> +			if (lanes[i])
> +				return dp->port[i];

[Severity: High]
Can this loop read uninitialized stack memory?

The lanes array is populated in the previous loop up to dp->ports, which
tracks successfully probed PHYs. However, this loop iterates up to
dp->bridge_count, which tracks DT endpoints. If a device tree specifies
more endpoints than successfully probed PHYs, this will read out of bounds
on the stack.

> +		}
> +	}
> +
>  	return NULL;
>  }
[ ... ]
> @@ -254,12 +268,45 @@ static const struct drm_edid *
>  cdn_dp_bridge_edid_read(struct drm_bridge *bridge, struct drm_connector =
*connector)
>  {
>  	struct cdn_dp_device *dp =3D bridge_to_dp(bridge);
> -	const struct drm_edid *drm_edid;
> +	struct cdn_dp_bridge *dp_bridge =3D bridge_to_dp_bridge(bridge);
> +	struct cdn_dp_port *port =3D dp->port[dp_bridge->id];
> +	struct cdn_dp_port *prev_port =3D NULL;
> +	const struct drm_edid *drm_edid =3D NULL;
> +	int i, ret;
> =20
>  	mutex_lock(&dp->lock);
> +
> +	/* More than one port is available */
> +	if (dp->bridge_count > 1 && !port->phy_enabled) {

[Severity: High]
Is there a risk of a NULL pointer dereference here?

If the device tree has more endpoints than successfully probed PHYs,
dp_bridge->id could exceed the bounds of initialized dp->port pointers.
In that scenario, port would be NULL, and evaluating !port->phy_enabled
will crash.

> +		for (i =3D 0; i < dp->bridge_count; i++) {
> +			/* Another port already enable */
> +			if (dp->bridge_list[i] !=3D dp_bridge && dp->bridge_list[i]->enabled)
> +				goto get_cache;
> +			/* Find already enabled port */
> +			if (dp->port[i]->phy_enabled)
> +				prev_port =3D dp->port[i];
> +		}
> +
> +		/* Switch to current port */
> +		if (prev_port) {
> +			ret =3D cdn_dp_switch_port(dp, prev_port, port);

[Severity: High]
Will this sequence fail to read the EDID for a newly connected monitor?

Switching the port here calls cdn_dp_switch_port(), which unconditionally
executes cdn_dp_config_video(dp). During EDID probing, no DRM display mode
has been committed yet, so dp->mode.clock is 0.=20

This causes cdn_dp_config_video() to fail its bandwidth calculation loop
and return -EINVAL, which aborts the port switch and forces the driver to
fall back to a cached EDID.

> +			if (ret)
> +				goto get_cache;
> +		}
> +	}
[ ... ]
> @@ -838,6 +948,7 @@ static const struct drm_bridge_funcs cdn_dp_bridge_fu=
ncs =3D {
>  	.atomic_disable =3D cdn_dp_bridge_atomic_disable,
>  	.mode_valid =3D cdn_dp_bridge_mode_valid,
>  	.mode_set =3D cdn_dp_bridge_mode_set,
> +	.hpd_notify =3D cdn_dp_bridge_hpd_notify,
> =20
>  	.dp_audio_prepare =3D cdn_dp_audio_prepare,

[Severity: High]
Because there is only a single DP hardware controller backing multiple
potential bridges, is there a risk of hardware state corruption if
userspace commits a state that maps CRTCs to both ports simultaneously?

Without an .atomic_check callback in cdn_dp_bridge_funcs to enforce mutual
exclusivity, cdn_dp_bridge_atomic_enable() could execute for the second
port and overwrite the video configuration while the first is active.

[ ... ]
> @@ -1030,6 +1142,101 @@ static int cdn_dp_bind(struct device *dev, struct=
 device *master, void *data)
[ ... ]
> +static int cdn_dp_parse_next_bridge_dt(struct cdn_dp_device *dp)
> +{
[ ... ]
> +	/* One endpoint may correspond to one next bridge. */
> +	for_each_of_graph_port_endpoint(port, dp_ep) {
> +		struct device_node *next_bridge_node __free(device_node) =3D
> +			of_graph_get_remote_port_parent(dp_ep);
> +
> +		bridge =3D of_drm_find_bridge(next_bridge_node);
> +		if (!bridge) {
> +			ret =3D -EPROBE_DEFER;
> +			goto out;
> +		}
> +
> +		dp->next_bridge_valid =3D true;
> +		dp->next_bridge_list[count] =3D drm_bridge_get(bridge);
> +		count++;

[Severity: Medium]
Is there a potential heap buffer overflow here?

The count variable is incremented and used as an index for
dp->next_bridge_list[count], but there is no bounds check against MAX_PHY.
If a misconfigured device tree provides 3 or more endpoints, this will
overwrite adjacent fields in the cdn_dp_device structure.

> +	}
[ ... ]
> @@ -1052,15 +1259,29 @@ static int cdn_dp_bind(struct device *dev, struct=
 device *master, void *data)
>  	schedule_work(&dp->event_work);
> =20
>  	return 0;
> +
> +out:
> +	for (i =3D 0; i < MAX_PHY; i++)
> +		drm_bridge_put(dp->next_bridge_list[i]);

[Severity: High]
Can this result in a double free and refcount underflow?

If cdn_dp_bind() fails and executes this error path, it calls
drm_bridge_put() but leaves the pointers intact in dp->next_bridge_list.
If the master bind is retried later and fails again, it will perform
another drm_bridge_put() on the same stale pointers.=20

The same pattern also appears below during unbind.

> +
> +	return ret;
>  }
> =20
>  static void cdn_dp_unbind(struct device *dev, struct device *master, voi=
d *data)
>  {
>  	struct cdn_dp_device *dp =3D dev_get_drvdata(dev);
> -	struct drm_encoder *encoder =3D &dp->encoder.encoder;
> +	struct drm_encoder *encoder;
> +	int i;
> =20
>  	cancel_work_sync(&dp->event_work);

[Severity: High]
This is a pre-existing issue, but can this lead to a use-after-free
during unbind?

Extcon notifiers are registered using devm_extcon_register_notifier().
While cancel_work_sync(&dp->event_work) cancels pending work here, the
devm-managed notifier remains active until devres cleanup, which happens
after unbind returns.=20

A hotplug event in this window could reschedule dp->event_work, executing
it after the structures are freed.

> -	encoder->funcs->destroy(encoder);
> +	for (i =3D 0; i < dp->bridge_count; i++) {
> +		encoder =3D &dp->bridge_list[i]->encoder.encoder;
> +		encoder->funcs->destroy(encoder);
> +		drm_bridge_put(dp->next_bridge_list[i]);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730013349.51-1=
-kernel@airkyi.com?part=3D6
