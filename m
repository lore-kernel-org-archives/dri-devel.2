Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE6AC55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43E2910E8C0;
	Tue,  4 Aug 2026 07:38:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CSpXznF2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B074010E8A8
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 07:38:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B517D60A59;
 Tue,  4 Aug 2026 07:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E081F000E9;
 Tue,  4 Aug 2026 07:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785829090;
 bh=hrtrGvIfX/YkldNz9/RW+ZQXu0D2mqcUHuLwWkewCdI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CSpXznF2FG091jAkHdDPo7DynS+EdkwZEb42buMh0Vszt53sr5CUPT4xM+7JpiNEM
 FfRDp1elLKA86e+qGa9cWgCYjjfe0qY9khYpCIlA/J8735p40v8aDds7EJNPuTDV15
 wEEEP1AASWpndkrmtg4niTM81bTm1LBfTC1R8tq98076wn7ep0+pYStgV9wmSzld3r
 QBc4XlOHCreheXbM5Ffnakw3HelMc53OfM0I+aGPY/pDF8cuso4d+lkO8/rmUlqMuc
 JlCHRhf+ftjeUhFYxfTmc1FWmUAGMeSMfPZjlvXfzQMe77hUFb4O3oLW2Ij28gDmp9
 DKn5PrHFpGpxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/7] drm/rockchip: cdn-dp: Add multiple bridges to
 support PHY port selection
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: linux-phy@lists.infradead.org, neil.armstrong@linaro.org, vkoul@kernel.org,
 dri-devel@lists.freedesktop.org, olteanv@gmail.com
In-Reply-To: <20260804070730.68-8-kernel@airkyi.com>
References: <20260804070730.68-1-kernel@airkyi.com>
 <20260804070730.68-8-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 07:38:09 +0000
Message-Id: <20260804073810.38E081F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 11 potential issue=
(s) to consider:

New issues:
- [High] `cdn_dp_connected_port` unconditionally returns `dp->port[0]` for =
extcon setups, completely breaking Hot-Plug Detection.
- [High] A mismatch between the number of PHYs (`dp->ports`) and DT endpoin=
ts (`dp->bridge_count`) causes uninitialized stack reads and NULL pointer d=
ereferences.
- [High] Out-of-bounds array write in `cdn_dp_parse_next_bridge_dt` when a =
device tree has more than two endpoints.
- [High] The error path in `cdn_dp_bind()` and successful path in `cdn_dp_u=
nbind()` do not clear `dp->next_bridge_list` pointers after dropping refere=
nces, leading to a Double-Put / Use-After-Free.
- [High] Double-free of EDID cache pointers across component unbind/rebind =
cycles.
- [High] Missing mutual exclusion in `atomic_check` allows simultaneous ena=
blement of multiple bridges sharing a single DP controller.
- [High] Using `devm_drm_bridge_alloc()` and `devm_drm_bridge_add()` inside=
 the component `bind` callback leads to memory leaks and dangling global DR=
M objects on unbind/rebind cycles.
- [High] `cdn_dp_switch_port` unconditionally programs video timings during=
 EDID reads, causing failures when no valid mode is set.
- [High] Failure to clean up a successfully initialized `drm_encoder` in `c=
dn_bridge_add` error paths leads to Use-After-Free.
- [Medium] `INIT_WORK` is called after exposing the bridge to external subs=
ystems, allowing an early HPD notification to schedule uninitialized work.

Pre-existing issues:
- [High] Using `devm_extcon_register_notifier` inside a component `bind` fu=
nction causes notifier chain corruption and UAF on rebind.
--

--- Patch [7]: [PATCH v6 7/7] drm/rockchip: cdn-dp: Add multiple bridges to=
 support PHY port selection ---
commit 47d7fbb7737dc45e037477d5f8fc38f597fe33c9
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/rockchip: cdn-dp: Add multiple bridges to support PHY port selection

This patch adds support for multiple bridges in the Rockchip CDN-DP control=
ler=20
to allow users to flexibly select the output port between two USB/DP combo=
=20
PHYs. It introduces independent encoders and bridges for each PHY port base=
d=20
on the DRM AUX HPD bridge, requiring proper DT configuration.

[ ... ]

> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/roc=
kchip/cdn-dp-core.c
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
Does this early return unconditionally bypass the connection state evaluati=
on
for extcon setups?

If !dp->next_bridge_valid evaluates to true, it looks like this will return
dp->port[0] on the first iteration without verifying whether the lanes
indicate an active connection, which would break hot-plug detection for
extcon-based devices.

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

[Severity: High]
Could this loop read uninitialized stack memory?

If the device tree defines more bridge endpoints in dp->bridge_count than t=
he
number of physical PHY ports in dp->ports, this loop iterates past the
initialized bounds of the lanes array.

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

[Severity: High]
Could this also lead to a NULL pointer dereference?

