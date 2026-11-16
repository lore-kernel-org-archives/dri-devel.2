Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3575D606A8B4
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZDD2HqH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B3C10EDDB;
	Mon, 16 Nov 2026 09:45:07 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D87E910ED63;
 Mon, 16 Nov 2026 09:45:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C529762834;
 Mon, 16 Nov 2026 09:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344961F000C4;
 Mon, 16 Nov 2026 09:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794822299;
 bh=6G0145n9dvi9pc5EU5BthwJpudqxGvPRdSxqVMDAG70=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gZDD2HqHiYjImJQZMxylljl2f0hBJZxsnjMb20zI5K8Gy7ghsfrldtSqfLh/Kv2bU
 nmmmEKMu2ndZOlKKP5VAUEWRzBxJHKtvxOmMNgiPwcAu2NElLfESGhykudAtT47Iok
 KgOtNX/ebylSm1wBZiKjoZAOG5rbo9cBtP3NmgXVioLjxm5t+GQ6KDDMHxSHMW3Cbv
 qPzZGxvU1vJf5o5wOupTY+e+TgWunIuKjXnvPQt7+tROzfQt3smv3BjjZcEiHE7174
 Nb02HEH9yTECOgHOnHaBuP7cO2k6tya/fLkTlSSoHjCfebrgAWF0AMHTpmDIkvIWFe
 GQME/HHE8UiSA==
Message-ID: <sashiko-outbox-216633@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/12] drm/atomic/uapi: Make async flips a bit more
 palatable through atomic
To: "Ville Syrjala" <ville.syrjala@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
In-Reply-To: <20261116091130.13950-12-ville.syrjala@linux.intel.com>
References: <20261116091130.13950-1-ville.syrjala@linux.intel.com>
 <20261116091130.13950-12-ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:44:58 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/atomic: skipping all no-op planes breaks CRTC-only async
  flips
- [Medium] drm/atomic: stale FB_DAMAGE_CLIPS read in
  drm_atomic_set_property()
--

commit 64d10f48b65296ed20fc62e81d5d8b357f0e8b51
Author: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

drm/atomic/uapi: Make async flips a bit more palatable through atomic

This commit filters out no-op property changes during atomic async flips
in drm_atomic_set_property() before duplicating plane and connector states,
while still adding the associated CRTCs to the commit.

> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index 7517950d2e515..87181aba14514 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c

[ ... ]

> @@ -1285,16 +1326,19 @@ int drm_atomic_set_property(struct drm_atomic_com=
mit *state,
>  		struct drm_plane_state *plane_state;
>  		struct drm_mode_config *config =3D &plane->dev->mode_config;
>  		const struct drm_plane_helper_funcs *plane_funcs =3D plane->helper_pri=
vate;
> -
> -		plane_state =3D drm_atomic_get_plane_state(state, plane);
> -		if (IS_ERR(plane_state)) {
> -			ret =3D PTR_ERR(plane_state);
> -			break;
> -		}
> +		bool is_noop =3D false;
> =20
>  		if (async_flip) {
> -			/* no-op changes are always allowed */
> -			ret =3D drm_atomic_plane_get_property(plane, plane_state,
> +			const struct drm_plane_state *current_plane_state;
> +
> +			current_plane_state =3D
> +				__drm_atomic_get_current_plane_state(state, plane);
> +			if (IS_ERR(current_plane_state)) {
> +				ret =3D PTR_ERR(current_plane_state);
> +				break;
> +			}
> +
> +			ret =3D drm_atomic_plane_get_property(plane, current_plane_state,
>  							    prop, &old_val);

[Severity: Medium]
Does reading prop_fb_damage_clips from current_plane_state return the
previous commit's damage blob ID instead of 0?

Unlike IN_FENCE_FD (which always reports -1), drm_atomic_plane_get_property=
()
returns state->fb_damage_clips->base.id, and state->fb_damage_clips is only
cleared to NULL when __drm_atomic_helper_plane_duplicate_state() duplicates
the state for a new commit.  Before this change, drm_atomic_get_plane_state=
()
ran first, so old_val was always 0 on a fresh plane state.

When current_plane_state is the un-duplicated plane->state from a previous
commit that attached damage clips, passing FB_DAMAGE_CLIPS =3D 0 on a
non-primary plane (such as a cursor plane) looks like a property change
(old_val !=3D 0) and fails the async flip with -EINVAL.  Conversely, if
userspace passes the same blob ID as the previous commit before FB_ID in the
property list, FB_DAMAGE_CLIPS is skipped as a no-op and then wiped to NULL
when FB_ID duplicates the plane state.

>  			if (ret)
>  				break;
> @@ -1318,25 +1362,40 @@ int drm_atomic_set_property(struct drm_atomic_com=
mit *state,
>  				break;
>  			}
> =20
> -			/*
> -			 * FIXME this is in the wrong place. Whether to do a
> -			 * bypass commit for async flips would is a driver
> -			 * decision. Drivers that want this need to just do
> -			 * these checks themselves somewhere.
> -			 */
> -			if (old_val !=3D prop_value && plane->type !=3D DRM_PLANE_TYPE_PRIMAR=
Y) {
> -				/* ask the driver if this non-primary plane is supported */
> -				if (plane_funcs && plane_funcs->atomic_bypass_check)
> -					ret =3D plane_funcs->atomic_bypass_check(plane, state, true);
> -				else
> -					ret =3D -EINVAL;
> -
> -				if (ret) {
> -					drm_dbg_atomic(prop->dev,
> -						       "[PLANE:%d:%s] does not support async flips\n",
> -						       obj->id, plane->name);
> -					break;
> -				}
> +			if (old_val =3D=3D prop_value)
> +				is_noop =3D true;
> +		}
> +
> +		/* No-op plane property changes can be fully skipped */
> +		if (is_noop) {
> +			ret =3D 0;
> +			break;
> +		}

[Severity: High]
What happens when all plane property updates in an async flip commit are
no-ops (for example, primary plane FB_ID set to the current FB_ID)?

__drm_atomic_get_current_plane_state() adds the CRTC to the commit and
set_async_flip() sets crtc_state->async_flip =3D true, but skipping all pla=
nes
leaves the commit with zero planes in state.

On i915/xe, crtc_state->do_async_flip is only set in
intel_plane_atomic_calc_changes(), which only runs for planes in state.
With no planes in state, do_async_flip stays false:

1. If the first async flip on a pipe is a no-op, uapi.async_flip becomes
   true in crtc->state without switching the primary plane to minimal
   wm0/DDB.  On the next async flip where FB_ID actually changes,
   intel_plane_do_async_flip() sees old_crtc_state->uapi.async_flip =3D=3D =
true
   and sets do_async_flip =3D true, while skl_compute_wm() tries to switch =
to
   minimal wm0/DDB for the first time; skl_ddb_add_affected_planes() and
   skl_wm_add_affected_planes() then reject that and all subsequent async
   flips with -EINVAL because watermarks/DDB cannot change during an async
   flip.

2. intel_crtc_complete_noop_async_flip() from commit "drm/i915: Complete
   no-op async flips by hand" returns early on !crtc_state->do_async_flip,
   so a no-op async flip falls through to a vblank-waited sync commit.

3. On amdgpu_dm, a commit with no planes skips pageflip event arming in
   amdgpu_dm_commit_planes() and falls back to drm_send_event_locked() in
   amdgpu_dm_atomic_commit_tail(), sending DRM_EVENT_FLIP_COMPLETE with a
   zeroed sequence and timestamp.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116091130.1395=
0-1-ville.syrjala@linux.intel.com?part=3D11
