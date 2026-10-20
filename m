Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE83E606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G/+f8KAM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1658E10F41F;
	Tue, 20 Oct 2026 09:19:49 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B57A510F433
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 09:19:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6A8CF4058C;
 Tue, 20 Oct 2026 09:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C451F000C5;
 Tue, 20 Oct 2026 09:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792487982;
 bh=z+HGXA/o2uCbYRojIyeO5SarXmus329+HMkliPlbMXE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G/+f8KAMAucZVjfGk66grabGExikUrMN1+2gey3I9UaQvWSds/U7wkDw1UzClI8FD
 a/2TOtGV44KWWl3hguisCrzh9LW96uYbMjYD5LZcwR9nYCP9N0+zEsf8TvDy753XiJ
 9WE7RGrC8+V16FT+zGngYHMTgHrooY+k+FikuIE99mC+SwM+Vl9MXiots0ol7soaBm
 UeS5gkeNyM7wtkVhjaIyjXxVojLJ0G1PXAUqBre2H7EVIoSbTOJWiaIWR1Rhczl7MR
 Ck0xO5eth9a3RGt39/VkD46EtkiFjwFkS5K0snSSQmKF30eirJDBjfqeMRKHXamQMs
 2BMwhZ8k/3A2w==
Message-ID: <sashiko-outbox-178716@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 7/7] drm/rockchip: cdn-dp: Add multiple bridges to
 support PHY port selection
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261020072816.180-8-kernel@airkyi.com>
References: <20261020072816.180-1-kernel@airkyi.com>
 <20261020072816.180-8-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 09:19:41 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] drm/rockchip: cdn-dp: unguarded cdn_dp_config_video() in cdn_dp_sw=
itch_port()
- [High] drm/rockchip: cdn-dp: missing PHY switch in cdn_dp_bridge_atomic_e=
nable()
- [High] drm/rockchip: cdn-dp: encoder use-after-free on cdn_dp_bind() fail=
ure
- [High] drm/rockchip: cdn-dp: missing per-bridge check in cdn_dp_bridge_de=
tect()
- [High] drm/rockchip: cdn-dp: ignored bridge HPD state in cdn_dp_connected=
_port()
- [Medium] drm/rockchip: cdn-dp: race on dp->active_port in cdn_dp_connecte=
d_port()
--

commit ecc80bdc2aa1d377f4a7cb763c9aafe0d00f7b9f
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/rockchip: cdn-dp: Add multiple bridges to support PHY port selection

This commit adds support for registering multiple DRM bridges and encoders
in the Rockchip CDN-DP driver so that users can select between multiple PHY
ports using the DRM AUX HPD bridge infrastructure.

> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/roc=
kchip/cdn-dp-core.c
> index 1c1c1116b5ebe..4067802904250 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c

[ ... ]

