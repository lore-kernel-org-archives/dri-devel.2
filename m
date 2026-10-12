Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B97FCA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:26:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0EBB10E621;
	Mon, 12 Oct 2026 15:26:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2564310F1D8;
 Mon, 12 Oct 2026 15:26:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9DD6660A6B;
 Mon, 12 Oct 2026 15:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A021F0089B;
 Mon, 12 Oct 2026 15:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791818779;
 bh=ms7PZvbJXLMCLiKeKMg3yF5a5c/131LRgTkQ0gpanbE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lijkWZSKDQnbbACO99ZUUvjY3+RXH6fIFayC8I3fun5TUrK8w6I15mBmk2TjPWM+b
 Cwe6QgPiO4/f6c3Ksv4C3wcL4LlmrNKNYUUW84JwQh3V1OEkf7xULVe0kv5PYSYCTf
 lBzz1b7cTbixoTeRihtCZngDiG+rmFex13Aa9GWOYjzdCJRW2Vk2eMEk1NNxDfKfn4
 xbDhOPfkAo9O2zEVvaXoYDjEVeCquSI3twsMs5lt9iW2qV+bAFCTsPI1WbFrXDgPQE
 FeNr8DrYLabCnbTA6XEz5jqjhvn5ob2uFk8KPx7Je1lPXtFJR9z4y9yyU5L6706aHV
 SVQHz+1r3+1rQ==
Message-ID: <sashiko-outbox-168332@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 7/8] drm/analogix/anx7625: Use dp_connector
 helpers to expose link training state
To: "Kory Maincent" <kory.maincent@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20261012-feat_link_cap-v3-7-7517f4aba0f3@bootlin.com>
References: <20261012-feat_link_cap-v3-0-7517f4aba0f3@bootlin.com>
 <20261012-feat_link_cap-v3-7-7517f4aba0f3@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 15:26:18 +0000
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
- [High] drm: lockdep assertion failure in DP helpers during atomic commit
- [High] drm/analogix: lockdep splat and sleep-in-atomic via dp_connector h=
elpers in atomic callbacks
- [Medium] drm: eDP sink capabilities incorrectly erased on atomic_disable
- [Medium] drm: reading stale DP link parameters in detect callback
--

commit 1548e3d30cfb50d6bc0f342acba2b2ddf8b97bab
Author: Kory Maincent <kory.maincent@bootlin.com>

drm/analogix/anx7625: Use dp_connector helpers to expose link training state

Adopt the DRM core DisplayPort helpers by setting DRM_BRIDGE_OP_DP and
populating the bridge dp_link_caps at probe time. Report the sink
capabilities on hotplug, reset them on disconnect, and report the link
parameters once link training succeeds.

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

[Severity: High]
Does calling drm_dp_sink_sync_caps() and anx7625_report_link_train() here
violate atomic context invariants and locking expectations?

During non-blocking atomic commits, the commit_tail worker executes this
callback asynchronously after the originating thread has dropped all modeset
locks. However, drm_dp_sink_sync_caps() and drm_dp_set_cur_link_params()
(called by anx7625_report_link_train) explicitly assert that
connector->dev->mode_config.connection_mutex is held.

Additionally, atomic_enable callbacks execute in atomic context where sleep=
ing
is forbidden. The DRM DP helpers perform I2C AUX transfers, allocate memory,
and acquire standard mutexes (like connector->dp.mutex), which are sleeping
operations.

>  	conn_state =3D drm_atomic_get_new_connector_state(state, connector);
> =20
>  	if (WARN_ON(!conn_state))

[ ... ]

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
> +

[Severity: High]
Similar to atomic_enable, does calling drm_dp_sink_reset_caps() from an
atomic_disable callback trigger lockdep and sleep-in-atomic warnings?

The helper asserts connection_mutex is held, but the lock is dropped before
asynchronous commits reach this callback. It also acquires standard mutexes,
violating the atomic context requirement.

[Severity: Medium]
Is it intentional to clear eDP sink capabilities on display disable?

Unlike hotpluggable DisplayPort monitors where capabilities must be cleared
upon physical unplug, an eDP panel is permanently attached to the system and
its capabilities are static. Erasing the capabilities on atomic_disable
causes sysfs DP capability attributes to read empty or zero whenever the
screen is in a DPMS off state or entering suspend, even though the panel
is still present.

>  	ctx->connector =3D NULL;
>  	anx7625_dp_stop(ctx);
> =20

[ ... ]

> @@ -2634,11 +2677,25 @@ anx7625_bridge_detect(struct drm_bridge *bridge, =
struct drm_connector *connector
>  	struct anx7625_data *ctx =3D bridge_to_anx7625(bridge);
>  	struct device *dev =3D ctx->dev;
>  	enum drm_connector_status status;
> +	int ret;
> =20
>  	DRM_DEV_DEBUG_DRIVER(dev, "drm bridge detect\n");
> =20
>  	status =3D anx7625_sink_detect(ctx);
>  	anx7625_audio_update_connector_status(ctx, status);
> +
> +	if (status =3D=3D connector_status_connected) {
> +		ret =3D drm_dp_sink_sync_caps(connector, &ctx->aux, NULL);
> +		if (ret)
> +			DRM_DEV_DEBUG_DRIVER(dev,
> +					     "error sink caps synchronisation (%d)\n",
> +					     ret);
> +
> +		anx7625_report_link_train(ctx, connector);
> +	} else {
> +		drm_dp_sink_reset_caps(connector);
> +	}
> +

[Severity: Medium]
Will anx7625_report_link_train() read stale hardware registers here?

During the detect phase, the DRM core is merely probing for a monitor
connection. The display pipeline has not been enabled, the sink hasn't been
powered up, and DP link training hasn't taken place yet. Reading the
negotiated link bandwidth and lane count directly from the hardware registe=
rs
at this point seems like it would yield uninitialized or stale values from a
previous display session.

These invalid values are then erroneously reported to the DRM core via
drm_dp_set_cur_link_params(), circumventing the logic of reporting them only
after successful link training.

>  	return status;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-feat_link_=
cap-v3-0-7517f4aba0f3@bootlin.com?part=3D7
