Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7796B606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AVw7kLDw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E793110EB00;
	Thu,  5 Nov 2026 16:49:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ADB410ED44
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 16:49:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E612C6020A;
 Thu,  5 Nov 2026 16:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787D41F00A18;
 Thu,  5 Nov 2026 16:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793897381;
 bh=o+jQqJc+4FhJ6LZHNCBgoOdTTWtWy1hVsxuYpX1+faQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AVw7kLDwNjTrt4cE+FI24XDnTuD8m9ks6jKzR+rlj58EH5zpipKgY2lk6mGXN7S+l
 /EYlIQm6v/iFVDZC+nApyEUPUJXs5RmoqgvAnSF7kYlrLb0lksSK5wZg+u1NyqwDcQ
 +eniWbBAB5WhILzbmL69ict0fHLBnTdmediHNtHBSiUf6zz4W04supYf0IrKl3V3bb
 JgfKh6j5qM6Tp8lSnNwwXOEXaUovPWbJy/l6so1peAL6ctTr2VOPVI8Hn4SsNuDaiM
 IJfoW805ELFuzEp3hb7Jn1Onbo3aSAKqnFFW7Bt524wqOwyXeKjJ1Vq1P1Uu/IPFB0
 heQmVuEZZDCGA==
Message-ID: <sashiko-outbox-199534@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/27] drm/crtc-helper: Add VRR helper functions
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-vrr-limiter-uapi-v2-6-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
 <20261105-vrr-limiter-uapi-v2-6-55f4215be2c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:49:41 +0000
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
- [High] drm/crtc-helper: unsynchronized crtc_state mutation in VRR helpers
- [Medium] drm/crtc-helper: vrr->dynamic set and left true when VRR is disa=
bled
--

commit 2e8aace704ca21ab8efb4aacd3b771407706ec16
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/crtc-helper: Add VRR helper functions

This commit adds drm_crtc_helper_vrr_flush() and drm_crtc_helper_vrr_vsync()
to update the internal VRR state in struct drm_crtc_state when a new frame =
is
ready or when a vertical blank ends, returning whether cur_vtotal changed.

> diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc=
_helper.c
> index 4a8cfe046e4ab..4ffb3b0b78780 100644
> --- a/drivers/gpu/drm/drm_crtc_helper.c
> +++ b/drivers/gpu/drm/drm_crtc_helper.c
> @@ -838,6 +838,69 @@ int drm_crtc_helper_set_config(struct drm_mode_set *=
set,
>  }
>  EXPORT_SYMBOL(drm_crtc_helper_set_config);
> =20
> +/**
> + * drm_crtc_helper_vrr_flush - Update VRR state on frame ready
> + * @crtc_state: pointer to &struct drm_crtc_state of CRTC that has a new=
 frame ready
> + *
> + * Update the VRR state by communicating that a frame is ready on
> + * @crtc_state.crtc.
> + *
> + * Should be called from the @crtc_state.crtc &drm_crtc_helper_funcs.ato=
mic_flush
> + * hook.
> + *
> + * Returns:
> + * - %true if @crtc_state.vrr_state.cur_vtotal changed
> + * - %false otherwise
> + */
> +bool drm_crtc_helper_vrr_flush(struct drm_crtc_state *crtc_state)
> +{
> +	struct drm_crtc_vrr_state *vrr =3D &crtc_state->vrr_state;
> +
> +	if (!crtc_state->vrr_enabled) {
> +		if (vrr->cur_vtotal) {
> +			vrr->cur_vtotal =3D 0;
> +			return true;
> +		}
> +		return false;
> +	}
> +
> +	if (vrr->cur_vtotal =3D=3D vrr->base_vtotal)
> +		return false;
> +
> +	vrr->cur_vtotal =3D vrr->base_vtotal;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL(drm_crtc_helper_vrr_flush);

[Severity: High]
As reported by Sashiko on RFC [1], is it safe for drm_crtc_helper_vrr_vsync=
()
and drm_crtc_helper_vrr_flush() to mutate crtc_state->vrr_state in place
across commits and from the vblank interrupt handler?

Consider a sequence of two atomic commits when VRR is enabled:

1. Commit 1 runs atomic_flush and calls drm_crtc_helper_vrr_flush(state_1),
   which sets state_1->vrr_state.cur_vtotal =3D base_vtotal and programs the
   hardware vtotal to base_vtotal.

2. Commit 2 starts and calls drm_atomic_get_crtc_state() ->
   __drm_atomic_helper_crtc_duplicate_state(), which copies crtc->state
   (state_1) into state_2 via memcpy(), snapshotting
   state_2->vrr_state.cur_vtotal =3D base_vtotal.

3. Before commit 2 calls drm_atomic_helper_swap_state() (or while waiting on
   fences / hw_done), a vblank interrupt fires and the driver's vblank
   handler calls drm_crtc_helper_vrr_vsync(crtc->state) on state_1, setting
   state_1->vrr_state.cur_vtotal =3D max_vtotal and programming the hardware
   vtotal to max_vtotal.

4. Commit 2 runs drm_atomic_helper_swap_state(), replacing crtc->state with
   state_2, which still holds the stale vrr_state.cur_vtotal =3D=3D base_vt=
otal
   copied in step 2.

5. When commit 2 reaches atomic_flush and calls
   drm_crtc_helper_vrr_flush(state_2), vrr->cur_vtotal =3D=3D vrr->base_vto=
tal
   evaluates to true and the helper returns false, causing the driver to sk=
ip
   reprogramming the hardware vtotal back from max_vtotal to base_vtotal for
   the new frame.

In addition, drm_crtc_helper_vrr_vsync() mutates crtc->state->vrr_state from
hardirq context without synchronization against
__drm_atomic_helper_crtc_duplicate_state(), drm_atomic_helper_swap_state(),
drm_crtc_helper_vrr_flush(), or state destruction after
drm_atomic_helper_commit_hw_done(). Should the mutable runtime VRR state li=
ve
on struct drm_crtc protected by an irq-safe spinlock rather than in
struct drm_crtc_state?

> +
> +/**
> + * drm_crtc_helper_vrr_vsync - Update VRR state on vblank end
> + * @crtc_state: pointer to &struct drm_crtc_state of CRTC the vblank occ=
urred on
> + *
> + * Update the VRR state by communicating that a vertical blank has ended=
 and a
> + * new frame is about to start.
> + *
> + * Returns:
> + *  - %true if @crtc_state.vrr_state.cur_vtotal changed
> + *  - %false otherwise
> + */
> +bool drm_crtc_helper_vrr_vsync(struct drm_crtc_state *crtc_state)
> +{
> +	struct drm_crtc_vrr_state *vrr =3D &crtc_state->vrr_state;
> +	u16 old_vtotal =3D vrr->cur_vtotal;
> +
> +	if (!crtc_state->vrr_enabled)
> +		vrr->cur_vtotal =3D 0;
> +	else
> +		vrr->cur_vtotal =3D vrr->max_vtotal;
> +
> +	if (abs_diff(vrr->cur_vtotal, old_vtotal) > 1)
> +		vrr->dynamic =3D true;
> +
> +	return old_vtotal !=3D vrr->cur_vtotal;
> +}

[Severity: Medium]
When crtc_state->vrr_enabled is false, drm_crtc_helper_vrr_vsync() sets
vrr->cur_vtotal =3D 0 and then checks:

	if (abs_diff(vrr->cur_vtotal, old_vtotal) > 1)
		vrr->dynamic =3D true;

If VRR was previously enabled so old_vtotal > 1 (including fixed-rate VRR
where vrr->dynamic was false), doesn't abs_diff(0, old_vtotal) > 1 evaluate
to true and set vrr->dynamic =3D true when VRR is disabled?

Neither drm_crtc_helper_vrr_vsync() nor drm_crtc_helper_vrr_flush() resets
vrr->dynamic to false in the !crtc_state->vrr_enabled path either, leaving
vrr->dynamic stuck at true after VRR is turned off. Should both helpers cle=
ar
vrr->dynamic =3D false when !crtc_state->vrr_enabled?

[1] https://lore.kernel.org/r/20260921-vrr-limiter-uapi-v1-7-2fcd7d011646@c=
ollabora.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-vrr-limite=
r-uapi-v2-0-55f4215be2c2@collabora.com?part=3D6