> @@ -191,14 +192,27 @@ static int cdn_dp_get_sink_count(struct cdn_dp_devi=
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
> +		if (!dp->next_bridge_valid && lanes[i])
>  			return port;
>  	}
> +
> +	if (dp->next_bridge_valid) {
> +		/* If more than one port is available, pick the last active port */
> +		if (dp->active_port >=3D 0 && lanes[dp->active_port])
> +			return dp->port[dp->active_port];

[Severity: Medium]
Can dp->active_port race here when cdn_dp_connected_port() is called
without holding dp->lock?

In cdn_dp_bridge_atomic_disable(), dp->lock is released before calling
cdn_dp_connected_port(dp):

drivers/gpu/drm/rockchip/cdn-dp-core.c:cdn_dp_bridge_atomic_disable() {
	...
	mutex_unlock(&dp->lock);
	...
	if (!dp->connected && cdn_dp_connected_port(dp))
		schedule_work(&dp->event_work);
}

Concurrently, cdn_dp_pd_event_work(), cdn_dp_bridge_edid_read() ->
cdn_dp_switch_port(), or cdn_dp_bridge_atomic_enable() can update
dp->active_port under dp->lock, including setting dp->active_port =3D -1 in
cdn_dp_disable_phy().

If dp->active_port is set to -1 right after the dp->active_port >=3D 0 chec=
k,
won't lanes[dp->active_port] or dp->port[dp->active_port] read out of bounds
at index -1?

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
When dp->next_bridge_valid is true, cdn_dp_bridge_hpd_notify() records the
per-port HPD state in dp_bridge->connected, but cdn_dp_connected_port(),
cdn_dp_enable(), and cdn_dp_check_sink_connection() never inspect
dp->bridge_list[i]->connected.

Instead, cdn_dp_connected_port() checks cdn_dp_get_port_lanes(port), which
calls phy_get_bus_width(port->phy) when port->extcon is NULL. If the PHY bus
width remains non-zero while HPD is deasserted (for example, with a Type-C
dock or adapter in DP altmode with no monitor plugged in, or before altmode
teardown completes), won't cdn_dp_connected_port() treat the disconnected
port as connected?

Even if lanes[0] becomes 0 when active port 0 is unplugged while port 1
remains connected (with dp->active =3D=3D true and dp->active_port =3D=3D 0=
),
cdn_dp_pd_event_work() sees cdn_dp_connected_port(dp) return port 1 and
takes the else if (!cdn_dp_check_sink_connection(dp)) branch:

drivers/gpu/drm/rockchip/cdn-dp-core.c:cdn_dp_pd_event_work() {
	...
	if (!cdn_dp_connected_port(dp)) {
		...
	} else if (!dp->active) {
		...
	} else if (!cdn_dp_check_sink_connection(dp)) {
		DRM_DEV_INFO(dp->dev, "Connected without sink; assert hpd\n");
		dp->connected =3D false;
	...
}

Because cdn_dp_check_sink_connection() checks dp->port[dp->active_port]
(the unplugged port 0) and has no !dp_bridge->connected early exit when
port->extcon is NULL, won't it poll DPCD for CDN_DPCD_TIMEOUT_MS (5 seconds)
and then set dp->connected =3D false instead of switching to port 1, leaving
port 1 unusable when no bridge was enabled in KMS to trigger
cdn_dp_bridge_atomic_disable()?

[ ... ]

> @@ -550,6 +598,50 @@ static bool cdn_dp_check_link_status(struct cdn_dp_d=
evice *dp)
>  	return drm_dp_channel_eq_ok(link_status, min(port->lanes, sink_lanes));
>  }
> =20
> +static int cdn_dp_switch_port(struct cdn_dp_device *dp, struct cdn_dp_po=
rt *prev_port,
> +			      struct cdn_dp_port *port)
> +{
> +	int ret;
> +
> +	ret =3D cdn_dp_disable_phy(dp, prev_port);
> +	if (ret)
> +		goto out;
> +	ret =3D cdn_dp_enable_phy(dp, port);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D cdn_dp_get_sink_capability(dp);
> +	if (ret) {
> +		cdn_dp_disable_phy(dp, port);
> +		goto out;
> +	}
> +
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
> +		if (ret)
> +			dev_err(dp->dev, "Failed to configure video: %d\n", ret);
> +	}
> +
> +out:
> +	return ret;
> +}

[Severity: High]
Does cdn_dp_switch_port() always fail with -EINVAL when called from
cdn_dp_bridge_edid_read() before the first modeset commit?

cdn_dp_bridge_edid_read() only calls cdn_dp_switch_port() when no bridge is
currently enabled. Before the first modeset (cdn_dp_bridge_mode_set() and
cdn_dp_display_info_update()), dp->mode.clock and dp->video_info.color_depth
are both 0.

When switching to the new port, cdn_dp_check_link_status(dp) returns false
and cdn_dp_switch_port() unconditionally calls cdn_dp_config_video(dp)
(unlike cdn_dp_pd_event_work(), which checks mode->clock first). In
cdn_dp_config_video():

drivers/gpu/drm/rockchip/cdn-dp-reg.c:cdn_dp_config_video() {
	...
	do {
		tu_size_reg +=3D 2;
		symbol =3D (u64)tu_size_reg * mode->clock * bit_per_pix;
		do_div(symbol, dp->max_lanes * link_rate * 8);
		rem =3D do_div(symbol, 1000);
		if (tu_size_reg > 64) {
			ret =3D -EINVAL;
			DRM_DEV_ERROR(dp->dev,
				      "tu error, clk:%d, lanes:%d, rate:%d\n",
				      mode->clock, dp->max_lanes, link_rate);
			goto err_config_video;
		}
	} while ((symbol <=3D 1) || (tu_size_reg - symbol < 4) ||
		 (rem > 850) || (rem < 100));
}

With mode->clock =3D=3D 0, symbol is 0 on every iteration until tu_size_reg=
 > 64,
returning -EINVAL. In cdn_dp_bridge_edid_read(), that error causes a jump to
get_cache, skipping drm_edid_read_custom() and returning NULL when
edid_cache is empty.

Also, if cdn_dp_enable_phy(dp, port) or cdn_dp_get_sink_capability(dp) fails
after cdn_dp_disable_phy(dp, prev_port) has already disabled prev_port,
prev_port is not re-enabled. Doesn't that leave all ports with
phy_enabled =3D=3D false and dp->active_port =3D=3D -1 while dp->active rem=
ains true,
so subsequent calls to cdn_dp_bridge_edid_read() find prev_port =3D=3D NULL=
 and
