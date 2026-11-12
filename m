Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35235606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U0T7yCwg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92355112256;
	Thu, 12 Nov 2026 17:16:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6C1A112256
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 17:16:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EF63461D4F
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 17:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DEC1F000C6;
 Thu, 12 Nov 2026 17:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794503775;
 bh=WC/klGoPzQuyDpdRaW0lt6Lwcew5b2xI59mfI1qu9y4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=U0T7yCwgkFj0sKNw2dbyxr7MzbogxgSXp32e5v5sxHgvmO6Ql2N8L7fcaqPBwzuWB
 C5KxfYUqfAiHg+OhEwAMOE/eupNnOasCLG2RBl3hhdFTx68wmck+OIgMrpjN209DKj
 oFTyhEm1eByUbfX4WZttRWfo8iQBIsW44tJWPeiAgNU2+fpdKPAfbTzq7FDP9NmOUw
 g+/CkbE20eFMTxUV4vYL7byageH6O+WhWT1LOl1+o6VzBi58IwJHWG+z38PFC3iDI7
 FRcPE2UIZNSMliC4w2FXlP5cMAH7nk9iYGWXyFFHN7Or2dhLjxXo0Qt0vrT5P76VTO
 BMxPjoV028e+Q==
Message-ID: <sashiko-outbox-211576@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/9] drm/atomic: Allow filling a commit with
 pristine object states
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261112-drm-reset-state-flag-v10-3-cefaa1ed056d@kernel.org>
References: <20261112-drm-reset-state-flag-v10-0-cefaa1ed056d@kernel.org>
 <20261112-drm-reset-state-flag-v10-3-cefaa1ed056d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 17:16:14 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/atomic: lost driver state in
  drm_atomic_commit_fill_with_defaults()
- [Medium] drm/atomic: race with lease revoke in
  drm_atomic_commit_fill_with_defaults()
--

commit 5078d7ac25f2348a94f9d3158195c6d51b1f515d
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic: Allow filling a commit with pristine object states

This commit adds drm_atomic_commit_fill_with_defaults() to populate an atom=
ic
commit with pristine object states created via atomic_create_state() for all
leased CRTCs, planes, connectors, and colorops.

> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 7a77051096c91..4fcce3bb0aa11 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -1649,6 +1649,291 @@ bool drm_atomic_implements_create_state(struct dr=
m_device *dev)

[ ... ]

