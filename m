Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD07DCD8C8E
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FFDC10EE22;
	Mon,  8 Jun 2026 07:22:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P+kNXKqG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AAB810EE2E
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 07:22:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7720542B64;
 Mon,  8 Jun 2026 07:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176A21F00893;
 Mon,  8 Jun 2026 07:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780903371;
 bh=chaueDOcCa9nvz2x0OIi4F1O0Po2a82gq6TAG29tfWU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P+kNXKqGJHyi7JdUiCk8CtOvh65aAeb77rD0uMOZXXcyUSOh6DNfQtogVJlcKOd3V
 MLI16T1rqnsbTgsHcODwNPFW2ocKt2UZIuRqU4S0CPY2kpJRlpOqyRDvVKQoNgKJRM
 d5tbO0NBWUYvZkKk9X7aDNZvPZA0W8Y3r7ReFxN23J/xxFne4e+x2nV8OiUbr5qCSZ
 u6fWE0VbORAs9CKs7r6YRvRGuDKUtLrEPrFe44HpMnIakqqJFPqPZMA6w4LbVwxFDe
 E3425DsfQbeZSn1UspUk9BzoZz/6WdepdnzOFxmsIlahN6+1BpA6QlLluLjdRH+s/N
 j1sgrxrkHpVSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] drm/rockchip: cdn-dp: Add multiple bridges to
 support PHY port selection
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 olteanv@gmail.com, vkoul@kernel.org, neil.armstrong@linaro.org
In-Reply-To: <20260608070805.88-6-kernel@airkyi.com>
References: <20260608070805.88-6-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 07:22:50 +0000
Message-Id: <20260608072251.176A21F00893@smtp.kernel.org>
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
- [High] `cdn_dp_connected_port()` unconditionally returns the first port o=
n extcon systems, breaking hotplug detection.
- [High] Dangling pointers in `dp->next_bridge_list` cause double-free and =
use-after-free on bind retry or unbind.
- [High] Mismatch between `dp->ports` and `dp->bridge_count` causes uniniti=
alized stack reads and NULL pointer dereferences.
- [High] Buffer overflow when parsing DT endpoints in `cdn_dp_parse_next_br=
idge_dt()`.
- [High] Memory and resource leaks due to devres (`devm_`) allocations in t=
he component bind callback.
- [High] Hardware multiplexing logic error allows multiple encoders to be e=
nabled simultaneously, corrupting hardware state.
- [High] Double-free / UAF of cached EDIDs upon unbind/bind cycles.
- [High] `cdn_dp_switch_port()` unconditionally attempts video configuratio=
n during an EDID probe, aborting the port switch.
- [Medium] Data race on multiple bridge connection state variables.

Pre-existing issues:
- [High] Notifier chain corruption via `devm_extcon_register_notifier()` in=
side the component bind callback.
- [High] Use-After-Free via uncancelled extcon notifiers after component un=
bind.
--

commit 8f73288a10a1e2cd66218daa8be78785997dc0e3
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: drm/rockchip: cdn-dp: Add multiple bridges to support PHY port sel=
ection

This commit adds support for multiple bridges to allow flexible selection
of the output port on RK3399 CDN-DP controllers. It registers a separate
encoder and bridge for each PHY port and parses DT connections to map
them properly.

> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/roc=
kchip/cdn-dp-core.c
> index 9068118859e21..f2eaad61ba440 100644
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
Does this unconditionally return the first port on extcon systems?

In cdn_dp_connected_port(), the loop evaluates if (!dp->next_bridge_valid)
and returns the port immediately on the first iteration. It completely
ignores the lanes connection check that was present in the old code. For
systems relying on extcon for hotplug detection, this might cause the
driver to always report the first port as connected to userspace, even
when nothing is plugged in.

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
> +
>  	return NULL;
>  }

[Severity: High]
Can this loop read uninitialized memory from the lanes array?

The lanes array is only populated up to dp->ports, but this loop iterates
up to dp->bridge_count. If a device tree defines more endpoints than there
are successfully probed PHYs, dp->bridge_count will exceed dp->ports,
causing out of bounds reads on the stack memory.

