Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03253606A326
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HvsEJrAy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3626210E02C;
	Tue, 10 Nov 2026 16:49:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B88E510E142
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:49:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5DC2143AE9
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230181F008A2;
 Tue, 10 Nov 2026 16:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794329382;
 bh=bzslCrHQCwB8fYjytqgsR/UGO4YI5hP89ZJZZA3PW2w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HvsEJrAyrBQrbc2/SlSlVHmK825Rj6bClNnkRAFfx+pVEdooukjrw2kkpmovCsU8G
 jN0+RTwSBvj8ULhAl+KGO8CIX/2YILw98OJEGf+XUNmBgH9O6ghsAmMVrq3l3RwkIZ
 nbinAVs+GCCiAcwDCk9087B/HO0YUl2g5Wr01vsgobKAvkGs2ekjLWrYqKdjMk6qPk
 xe90vDSYsEp/6Lr/LJTIp5fGdEfnIf2GEorv7m/ajFq3+RRDW37MwJZnpIOEJkcGnm
 hdvexTSN4UXGNd20OFGYwWbY5uVCiTWeoDdM9UAEFdqiqd3NQVgsjjft05TcyuVZjj
 oaagi56qj8Kaw==
Message-ID: <sashiko-outbox-207416@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 04/10] drm/atomic: Allow filling a commit with
 pristine object states
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-drm-reset-state-flag-v9-4-ddb0e26324a0@kernel.org>
References: <20261110-drm-reset-state-flag-v9-0-ddb0e26324a0@kernel.org>
 <20261110-drm-reset-state-flag-v9-4-ddb0e26324a0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 16:49:41 +0000
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
- [High] drm/atomic: race on plane->state in
  drm_atomic_commit_fill_with_defaults()
- [High] drm/atomic: preserve normalized_zpos in
  drm_atomic_commit_fill_with_defaults()
- [Medium] drm/atomic: unleased connector pull in
  drm_atomic_commit_fill_with_defaults()
--

commit 0fce0c540da05484e00eeed0228bcc4903e9743e
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic: Allow filling a commit with pristine object states

This commit adds drm_atomic_commit_fill_with_defaults() to populate an
atomic commit with pristine default states for CRTCs, connectors, planes,
and color operations via atomic_create_state().

> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 7a77051096c91..b469a8169ca6d 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c

[ ... ]

> +static int drm_atomic_commit_fill_connector_with_defaults(struct drm_fil=
e *file_priv,
> +							  struct drm_atomic_commit *commit,
> +							  struct drm_connector *connector)
> +{

[ ... ]

> +	} else {
> +		/*
> +		 * The connector isn't part of the lease so it keeps its
> +		 * current state. If it is bound to a leased CRTC though,
> +		 * that CRTC is being reset under it and comes with an
> +		 * empty connector mask, so
> +		 * drm_atomic_add_affected_connectors() won't find the
> +		 * connector during the check. Pull it in here so that its
> +		 * routing and encoder are properly handled.
> +		 *
> +		 * The leased CRTCs are all part of the commit by now. An
> +		 * unleased one might not be yet, but it keeps its
> +		 * connector mask, so the helpers will pull the connector
> +		 * in on their own if that CRTC ends up being changed.
> +		 */
> +		if (!connector->state->crtc)
> +			return 0;
> +
> +		crtc_state =3D drm_atomic_get_new_crtc_state(commit,
> +							   connector->state->crtc);
> +		if (!crtc_state)
> +			return 0;
> +
> +		connector_state =3D drm_atomic_get_connector_state(commit,
> +								 connector);
> +		if (IS_ERR(connector_state))
> +			return PTR_ERR(connector_state);
> +
> +		/*
> +		 * The connector can't stay bound to a CRTC that the reset
> +		 * disables, whether it is a leased one being reset or an
> +		 * unleased one that just lost its last leased connector:
> +		 * update_connector_routing() would keep it attached to a
> +		 * disabled CRTC. Detach it like userspace setting CRTC_ID
> +		 * to 0 would.
> +		 */
> +		if (!crtc_state->enable) {
> +			ret =3D drm_atomic_set_crtc_for_connector(connector_state,
> +								NULL);
> +			if (ret)
> +				return ret;
> +		}
> +	}

[Severity: Medium]
Should this check !crtc_state->enable before calling
drm_atomic_get_connector_state(), like the unleased plane loop below does?

When an unleased CRTC drives both a leased connector and an unleased
connector in clone mode, and the leased connector precedes the unleased
one in connector_list, the leased connector pulls the unleased CRTC into
the commit while leaving it enabled because the unleased connector's bit
remains in crtc_state->connector_mask.  Calling
drm_atomic_get_connector_state() here then adds the unleased connector to
the commit before drm_atomic_helper_check_modeset() runs, which marks it
as added_by_user in user_connectors_mask.  If that unleased connector was
hot-unplugged and unregistered while the unleased CRTC stays active,
update_connector_routing() rejects the lessee's reset commit with -EINVAL:

drivers/gpu/drm/drm_atomic_helper.c:update_connector_routing() {
	...
	if (!state->duplicated && drm_connector_is_unregistered(connector) &&
	    added_by_user && crtc_state->active) {
		drm_dbg_atomic(connector->dev,
			       "[CONNECTOR:%d:%s] is not registered\n",
			       connector->base.id, connector->name);
		return -EINVAL;
	}
	...
}

