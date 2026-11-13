Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88556606D932
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IWEyifuh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC6FC10E380;
	Fri, 13 Nov 2026 08:49:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5351C10E380
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:49:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EBF8C436E5;
 Fri, 13 Nov 2026 08:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EE51F000C4;
 Fri, 13 Nov 2026 08:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794559766;
 bh=bc0VEv/1MSuT07qIbIvGJddImfuB99U31Y6kNPbfbE8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IWEyifuhsHGoPx1ueQVz0euYcFJU6tLnNELi8jqFmE5f+I32QYKJfbFr95vvnPoQ5
 CJsVxZUTjja/uY8h1DMB/YZaMeYZF4tGrpRQuL/iS1OdPtT13V1WZuYGR29Bld2PBE
 cdrlBjaZCkiqEBH67haTyBqBY+N09QFVLokfKboHfiCcdXbjo8crbZpsVeTSaBOsFX
 C6w4tjhLdlsIsMSqudO6FC9VMA8SDkOEhWzzOjO0/jgNv7KFPWPN5b0ab8dE4bJw3X
 EYtRH0JOyPQQlqtF0tgpP6xmuytKc7s7pyK6tCj9DduCEvIdcPpOAAsebBgm5JcQAY
 uH/9peDT4Ingg==
Message-ID: <sashiko-outbox-212465@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 17/18] drm/bridge: analogix_dp: Handle HPD
 notification from downstream bridge
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261113082305.541652-18-damon.ding@rock-chips.com>
References: <20261113082305.541652-1-damon.ding@rock-chips.com>
 <20261113082305.541652-18-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 08:49:26 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] drm/bridge: analogix_dp: analogix_dp_supports_hpd() ignores
  hpd_notify_mode
- [Medium] drm/bridge: analogix_dp: DRM_BRIDGE_OP_HPD set before
  drm_bridge_attach()
- [Medium] drm/bridge: analogix_dp: detect hpd_notify() echo races with
  HPD notifications
--

commit c237458f9c91bcd96060ebf17f0f83f06f94643c
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Handle HPD notification from downstream bridge

This commit adds an hpd_notify_mode to analogix_dp so that hotplug status is
tracked via .hpd_notify instead of native HPD interrupts or register polling
when a downstream bridge provides HPD without detection.

Link: https://lore.kernel.org/all/5609825.iZASKD2KPV@diego/

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 9f50163aecf9f..6db2893443758 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -52,7 +52,8 @@ static const bool verify_fast_training;
>  static bool analogix_dp_require_pm_for_hpd_irq(struct analogix_dp_device=
 *dp)
>  {
>  	return (dp->plat_data->dev_type =3D=3D RK3576_EDP || dp->plat_data->dev=
_type =3D=3D RK3588_EDP) &&
> -	       !dp->hpd_gpiod && !dp->force_hpd && !dp->force_connected_mode;
> +	       !dp->hpd_gpiod && !dp->force_hpd && !dp->force_connected_mode &&
> +	       !dp->hpd_notify_mode;
>  }

[Severity: Medium]
Should analogix_dp_supports_hpd() also check !dp->hpd_notify_mode?

drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:analogix_dp_supports_hpd=
() {
	if (dp->force_connected_mode || dp->force_hpd)
		return false;

	if (dp->hpd_gpiod)
		return true;

	return dp->plat_data->dev_type =3D=3D RK3576_EDP || dp->plat_data->dev_typ=
e =3D=3D RK3588_EDP;
}

In analogix_dp_bind(), analogix_dp_require_pm_for_hpd_irq(dp) now returns
false when dp->hpd_notify_mode is set, skipping pm_runtime_resume_and_get()
and leaving native HPD interrupts unmuted in hardware because
analogix_dp_config_interrupt() has not run.  Right after that,
analogix_dp_supports_hpd(dp) still returns true on RK3576_EDP and RK3588_EDP
and calls enable_irq(dp->irq), so any assertion on the unmuted native IRQ
line wakes analogix_dp_irq_thread() and calls drm_bridge_hpd_notify().

