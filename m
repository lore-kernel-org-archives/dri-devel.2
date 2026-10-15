Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B51CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7717A10E796;
	Thu, 15 Oct 2026 16:05:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C115610E796
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:05:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CBFDF60120
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2F41F000C4;
 Thu, 15 Oct 2026 16:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792080330;
 bh=P4ULFg/dBSy+AbVW8OsbDVO0q928XtPQittmN5fu0kQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dpfsQo2ujPIwx+0XhJxwAsy9PaigZpgs86Ch28D0EXAf7NWbCKiBW0gX1hX6e7YEu
 F5tQ4F6k6CbFMmnl5ZLWAG2bMsdh5zJ10NZ8j4Rfv0FGYOIu0BsHRbudq+NStRIU/2
 4C8ha8y4Qd0hFut2GvlwLVtmGWE1G1/KacEvArTpF1VqF44h2lz5Puzj0jIVNGcbAo
 Gf7GpwpC2gAm/LnLfZg5tGWg+l7h3eXt0d3ubM7WcYanwQdUL8Q95gfqWEBBCZtVXv
 22SfePqB4Ivxv7+NaV1Q4KLBcYD//rkrYoplto+oY88nxWHDdwxiR25+NcB5BRVBVn
 RZAZeP2ybUXkA==
Message-ID: <sashiko-outbox-173130@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/28] drm/bridge: Handle bridges with hardware state
 readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-drm-state-readout-v6-11-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-11-6cc02cd10998@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 16:05:29 +0000
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
- [High] drm/bridge: NULL pointer dereference on disabled connectors during=
 SRO readout
- [High] drm/sro: out-of-bounds array access on concurrent connector hotplug
- [Medium] drm/bridge: SRO readout aborts on unrouted/inactive bridges
- [Low] drm/bridge: spurious WARN_ON for connectors missing SRO state
--

commit e3458795912787bd3a45246c30b0044f0dcbc3e3
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: Handle bridges with hardware state readout

This commit adds a drm_bridge_atomic_readout_priv_state wrapper that looks =
up
the connector and CRTC states for a bridge's encoder during hardware state
readout. It also provides a separate drm_private_state_funcs vtable for
bridges supporting SRO readout.

> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 9d5529765f5fb..8aa94f842634c 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
[ ... ]
> @@ -555,6 +556,64 @@ drm_bridge_atomic_create_priv_state(struct drm_priva=
te_obj *obj)
>  	return &state->base;
>  }
> =20
> +static struct drm_connector_state *
> +find_connector_state_for_encoder(struct drm_atomic_sro_state *state,
> +				struct drm_encoder *encoder)
> +{
> +	struct drm_connector_list_iter conn_iter;
> +	struct drm_connector *connector;
> +
> +	drm_connector_list_iter_begin(drm_atomic_sro_state_get_device(state),
> +				      &conn_iter);
> +	drm_for_each_connector_iter(connector, &conn_iter) {
> +		struct drm_connector_state *conn_state =3D
> +			drm_atomic_sro_get_connector_state(state, connector);

[Severity: High]
Can connector->index exceed the pre-allocated SRO array bounds here?

The SRO readout state is allocated based on dev->mode_config.num_connector.
However, if a connector is hotplugged concurrently (e.g., DP MST) or removed
during early probe, connector->index (which is assigned via IDA) can exceed
the current count.

Since drm_atomic_sro_get_connector_state() unconditionally accesses
state->connectors[index] without bounds checking, could this cause an
out-of-bounds array access if the live connector list contains newer
connectors?

> +
> +		if (WARN_ON(!conn_state))

[Severity: Low]
Will this produce a spurious WARN_ON for connectors missing SRO state?

If DRM_ATOMIC_READOUT_SKIP_MISSING_READOUT is used, connectors lacking
atomic_sro_readout_state skip readout, leaving their state NULL. This
iteration will then trigger the warning on every bridge readout for every
skipped connector during boot.

> +			continue;
> +
> +		if (encoder =3D=3D conn_state->best_encoder) {
> +			drm_connector_list_iter_end(&conn_iter);
> +			return conn_state;
> +		}
> +	}
> +	drm_connector_list_iter_end(&conn_iter);
> +
> +	return NULL;
> +}
> +
> +static int
> +drm_bridge_atomic_readout_priv_state(struct drm_private_obj *obj,
> +				     struct drm_atomic_sro_state *state,
> +				     struct drm_private_state *priv_state)
> +{
> +	struct drm_bridge *bridge =3D drm_priv_to_bridge(obj);
> +	struct drm_encoder *encoder =3D bridge->encoder;
> +	const struct drm_bridge_funcs *bridge_funcs =3D bridge->funcs;
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_bridge_state *bridge_state;
> +	struct drm_connector_state *conn_state;
> +	int ret;
> +
> +	conn_state =3D find_connector_state_for_encoder(state, encoder);
> +	if (!conn_state)
> +		return -EINVAL;

[Severity: Medium]
Will returning -EINVAL here abort the entire SRO readout for unrouted bridg=
es?

If the bootloader leaves a bridge or encoder inactive, best_encoder may be
NULL for the connector, causing find_connector_state_for_encoder() to return
NULL.

By propagating -EINVAL, the entire device's SRO readout fails and falls back
to a hardware reset, which breaks seamless display handover (fastboot) and
causes display flickering.

> +
> +	crtc_state =3D drm_atomic_sro_get_crtc_state(state, conn_state->crtc);

[Severity: High]
Can conn_state->crtc be NULL here if the display pipeline is disabled?

In a disabled or unassigned pipeline, a connector might have best_encoder
populated but lack an active CRTC. Calling drm_atomic_sro_get_crtc_state()
passes this potentially NULL crtc to drm_crtc_index(crtc):

drivers/gpu/drm/drm_atomic_sro.c:drm_atomic_sro_get_crtc_state() {
    unsigned int index =3D drm_crtc_index(crtc);
    ...
}

Will this cause a NULL pointer dereference during hardware readout?

> +	if (!crtc_state)
> +		return -EINVAL;
> +
> +	bridge_state =3D drm_priv_to_bridge_state(priv_state);
> +	if (bridge_funcs->atomic_sro_readout_state) {
> +		ret =3D bridge_funcs->atomic_sro_readout_state(
> +			bridge, state, bridge_state, crtc_state, conn_state);
> +		if (WARN_ON(ret))
> +			return ret;
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-drm-state-=
readout-v6-0-6cc02cd10998@kernel.org?part=3D11