attempt to read EDID with all PHYs powered off?

[ ... ]

> @@ -599,6 +692,9 @@ static void cdn_dp_bridge_atomic_enable(struct drm_br=
idge *bridge, struct drm_at
> =20
>  	mutex_lock(&dp->lock);
> =20
> +	if (dp->next_bridge_valid)
> +		dp->active_port =3D dp_bridge->id;
> +
>  	ret =3D cdn_dp_enable(dp);
>  	if (ret) {
>  		DRM_DEV_ERROR(dp->dev, "Failed to enable bridge %d\n",
> @@ -631,6 +727,7 @@ static void cdn_dp_bridge_atomic_enable(struct drm_br=
idge *bridge, struct drm_at
>  		goto out;
>  	}
> =20
> +	dp_bridge->enabled =3D true;
>  out:
>  	mutex_unlock(&dp->lock);
>  }

[Severity: High]
How does cdn_dp_bridge_atomic_enable() switch PHYs when dp->active is
already true on the other port?

When a sink is connected, cdn_dp_pd_event_work() calls cdn_dp_enable(dp),
which enables one PHY port and sets dp->active =3D true. Similarly, probing
connectors via cdn_dp_bridge_edid_read() can leave the other port's PHY
enabled while dp->active is true.

When cdn_dp_bridge_atomic_enable() then runs for dp_bridge, it sets
dp->active_port =3D dp_bridge->id and calls cdn_dp_enable(dp), which returns
immediately when dp->active is true:

drivers/gpu/drm/rockchip/cdn-dp-core.c:cdn_dp_enable() {
	...
	if (dp->active)
		return 0;
	...
}

Doesn't this leave the previously enabled PHY powered on and
dp->port[dp_bridge->id]->phy_enabled false, causing link training and video
output in cdn_dp_bridge_atomic_enable() to run against the wrong PHY?

In addition, since each bridge registers a separate drm_encoder with the
same possible_crtcs and there is no atomic_check preventing both bridges
from being enabled at the same time, what happens if userspace enables both
bridges and then disables one in cdn_dp_bridge_atomic_disable(), which calls
cdn_dp_disable(dp) and shuts down the entire controller?

[ ... ]

> @@ -947,10 +1062,12 @@ static void cdn_dp_pd_event_work(struct work_struc=
t *work)
>  	}
> =20
>  out:
> +	notify =3D last_connected !=3D dp->connected;
>  	mutex_unlock(&dp->lock);
> -	drm_bridge_hpd_notify(&dp->bridge,
> -			      dp->connected ? connector_status_connected
> -					    : connector_status_disconnected);
> +	for (i =3D 0; i < dp->bridge_count; i++) {
> +		if (notify)
> +			drm_kms_helper_connector_hotplug_event(dp->bridge_list[i]->connector);
> +	}
>  }

[Severity: High]
Should cdn_dp_bridge_detect() also check dp_bridge->connected, similar to
cdn_dp_bridge_mode_valid()?

Currently cdn_dp_bridge_detect() only checks the controller-wide
dp->connected flag:

drivers/gpu/drm/rockchip/cdn-dp-core.c:cdn_dp_bridge_detect() {
	struct cdn_dp_device *dp =3D bridge_to_dp(bridge);
	enum drm_connector_status status =3D connector_status_disconnected;

	mutex_lock(&dp->lock);
	if (dp->connected)
		status =3D connector_status_connected;
	mutex_unlock(&dp->lock);

	return status;
}

Because each bridge sets DRM_BRIDGE_OP_DETECT, drm_bridge_connector_init()
selects cdn_dp_bridge as bridge_detect for each connector. When port 0 is
connected (dp->connected =3D=3D true) and port 1 is disconnected
(bridge_list[1]->connected =3D=3D false), cdn_dp_pd_event_work() calls
drm_kms_helper_connector_hotplug_event() on all connectors.

When drm_bridge_connector_detect_ctx() probes the disconnected port 1
connector:

drivers/gpu/drm/display/drm_bridge_connector.c:drm_bridge_connector_detect_=
ctx() {
	...
	if (detect) {
		status =3D detect->funcs->detect(detect, connector);
		...
		drm_bridge_connector_hpd_notify(connector, status);
	}
	...
}

cdn_dp_bridge_detect() returns connector_status_connected for port 1, and
drm_bridge_connector_hpd_notify() immediately calls
cdn_dp_bridge_hpd_notify() on bridge_list[1] with
connector_status_connected, overwriting bridge_list[1]->connected =3D true =
and
causing port 1 to attempt an EDID read (switching PHYs if port 0 is not yet
enabled).