> =20
>  /*
> @@ -946,6 +947,10 @@ analogix_dp_bridge_detect(struct drm_bridge *bridge,=
 struct drm_connector *conne
>  	enum drm_connector_status status =3D connector_status_disconnected;
>  	int ret;
> =20
> +	if (dp->hpd_notify_mode)
> +		return dp->connection_notified ? connector_status_connected :
> +						 connector_status_disconnected;
> +
>  	if (dp->force_connected_mode)
>  		return connector_status_connected;

[ ... ]

> @@ -1008,6 +1028,7 @@ static int analogix_dp_bridge_attach(struct drm_bri=
dge *bridge,
>  		 * accurate hotplug state.
>  		 */
>  		dp->force_connected_mode =3D analogix_dp_bridge_force_connected(dp);
> +		dp->hpd_notify_mode =3D analogix_dp_has_downstream_hpd(dp);
>  	}
> =20
>  	return 0;

[Severity: Medium]
Does analogix_dp_bind() check analogix_dp_supports_hpd() too early when
setting DRM_BRIDGE_OP_HPD?

drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:analogix_dp_bind() {
    ...
	bridge->ops =3D DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT;
	if (analogix_dp_supports_hpd(dp))
		bridge->ops |=3D DRM_BRIDGE_OP_HPD;
	bridge->of_node =3D dp->dev->of_node;
	bridge->type =3D DRM_MODE_CONNECTOR_eDP;
	ret =3D devm_drm_bridge_add(dp->dev, &dp->bridge);
	if (ret)
		goto err_unregister_aux;

	ret =3D drm_bridge_attach(dp->encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_=
CONNECTOR);
    ...
}

dp->force_connected_mode and dp->hpd_notify_mode are only computed inside
analogix_dp_bridge_attach() when drm_bridge_attach() runs.  When
analogix_dp_supports_hpd(dp) is evaluated before drm_bridge_attach(), both
flags are still false, so bridge->ops advertises DRM_BRIDGE_OP_HPD on
RK3576_EDP and RK3588_EDP (or when dp->hpd_gpiod is set) even for fixed
panels where enable_irq(dp->irq) is later skipped.

> @@ -1304,6 +1325,14 @@ static void analogix_dp_bridge_atomic_post_disable=
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
Can the .hpd_notify() call at the end of drm_bridge_connector_detect_ctx()
overwrite a concurrent hotplug notification in dp->connection_notified?

drm_bridge_connector_detect_ctx() calls detect->funcs->detect() and then
passes the returned status to drm_bridge_connector_hpd_notify().  Meanwhile,
drm_bridge_connector_handle_hpd() drops dev->mode_config.mutex before calli=
ng
drm_bridge_connector_hpd_notify() and
drm_kms_helper_connector_hotplug_event():

CPU0                                  CPU1
drm_bridge_connector_detect_ctx()
  analogix_dp_bridge_detect()
    reads connection_notified (false)
                                      drm_bridge_connector_handle_hpd()
                                        drm_bridge_connector_hpd_notify(
                                          ..., status_connected)
                                          analogix_dp_bridge_notify()
                                            connection_notified =3D true
  drm_bridge_connector_hpd_notify(
    ..., status_disconnected)
    analogix_dp_bridge_notify()
      connection_notified =3D false  <-- overwrites connected state
                                        drm_kms_helper_connector_hotplug_ev=
ent()
                                          ...
                                          analogix_dp_bridge_detect()
                                            returns status_disconnected

When the hotplug event on CPU1 re-probes the connector,
analogix_dp_bridge_detect() sees dp->connection_notified =3D=3D false and r=
eports
the newly connected sink as disconnected, and subsequent AUX transfers fail=
 in
analogix_dp_detect_hpd().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113082305.5416=
52-1-damon.ding@rock-chips.com?part=3D17
