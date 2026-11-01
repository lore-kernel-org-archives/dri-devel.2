Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF4D606A325
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 04:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LI7vVtot
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F5A610E0C4;
	Sun,  1 Nov 2026 04:01:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67FD510E0C4;
 Sun,  1 Nov 2026 04:00:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 63C7E60054;
 Sun,  1 Nov 2026 04:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFEB1F000C1;
 Sun,  1 Nov 2026 04:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793505657;
 bh=PQtN2DmMlArm43iuRLPKfe5SvdgsrJvBIl/lGzqsfFU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LI7vVtotfFHm8BvbxglIHYJy9jWZj90uVASPODn+ziEhPwMp59cP6vDZSsQ9kL9Fh
 KEFZO3j6riYXMAzSkqFvh9/VZ+QYk0NhJ5nJWgvgzRj7cn1HJmNHFFZ0lvPdtZjVaN
 GIh6OFTQB6YFzeeIl1cvYSOxWpvfsRjZfNViRLdoLHgTH7UHhKGhXmrsvCRtXu40ZQ
 ZlMNtJIyCv98lI0zBxAooT+OjTWk+Bwb04KzsR4ql7LM90auWDBx3HwsXdhGsSx4gQ
 KdjGLb8gDBAhwhcexSC4l/Z6DcEl4sioGATYUpG1AUOYTNlNRDMpZDsjhtzQdGfprP
 iR4cBV5gDF67g==
Message-ID: <sashiko-outbox-192266@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/i915/dp_mst: Skip link retrain and the ACT
 wait for disconnected MST streams
To: "Xiao Lu" <xiaolu.xie@intel.com>, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261101033535.2078860-3-xiaolu.xie@intel.com>
References: <20261101033535.2078860-1-xiaolu.xie@intel.com>
 <20261101033535.2078860-3-xiaolu.xie@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 04:00:56 +0000
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
- [Medium] drm/i915/dp_mst: missing topology check in mst_connector_stream_=
disconnected()
--

commit b28e17eee0029b86851cad8de209d49fbc2f0399
Author: Xiao Lu <xiaolu.xie@intel.com>

drm/i915/dp_mst: Skip link retrain and the ACT wait for disconnected MST st=
reams

This commit skips link retraining when all active pipes on an MST link are
bound to disconnected MST sinks, and avoids waiting for a branch ACT during
stream enable or disable when no payload change was sent to the branch.

Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17741

> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/dr=
m/i915/display/intel_dp_mst.c
> index 7023619aaaba9..ecc7b105e6408 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c

[ ... ]

> @@ -2172,6 +2178,20 @@ bool intel_dp_mst_crtc_needs_modeset(struct intel_=
atomic_state *state,
>  	return false;
>  }
> =20
> +static bool mst_connector_stream_disconnected(struct intel_connector *co=
nnector)
> +{
> +	if (!connector->mst.dp)
> +		return false;
> +
> +	if (!connector->mst.dp->mst.mgr.mst_state)
> +		return true;
> +
> +	if (drm_connector_is_unregistered(&connector->base))
> +		return true;
> +
> +	return false;
> +}
> +
>  bool intel_dp_mst_stream_disconnected(struct intel_atomic_state *state,
>  				      const struct intel_crtc *crtc)
>  {
> @@ -2181,16 +2201,39 @@ bool intel_dp_mst_stream_disconnected(struct inte=
l_atomic_state *state,
>  	if (!connector)
>  		return false;
> =20
> -	if (!connector->mst.dp)
> -		return false;
> +	return mst_connector_stream_disconnected(connector);
> +}
> =20
> -	if (!connector->mst.dp->mst.mgr.mst_state)
> -		return true;
> +/**
> + * intel_dp_mst_disconnected_pipes - get the pipes driving disconnected =
MST streams
> + * @intel_dp: DP port object
> + *
> + * Returns the mask of pipes whose MST connector has left the topology, =
so
> + * there is no sink behind them. The caller must hold
> + * &drm_mode_config.connection_mutex.
> + */
> +u8 intel_dp_mst_disconnected_pipes(struct intel_dp *intel_dp)
> +{
> +	struct intel_display *display =3D to_intel_display(intel_dp);
> +	struct drm_connector_list_iter conn_iter;
> +	struct intel_connector *connector;
> +	u8 pipe_mask =3D 0;
> =20
> -	if (drm_connector_is_unregistered(&connector->base))
> -		return true;
> +	drm_connector_list_iter_begin(display->drm, &conn_iter);
> +	for_each_intel_connector_iter(connector, &conn_iter) {
> +		struct drm_connector_state *conn_state =3D connector->base.state;
> =20
> -	return false;
> +		if (connector->mst.dp !=3D intel_dp || !conn_state->crtc)
> +			continue;
> +
> +		if (mst_connector_stream_disconnected(connector) ||
> +		    !drm_dp_mst_port_downstream_of_parent(&intel_dp->mst.mgr,
> +							  connector->mst.port, NULL))

[Severity: Medium]
As reported by Sashiko on v1 [1], should the
drm_dp_mst_port_downstream_of_parent() check live inside
mst_connector_stream_disconnected() instead of only in
intel_dp_mst_disconnected_pipes()?

When an MST port or branch leaves the topology while another stream on the
link stays connected (or after upstream HPD reconnects with a new primary
branch), connector->mst.port is unlinked from mgr.mst_primary before
mgr->delayed_destroy_work asynchronously unregisters the connector.

If intel_dp_retrain_link() or a modeset runs during that window,
intel_link_bw_init_limits() calls intel_dp_mst_stream_disconnected():

drivers/gpu/drm/i915/display/intel_link_bw.c:intel_link_bw_init_limits() {
	...
		if ((state->base.duplicated && crtc_state) ||
		    intel_dp_mst_stream_disconnected(state, crtc)) {
			limits->max_bpp_x16[pipe] =3D crtc_state->max_link_bpp_x16;
			if (intel_dsc_enabled_on_link(crtc_state))
				limits->link_dsc_pipes |=3D BIT(pipe);
		} else {
			limits->max_bpp_x16[pipe] =3D INT_MAX;
		}
	...
}

Because mst_connector_stream_disconnected() does not check
drm_dp_mst_port_downstream_of_parent(), intel_dp_mst_stream_disconnected()
returns false while mgr.mst_state is true and the connector is not yet
unregistered. Could that reset limits->max_bpp_x16[pipe] to INT_MAX and drop
limits->link_dsc_pipes for the disconnected stream, allowing its recomputed
TU allocation to exceed mst_state->total_avail_slots in
drm_dp_mst_atomic_check_payload_alloc_limits()?

[1] https://lore.kernel.org/r/sashiko-outbox-192037@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101033535.2078=
860-1-xiaolu.xie@intel.com?part=3D2
