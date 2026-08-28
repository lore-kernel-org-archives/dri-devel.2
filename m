Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37DBC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F4110F309;
	Fri, 28 Aug 2026 09:14:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lHOoEgZN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03A7610F309
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 09:14:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9DF664190A;
 Fri, 28 Aug 2026 09:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9381F00A3A;
 Fri, 28 Aug 2026 09:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787908467;
 bh=6jtVWyW3lAo3HEsJHl0q4U7URdaSfejciHwbR2r8Pe8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lHOoEgZNIsaRzo638nNSYRvc/MjYVZ/BtVHfkv5lM48GdDJ2Wpc8VsN46Ym4bRxr+
 sf4Zjdd9xNnDi17IVITTttkA4abBTq6ImttOrYtbm58easlqLM2KUtz5Um3mEtkgnq
 HzfCAg5Fl+78HFAUTid8HOBay4AbM0lz277Sq7PfmWOzitVv3NB8U/kKdGRdXpFaoy
 FA8Mu+Wqji3xDv7rS3EmaKmXzkCrtQYckqRXk3ZwQi0gKBp5O8FtsKTRMLvErPveoQ
 34SjYm+qHxuvUmRM9VJ2UEvIP67fuykbX0VudKlxeupQE3PZm1QVTsI7nX96IykrxA
 6UuIP+OTKodnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 7/7] drm/rockchip: cdn-dp: Add multiple bridges to
 support PHY port selection
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: linux-phy@lists.infradead.org, olteanv@gmail.com,
 dri-devel@lists.freedesktop.org, vkoul@kernel.org, neil.armstrong@linaro.org
In-Reply-To: <20260828084737.565-8-kernel@airkyi.com>
References: <20260828084737.565-1-kernel@airkyi.com>
 <20260828084737.565-8-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 09:14:26 +0000
Message-Id: <20260828091427.4C9381F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Missing atomic_check to prevent concurrent enablement of mutually =
exclusive DP bridges.
- [High] Hardware registers are accessed while DP clocks are disabled, lead=
ing to a synchronous external abort and kernel panic.
- [High] The driver fails to propagate internal hotplug state changes to us=
erspace because its bridge no longer receives the HPD callback.
- [High] Video pipeline configuration is inappropriately executed during ED=
ID read, leading to inevitable failure on secondary ports.
- [Medium] The connected status of bridges is updated and read concurrently=
 without holding the necessary synchronization locks.
--

commit a45588df990bb11f402ba98f56052bec1405db96
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/rockchip: cdn-dp: Add multiple bridges to support PHY port selection

This commit adds support for multiple bridges to the Rockchip CDN-DP driver,
allowing dynamic output port selection. It registers separate encoders and
bridges for each PHY port and parses the device tree to describe connection=
s.
Port switching is handled dynamically during EDID reads or when enabling the
DP block.

> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/roc=
kchip/cdn-dp-core.c
> index 74e1f5422a6e2..999309b39b34c 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c

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
Will this video pipeline configuration fail during an EDID read?

When reading the EDID on a secondary port, this switches the port and
ultimately calls cdn_dp_config_video() via cdn_dp_switch_port(). Since this
happens during connector probing, no atomic mode has been committed yet,
meaning dp->mode.clock is either 0 or holds a stale value.

This will cause the timing calculation in cdn_dp_config_video() to return
-EINVAL. The switch then fails, and this function falls back to returning t=
he
cache (which is NULL on the first plug), breaking secondary port detection.

> +			if (ret)
> +				goto get_cache;
> +		}
> +	}
> +
>  	drm_edid =3D drm_edid_read_custom(connector, cdn_dp_get_edid_block, dp);

[Severity: High]
Is there a risk of a synchronous external abort when accessing the DP hardw=
are
registers here?

Hotplug events from downstream bridges trigger cdn_dp_bridge_hpd_notify(),
which schedules dp->event_work to enable the DP clocks and hardware via
cdn_dp_enable(). At the same time, the DRM core processes the hotplug event
and schedules output_poll_work, which initiates an EDID read here.

