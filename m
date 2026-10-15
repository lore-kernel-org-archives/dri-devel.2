Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF519CC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 213E2112404;
	Thu, 15 Oct 2026 16:59:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFECE112404
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:59:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D604D601EF
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645E41F000C4;
 Thu, 15 Oct 2026 16:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792083578;
 bh=piAIFOeNjNJrlZEUFwH9bDBTTxQmKOcLsWOrlZMfil8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RYSJMPs67K4IQwY+3NRod8OMwrlZWzEiPz7O5hJiLEr7NhLrE2qTXkNi1r4tMRRvV
 ajZW2UMyZQJQzWb0RsjbDu8Q2KJMG0q14haVcm1FEoes2KhNv8ps+T/1G7XWxD03P1
 64mK1ZLlZ+oIVFeoRJkYLubYyBPNKVDK0tujRUXGYAbj7bCEIZKFuOYwwb3y38R9e+
 79Vf2O5tlWDatf0FliCjLUsNHNpKmgBXQseEyQzwQeUznQqKGoHzyGvW2gWJmu1WF8
 TLIZ9WTzzyEU6w3bQvy7bQ5reuonJXJXHZasRROyjdeiZHF1vDgOjBjo4cwGRTSBWM
 vAqmiYAxmdaKg==
Message-ID: <sashiko-outbox-173219@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 21/28] drm/bridge: display-connector: Implement
 readout support
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-drm-state-readout-v6-21-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-21-6cc02cd10998@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 16:59:37 +0000
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
- [Medium] drm/bridge: display-connector SRO readout aborts on missing upst=
ream state
--

commit 3d42e46c975cd0148add9f035d4abfcb174d9299
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: display-connector: Implement readout support

The display-connector bridge is the last bridge in the chain on
platforms using drm_bridge_connector. This commit implements the
atomic_sro_readout_state hook, reconstructing the bridge bus configuration
from the previous bridge's readout state and the connector's display_info.

> diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm=
/bridge/display-connector.c
> index eb3412ec30a07..7f285b7c1e84b 100644
> --- a/drivers/gpu/drm/bridge/display-connector.c
> +++ b/drivers/gpu/drm/bridge/display-connector.c
[ ... ]
> @@ -213,6 +216,65 @@ static u32 *display_connector_get_input_bus_fmts(str=
uct drm_bridge *bridge,
[ ... ]
> +static int
> +display_connector_readout_state(struct drm_bridge *bridge,
> +				struct drm_atomic_sro_state *state,
> +				struct drm_bridge_state *bridge_state,
> +				struct drm_crtc_state *crtc_state,
> +				struct drm_connector_state *conn_state)
> +{
> +	struct drm_display_info *di =3D &conn_state->connector->display_info;
> +	struct drm_bridge *prev_bridge __free(drm_bridge_put) =3D
> +		drm_bridge_get_prev_bridge(bridge);
> +
> +	if (prev_bridge) {
> +		struct drm_private_state *prev_priv_state =3D
> +			drm_atomic_sro_get_private_obj_state(state,
> +							     &prev_bridge->base);
> +		struct drm_bridge_state *prev_bridge_state;
> +
> +		if (!prev_priv_state)
> +			return -ENODEV;

[Severity: Medium]
Will this hard error abort the entire SRO readout if an upstream bridge is
missing readout support?

If the DRM core is configured to attempt readout despite missing
implementations, drm_atomic_helper_sro_readout_bridges_state() will skip
bridges lacking an atomic_sro_readout_state hook:

		if (!bridge_obj_funcs->atomic_sro_readout_state) {
			drm_warn(dev,
				 "No bridge %s readout implementation.",
				 bridge->name);
			continue;
		}

If that happens, prev_bridge will be non-NULL, but prev_priv_state will be
NULL since the core continued without allocating it. Returning -ENODEV here
causes the core to fail with a warning, rather than gracefully falling back
to default values like it does when there is no prev_bridge at all.

Should this fall back to MEDIA_BUS_FMT_FIXED instead of returning an error?

> +
> +		prev_bridge_state =3D
> +			drm_priv_to_bridge_state(prev_priv_state);
> +
> +		bridge_state->input_bus_cfg.format =3D
> +			prev_bridge_state->output_bus_cfg.format;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-drm-state-=
readout-v6-0-6cc02cd10998@kernel.org?part=3D21