> @@ -254,12 +268,45 @@ static const struct drm_edid *
>  cdn_dp_bridge_edid_read(struct drm_bridge *bridge, struct drm_connector =
*connector)
>  {
>  	struct cdn_dp_device *dp =3D bridge_to_dp(bridge);
> -	const struct drm_edid *drm_edid;
> +	struct cdn_dp_bridge *dp_bridge =3D bridge_to_dp_bridge(bridge);
> +	struct cdn_dp_port *port =3D dp->port[dp_bridge->id];

[Severity: High]
Could this dereference a NULL pointer?

If dp->bridge_count exceeds dp->ports due to a PHY probe failure,
dp_bridge->id can be greater than or equal to dp->ports. Indexing dp->port
with dp_bridge->id would return NULL, leading to a kernel panic when
port->phy_enabled is evaluated below.

> +	struct cdn_dp_port *prev_port =3D NULL;
> +	const struct drm_edid *drm_edid =3D NULL;
> +	int i, ret;
> =20
>  	mutex_lock(&dp->lock);
> +
> +	/* More than one port is available */
> +	if (dp->bridge_count > 1 && !port->phy_enabled) {
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
> +			if (ret)
> +				goto get_cache;
> +		}
> +	}
> +
>  	drm_edid =3D drm_edid_read_custom(connector, cdn_dp_get_edid_block, dp);
> +	/* replace edid cache */
> +	if (dp->edid_cache[dp_bridge->id])
> +		drm_edid_free(dp->edid_cache[dp_bridge->id]);
> +	dp->edid_cache[dp_bridge->id] =3D drm_edid_dup(drm_edid);

[Severity: High]
Can this cause a double-free on the cached EDID?

In cdn_dp_unbind(), the cached EDIDs are freed but the array pointers
are not set to NULL. Since the dp context structure outlives the unbind and
bind cycle, the next time the component is bound and this EDID read
function is called, it might attempt to free the dangling pointer again.

[ ... ]
> @@ -551,6 +599,50 @@ static bool cdn_dp_check_link_status(struct cdn_dp_d=
evice *dp)
>  	return drm_dp_channel_eq_ok(link_status, min(port->lanes, sink_lanes));
>  }
> =20
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
> +
> +out:
> +	return ret;
> +}

[Severity: High]
Will this video configuration fail and abort the port switch during EDID pr=
obing?

When reading an EDID on an inactive port, cdn_dp_bridge_edid_read() calls
cdn_dp_switch_port(). However, there is no display mode assigned yet during
early EDID probing, so dp->mode.clock is 0. Calling cdn_dp_config_video()
here calculates a symbol value of 0, which triggers an arithmetic
validation loop failure returning -EINVAL. This might abort the port switch
entirely.

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
Does this logic allow multiple encoders to be enabled simultaneously and
corrupt hardware state?

If a second encoder is enabled, cdn_dp_bridge_atomic_enable() sets
dp->active_port, but cdn_dp_enable() will exit early because dp->active is
already true. The hardware port switch is never executed. Without an
atomic_check to prevent concurrent commits, the shared hardware controller
might be placed into an invalid state.

