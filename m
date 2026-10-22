Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A6E606A31B
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ivMeh4qd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA86510E46D;
	Thu, 22 Oct 2026 17:03:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB7EF10E055;
 Thu, 22 Oct 2026 17:03:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1DE8E6022E;
 Thu, 22 Oct 2026 17:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A661F01825;
 Thu, 22 Oct 2026 17:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792688591;
 bh=lTADlze0gzKd1ZBVwsTSoIYcCYunDsAJLu0uojt0U0Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ivMeh4qdbfsLmmMzF0qLUY/k3HHLjsiL6jpP2CMiXzCA7ZB7dmdlrpJeEvivV5NPO
 GY3YAZYrVbP9WAHt3OO6T7LZhLpKQ89ZQKDe4xnNSrB2RR7gEjD+LCZ4u+SueH0jOP
 D5H6bnbh8KkatoEvL5NXRKqvKYCRJ02yhA0wuEZ++tZIL5V+sS1XzCe44II3ISuYlF
 ZuaEH9NUobS4XKNnY7z7IaopfgVeBCgwMzxS7S8mjt08lrKgkh/I6QwaUaVQPHHLfj
 LyKJbbSZmHTiRwgMMlBhBFk9mrG1zpBj6Tsmt+jlwaPBkGt7EYIHIHQO377UYxTS74
 zN9w0ZGQMYQZw==
Message-ID: <sashiko-outbox-181842@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/8] drm/analogix/anx7625: Use dp_connector helpers
 to expose link training state
To: "Kory Maincent" <kory.maincent@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261022-feat_link_cap-v4-7-a4f3f6e8cad9@bootlin.com>
References: <20261022-feat_link_cap-v4-0-a4f3f6e8cad9@bootlin.com>
 <20261022-feat_link_cap-v4-7-a4f3f6e8cad9@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 17:03:10 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/analogix/anx7625: wrong eDP check in anx7625_bridge_atomic_d=
isable()
--

commit 49aa21f51dedc9ed0b5c807bbb55946e8c40288d
Author: Kory Maincent <kory.maincent@bootlin.com>

drm/analogix/anx7625: Use dp_connector helpers to expose link training state

This commit adopts the DisplayPort connector helpers in the anx7625 bridge
driver by setting DRM_BRIDGE_OP_DP, populating dp_link_caps, and reporting
sink capabilities and link training parameters.

> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/=
bridge/analogix/anx7625.c
> index c3af88e14f8b2..2b1235efc9fa4 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c

[ ... ]

> @@ -2580,6 +2606,17 @@ static void anx7625_bridge_atomic_enable(struct dr=
m_bridge *bridge,
> =20
>  	anx7625_dp_start(ctx);
> =20
> +	/* On DisplayPort case, the caps are set in the detect callback. */
> +	if (bridge->type =3D=3D DRM_MODE_CONNECTOR_eDP) {
> +		ret =3D drm_dp_sink_sync_caps(connector, &ctx->aux, NULL);
> +		if (ret)
> +			DRM_DEV_DEBUG_DRIVER(dev,
> +					     "error sink caps synchronisation (%d)\n",
> +					     ret);
> +	}
> +
> +	anx7625_report_link_train(ctx, connector);
> +
>  	conn_state =3D drm_atomic_get_new_connector_state(state, connector);
> =20
>  	if (WARN_ON(!conn_state))
> @@ -2616,6 +2653,12 @@ static void anx7625_bridge_atomic_disable(struct d=
rm_bridge *bridge,
>  		dev_dbg(dev, "update CP to DESIRE\n");
>  	}
> =20
> +	/* On DisplayPort unplug, the caps are already reset in the detect
> +	 * callback.
> +	 */
> +	if (bridge->type =3D=3D DRM_MODE_CONNECTOR_eDP)
> +		drm_dp_sink_reset_caps(ctx->connector);

[Severity: Medium]
In anx7625_bridge_atomic_enable() and anx7625_bridge_atomic_disable(), does
checking bridge->type =3D=3D DRM_MODE_CONNECTOR_eDP work as intended on
DisplayPort boards that wire port 1 to a downstream dp-connector bridge?

In anx7625_parse_dt_panel(), pdata->panel_bridge is populated with whatever
bridge is connected on port 1:

drivers/gpu/drm/bridge/analogix/anx7625.c:anx7625_parse_dt_panel() {
	pdata->panel_bridge =3D devm_drm_of_get_bridge(dev, np, 1, 0);
	...
}

Then in anx7625_link_bridge(), DRM_BRIDGE_OP_DETECT is enabled whenever the
panel is not on the aux-bus, while bridge.type is set to
DRM_MODE_CONNECTOR_eDP whenever pdata.panel_bridge is non-NULL:

drivers/gpu/drm/bridge/analogix/anx7625.c:anx7625_link_bridge() {
	...
	if (!platform->pdata.panel_bridge || !anx7625_of_panel_on_aux_bus(dev))
		platform->bridge.ops |=3D DRM_BRIDGE_OP_HPD | DRM_BRIDGE_OP_DETECT;
	platform->bridge.type =3D platform->pdata.panel_bridge ?
				    DRM_MODE_CONNECTOR_eDP :
				    DRM_MODE_CONNECTOR_DisplayPort;
	...
}

On boards using a downstream dp-connector bridge on port 1 (such as
qcs615-ride, lemans-ride, or qcs8300-ride), pdata.panel_bridge is non-NULL,
so bridge->type is DRM_MODE_CONNECTOR_eDP even though DRM_BRIDGE_OP_DETECT
is set and the connector's connector_type is DRM_MODE_CONNECTOR_DisplayPort.

When the display is disabled via anx7625_bridge_atomic_disable() while the
DisplayPort monitor remains plugged in (for example during dpms off or a
modeset disable), bridge->type =3D=3D DRM_MODE_CONNECTOR_eDP evaluates to t=
rue
and calls drm_dp_sink_reset_caps(ctx->connector), clearing
connector->dp.sink_link_caps and connector->dp.cur_link_info for the
still-connected sink until a future hotplug event occurs. Similarly,
anx7625_bridge_atomic_enable() redundantly calls drm_dp_sink_sync_caps()
even though anx7625_bridge_detect() already synchronized the caps on
hotplug.

Should these checks test !(bridge->ops & DRM_BRIDGE_OP_DETECT) (or check
ctx->connector->connector_type =3D=3D DRM_MODE_CONNECTOR_eDP) instead of
bridge->type?

> +
>  	ctx->connector =3D NULL;
>  	anx7625_dp_stop(ctx);
> =20

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-feat_link_=
cap-v4-0-a4f3f6e8cad9@bootlin.com?part=3D7