If dp_bridge->id exceeds the configured PHY ports, dp->port will be NULL.
The subsequent check for port->phy_enabled below will then dereference this
NULL pointer.

> +	struct cdn_dp_port *prev_port =3D NULL;
> +	const struct drm_edid *drm_edid =3D NULL;

[ ... ]

> +static int cdn_dp_switch_port(struct cdn_dp_device *dp, struct cdn_dp_po=
rt *prev_port,
> +			      struct cdn_dp_port *port)
> +{
> +	int ret;

[ ... ]

> +	dp->lanes =3D port->lanes;
> +
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

[Severity: High]
Will this video configuration fail when called from the EDID read path?

cdn_dp_switch_port() is invoked from cdn_dp_bridge_edid_read() where no
valid display mode has been established yet. Since dp->mode.clock is likely
zero at this point, cdn_dp_config_video() might fail with an invalid argume=
nt
or divide-by-zero, which would break the port switch entirely.

> +		if (ret)
> +			dev_err(dp->dev, "Failed to configure video: %d\n", ret);
> +	}
> +
> +out:
> +	return ret;
> +}

[ ... ]

> @@ -600,6 +693,9 @@ static void cdn_dp_bridge_atomic_enable(struct drm_br=
idge *bridge, struct drm_at
> =20
>  	mutex_lock(&dp->lock);
> =20
> +	if (dp->next_bridge_valid)
> +		dp->active_port =3D dp_bridge->id;
> +
>  	ret =3D cdn_dp_enable(dp);

[Severity: High]
Is there missing mutual exclusion to prevent simultaneous enablement of
multiple bridges sharing this single DP controller?

Since the driver creates multiple DRM connectors (one per PHY port) that
share a single physical DP hardware block, without an atomic_check to ensure
only one connector is active at a time, userspace might try to simultaneous=
ly
enable CRTCs on multiple connectors. Both could race to program the shared
dp->regs and GRF registers.

>  	if (ret) {
>  		DRM_DEV_ERROR(dp->dev, "Failed to enable bridge %d\n",

[ ... ]

> -static int cdn_dp_bind(struct device *dev, struct device *master, void *=
data)
> +static int cdn_bridge_add(struct device *dev,
> +			  struct drm_bridge *bridge,
> +			  struct drm_bridge *next_bridge,
> +			  struct drm_encoder *encoder)
>  {
>  	struct cdn_dp_device *dp =3D dev_get_drvdata(dev);
> -	struct drm_encoder *encoder;
> +	struct drm_device *drm_dev =3D dp->drm_dev;
> +	struct drm_bridge *last_bridge __free(drm_bridge_put) =3D NULL;
>  	struct drm_connector *connector;
> -	struct cdn_dp_port *port;
> -	struct drm_device *drm_dev =3D data;
> -	int ret, i;
> -
> -	ret =3D cdn_dp_parse_dt(dp);
> -	if (ret < 0)
> -		return ret;
> -
> -	dp->drm_dev =3D drm_dev;
> -	dp->connected =3D false;
> -	dp->active =3D false;
> -	dp->active_port =3D -1;
> -	dp->fw_loaded =3D false;
> -
> -	INIT_WORK(&dp->event_work, cdn_dp_pd_event_work);
> -
> -	encoder =3D &dp->encoder.encoder;
> +	int ret;
> =20
>  	encoder->possible_crtcs =3D drm_of_find_possible_crtcs(drm_dev,
>  							     dev->of_node);
> @@ -1003,26 +1106,35 @@ static int cdn_dp_bind(struct device *dev, struct=
 device *master, void *data)
> =20
>  	drm_encoder_helper_add(encoder, &cdn_dp_encoder_helper_funcs);
> =20
> -	dp->bridge.ops =3D
> -			DRM_BRIDGE_OP_DETECT |
> -			DRM_BRIDGE_OP_EDID |
> -			DRM_BRIDGE_OP_HPD |
> -			DRM_BRIDGE_OP_DP_AUDIO;
> -	dp->bridge.of_node =3D dp->dev->of_node;
> -	dp->bridge.type =3D DRM_MODE_CONNECTOR_DisplayPort;
> -	dp->bridge.hdmi_audio_dev =3D dp->dev;
> -	dp->bridge.hdmi_audio_max_i2s_playback_channels =3D 8;
> -	dp->bridge.hdmi_audio_spdif_playback =3D 1;
> -	dp->bridge.hdmi_audio_dai_port =3D -1;
> -
> -	ret =3D devm_drm_bridge_add(dev, &dp->bridge);
> +	bridge->ops =3D
> +		DRM_BRIDGE_OP_DETECT |
> +		DRM_BRIDGE_OP_EDID |
> +		DRM_BRIDGE_OP_HPD |
> +		DRM_BRIDGE_OP_DP_AUDIO;
> +	bridge->of_node =3D dp->dev->of_node;
> +	bridge->type =3D DRM_MODE_CONNECTOR_DisplayPort;
> +	bridge->hdmi_audio_dev =3D dp->dev;
> +	bridge->hdmi_audio_max_i2s_playback_channels =3D 8;
> +	bridge->hdmi_audio_spdif_playback =3D 1;
> +	bridge->hdmi_audio_dai_port =3D -1;
> +
> +	ret =3D devm_drm_bridge_add(dev, bridge);

[Severity: High]
Will using devres-managed memory allocation and registration inside a
component bind callback cause memory leaks?

Because cdn_dp_bind() is a component bind callback, the devm lifecycle
is tied to the parent device which was bound during probe. When the
component is unbound, the devm cleanup does not fire. Upon rebinding,
new memory is allocated and new bridges are added to the global list,
leaking the old ones and leaving dangling objects.

This applies to devm_drm_bridge_alloc() usage below as well.

>  	if (ret)
>  		return ret;

[ ... ]

> +static int cdn_dp_parse_next_bridge_dt(struct cdn_dp_device *dp)
> +{
> +	struct device_node *np =3D dp->dev->of_node;
> +	struct device_node *port __free(device_node) =3D of_graph_get_port_by_i=
d(np, 1);
> +	struct drm_bridge *bridge;
> +	int count =3D 0;
> +	int ret =3D 0;
> +	int i;

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

[Severity: High]
Can this loop overflow the next_bridge_list array?

If the device tree specifies more than MAX_PHY (2) endpoints, this
unconditionally increments count and writes past the bounds of the array,
which would corrupt the cdn_dp_device structure.

> +	}
> +
> +out:
> +	dp->bridge_count =3D count ? count : 1;
> +	return ret;
> +}
> +
> +static int cdn_dp_bind(struct device *dev, struct device *master, void *=
data)
> +{
> +	struct cdn_dp_device *dp =3D dev_get_drvdata(dev);

[ ... ]

> +	for (i =3D 0; i < dp->bridge_count; i++) {
> +		encoder =3D &dp->bridge_list[i]->encoder.encoder;
> +		bridge =3D &dp->bridge_list[i]->bridge;
> +		next_bridge =3D dp->next_bridge_list[i];
> +		ret =3D cdn_bridge_add(dev, bridge, next_bridge, encoder);

[Severity: High]
Does this error path leave an initialized encoder hanging without cleanup?

If cdn_bridge_add() succeeds at drm_simple_encoder_init() but fails on a
subsequent step like drm_bridge_connector_init(), it returns an error but
leaves the encoder initialized and attached to the drm_dev.=20

Additionally, if the loop here fails on the second iteration and jumps to
out, it frees resources but leaves the first successfully initialized encod=
er
still attached to the drm_dev. When the DRM core later traverses its encoder
lists, this could result in a use-after-free.

> +		if (ret)
> +			goto out;
> +	}
> +
> +	INIT_WORK(&dp->event_work, cdn_dp_pd_event_work);

[Severity: Medium]
Is it safe to initialize this work struct after the bridge has been exposed
to external subsystems?

The bridges are created and attached to the global chain just prior to this,
making them visible. If an external bridge or connected sink fires an HPD
notification immediately, cdn_dp_bridge_hpd_notify() could execute and call
schedule_work() before INIT_WORK() has run, potentially causing a crash.

>  	for (i =3D 0; i < dp->ports; i++) {
>  		port =3D dp->port[i];
> =20
> @@ -1043,7 +1250,7 @@ static int cdn_dp_bind(struct device *dev, struct d=
evice *master, void *data)
>  		if (ret) {
>  			DRM_DEV_ERROR(dev,
>  				      "register EXTCON_DISP_DP notifier err\n");
> -			return ret;
> +			goto out;

[Severity: High]
This is a pre-existing issue, but does using devm_extcon_register_notifier()
in a component bind callback cause notifier chain corruption?

Similar to the bridge devm issue, since the device isn't torn down on
component unbind, the devres cleanup never fires. On a subsequent re-bind,
it registers the same notifier block again, which corrupts the linked list
of the extcon notifier chain.

>  		}
>  	}
> =20
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
Could this error path cause a double-put or use-after-free on bind retries?

The dp structure is allocated in probe, so it persists across component
bind/unbind cycles. When dropping references here, the pointers in
dp->next_bridge_list are not set to NULL. If a subsequent bind retry fails,
this error path might execute again and call drm_bridge_put() on the already
freed pointers.

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
Does this leave stale EDID pointers in the cache?

This frees the cached EDIDs but fails to set the pointers to NULL. Because
the dp context persists across component unbind/rebind, a subsequent EDID
read via cdn_dp_bridge_edid_read() might attempt to free the same stale
pointer again before replacing it, corrupting memory.

> =20
>  	pm_runtime_disable(dev);
>  	if (dp->fw_loaded)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804070730.68-1=
-kernel@airkyi.com?part=3D7
