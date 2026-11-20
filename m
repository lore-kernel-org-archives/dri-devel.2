Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADAA606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CgQMy7mD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90099112A55;
	Fri, 20 Nov 2026 13:38:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7C25112A7D
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:38:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A801845774
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01881F000C0;
 Fri, 20 Nov 2026 13:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795181898;
 bh=d1l0ZMbzTWIz3Ov+pfpWOOmxFqrpLEQqXOhqCw2WO2A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CgQMy7mDpenVRPhJc3BuBcHyOavx4mornd4BF5Hz0ut45nYrlkpxsVlOQQY1fkAdj
 UcA0o8IuWC42sMfEX8qoKHLp87pDuhtpx7Z2rEfsQr4Obn4rbwt1O+XbnR2vOoQc7j
 PbLHklw71fbM5h+h/7T2IilGTZxgMvn90IMCHJy8naw5xFwKbK0nPuESMs/tM8o2na
 d3ILiWP5wrhIMdDa2J6uDBrBo5kGBSaNhS1wOiDNrfi7g+GgITrUpJu12Eer1k9Vnc
 uR+bhi/9xWPrDfOzpWaQB7HOA626A3oYeJW22LLyQIJxvGiNFi6G+LRBqZHYDyA2bu
 dAuSUD2RRSMBA==
Message-ID: <sashiko-outbox-225256@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 3/9] drm/atomic: Allow filling a commit with
 pristine object states
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261120-drm-reset-state-flag-v12-3-42d63d7417fc@kernel.org>
References: <20261120-drm-reset-state-flag-v12-0-42d63d7417fc@kernel.org>
 <20261120-drm-reset-state-flag-v12-3-42d63d7417fc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:38:17 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/atomic: lost driver state in
  drm_atomic_commit_fill_with_defaults()
--

commit 5edb49cfe4c7062b503d63439cf904e87048fe2c
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic: Allow filling a commit with pristine object states

This commit adds drm_atomic_commit_fill_with_defaults() to populate an
atomic commit with freshly created default object states via the
atomic_create_state() hooks while carrying over adjusted_mode and
best_encoder.

> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 7a77051096c91..43df13aaef1eb 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -1649,6 +1649,327 @@ bool drm_atomic_implements_create_state(struct dr=
m_device *dev)
>  }
>  EXPORT_SYMBOL(drm_atomic_implements_create_state);
> =20
[ ... ]
> +int drm_atomic_commit_fill_with_defaults(struct drm_file *file_priv,
> +					 struct drm_atomic_commit *commit)
> +{
[ ... ]
> +	drm_for_each_crtc(crtc, dev) {
> +		struct drm_crtc_state *crtc_state;
[ ... ]
> +		crtc_state =3D crtc->funcs->atomic_create_state(crtc);
> +		if (IS_ERR(crtc_state))
> +			return PTR_ERR(crtc_state);
[ ... ]
> +		drm_mode_copy(&crtc_state->adjusted_mode,
> +			      &crtc->state->adjusted_mode);
> +
> +		/*
> +		 * The planes come back with the default zpos, which the
> +		 * atomic helpers only normalize when the planes bound to a
> +		 * CRTC or one of their zpos changed. Re-applying the same
> +		 * configuration on top of the reset wouldn't trigger
> +		 * either, so ask for a normalization explicitly.
> +		 */
> +		crtc_state->zpos_changed =3D true;
> +
> +		drm_atomic_commit_set_crtc_state(commit, crtc, crtc_state);
> +	}
> +
> +	drm_for_each_plane(plane, dev) {
> +		struct drm_plane_state *plane_state;
[ ... ]
> +		plane_state =3D plane->funcs->atomic_create_state(plane);
> +		if (IS_ERR(plane_state))
> +			return PTR_ERR(plane_state);
[ ... ]
> +		drm_atomic_commit_set_plane_state(commit, plane, plane_state);
> +	}
> +
> +	ret =3D drm_modeset_lock(&config->connection_mutex, commit->acquire_ctx=
);
> +	if (ret)
> +		return ret;
> +
> +	drm_connector_list_iter_begin(dev, &conn_iter);
> +	drm_for_each_connector_iter(connector, &conn_iter) {
> +		struct drm_connector_state *connector_state;
[ ... ]
> +		connector_state =3D connector->funcs->atomic_create_state(connector);
> +		if (IS_ERR(connector_state)) {
> +			drm_connector_list_iter_end(&conn_iter);
> +			ret =3D PTR_ERR(connector_state);
> +			return ret;
> +		}
> +
> +		/*
> +		 * best_encoder is a routing information maintained by the
> +		 * atomic helpers rather than a userspace property, and it
> +		 * is only carried over to a new state when that state is a
> +		 * duplicate of the current one. Since
> +		 * update_connector_routing() uses it to detect the commits
> +		 * that keep the connector routing unchanged, carry the
> +		 * encoder currently in use over so that a reset on which
> +		 * userspace re-applies the exact same configuration doesn't
> +		 * require a modeset.
> +		 */
> +		connector_state->best_encoder =3D connector->state->best_encoder;

[Severity: High]
Does building the commit from atomic_create_state() while carrying over
adjusted_mode and best_encoder lose driver-private state in drivers where
drm_atomic_implements_create_state() is true?

When userspace re-applies the current mode and connector routing on top of
a reset, carrying over adjusted_mode and best_encoder keeps mode_changed
and connectors_changed false, while the new CRTC, plane, and connector
states have their driver-private fields zero-initialized instead of copied
from the current state.

In msm/mdp5 (which implements mdp5_crtc_create_state(),
mdp5_plane_create_state(), and drm_bridge_connector_create_state()),
mdp5_plane_atomic_check_with_state() releases the old hardware pipes from
mdp5_state->hwpipe and mdp5_state->r_hwpipe on the new plane state.
Because mdp5_plane_create_state() leaves those pointers NULL, resetting an
active plane passes NULL to mdp5_pipe_release() and permanently leaks the
assigned pipes in mdp5_global_state->hwpipe.hwpipe_to_plane[].  If a reset
keeps a CRTC active with no visible planes, mdp5_crtc_atomic_check() also
returns before mdp5_crtc_setup_pipeline(), leaving
mdp5_cstate->pipeline.mixer NULL and causing a NULL pointer dereference in
blend_setup() during mdp5_crtc_atomic_flush().

In nouveau dispnv50 (nv50_head_create_state(), nv50_wndw_create_state(),
and nouveau_conn_atomic_create_state()), skipping a modeset leaves
asyh->mode, asyh->view, asyh->or, and asyh->wndw.owned zeroed in the CRTC
state because nv50_outp_atomic_check() and nv50_head_atomic_check() only
recompute them when mode_changed or connectors_changed is set.  On planes
kept enabled with the same framebuffer, nv50_wndw_atomic_check_acquire()
skips populating asyw->image when modeset is false, causing
curs507a_acquire() to reject cursor commits with -EINVAL (asyw->image.w =3D=
=3D
0) and zeroing asyw->ntfy.handle, asyw->sema.handle, and asyw->xlut.handle
so they are not cleaned up on later disables.  Resetting a modified
connector property back to its default without a modeset also leaves
asyc->set.mask at 0 because nouveau_conn_atomic_set_property() compares
against the newly created default state, skipping hardware reprogramming.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-drm-reset-=
state-flag-v12-0-42d63d7417fc@kernel.org?part=3D3
