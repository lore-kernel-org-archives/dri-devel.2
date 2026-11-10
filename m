Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC528606A333
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X7DujSWD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AED610E10B;
	Tue, 10 Nov 2026 17:47:06 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AFAB10E10B
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 17:47:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 03114457C0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 17:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF7C1F008A1;
 Tue, 10 Nov 2026 17:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794332819;
 bh=CWpuVpGqf9AHq363mvGj10lBgP9ex3zu9CkIukz9B/k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X7DujSWDVBa8FQYeKgo/SV5nneQwLnxcDAkFKaN0+NqCJCRLBwP8DMkUeT3NKmH98
 NVISima/WZoemCE0Y+5HC+vNrttwqEhLctI1OtqdW2Yqb59r0P1Jx1QooCFcISJYZq
 lFLjKyjH5XFKIEt7ux/yF4AnH3RV/xg77D5zkg+82NASW9Y65wDJsMRvpXK/vpkNGr
 KjYRouYyPVg9Cg3l8lG7cVZL/6sprWAqWuD0esLohrtVNSRRVSaiyCOKtXhe/I8/ye
 Nn80g4TQtmEYqMMskQ3jvl2uew6P3H1+0eAnfNVbc1m+oisC60mmuclXfw+BeXI8TS
 GPubLWOALu/jg==
Message-ID: <sashiko-outbox-207512@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 09/10] drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-drm-reset-state-flag-v9-9-ddb0e26324a0@kernel.org>
References: <20261110-drm-reset-state-flag-v9-0-ddb0e26324a0@kernel.org>
 <20261110-drm-reset-state-flag-v9-9-ddb0e26324a0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 17:46:59 +0000
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
- [High] drm/atomic: unlocked plane->state->crtc read on unleased planes
  on reset
- [Medium] drm/atomic: TOCTOU race with lease revocation in
  prepare_signaling()
--

commit f689cd02961e3a01034ef22d1f4351321e14445b
Author: Sebastian Wick <sebastian.wick@redhat.com>

drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag

This commit introduces the DRM_MODE_ATOMIC_RESET flag and the
DRM_CAP_ATOMIC_RESET capability to allow userspace to reset all KMS object
states to their defaults in an atomic commit before applying new property
values.

> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index 1eebcf6f5e05b..1a89175318d02 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -1440,10 +1440,41 @@ static int prepare_signaling(struct drm_device *d=
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
> +
> +		/*
> +		 * A lessee commit with the DRM_MODE_ATOMIC_RESET flag also
> +		 * contains unleased CRTCs, pulled in because a leased plane
> +		 * or connector is bound to them. Those CRTCs belong to
> +		 * another master, so the lessee can't get a page flip from
> +		 * them: don't attach any event to them, and don't count
> +		 * them towards the CRTCs that can report one.
> +		 */
> +		if (page_flip_event && (arg->flags & DRM_MODE_ATOMIC_RESET) &&
> +		    !drm_lease_held(file_priv, crtc->base.id))
> +			page_flip_event =3D false;

[Severity: Medium]
Can a concurrent lease revocation during prepare_signaling() cause a
multi-CRTC reset commit to drop page-flip events for a subset of leased
CRTCs?

drm_atomic_commit_fill_with_defaults() checks drm_lease_revoked() at the
end of filling the state, but idr_mutex is only held inside individual
drm_lease_held() calls.  If the lessor revokes the lease after that check:

CPU0 (lessee)                           CPU1 (lessor)
drm_mode_atomic_ioctl()
  drm_atomic_commit_fill_with_defaults()
    drm_lease_revoked() -> false
  ...
  prepare_signaling()
    /* crtc 0 (leased) */
    drm_lease_held(crtc 0) -> true
    create_vblank_event(crtc 0)
    c++
                                        drm_mode_revoke_lease_ioctl()
                                          drm_lease_revoke()
                                            _drm_lease_revoke()
                                              idr_destroy(&master->leases)
    /* crtc 1 (leased) */
    drm_lease_held(crtc 1) -> false
    page_flip_event =3D false             <-- event skipped for crtc 1
  drm_atomic_commit()

Because c > 0, prepare_signaling() succeeds and the commit is applied to
both leased CRTCs, but crtc 1 never emits its requested vblank event,
leaving userspace waiting for an event that never arrives.  If the lease
is revoked before the loop starts, all leased CRTCs fail drm_lease_held()
and prepare_signaling() fails with -EINVAL instead of -ENOENT.

Checking drm_lease_revoked(file_priv) after the CRTC loop in
prepare_signaling() (as drm_atomic_commit_fill_with_defaults() does) would
catch a revocation that happened before or during the loop.

[ ... ]

> @@ -1688,6 +1727,17 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
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
Can calling drm_atomic_commit_fill_with_defaults() from a lessee trigger a
use-after-free or NULL pointer dereference on plane->state?

For unleased planes, drm_atomic_commit_fill_with_defaults() reads
plane->state->crtc twice before acquiring plane->mutex:

drivers/gpu/drm/drm_atomic.c:drm_atomic_commit_fill_with_defaults() {
    ...
		} else if (plane->state->crtc) {
			crtc_state =3D drm_atomic_get_new_crtc_state(commit,
								   plane->state->crtc);
			if (!crtc_state || crtc_state->enable)
				continue;

			plane_state =3D drm_atomic_get_plane_state(commit, plane);
    ...
}

When an unleased plane is bound to an unleased CRTC, the lessee's reset
commit holds neither plane->mutex nor that CRTC's crtc->mutex.  The lessor
(or another lessee) can concurrently commit a plane update on that
unleased plane:

CPU0 (lessee)                           CPU1 (lessor)
drm_mode_atomic_ioctl()
  drm_atomic_commit_fill_with_defaults()
    if (plane->state->crtc)
                                        drm_atomic_helper_swap_state()
                                          /* sets plane->state->crtc =3D NU=
LL
                                           * and frees old plane->state
                                           */
    drm_atomic_get_new_crtc_state(...,
      plane->state->crtc)
      drm_crtc_index(NULL)              <-- NULL pointer dereference
                                            (or UAF of old plane->state)

Locking plane->mutex before inspecting plane->state in the unleased branch
as well would prevent concurrent state swaps while reading plane->state->cr=
tc.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-drm-reset-=
state-flag-v9-0-ddb0e26324a0@kernel.org?part=3D9