> +int drm_atomic_commit_fill_with_defaults(struct drm_file *file_priv,
> +					 struct drm_atomic_commit *commit)
> +{

[ ... ]

> +	drm_for_each_plane(plane, dev) {
> +		struct drm_plane_state *plane_state;
> +
> +		if (!drm_lease_held(file_priv, plane->base.id))
> +			continue;
> +
> +		ret =3D drm_modeset_lock(&plane->mutex, commit->acquire_ctx);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * The pristine state detaches the plane from the CRTC it
> +		 * is enabled on, which the atomic helpers can only sort
> +		 * out with that CRTC in the commit. Resetting a plane
> +		 * enabled on a CRTC that isn't leased would thus require
> +		 * touching an object the lease doesn't cover, so report it
> +		 * like any other access outside of the lease.
> +		 */
> +		if (plane->state->crtc &&
> +		    !drm_lease_held(file_priv, plane->state->crtc->base.id)) {
> +			drm_dbg_atomic(dev,
> +				       "[PLANE:%d:%s] is enabled on [CRTC:%d:%s], which isn't leased=
\n",
> +				       plane->base.id, plane->name,
> +				       plane->state->crtc->base.id,
> +				       plane->state->crtc->name);
> +			return -ENOENT;
> +		}
> +
> +		plane_state =3D plane->funcs->atomic_create_state(plane);
> +		if (IS_ERR(plane_state))
> +			return PTR_ERR(plane_state);
> +
> +		/*
> +		 * Same thing for the planes: report a color pipeline change
> +		 * compared to the current state.
> +		 */
> +		plane_state->color_mgmt_changed =3D
> +			plane->state->color_pipeline !=3D plane_state->color_pipeline;
> +
> +		drm_atomic_commit_set_plane_state(commit, plane, plane_state);
> +	}
> +
> +	drm_for_each_crtc(crtc, dev) {
> +		struct drm_crtc_state *crtc_state;
> +
> +		if (!drm_lease_held(file_priv, crtc->base.id))
> +			continue;

[Severity: Medium]
Can a concurrent lease revocation between the plane, CRTC, and connector
loops leave a split pipeline in commit and cause a NULL pointer dereference?

drm_lease_held() takes and drops mode_config.idr_mutex on each call, while
drm_lease_revoke() clears master->leases under idr_mutex without holding any
modeset locks:

CPU0 (lessee atomic reset)        CPU1 (lessor revoke)
drm_atomic_commit_fill_with_defaults()
  drm_for_each_plane()
    drm_lease_held(plane) -> true
    drm_lease_held(plane->state->crtc) -> true
    drm_atomic_commit_set_plane_state()
      /* old->crtc =3D crtc, new->crtc =3D NULL */
                                  drm_mode_revoke_lease_ioctl()
                                    drm_lease_revoke()
                                      idr_destroy(&master->leases)
  drm_for_each_crtc()
    drm_lease_held(crtc) -> false (skipped)
  drm_for_each_connector_iter()
    drm_lease_held(conn) -> false
    drm_lease_held(conn->state->crtc) -> false
  return 0
...
drm_atomic_helper_setup_commit()
  crtc_or_fake_commit(state, old_plane_state->crtc)
    new_crtc_state =3D drm_atomic_get_new_crtc_state(state, crtc)
    return new_crtc_state->commit;  <-- NULL pointer dereference

Similarly, if the lease is revoked between the CRTC loop and the connector
loop, a leased CRTC is added to commit with a disabled pristine state while
the connector bound to it is skipped because drm_lease_held() returns false
for both the connector and connector->state->crtc, leaving the connector
bound to a disabled CRTC.

> +		ret =3D drm_modeset_lock(&crtc->mutex, commit->acquire_ctx);
> +		if (ret)
> +			return ret;

[ ... ]

> +		crtc_state =3D crtc->funcs->atomic_create_state(crtc);
> +		if (IS_ERR(crtc_state))
> +			return PTR_ERR(crtc_state);

[ ... ]

> +		drm_mode_copy(&crtc_state->adjusted_mode,
> +			      &crtc->state->adjusted_mode);

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
Does carrying over adjusted_mode and best_encoder onto pristine states crea=
ted
via atomic_create_state() break drivers that rely on persistent driver-priv=
ate
state when a commit does not trigger a modeset?

When userspace re-applies the active mode and connector routing on top of a
reset, mode_changed and connectors_changed remain false, so drivers skip
modeset recomputation even though atomic_create_state() zeroed their private
state subclass fields and drm_private_obj states were not reset.  For drive=
rs
where drm_atomic_implements_create_state() returns true without dedicated
state carry-over handling:

- In msm/mdp5, mdp5_plane_create_state() zeroes mdp5_state->hwpipe, so
  mdp5_plane_atomic_check_with_state() never releases the previous hwpipe in
  mdp5_global_state->hwpipe.hwpipe_to_plane[], permanently leaking hardware
  pipes.  If a CRTC stays active with no visible planes,
  mdp5_crtc_atomic_check() returns early before mdp5_crtc_setup_pipeline(),
  leaving mdp5_cstate->pipeline.mixer NULL while mdp5_cstate->ctl is set and
  causing a NULL pointer dereference in blend_setup() during
  mdp5_crtc_atomic_flush():

drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c:blend_setup() {
    ...
	struct mdp5_hw_mixer *mixer =3D mdp5_cstate->pipeline.mixer;
	uint32_t lm =3D mixer->lm;
    ...
}

- In nouveau dispnv50, nv50_wndw_atomic_check_acquire() skips rebuilding
  asyw->image when the framebuffer is unchanged and no modeset is requested,
  so curs507a_acquire() sees a zeroed asyw->image.w and rejects cursor
  commits with -EINVAL, while primary/overlay planes lose asyw->ntfy.handle
  and asyw->xlut.handle.  nv50_head_atomic_check() also skips
  nv50_head_atomic_check_mode() when mode_changed and connectors_changed are
  false, leaving asyh->mode, asyh->view, and asyh->or zeroed, and resetting
  connector properties via nouveau_conn_atomic_create_state() leaves
  asyc->set.mask at 0 so scaler, dither, and procamp hardware state is not
  reprogrammed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-drm-reset-=
state-flag-v10-0-cefaa1ed056d@kernel.org?part=3D3
