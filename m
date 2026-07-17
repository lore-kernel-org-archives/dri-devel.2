Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2148BC4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 07:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E17310F480;
	Fri, 17 Jul 2026 07:38:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PhAWGk9W";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFD7B10F47D
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 07:38:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C2CB41AA9;
 Fri, 17 Jul 2026 07:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130F01F000E9;
 Fri, 17 Jul 2026 07:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784273899;
 bh=Khtv+NBajc5FxpYbYEIJ9LfpCaKjFzT6WDUADSHwox4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PhAWGk9WMTWaQsGDjQZRCyKjwy6gHZXycXKxNr9gUT59VZp8vB/NL3kRD1QWCw4Rj
 ld81mPSfCPUs+oUs00WzT9IQRKhA/TiijyWdBa0TkeuLwFTsPaNRGH5+x/UrCidPFZ
 KtvHOZi8DfDiuzUmUD59IUNFihRJGuOJf8tHdevb+pXw+IOMRm2WDgEMgKdrRA30KM
 YKFB1ScCL+JSZUbS8/0VpaDTJF5/AJfamUTp0sWUs1v0KdKFu10KQ64gLeTNGEMQAm
 Wt2rdQw3098kIdKakqD8MOPy1uQuvht95kN6avCoLL3cNT9cCl+sjTNvJOaPNqKXkd
 zCVKPS8WaSfzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] drm/rockchip: cdn-dp: Add multiple bridges to
 support PHY port selection
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org, olteanv@gmail.com, vkoul@kernel.org,
 linux-phy@lists.infradead.org, neil.armstrong@linaro.org
In-Reply-To: <20260717072323.96-6-kernel@airkyi.com>
References: <20260717072323.96-1-kernel@airkyi.com>
 <20260717072323.96-6-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 07:38:18 +0000
Message-Id: <20260717073819.130F01F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

New issues:
- [High] Buffer overflow when parsing device tree endpoints due to missing =
bounds check.
- [High] Broken hotplug detection for legacy extcon configurations due to u=
nconditional port return.
- [High] NULL pointer dereference and uninitialized memory read if DT endpo=
ints exceed valid PHYs.
- [High] Port switching during EDID read always fails because `cdn_dp_confi=
g_video` is called with a zero clock.
- [High] Stale pointers in persistent arrays cause double-free and use-afte=
r-free on component re-bind.
- [High] Workqueue `dp->event_work` is scheduled before being initialized, =
leading to a NULL pointer dereference.
- [Medium] Multiple encoders share a single hardware DP controller but lack=
 an `atomic_check` callback to prevent simultaneous activation.

Pre-existing issues:
- [High] Using `devm_` APIs in the component `bind` callback causes severe =
resource leaks and active stale notifiers after `unbind`.
--

--- Patch [5]: [PATCH v3 5/5] drm/rockchip: cdn-dp: Add multiple bridges to=
 support PHY port selection ---
commit a0d8b7a8a3a01d68ddf971ecfdb92ccb11c60b09
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/rockchip: cdn-dp: Add multiple bridges to support PHY port selection

This patch adds support for multiple bridges to allow selecting between
different PHY ports on the RK3399 CDN-DP controller. It registers a separate
encoder and bridge for each PHY port and parses the DT to handle bridge
chain configurations.

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
Does this break hotplug detection for legacy extcon configurations?

By removing the check for lanes > 0, this will unconditionally return the
first port regardless of actual connection status.

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
> +		}
> +	}

[Severity: High]
Could this lead to an uninitialized memory read and NULL pointer
dereference?

If the device tree provides more endpoints than probed PHYs,
dp->bridge_count will exceed dp->ports. This loop will access
uninitialized stack memory in lanes[i] and potentially return a NULL
dp->port[i], causing a crash later in cdn_dp_bridge_edid_read() when
checking port->phy_enabled.

