Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B47BCCF2DB
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:16:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 016BD10E8D7;
	Mon, 19 Oct 2026 09:16:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3533210E8F5
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:16:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C9B840E3F;
 Mon, 19 Oct 2026 09:16:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4321F000C4;
 Mon, 19 Oct 2026 09:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792401395;
 bh=+2o2qlgK5IGSmEf5DP4euOO6ShEdrzf+YEnYx0thx0A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DTFSM4iQs2x8FLh/oa1MxXvJX1h4s9URiIRTXtaq9h6o/T3XtyUNEvgaMqQSrviqv
 wE248Q0ckGA+P2SjMpBtVJgkvISBs+xrX5kdmEMes6RgJ0WWWwhsDv6nvO6DqssCCH
 wRoUz9K/Cs9p/YAIPXDXTABV4zJMMHVoWphQCq2am4ELj+dXXQCI/jkRVsOmVfU3mC
 D6jC+TrFUWGojIIMz1/xQ6Yqxx8On2+A1/KGcQl3V1heJSmJYOi+9QeS2cqLkDuYpE
 qQWSZ4IfUJRnC6h56P6ZL4mfwmOVRG/j189Ql1nkFDfU5TsYnS98ARvS2xHeZESlPw
 J+3UdKmR36f8Q==
Message-ID: <sashiko-outbox-176886@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/14] drm/bridge: analogix_dp: Handle HPD
 notification from downstream bridge
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261019085836.3065008-14-damon.ding@rock-chips.com>
References: <20261019085836.3065008-1-damon.ding@rock-chips.com>
 <20261019085836.3065008-14-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 09:16:34 +0000
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
- [Medium] drm/bridge: analogix_dp: race on dp->connection_notified in anal=
ogix_dp_bridge_notify()
--

commit e243ae0110d3bc583be1aa034e4af8955ad61137
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Handle HPD notification from downstream bridge

This commit handles hotplug notifications from a downstream bridge that
supports HPD events (DRM_BRIDGE_OP_HPD) when no downstream bridge provides
detection (DRM_BRIDGE_OP_DETECT). It caches the status passed to the
bridge's .hpd_notify callback and uses it in analogix_dp_get_plug_in_status=
()
while muting and skipping native HPD initialization.

Link: https://lore.kernel.org/all/5609825.iZASKD2KPV@diego/

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index df898f3142549..90245d55d1d2c 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c

[ ... ]

> @@ -1260,6 +1276,14 @@ static void analogix_dp_bridge_atomic_post_disable=
(struct drm_bridge *bridge,
>  		DRM_ERROR("Failed to enable psr (%d)\n", ret);
>  }
> =20
> +static void analogix_dp_bridge_notify(struct drm_bridge *bridge, struct =
drm_connector *connector,
> +				      enum drm_connector_status status)
> +{
> +	struct analogix_dp_device *dp =3D to_dp(bridge);
> +
> +	dp->connection_notified =3D (status =3D=3D connector_status_connected);
> +}

[Severity: Medium]
Can a concurrent connector probe overwrite a downstream HPD notification he=
re
and cause the hotplug transition to be lost?

When dp->hpd_notify_mode is enabled, drm_bridge_connector_init() sets
bridge_connector->bridge_detect to the Analogix DP bridge and
bridge_connector->bridge_hpd to the downstream bridge.

In the connector detection path (for example via drm_mode_getconnector(),
drm_client_modeset_probe(), or status_store()),
drm_bridge_connector_detect_ctx() holds dev->mode_config.mutex, calls
detect->funcs->detect() which reads dp->connection_notified via:

  analogix_dp_bridge_detect()
    -> analogix_dp_detect_hpd()
      -> analogix_dp_get_plug_in_status()

and then feeds that return value back into drm_bridge_connector_hpd_notify(=
):

drivers/gpu/drm/display/drm_bridge_connector.c:drm_bridge_connector_detect_=
ctx() {
	...
	if (detect)
		status =3D detect->funcs->detect(detect, connector);
	...
	drm_bridge_connector_hpd_notify(connector, status);
}

Meanwhile, when a downstream HPD event arrives via drm_bridge_hpd_notify(),
drm_bridge_connector_handle_hpd() releases dev->mode_config.mutex before
calling drm_bridge_connector_hpd_notify():

drivers/gpu/drm/display/drm_bridge_connector.c:drm_bridge_connector_handle_=
hpd() {
	...
	mutex_lock(&dev->mode_config.mutex);
	connector->status =3D status;
	mutex_unlock(&dev->mode_config.mutex);

	drm_bridge_connector_hpd_notify(connector, status);

	drm_kms_helper_connector_hotplug_event(connector);
}

If these two paths interleave:

1. drm_bridge_connector_handle_hpd() updates connector->status and unlocks
   dev->mode_config.mutex.
2. A concurrent probe enters drm_bridge_connector_detect_ctx() under
   dev->mode_config.mutex and calls analogix_dp_bridge_detect(), reading the
   stale dp->connection_notified value.
3. drm_bridge_connector_handle_hpd() calls drm_bridge_connector_hpd_notify()
   -> analogix_dp_bridge_notify(), setting dp->connection_notified to the n=
ew
   status, and then waits on dev->mode_config.mutex inside
   drm_kms_helper_connector_hotplug_event().
4. drm_bridge_connector_detect_ctx() finishes and calls
   drm_bridge_connector_hpd_notify() -> analogix_dp_bridge_notify() with the
   stale status it read in step 2, clobbering dp->connection_notified.

When drm_kms_helper_connector_hotplug_event() (or userspace handling the
hotplug event) subsequently probes the connector,
analogix_dp_get_plug_in_status() will see the stale dp->connection_notified
value and the hotplug state change is lost.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019085836.3065=
008-1-damon.ding@rock-chips.com?part=3D13
