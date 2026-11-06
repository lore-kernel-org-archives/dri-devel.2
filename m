Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE06606A33A
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JzoHCNrM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B2A010EA9A;
	Fri,  6 Nov 2026 15:37:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D75CC112E4C
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 15:37:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9374E42389
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 15:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F40A1F008A3;
 Fri,  6 Nov 2026 15:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793979465;
 bh=MjishFv01UQMmL5yKZXFtWHaHBbKCTGkvfPIUpYWPBk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JzoHCNrMdnGuuSYzoma48ORpAA2gJr2v5z4OamyUI79MopnUiAtn2xGzI+cz0R879
 tfluovewzWHJLqRv49+N5D4F/a7v9xO+pRtdWAxbH4Her3xhMBoTDt3U3jKf9ymDbw
 fQKvYUu4NjCpNwE9K77CNxbMZY4P6V1VMNkHJcr0E21PRT8/mEDylIlw5XUHrOYdse
 vDH5UnPnO8eivvp0Hv0vnejlwXrVv5+DjjscQvsLT+GSUgaqFuxnmilnuFJl77zitU
 t8p07VnK7NlR7VjN1i9nvHh9TcyXQa/5cEKfV0AP/KP3j5QhdeGpEwQDPZ16rSSw88
 qWS9YS8Buu5JQ==
Message-ID: <sashiko-outbox-201706@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/7] drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106-drm-reset-state-flag-v8-6-50fd046b705f@kernel.org>
References: <20261106-drm-reset-state-flag-v8-0-50fd046b705f@kernel.org>
 <20261106-drm-reset-state-flag-v8-6-50fd046b705f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:37:44 +0000
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
- [Critical] drm/atomic: amdgpu_dm refcount underflow and BUG_ON on
  DRM_MODE_ATOMIC_RESET
- [High] drm/atomic: cross-lease state corruption and events in
  prepare_signaling()
--

commit cf481361f08f3389a3c97bbb841a8f197b13651d
Author: Sebastian Wick <sebastian.wick@redhat.com>

drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag

This commit introduces the DRM_MODE_ATOMIC_RESET flag and DRM_CAP_ATOMIC_RE=
SET
capability to reset all KMS object states in a commit to their defaults bef=
ore
applying the requested property changes.

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
Can prepare_signaling() attach a page-flip event to an active unleased CRTC
when a lessee submits a DRM_MODE_ATOMIC_RESET commit?

When a leased plane or connector is bound to an active unleased CRTC,
drm_atomic_commit_fill_with_defaults() pulls that unleased CRTC into the
commit with its duplicated active state.  Because prepare_signaling() does
not check drm_lease_held(file_priv, crtc->base.id), crtc_state->active is
true and a vblank event is queued on the unleased CRTC for the lessee's
file_priv, leaking flip events across the lease, bypassing the c =3D=3D 0 c=
heck
when all leased CRTCs stay disabled, or failing the lessee's commit with
-EBUSY if the lessor has a flip in flight.

Cross-lease bindings also leave the commit state inconsistent during
drm_atomic_commit_fill_with_defaults():

- In drm_atomic_commit_fill_connector_with_defaults(), an unleased connector
  bound to a leased CRTC has its state duplicated with connector_state->crtc
  and best_encoder still set while the leased CRTC is reset to disabled with
  connector_mask =3D=3D 0, which triggers WARN_ONs in mode_fixup() and
  drm_atomic_helper_update_legacy_modeset_state() if the lessee re-enables
  that CRTC on a shared encoder.
- drm_atomic_commit_fill_with_defaults() skips unleased planes bound to a
  leased CRTC, so drm_atomic_add_affected_planes() later pulls them in still
  bound to the disabled CRTC and drm_atomic_helper_check_plane_state()
  rejects the reset with -EINVAL.
- When a leased connector was the sole connector on an enabled unleased
  CRTC, clearing it from crtc_state->connector_mask leaves the unleased CRTC
  with enable =3D=3D true and connector_mask =3D=3D 0, which
  drm_atomic_helper_check_modeset() rejects with -EINVAL.

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

[Severity: Critical]
Does exposing drm_atomic_commit_fill_with_defaults() on amdgpu_dm cause
dc_stream_state and dc_plane_state refcount underflows and a BUG_ON()?

amdgpu_dm implements atomic_create_state on all planes, CRTCs and
connectors, so DRM_CAP_ATOMIC_RESET is advertised and DRM_MODE_ATOMIC_RESET
is accepted.  However, amdgpu_dm_crtc_create_state() and
amdgpu_dm_plane_drm_plane_create_state() leave dm_new_crtc_state->stream and
dm_new_plane_state->dc_state NULL without retaining the references that
atomic_duplicate_state() normally takes from the current state.

When an active CRTC or plane is disabled by the reset (even in a
DRM_MODE_ATOMIC_TEST_ONLY check), dm_update_crtc_state() and
dm_update_plane_state() assume the new state holds a duplicated reference
and unconditionally release the old state's reference:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:dm_update_crtc_state() {
	...
		if (!dm_old_crtc_state->stream)
			goto skip_modeset;

		dc_stream_release(dm_old_crtc_state->stream);
		dm_new_crtc_state->stream =3D NULL;
	...
}

This drops the reference owned by the live state and leads to use-after-free
on active dc_stream_state and dc_plane_state objects.

In addition, if the DRM_MODE_ATOMIC_RESET commit keeps an active CRTC
enabled with the same mode and connector so that
drm_atomic_crtc_needs_modeset() is false, dm_update_crtc_state() jumps to
skip_modeset with dm_new_crtc_state->stream still NULL and hits
BUG_ON(dm_new_crtc_state->stream =3D=3D NULL).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-drm-reset-=
state-flag-v8-0-50fd046b705f@kernel.org?part=3D6