[ ... ]
> @@ -551,6 +599,50 @@ static bool cdn_dp_check_link_status(struct cdn_dp_d=
evice *dp)
> +static int cdn_dp_switch_port(struct cdn_dp_device *dp, struct cdn_dp_po=
rt *prev_port,
> +			      struct cdn_dp_port *port)
> +{
[ ... ]
> +	if (!cdn_dp_check_link_status(dp)) {
> +		dev_info(dp->dev, "Connected with sink; re-train link\n");
> +
> +		ret =3D cdn_dp_train_link(dp);
> +		if (ret) {
> +			dev_err(dp->dev, "Training link failed: %d\n", ret);
> +			goto out;
> +		}
> +
> +		ret =3D cdn_dp_set_video_status(dp, CONTROL_VIDEO_IDLE);
> +		if (ret) {
> +			dev_err(dp->dev, "Failed to idle video %d\n", ret);
> +			goto out;
> +		}
> +
> +		ret =3D cdn_dp_config_video(dp);
> +		if (ret)
> +			dev_err(dp->dev, "Failed to configure video: %d\n", ret);
> +	}

[Severity: High]
Will this port switch fail consistently during EDID read operations?

When cdn_dp_bridge_edid_read() calls this function, dp->mode.clock is
typically 0. A zero clock will cause cdn_dp_config_video() to spin until
timeout and return -EINVAL, thus aborting the EDID read.

[ ... ]
> @@ -828,6 +927,17 @@ static int cdn_dp_audio_mute_stream(struct drm_bridg=
e *bridge,
>  static const struct drm_bridge_funcs cdn_dp_bridge_funcs =3D {
>  	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
>  	.atomic_reset =3D drm_atomic_helper_bridge_reset,
>  	.detect =3D cdn_dp_bridge_detect,
>  	.edid_read =3D cdn_dp_bridge_edid_read,
>  	.atomic_enable =3D cdn_dp_bridge_atomic_enable,
>  	.atomic_disable =3D cdn_dp_bridge_atomic_disable,
>  	.mode_valid =3D cdn_dp_bridge_mode_valid,
>  	.mode_set =3D cdn_dp_bridge_mode_set,
> +	.hpd_notify =3D cdn_dp_bridge_hpd_notify,

[Severity: Medium]
Should there be an atomic_check callback here to prevent simultaneous
activation of multiple CRTCs?

Since all registered encoders share the same possible_crtcs mask for a
single underlying DP controller, userspace could potentially enable
multiple displays at once, leading to hardware register corruption.

[ ... ]
> @@ -1030,6 +1142,101 @@ static int cdn_dp_bind(struct device *dev, struct=
 device *master, void *data)
> +static int cdn_dp_parse_next_bridge_dt(struct cdn_dp_device *dp)
> +{
[ ... ]
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
> +	}

[Severity: High]
Could this code overflow the dp->next_bridge_list[] array?

The count variable is incremented for each endpoint and used as an index,
but it is never checked against MAX_PHY.

[ ... ]
> @@ -1030,6 +1142,101 @@ static int cdn_dp_bind(struct device *dev, struct=
 device *master, void *data)
> +	for (i =3D 0; i < dp->bridge_count; i++) {
> +		dp_bridge =3D devm_drm_bridge_alloc(dev, struct cdn_dp_bridge, bridge,
> +						    &cdn_dp_bridge_funcs);

[Severity: High]
This is a pre-existing issue, but does using devm_ APIs inside a component
bind callback cause memory leaks and use-after-free crashes?

Component unbind does not release devm_ resources, meaning structures like
dp_bridge and the extcon notifiers remain active after unbind and will
leak on subsequent re-binds.

[ ... ]
> +	for (i =3D 0; i < dp->bridge_count; i++) {
> +		encoder =3D &dp->bridge_list[i]->encoder.encoder;
> +		bridge =3D &dp->bridge_list[i]->bridge;
> +		next_bridge =3D dp->next_bridge_list[i];
> +		ret =3D cdn_bridge_add(dev, bridge, next_bridge, encoder);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	INIT_WORK(&dp->event_work, cdn_dp_pd_event_work);

[Severity: High]
Can this sequence cause a NULL pointer dereference?

By registering the bridges via cdn_bridge_add() before calling INIT_WORK,
an early HPD event can trigger cdn_dp_bridge_hpd_notify() and attempt to
schedule the uninitialized dp->event_work queue.

[ ... ]
> +out:
> +	for (i =3D 0; i < MAX_PHY; i++)
> +		drm_bridge_put(dp->next_bridge_list[i]);
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
> -	encoder->funcs->destroy(encoder);
> +	for (i =3D 0; i < dp->bridge_count; i++) {
> +		encoder =3D &dp->bridge_list[i]->encoder.encoder;
> +		encoder->funcs->destroy(encoder);
> +		drm_bridge_put(dp->next_bridge_list[i]);
> +	}
> +
> +	for (i =3D 0; i < MAX_PHY; i++)
> +		drm_edid_free(dp->edid_cache[i]);

[Severity: High]
Does this leave dangling pointers in persistent arrays across bind/unbind
cycles?

Because dp is allocated in probe, freeing dp->next_bridge_list and
dp->edid_cache here without setting them to NULL can lead to double-frees
or use-after-free issues if the component is rebound.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717072323.96-1=
-kernel@airkyi.com?part=3D5