Also, the comment notes that an unleased connector could be bound to an
unleased CRTC that just lost its last leased connector and was disabled,
which cannot happen while this unleased connector's bit is still set in
crtc_state->connector_mask.

[ ... ]

> +			plane_state =3D plane->funcs->atomic_create_state(plane);
> +			if (IS_ERR(plane_state))
> +				return PTR_ERR(plane_state);
> +
> +			/*
> +			 * Same thing for the planes: report a color pipeline change
> +			 * compared to the current state.
> +			 */
> +			plane_state->color_mgmt_changed =3D
> +				plane->state->color_pipeline !=3D plane_state->color_pipeline;
> +
> +			drm_atomic_commit_set_plane_state(commit, plane, plane_state);

[Severity: High]
Does plane_state also need to carry over plane->state->normalized_zpos,
just as connector_state->best_encoder and crtc_state->adjusted_mode are
preserved above?

__drm_atomic_helper_plane_state_init() initializes normalized_zpos to the
un-normalized default zpos value, and drm_atomic_plane_set_property() only
updates state->zpos when userspace sets the zpos property.  During atomic
check, drm_atomic_normalize_zpos() only recalculates normalized_zpos if
plane_mask or a plane's zpos changed between old and new states:

drivers/gpu/drm/drm_blend.c:drm_atomic_normalize_zpos() {
	...
	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_st=
ate, i) {
		crtc =3D new_plane_state->crtc;
		if (!crtc)
			continue;
		if (old_plane_state->zpos !=3D new_plane_state->zpos) {
			new_crtc_state =3D drm_atomic_get_new_crtc_state(state, crtc);
			new_crtc_state->zpos_changed =3D true;
		}
	}

	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state,=
 i) {
		if (old_crtc_state->plane_mask !=3D new_crtc_state->plane_mask ||
		    new_crtc_state->zpos_changed) {
			ret =3D drm_atomic_helper_crtc_normalize_zpos(crtc,
								    new_crtc_state);
	...
}

When a reset commit re-applies the active plane_mask and zpos values on a
CRTC, drm_atomic_normalize_zpos() skips normalization and leaves
new_plane_state->normalized_zpos at its un-normalized default, corrupting
plane z-ordering or causing a NULL pointer dereference in drivers such as
sun4i_backend_atomic_check() that index an array by normalized_zpos and
dereference plane_states[i]->fb.

> +		} else if (plane->state->crtc) {
> +			/*
> +			 * An unleased plane keeps its current state, unless
> +			 * the CRTC it is enabled on is disabled by the reset:
> +			 * that CRTC is either leased and comes with a
> +			 * pristine state, or unleased and just lost its last
> +			 * leased connector. The plane can't remain enabled on
> +			 * a disabled CRTC: the atomic helpers would pull it in
> +			 * with its current state during the check and reject
> +			 * the commit. Disable it like userspace setting
> +			 * CRTC_ID and FB_ID to 0 would.
> +			 */
> +			crtc_state =3D drm_atomic_get_new_crtc_state(commit,
> +								   plane->state->crtc);
> +			if (!crtc_state || crtc_state->enable)
> +				continue;
> +
> +			plane_state =3D drm_atomic_get_plane_state(commit, plane);
> +			if (IS_ERR(plane_state))
> +				return PTR_ERR(plane_state);
> +
> +			ret =3D drm_atomic_set_crtc_for_plane(plane_state, NULL);
> +			if (ret)
> +				return ret;
> +
> +			drm_atomic_set_fb_for_plane(plane_state, NULL);
> +		}

[Severity: High]
Can reading plane->state->crtc without holding plane->mutex here cause a
use-after-free or NULL pointer dereference when a concurrent commit updates
an unleased plane?

Unlike the leased branch above, which locks plane->mutex before reading
plane->state->crtc, the unleased branch dereferences plane->state twice
before drm_atomic_get_plane_state() acquires plane->mutex.  A concurrent
non-modeset plane update or page flip on an unleased plane and unleased
CRTC does not take connection_mutex, so it can swap and free the old
drm_plane_state or clear plane->state->crtc in parallel:

CPU0 (lessee reset)               CPU1 (lessor plane update)
drm_atomic_commit_fill_with_defaults()
  else if (plane->state->crtc)
                                  drm_mode_atomic_ioctl()
                                    ...
                                    drm_atomic_helper_swap_state()
                                      /* plane->state->crtc =3D NULL */
                                    drm_atomic_commit_put()
                                      ...
                                      atomic_destroy_state(old_plane_state)
  drm_atomic_get_new_crtc_state(commit,
                                plane->state->crtc)
    drm_crtc_index(NULL)  <-- NULL pointer dereference (or UAF on old state)

In addition, if the unleased plane was on a CRTC being disabled when
checked unlocked, but a concurrent commit moves it onto an active unleased
CRTC before drm_atomic_get_plane_state() takes plane->mutex, this branch
will detach and disable the unleased plane on that active CRTC.  Locking
plane->mutex before reading plane->state->crtc avoids these races.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-drm-reset-=
state-flag-v9-0-ddb0e26324a0@kernel.org?part=3D4
