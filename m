Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6735F606A8CF
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KcPfePkl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC88D11274D;
	Fri, 30 Oct 2026 10:55:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C23011274D
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:54:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2D7DB43DEE
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E661F0093A;
 Fri, 30 Oct 2026 10:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793357697;
 bh=FHJwbqM8NpOiFofdF8o2KAT7+xwfvtVGOZ3JTl+kGvw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KcPfePklkVdMgU1gf7jv4eqRBbKVazrXU6qgLAGvQ7gzxFkrl3sUlozDIx+3BUC0H
 JHfBMkg1dwMsemCEISfoZTUTGz6yZDri4zqNxUNXxiNPK+BtveKR45r+PI8kJbbj/V
 wYbY61LEhddsoKXpXlKAWnnL02CvpGVeZcNi+XfZjsNKSELPxFoRNcH1MiNtmlKU8a
 FiWdo0KhcuiMp0OMPi+tK87My6vUzsfKW5ghPT6twhIpRhngRAXUXC3Wi0xYp+yICU
 FFyoCegAlnIK4ByoMKEmxYgOh0qsezhrQPTGTUXaSH1dodS46pgBIuti9SgopQoAFl
 BsUfY5q8vRcIw==
Message-ID: <sashiko-outbox-190892@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/16] drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261030-drm-reset-state-flag-v7-14-4e55eaeae683@kernel.org>
References: <20261030-drm-reset-state-flag-v7-0-4e55eaeae683@kernel.org>
 <20261030-drm-reset-state-flag-v7-14-4e55eaeae683@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 10:54:56 +0000
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
- [High] drm/atomic: zeroed adjusted_mode on DRM_MODE_ATOMIC_RESET without =
modeset
- [High] drm/atomic: cross-lease state corruption and events on DRM_MODE_AT=
OMIC_RESET
--

commit c819cce4a5454d4a632c82a26b77df3ff48e4432
Author: Sebastian Wick <sebastian.wick@redhat.com>

drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag

This commit introduces the DRM_MODE_ATOMIC_RESET flag and DRM_CAP_ATOMIC_RE=
SET
capability so userspace can reset all KMS object states to their defaults
before applying the properties in an atomic commit. It also updates
prepare_signaling() to avoid attaching page flip events to CRTCs that remain
disabled across a reset commit.

> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index 1eebcf6f5e05b..77d0713c7e2d6 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -1440,10 +1440,29 @@ static int prepare_signaling(struct drm_device *d=
ev,
> =20
>  	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
>  		s32 __user *fence_ptr;
> +		bool page_flip_event;
> =20
>  		fence_ptr =3D get_out_fence_for_crtc(crtc_state->state, crtc);
> =20
> -		if (arg->flags & DRM_MODE_PAGE_FLIP_EVENT || fence_ptr) {
> +		page_flip_event =3D arg->flags & DRM_MODE_PAGE_FLIP_EVENT;
> +
> +		/*
> +		 * A commit with the DRM_MODE_ATOMIC_RESET flag contains
> +		 * every CRTC of the device or lease, even the ones that are
> +		 * disabled before and after the commit. Those can't report
> +		 * a page flip, and drm_atomic_crtc_check() would reject the
> +		 * whole commit, so don't attach any event to them.
> +		 */
> +		if (page_flip_event && !fence_ptr &&
> +		    (arg->flags & DRM_MODE_ATOMIC_RESET) &&
> +		    !crtc_state->active) {
> +			struct drm_crtc_state *old_crtc_state;
> +
> +			old_crtc_state =3D drm_atomic_get_old_crtc_state(state, crtc);
> +			page_flip_event =3D old_crtc_state->active;
> +		}

[Severity: High]
As reported by Sashiko on v6 [1], what happens when a DRM lessee calls
drm_mode_atomic_ioctl() with DRM_MODE_ATOMIC_RESET while KMS objects are
bound across the lease boundary?

In drm_atomic_commit_fill_with_defaults(), when a leased plane or leased
connector is currently bound to an unleased CRTC, the unleased CRTC is pull=
ed
into the commit with its current state duplicated:

drivers/gpu/drm/drm_atomic.c:drm_atomic_commit_fill_with_defaults() {
    ...
		if (plane->state->crtc) {
			struct drm_crtc_state *crtc_state;

			crtc_state =3D drm_atomic_get_crtc_state(commit,
							       plane->state->crtc);
			if (IS_ERR(crtc_state))
				return PTR_ERR(crtc_state);
		}

		plane_state =3D plane->funcs->atomic_create_state(plane);
    ...
}

Because prepare_signaling() iterates over all CRTCs in state without checki=
ng
drm_lease_held(file_priv, crtc->base.id), any active unleased CRTC pulled i=
nto
the commit has crtc_state->active set to true and will have a page flip eve=
nt
attached for the lessee's file_priv and increment c. Doesn't this leak vbla=
nk
events for an unleased CRTC to the lessee, allow a commit that leaves all of
the lessee's own CRTCs disabled to bypass the c =3D=3D 0 check, and risk fa=
iling
with -EBUSY in stall_checks() if the lessor has a flip in flight on that CR=
TC?

In addition, when detaching a leased plane or connector from an unleased CR=
TC
via atomic_create_state(), drm_atomic_commit_fill_with_defaults() does not
clear drm_plane_mask(plane) from crtc_state->plane_mask or
drm_connector_mask(connector) from crtc_state->connector_mask on the
duplicated unleased CRTC state. Conversely, if an unleased connector or pla=
ne
is bound to a leased CRTC that gets reset, the leased CRTC's connector_mask
and plane_mask are zeroed while the unleased connector or plane state still
points to that CRTC:

drivers/gpu/drm/drm_atomic.c:drm_atomic_commit_fill_with_defaults() {
    ...
		if (!drm_lease_held(file_priv, connector->base.id)) {
			if (!connector->state->crtc)
				continue;

			if (!drm_atomic_get_new_crtc_state(commit,
							   connector->state->crtc))
				continue;

			connector_state =3D drm_atomic_get_connector_state(commit,
									 connector);
    ...
}

Won't these cross-lease bindings corrupt the CRTC state masks or cause
drm_atomic_helper_check_modeset() and drm_atomic_helper_check_planes() to
reject the lessee's reset commit with -EINVAL?

[ ... ]

> @@ -1688,6 +1715,17 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>  	fence_state =3D NULL;
>  	num_fences =3D 0;
> =20
> +	if (arg->flags & DRM_MODE_ATOMIC_RESET) {
> +		if (!drm_atomic_implements_create_state(dev)) {
> +			ret =3D -EOPNOTSUPP;
> +			goto out;
> +		}
> +
> +		ret =3D drm_atomic_commit_fill_with_defaults(file_priv, state);
> +		if (ret)
> +			goto out;
> +	}

[Severity: High]
When userspace issues a commit with DRM_MODE_ATOMIC_RESET that re-applies t=
he
same mode and connector routing on an already-enabled CRTC, does
new_crtc_state->adjusted_mode get left all-zeroed?

In drm_atomic_commit_fill_with_defaults(), the fresh CRTC state is allocated
via crtc->funcs->atomic_create_state(crtc) with adjusted_mode zeroed, while
connector_state->best_encoder is preserved from connector->state->best_enco=
der
so that re-applying the current configuration avoids a modeset:

drivers/gpu/drm/drm_atomic.c:drm_atomic_commit_fill_with_defaults() {
    ...
		crtc_state =3D crtc->funcs->atomic_create_state(crtc);
    ...
		connector_state->best_encoder =3D connector->state->best_encoder;
    ...
}

When userspace supplies the existing MODE_ID, ACTIVE =3D 1, and CRTC_ID
properties, new_crtc_state->mode and new_crtc_state->enable match
old_crtc_state, and update_connector_routing() sees new_encoder =3D=3D
new_connector_state->best_encoder, leaving both mode_changed and
connectors_changed false. In drm_atomic_helper_check_modeset() -> mode_fixu=
p(),
copying mode into adjusted_mode is then skipped:

drivers/gpu/drm/drm_atomic_helper.c:mode_fixup() {
    ...
	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
		if (!new_crtc_state->mode_changed &&
		    !new_crtc_state->connectors_changed)
			continue;

		drm_mode_copy(&new_crtc_state->adjusted_mode, &new_crtc_state->mode);
	}
    ...
}

With new_crtc_state->adjusted_mode remaining all zeros on an enabled CRTC,
won't subsequent checks and commit steps fail or crash=E2=80=94for example,=
 dividing
by zero on mode->htotal in vc4_crtc_atomic_check(), rejecting valid plane
coordinates against adjusted_mode.hdisplay in omap_plane_atomic_check(), and
corrupting vblank timing constants in
drm_atomic_helper_calc_timestamping_constants()?

[1] https://lore.kernel.org/r/20261022-drm-reset-state-flag-v6-13-f36d640b7=
e76@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-drm-reset-=
state-flag-v7-0-4e55eaeae683@kernel.org?part=3D14