If the EDID read happens before the worker thread has enabled the clocks, it
will bypass the port switch logic (since prev_port is NULL) and directly
access the APB registers (like MAILBOX_EMPTY_ADDR) inside
cdn_dp_get_edid_block(). Accessing these registers while pclk and core_clk
are disabled causes a kernel panic.

> +	/* replace edid cache */
> +	if (dp->edid_cache[dp_bridge->id])
> +		drm_edid_free(dp->edid_cache[dp_bridge->id]);
> +	dp->edid_cache[dp_bridge->id] =3D drm_edid_dup(drm_edid);
> +
>  	mutex_unlock(&dp->lock);
> +	return drm_edid;

[ ... ]

> @@ -572,6 +664,7 @@ static void cdn_dp_display_info_update(struct cdn_dp_=
device *dp,
>  static void cdn_dp_bridge_atomic_enable(struct drm_bridge *bridge, struc=
t drm_atomic_commit *state)
>  {
>  	struct cdn_dp_device *dp =3D bridge_to_dp(bridge);
> +	struct cdn_dp_bridge *dp_bridge =3D bridge_to_dp_bridge(bridge);
>  	struct drm_connector *connector;
>  	int ret, val;
> =20
> @@ -600,6 +693,9 @@ static void cdn_dp_bridge_atomic_enable(struct drm_br=
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
> @@ -632,6 +728,7 @@ static void cdn_dp_bridge_atomic_enable(struct drm_br=
idge *bridge, struct drm_at
>  		goto out;
>  	}
> =20
> +	dp_bridge->enabled =3D true;

[Severity: High]
What prevents userspace from enabling multiple CRTCs simultaneously on this
single DP hardware block?

The driver registers multiple independent DRM bridges and encoders that sha=
re
a single DP controller. Without a custom atomic_check to enforce mutual
exclusion, the DRM core allows userspace to assign and enable multiple CRTCs
to these encoders.

If multiple bridges are enabled concurrently, cdn_dp_bridge_atomic_enable()
is called for both. The second call will see dp->active =3D=3D true, skip t=
he
PHY enablement, and then proceed to call cdn_dp_train_link() and
cdn_dp_config_video() here, which overrides the shared hardware registers
and corrupts the active display.

>  out:
>  	mutex_unlock(&dp->lock);
>  }

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
Is it safe to modify this connected state without acquiring dp->lock?

The boolean state dp->bridge_list[dp_bridge->id]->connected is written here
directly, but cdn_dp_pd_event_work() reads this exact flag immediately after
explicitly dropping dp->lock. This data race could cause the worker to
process stale state if a concurrent HPD notification occurs.

> +
>  static const struct drm_bridge_funcs cdn_dp_bridge_funcs =3D {
>  	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,

[ ... ]

> @@ -945,9 +1057,12 @@ static void cdn_dp_pd_event_work(struct work_struct=
 *work)
> =20
>  out:
>  	mutex_unlock(&dp->lock);
> -	drm_bridge_hpd_notify(&dp->bridge,
> -			      dp->connected ? connector_status_connected
> -					    : connector_status_disconnected);
> +	for (i =3D 0; i < dp->bridge_count; i++) {
> +		connected =3D dp->connected && dp->bridge_list[i]->connected;
> +		drm_bridge_hpd_notify(&dp->bridge_list[i]->bridge,
> +				      connected ? connector_status_connected
> +						: connector_status_disconnected);
> +	}
>  }

[Severity: High]
Will this HPD notification actually reach userspace?

The DRM bridge connector (drm_bridge_connector_init) only registers the
hpd_cb on the last bridge in the chain that supports DRM_BRIDGE_OP_HPD.
Because the downstream AUX HPD bridge supports HPD and is added to the chai=
n,
it becomes the designated HPD bridge and takes the hpd_cb.

As a result, this bridge's hpd_cb is never set, making this call to
drm_bridge_hpd_notify() a silent no-op. If link training fails, userspace
is never notified that the connection has dropped, permanently breaking the
display state machine.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828084737.565-=
1-kernel@airkyi.com?part=3D7
