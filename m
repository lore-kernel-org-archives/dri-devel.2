Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F349B606A31D
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oEpjv/bD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E49D10E1FB;
	Sat, 31 Oct 2026 14:54:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12AD410E012
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 14:54:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8C23340A35;
 Sat, 31 Oct 2026 14:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5476E1F000C1;
 Sat, 31 Oct 2026 14:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793458461;
 bh=J0FXP0wJwj0eDZOb8IXdiL43Ede7mRfYAc0YMr091SU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oEpjv/bDeqAqTvWdUPys14kaCFhOR9Yy0rBnvyynEkyDiQfCm6FjPWIktohSo52px
 h3qkp3BpJzdahxBd+EuXCxXgdHSXcZw9dR3HDScrlbLk3iWhvEv4kQVVD//a5KeG1O
 K30zeBZGKH+5bBmED2AxTTkqgMtNlo1cnGL7lImEn0PIZoej3mp3teCLwQiN162mgj
 X2IhnBtei7+V88/pojCMBuU/nIbpPbiEIhTNuivJGvtNJU8CNNpM3JK3zDG5Ju0GFH
 HBMZtsyNVPKmayDUW1ndilucnXwC3wICmTMFVL+/73ZZtoabobSk/agsfjOy6X3ZAp
 h/mo1IIqH4sKQ==
Message-ID: <sashiko-outbox-192001@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: Hold the VRR vblank reference only on
 active CRTCs
To: "Hugo Sales" <hugo@hsal.es>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261031143351.3222033-1-hugo@hsal.es>
References: <20261031143351.3222033-1-hugo@hsal.es>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 14:54:20 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/amd/display: dc_exit_ips_for_hw_access() disables IPS on CRT=
C disable
--

commit 8e13aac5aafca2cc16730e98147592bfe9db266f
Author: Hugo Sales <hugo@hsal.es>

drm/amd/display: Hold the VRR vblank reference only on active CRTCs

This patch gates the VRR active state check in
amdgpu_dm_handle_vrr_transition() on the CRTC's base.active flag so that
disabling a CRTC drops the VRR vblank reference and enabling it takes the
reference again.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b=
/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> index 386ba88c57c6a..ee8a11f62a0d3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> @@ -414,8 +414,16 @@ void amdgpu_dm_handle_vrr_transition(struct amdgpu_d=
isplay_manager *dm,
>  				     struct dm_crtc_state *new_state)
>  {
>  	struct amdgpu_device *adev =3D dm->adev;
> -	bool old_vrr_active =3D amdgpu_dm_crtc_vrr_active(old_state);
> -	bool new_vrr_active =3D amdgpu_dm_crtc_vrr_active(new_state);
> +	/*
> +	 * A disabled CRTC keeps its freesync state, but drm_crtc_vblank_get()
> +	 * fails there because vblank is off. Hold the reference only while
> +	 * the CRTC is active as well, which also covers resume, where the
> +	 * reset state lost track of the reference taken before suspend
> +	 */
> +	bool old_vrr_active =3D old_state->base.active &&
> +			      amdgpu_dm_crtc_vrr_active(old_state);
> +	bool new_vrr_active =3D new_state->base.active &&
> +			      amdgpu_dm_crtc_vrr_active(new_state);

[Severity: Medium]
Can gating new_vrr_active on new_state->base.active leave DC idle power
optimizations (IPS) disabled when disabling the last active CRTC in a
headless configuration while VRR was active?

In drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c,
amdgpu_dm_atomic_commit_tail() first calls amdgpu_dm_commit_streams(),
which disables vblank via manage_dm_interrupts(), flushes
dm->vblank_control_workqueue, commits the stream removal, and enables idle
optimizations for headless display-off:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:amdgpu_dm_commit_streams(=
) {
	...
	/* Allow idle optimization when vblank count is 0 for display off */
	if ((dm->active_vblank_irq_count =3D=3D 0) && amdgpu_dm_is_headless(dm->ad=
ev))
		dc_allow_idle_optimizations(dm->dc, true);
}

Later in amdgpu_dm_atomic_commit_tail(), amdgpu_dm_handle_vrr_transition()
runs. When disabling a CRTC that had VRR_STATE_ACTIVE_VARIABLE,
old_vrr_active is true and new_vrr_active is now false, so execution enters
the old_vrr_active && !new_vrr_active branch:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c:amdgpu_dm_handle=
_vrr_transition() {
	...
	} else if (old_vrr_active && !new_vrr_active) {
		...
		drm_crtc_vblank_put(new_state->base.crtc);
		...
		scoped_guard(mutex, &dm->dc_lock) {
			dc_exit_ips_for_hw_access(dm->dc);
			amdgpu_dm_psr_set_event(dm, new_state->stream, false,
				psr_event_vrr_transition, false);
			amdgpu_dm_replay_set_event(dm, new_state->stream, false,
				replay_event_vrr, false);
		}
	}
}

Because drm_crtc_vblank_off() already set vblank->inmodeset and holds a
vblank reference, drm_crtc_vblank_put() decrements vblank->refcount from 2
to 1 without scheduling vblank_control_work.

Then dc_exit_ips_for_hw_access(dm->dc) unconditionally calls
dc_allow_idle_optimizations(dm->dc, false), even though new_state->stream
is NULL when the CRTC is being disabled and both amdgpu_dm_psr_set_event()
and amdgpu_dm_replay_set_event() immediately return false at their !stream
checks without touching hardware.

Since new_state->stream is NULL, amdgpu_dm_commit_planes() is skipped, and
amdgpu_dm_idle_worker() breaks out of its loop upon seeing
!dc->idle_optimizations_allowed. Should the dc_lock block and
dc_exit_ips_for_hw_access() in that branch be skipped when
new_state->stream is NULL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031143351.3222=
033-1-hugo@hsal.es?part=3D1
