Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AAF606C6E8
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GachvZ+G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B75BD112747;
	Fri, 30 Oct 2026 10:54:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86711112752
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:53:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6A0ED42211
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334711F000C1;
 Fri, 30 Oct 2026 10:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793357636;
 bh=pe2slj1MW88HZ1hDpWVbzw0X1sXQAy8OkYOXye1YrDE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GachvZ+GYDlr5XcaYjTExAv/Mzy1x8SNtwmU+Pa9p5b24I4stW55LZ7vmH36y0r7m
 fw9/UrS3I4n2bDzL0CcOrHEjgZYBw4/BGJrOsQb2zfG7j/H50r/Qy4SivI6Qh7nTTH
 v/eae+JODa6C1pJIU8bWdL+FqS4YRc2e6wJmaVnbbxq1dUdKjP8C6wnObuuZahqxBm
 ViyHiaeAZNCiLW1nmHOMvbyKlhJM9pLew6NnRVbkG7K6F9/k/tBnaWf9y6vZ621v5a
 9qtAmiynDGO1rrKl1Agq2riTkDT+Ir7dQeJ0osiCGEqQuNZqOKad67YsXYmwCXObVl
 RTvydYlehC0KA==
Message-ID: <sashiko-outbox-190891@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/16] drm/atomic: Allow filling a commit with
 pristine object states
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261030-drm-reset-state-flag-v7-12-4e55eaeae683@kernel.org>
References: <20261030-drm-reset-state-flag-v7-0-4e55eaeae683@kernel.org>
 <20261030-drm-reset-state-flag-v7-12-4e55eaeae683@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 10:53:55 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/atomic: broken lease handling in drm_atomic_commit_fill_with_d=
efaults()
- [High] drm/atomic: uninitialized adjusted_mode on no-modeset reset commits
--

commit bec50b903063597d979230c48b9e1dfe0d54aa1f
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic: Allow filling a commit with pristine object states

This commit adds drm_atomic_commit_fill_with_defaults() to populate an
atomic commit with pristine default states for all leased KMS objects in
the device using their atomic_create_state() hooks.

> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 7a77051096c91..6bc0d6339f142 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
[ ... ]
> +int drm_atomic_commit_fill_with_defaults(struct drm_file *file_priv,
> +					 struct drm_atomic_commit *commit)
> +{
> +	struct drm_device *dev =3D commit->dev;
> +	struct drm_mode_config *config =3D &dev->mode_config;
> +	struct drm_crtc *crtc;
> +	struct drm_plane *plane;
> +	struct drm_connector *connector;
> +	struct drm_connector_list_iter conn_iter;
> +	struct drm_colorop *colorop;
> +	int ret;
> +
> +	drm_WARN_ON(dev, !commit->acquire_ctx);
> +
> +	/*
> +	 * Private objects are ignored because none have userspace
> +	 * properties we might want to reset. atomic_check
> +	 * implementations will derive or infer their private obj state
> +	 * from the state that will end up being committed anyway.
> +	 *
> +	 * The CRTCs are handled before the planes and connectors so that,
> +	 * when those pull the CRTC they are currently bound to into the
> +	 * commit, a leased CRTC is already there with its pristine state
> +	 * while an unleased one gets duplicated and keeps its current
> +	 * state.
> +	 */
> +	drm_for_each_crtc(crtc, dev) {
> +		struct drm_crtc_state *crtc_state;
> +
> +		if (!drm_lease_held(file_priv, crtc->base.id))
> +			continue;
> +
> +		ret =3D drm_modeset_lock(&crtc->mutex, commit->acquire_ctx);
> +		if (ret)
> +			return ret;
> +
> +		crtc_state =3D crtc->funcs->atomic_create_state(crtc);
> +		if (IS_ERR(crtc_state))
> +			return PTR_ERR(crtc_state);
[ ... ]
> +		drm_atomic_commit_set_crtc_state(commit, crtc, crtc_state);
> +	}
> +
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
> +		 * Make sure the CRTC the plane is currently enabled on is
> +		 * part of the commit, like drm_atomic_set_crtc_for_plane()
> +		 * does when userspace disables a plane. The atomic helpers
> +		 * need the CRTC state to update planes_changed and track
> +		 * the commit, and would dereference a NULL CRTC state
> +		 * otherwise.
> +		 */
> +		if (plane->state->crtc) {
> +			struct drm_crtc_state *crtc_state;
> +
> +			crtc_state =3D drm_atomic_get_crtc_state(commit,
> +							       plane->state->crtc);
> +			if (IS_ERR(crtc_state))
> +				return PTR_ERR(crtc_state);
> +		}
> +
> +		plane_state =3D plane->funcs->atomic_create_state(plane);
> +		if (IS_ERR(plane_state))
> +			return PTR_ERR(plane_state);
[ ... ]
> +		drm_atomic_commit_set_plane_state(commit, plane, plane_state);
> +	}
[ ... ]
> +	drm_connector_list_iter_begin(dev, &conn_iter);
> +	drm_for_each_connector_iter(connector, &conn_iter) {
> +		struct drm_connector_state *connector_state;
> +		struct drm_crtc_state *crtc_state;
> +
> +		if (!drm_lease_held(file_priv, connector->base.id)) {
> +			/*
> +			 * The connector isn't part of the lease so it keeps
> +			 * its current state, but if it is bound to a CRTC
> +			 * that is part of the commit, pull it in like
> +			 * drm_atomic_add_affected_connectors() would do on a
> +			 * regular commit, so that its routing and encoder
> +			 * are properly handled.
> +			 */
> +			if (!connector->state->crtc)
> +				continue;
> +
> +			if (!drm_atomic_get_new_crtc_state(commit,
> +							   connector->state->crtc))
> +				continue;
> +
> +			connector_state =3D drm_atomic_get_connector_state(commit,
> +									 connector);
> +			if (IS_ERR(connector_state)) {
> +				drm_connector_list_iter_end(&conn_iter);
> +				return PTR_ERR(connector_state);
> +			}
> +
> +			continue;
> +		}
> +
> +		/*
> +		 * drm_atomic_implements_create_state() already checked
> +		 * this, but connectors can be hotplugged between that
> +		 * lockless check and the iteration here.
> +		 */
> +		if (!connector->funcs->atomic_create_state) {
> +			drm_connector_list_iter_end(&conn_iter);
> +			return -EOPNOTSUPP;
> +		}
> +
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
> +		 * that keep the connector routing unchanged, let's carry
> +		 * the encoder currently in use over so that a reset on
> +		 * which userspace re-applies the exact same configuration
> +		 * doesn't require a modeset.
> +		 */
> +		connector_state->best_encoder =3D connector->state->best_encoder;

[Severity: High]
When connector_state->best_encoder is carried over so that re-applying the
same active configuration on a reset commit avoids a modeset, does
new_crtc_state->adjusted_mode remain all zeroes?

In drm_atomic_commit_fill_with_defaults(), crtc->funcs->atomic_create_state=
()
creates a pristine state with a zeroed adjusted_mode. If userspace then
re-applies the current mode and connector routing in the same commit,
drm_atomic_set_mode_prop_for_crtc() updates new_crtc_state->mode and sets
new_crtc_state->enable =3D true, while both new_crtc_state->mode_changed and
new_crtc_state->connectors_changed remain false in
drm_atomic_helper_check_modeset().

In drivers/gpu/drm/drm_atomic_helper.c:mode_fixup():

	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
		if (!new_crtc_state->mode_changed &&
		    !new_crtc_state->connectors_changed)
			continue;

		drm_mode_copy(&new_crtc_state->adjusted_mode, &new_crtc_state->mode);
	}

Because neither flag is set, mode_fixup() skips copying mode into
adjusted_mode. That leaves new_crtc_state->adjusted_mode zeroed (with
crtc_clock =3D=3D 0) on an enabled crtc, passing a zeroed adjusted_mode to
bridge, encoder, and crtc check hooks and causing
drm_atomic_helper_calc_timestamping_constants() ->
drm_calc_timestamping_constants() to warn and zero out vblank timing
constants during commit.

