Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD512606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KDpK3sT9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D32C10EF34;
	Mon, 16 Nov 2026 10:41:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E217210EF34
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:41:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2DE5262881
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB4E1F000C4;
 Mon, 16 Nov 2026 10:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825702;
 bh=NkLbhra8WY9BaomVeiqg129uR9/CcHZWVfxxlzRAFc8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KDpK3sT9xSLg93pum6K51Dr+smlxXQZSRhoQt7tYXnxMt0m27lb5h8NG/PXCqoBfY
 SEYYrX5SDCkMvNxxuoro7uFhgFrWtsZS7retP4aI0DlzqAAYE37FyAgnxqQweYvXho
 TI5ExZQ9Gn9Xyvi0yLg3q+her6tRNnW/HKeSXv7C7Ttwyo5vsNcHasvFpNl6as48or
 KVW6FrKtthplP9W93Bvqs50CHqgmGBYPNxU48uCrjBmklAevUUeRg+SeCXbR39AH3f
 suZ1KJaGtg2eAx4XZ/fQn6A3vQcgYyJhiI7un1Xf7d0H63lduU0eHzoRC9Woc2nMIZ
 rxKeQynVX/3jg==
Message-ID: <sashiko-outbox-216752@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 3/9] drm/atomic: Allow filling a commit with
 pristine object states
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261116-drm-reset-state-flag-v11-3-378b3f7bef32@kernel.org>
References: <20261116-drm-reset-state-flag-v11-0-378b3f7bef32@kernel.org>
 <20261116-drm-reset-state-flag-v11-3-378b3f7bef32@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 10:41:42 +0000
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

commit da151559e1bf404876508e3465b551e3f9d62af2
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic: Allow filling a commit with pristine object states

This commit adds drm_atomic_commit_fill_with_defaults() to populate an
atomic commit with pristine object states created via atomic_create_state()
while preserving adjusted_mode and best_encoder.

> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 7a77051096c91..43df13aaef1eb 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -1649,6 +1649,327 @@ bool drm_atomic_implements_create_state(struct dr=
m_device *dev)
>  }
>  EXPORT_SYMBOL(drm_atomic_implements_create_state);
> =20
> +int drm_atomic_commit_fill_with_defaults(struct drm_file *file_priv,
> +					 struct drm_atomic_commit *commit)
> +{

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

[ ... ]

> +		plane_state =3D plane->funcs->atomic_create_state(plane);
> +		if (IS_ERR(plane_state))
> +			return PTR_ERR(plane_state);

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
Does creating fresh states via atomic_create_state() while carrying over
adjusted_mode and best_encoder to avoid a modeset drop required
driver-private state in drivers that satisfy
drm_atomic_implements_create_state()?

In msm/mdp5, mdp5_plane_create_state() zeroes mdp5_state->hwpipe and
r_hwpipe, so mdp5_plane_atomic_check_with_state() passes NULL to
mdp5_pipe_release() and permanently leaks the previously assigned hardware
pipes in mdp5_global_state; if a CRTC stays active with no visible planes,
mdp5_crtc_atomic_check() also skips mdp5_crtc_setup_pipeline(), leaving
mdp5_cstate->pipeline.mixer NULL and causing a NULL pointer dereference in
blend_setup() during mdp5_crtc_atomic_flush().

In nouveau dispnv50, skipping a modeset when the active configuration is
re-applied across a reset causes nv50_wndw_atomic_check_acquire() to skip
populating asyw->image when the framebuffer is unchanged (making
curs507a_acquire() reject cursor commits with -EINVAL and zeroing
asyw->ntfy, sema, xlut, and csc handles on primary/overlay planes), leaves
asyh->mode, view, or, dither, procamp, and wndw.owned zeroed in
nv50_head_atomic_check(), and leaves asyc->set.mask zeroed when connector
properties are reset to their defaults.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-drm-reset-=
state-flag-v11-0-378b3f7bef32@kernel.org?part=3D3