Conversely, when a port first signals HPD connect via
drm_bridge_connector_handle_hpd(), cdn_dp_bridge_hpd_notify() sets
dp_bridge->connected =3D true and schedules dp->event_work, while
drm_bridge_connector_handle_hpd() immediately triggers connector probing. If
drm_bridge_connector_detect_ctx() runs before dp->event_work sets
dp->connected =3D true, won't cdn_dp_bridge_detect() return
connector_status_disconnected and overwrite dp_bridge->connected back to
false via drm_bridge_connector_hpd_notify()?

> =20
>  static int cdn_dp_pd_event(struct notifier_block *nb,
> @@ -970,28 +1087,16 @@ static int cdn_dp_pd_event(struct notifier_block *=
nb,
>  	return NOTIFY_DONE;
>  }
> =20
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

[ ... ]

> @@ -1033,6 +1147,108 @@ static int cdn_dp_bind(struct device *dev, struct=
 device *master, void *data)
>  		return ret;
>  	}
> =20
> +	if (last_bridge) {
> +		fwnode_handle_put(connector->fwnode);
> +		connector->fwnode =3D fwnode_handle_get(of_fwnode_handle(last_bridge->=
of_node));
> +	}
> +
> +	bridge_to_dp_bridge(bridge)->connector =3D connector;
> +
> +	return 0;
> +}

[ ... ]

> +static int cdn_dp_bind(struct device *dev, struct device *master, void *=
data)
> +{
> +	struct cdn_dp_device *dp =3D dev_get_drvdata(dev);
> +	struct drm_bridge *bridge, *next_bridge;
> +	struct drm_encoder *encoder;
> +	struct cdn_dp_port *port;
> +	struct drm_device *drm_dev =3D data;
> +	struct cdn_dp_bridge *dp_bridge;
> +	int ret, i;
> +
> +	ret =3D cdn_dp_parse_dt(dp);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D cdn_dp_parse_next_bridge_dt(dp);
> +	if (ret)
> +		goto out;
> +
> +	dp->drm_dev =3D drm_dev;
> +	dp->connected =3D false;
> +	dp->active =3D false;
> +	dp->active_port =3D -1;
> +	dp->fw_loaded =3D false;
> +
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
> +
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
> +
>  	for (i =3D 0; i < dp->ports; i++) {
>  		port =3D dp->port[i];
> =20
> @@ -1046,7 +1262,7 @@ static int cdn_dp_bind(struct device *dev, struct d=
evice *master, void *data)
>  		if (ret) {
>  			DRM_DEV_ERROR(dev,
>  				      "register EXTCON_DISP_DP notifier err\n");
> -			return ret;
> +			goto out;
>  		}
>  	}
> =20
> @@ -1055,15 +1271,31 @@ static int cdn_dp_bind(struct device *dev, struct=
 device *master, void *data)
>  	schedule_work(&dp->event_work);
> =20
>  	return 0;
> +
> +out:
> +	for (i =3D 0; i < MAX_PHY; i++)
> +		drm_bridge_clear_and_put(&dp->next_bridge_list[i]);
> +
> +	return ret;
>  }

[Severity: High]
Can a failure in cdn_dp_bind() cause a use-after-free on encoder?

In this patch, struct rockchip_encoder encoder is embedded inside struct
cdn_dp_bridge, which is allocated with devm_drm_bridge_alloc() inside
cdn_dp_bind() (under component_bind()'s devres group).

In cdn_bridge_add(), drm_encoder_init() adds &dp_bridge->encoder.encoder to
drm_dev->mode_config.encoder_list. If a subsequent step in cdn_bridge_add()
or cdn_dp_bind() fails (for example, drm_bridge_attach() on next_bridge,
drm_bridge_connector_init(), the second iteration of cdn_bridge_add(), or
devm_extcon_register_notifier()), the error path at out: does not destroy
any already-initialized encoders.

When component_bind() then releases its devres group, the devm reference on
dp_bridge is dropped, freeing dp_bridge (either immediately if
drm_bridge_attach() on dp_bridge->bridge did not run, or during
drm_encoder_cleanup() -> drm_bridge_detach() when
drm_mode_config_cleanup() unwinds) while drm_encoder_cleanup() still
accesses the embedded encoder. Should the error path clean up any
initialized encoders (or use drmm_encoder_alloc() / separate the encoder
allocation from the bridge container)?

> =20
>  static void cdn_dp_unbind(struct device *dev, struct device *master, voi=
d *data)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020072816.180-=
1-kernel@airkyi.com?part=3D7