Should crtc_state->adjusted_mode also be copied from
crtc->state->adjusted_mode in drm_atomic_commit_fill_with_defaults(), or
should mode_fixup() populate adjusted_mode when resetting?

> +
> +		ret =3D drm_atomic_commit_set_connector_state(commit, connector, conne=
ctor_state);
> +		if (ret) {
> +			connector->funcs->atomic_destroy_state(connector, connector_state);
> +			drm_connector_list_iter_end(&conn_iter);
> +			return ret;
> +		}
> +
> +		/*
> +		 * Make sure the CRTC the connector is currently bound to
> +		 * is part of the commit, like drm_atomic_get_connector_state()
> +		 * does, so that the atomic helpers can update the CRTC
> +		 * state and the connector routing.
> +		 */
> +		if (connector->state->crtc) {
> +			crtc_state =3D drm_atomic_get_crtc_state(commit,
> +							       connector->state->crtc);
> +			if (IS_ERR(crtc_state)) {
> +				drm_connector_list_iter_end(&conn_iter);
> +				return PTR_ERR(crtc_state);
> +			}
> +		}
> +	}

[Severity: High]
As reported by Sashiko on v6 [1], can resetting a subset of objects for a
lessee leave crtc_state->plane_mask, crtc_state->connector_mask, and
cross-lease object routing inconsistent in
drm_atomic_commit_fill_with_defaults()?

First, when a leased plane or leased connector is currently bound to an
unleased crtc, drm_atomic_get_crtc_state() duplicates the unleased crtc's
current state into the commit, keeping drm_plane_mask(plane) in
crtc_state->plane_mask and drm_connector_mask(connector) in
crtc_state->connector_mask. The leased plane or connector is then given a
pristine state with crtc =3D NULL via atomic_create_state(), but unlike
drm_atomic_set_crtc_for_plane() and drm_atomic_set_crtc_for_connector(),
nothing clears those mask bits from the unleased crtc_state. In addition, if
an unleased connector cloned onto that same unleased crtc is visited earlier
in the connector loop than the leased connector,
drm_atomic_get_new_crtc_state(commit, connector->state->crtc) returns NULL
because the unleased crtc is only added to the commit later when the leased
connector is processed.

Second, when an unleased connector or unleased plane is currently bound to a
leased crtc, the leased crtc receives a pristine state with enable =3D fals=
e,
plane_mask =3D 0, and connector_mask =3D 0. For an unleased connector bound=
 to
that leased crtc, the !drm_lease_held() branch calls
drm_atomic_get_connector_state(), duplicating connector->state with
connector_state->crtc still pointing to the disabled pristine crtc while
crtc_state->connector_mask is 0. In drm_atomic_helper_check_modeset(),
update_connector_routing() keeps the connector routed to the disabled crtc,
causing mode_valid() and mode_fixup() to validate against a zeroed mode or
leaving crtc_state->connector_mask missing the unleased connector if the
crtc is re-enabled. Likewise, an unleased plane bound to the leased crtc is
skipped in the plane loop and later pulled in by
drm_atomic_add_affected_planes() with its active state still bound to the
reset crtc, failing drm_atomic_helper_check_plane_state() when the crtc is
disabled or missing from crtc_state->plane_mask if re-enabled.

Third, drm_lease_held() acquires and releases mode_config.idr_mutex on each
individual call across the four loops (crtcs, planes, colorops, and
connectors). If drm_mode_revoke_lease_ioctl() -> drm_lease_revoke() runs
concurrently after the crtc loop has already inserted pristine disabled crtc
states, the subsequent plane and connector loops see drm_lease_held() return
false and treat the lessee's planes and connectors as unleased objects bound
to those reset crtcs.

[1] https://lore.kernel.org/r/20261022-drm-reset-state-flag-v6-11-f36d640b7=
e76@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-drm-reset-=
state-flag-v7-0-4e55eaeae683@kernel.org?part=3D12