[ ... ]
> @@ -639,9 +736,11 @@ static void cdn_dp_bridge_atomic_enable(struct drm_b=
ridge *bridge, struct drm_at
>  static void cdn_dp_bridge_atomic_disable(struct drm_bridge *bridge, stru=
ct drm_atomic_state *state)
>  {
>  	struct cdn_dp_device *dp =3D bridge_to_dp(bridge);
> +	struct cdn_dp_bridge *dp_bridge =3D bridge_to_dp_bridge(bridge);
>  	int ret;
> =20
>  	mutex_lock(&dp->lock);
> +	dp_bridge->enabled =3D false;
> =20
>  	if (dp->active) {
>  		ret =3D cdn_dp_disable(dp);

[Severity: High]
Will this unconditionally disable the shared hardware regardless of other
active encoders?

Because the DP controller is shared, if one encoder is disabled while
another is still active, cdn_dp_disable() turns off the shared hardware
controller. This would instantly crash the stream for the other active
encoder.

[ ... ]
> @@ -828,6 +927,17 @@ static int cdn_dp_audio_mute_stream(struct drm_bridg=
e *bridge,
>  	return ret;
>  }
> =20
> +static void cdn_dp_bridge_hpd_notify(struct drm_bridge *bridge,
> +				     struct drm_connector *connector,
> +				     enum drm_connector_status status)
> +{
> +	struct cdn_dp_bridge *dp_bridge =3D bridge_to_dp_bridge(bridge);
> +	struct cdn_dp_device *dp =3D bridge_to_dp(bridge);
> +
> +	dp->bridge_list[dp_bridge->id]->connected =3D status =3D=3D connector_s=
tatus_connected;
> +	schedule_work(&dp->event_work);
> +}

[Severity: Medium]
Is this updating connection state without holding the appropriate lock?

The connection flag is modified here without acquiring dp->lock. At the
same time, cdn_dp_pd_event_work() reads these connection states iteratively
while explicitly dropping dp->lock. This might cause a data race when
evaluating compound connection flags for reporting to userspace.

[ ... ]
> @@ -1003,26 +1106,35 @@ static int cdn_dp_bind(struct device *dev, struct=
 device *master, void *data)
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
> +	}

[Severity: High]
Can this overflow the next_bridge_list array?

The for_each_of_graph_port_endpoint loop iterates over all endpoints defined
in the device tree and stores each resolved bridge in
dp->next_bridge_list[count]. Since next_bridge_list is a fixed-size array
of MAX_PHY (2), a device tree defining 3 or more endpoints would cause a
buffer overflow, corrupting adjacent driver memory.

[ ... ]
> +	for (i =3D 0; i < dp->bridge_count; i++) {
> +		dp_bridge =3D devm_drm_bridge_alloc(dev, struct cdn_dp_bridge, bridge,
> +						    &cdn_dp_bridge_funcs);
> +		if (IS_ERR(dp_bridge)) {
> +			ret =3D PTR_ERR(dp_bridge);
> +			goto out;
> +		}
> +		dp_bridge->id =3D i;
> +		dp_bridge->parent =3D dp;
> +		if (!dp->next_bridge_valid)
> +			dp_bridge->connected =3D true;
> +		dp->bridge_list[i] =3D dp_bridge;
> +	}

[Severity: High]
Does allocating devm resources inside the component bind callback cause mem=
ory leaks?

The component framework requires resources allocated in bind() to be freed
in unbind(). The driver uses devm_drm_bridge_alloc() and then calls
devm_drm_bridge_add() inside cdn_bridge_add(). These resources are tied to
the lifetime of the component device, not the bind cycle. Every time the
component is bound, such as after an -EPROBE_DEFER or unbind/rebind, new
bridge memory is allocated and new bridges are registered, leaking memory
and piling up duplicate DRM bridges.

[ ... ]
>  	for (i =3D 0; i < dp->ports; i++) {
>  		port =3D dp->port[i];
> =20
> @@ -1045,7 +1252,7 @@ static int cdn_dp_bind(struct device *dev, struct d=
evice *master, void *data)
>  		if (ret) {
>  			DRM_DEV_ERROR(dev,
>  				      "register EXTCON_DISP_DP notifier err\n");
> -			return ret;
> +			goto out;
>  		}
>  	}

[Severity: High]
This is a pre-existing issue, but does using devm_extcon_register_notifier
in the bind callback corrupt the notifier chain?

Because devm_extcon_register_notifier is managed by device removal, it does
not unregister the notifier in cdn_dp_unbind(). When the component is bound
a second time, the exact same event_nb object is re-registered to the
extcon notifier chain. Adding an already-linked node to a list creates an
infinite cycle, leading to a hard lockup the next time the notifier fires.

> @@ -1054,15 +1261,29 @@ static int cdn_dp_bind(struct device *dev, struct=
 device *master, void *data)
>  	schedule_work(&dp->event_work);
> =20
>  	return 0;
> +
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

[Severity: High]
Could this leave dangling pointers in dp->next_bridge_list causing a double=
-free?

If cdn_dp_bind() encounters an error and jumps to the out block, or when
cdn_dp_unbind() is called, the driver calls drm_bridge_put() on the pointers
but fails to set them to NULL. Since the dp context structure is allocated
in probe() and survives component bind retries, a subsequent bind failure or
unbind will call drm_bridge_put() on the exact same dangling pointers.

[Severity: High]
This isn't a bug introduced by this patch, but does failing to unregister
the notifiers during unbind cause a use-after-free?

The driver correctly calls cancel_work_sync(&dp->event_work), but fails to
unregister the event sources because devm_extcon_register_notifier() is
managed by device removal. If a hotplug event fires between unbind() and
remove(), or if the work executes concurrently, it will call
schedule_work(&dp->event_work) on memory that may have already been freed.

> +
> +	for (i =3D 0; i < MAX_PHY; i++)
> +		drm_edid_free(dp->edid_cache[i]);

[Severity: High]
Are these pointers left dangling after being freed?

The cached EDIDs are freed via drm_edid_free() here, but the array indices
are not reset to NULL. The dp context outlives the unbind/bind cycle,
meaning cdn_dp_bridge_edid_read() might later attempt to free these dangling
pointers again.

>  	pm_runtime_disable(dev);
>  	if (dp->fw_loaded)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608070805.88-1=
-kernel@airkyi.com?part=3D5
