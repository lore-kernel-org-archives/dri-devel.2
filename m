Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C03DC5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8969310EB1F;
	Fri, 14 Aug 2026 07:19:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="md9AIqHF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7FDA10EB1F
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 07:19:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 312C860A63;
 Fri, 14 Aug 2026 07:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD48E1F000E9;
 Fri, 14 Aug 2026 07:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786691963;
 bh=rkHSlKrfGPgjow/WFD56NttK+HtzHa91qf6zEPOY8So=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=md9AIqHFNuIDLy6V/TtO55caUo+lTMRNy0Ex/boDtJ9ZPXWkhLu16wId9AHf9lvoT
 sLW/7vF3vjctOlwmiGz90cKF6VBQT5Vq4kTDjMjjQJ2/jCcUILZO6MMFBTfYR6qMIs
 e26OinApqM2XfFcOR6/xc/+1/gt0Mum10cff6PMtAZeHTPT955bXDtzydOBkweKyOV
 YRBfpxyOA+w3fqSCNoTS3u1jLbsUJJ8ekmdAEGA55sEZ1QZcBO6yPG8ftCXh/i2VNd
 kInbKwEtooD7k3jgWHWKLN4yn9amdYJrH8ckRu4LqouMfVdA+7uuKyBWn9KsNj39hg
 iVF2N6B1SpsLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/amd/display: Skip connector updates without a
 stream
To: "David Weber" <weber.aulendorf@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813112634.11455-2-weber.aulendorf@gmail.com>
References: <20260813112634.11455-1-weber.aulendorf@gmail.com>
 <20260813112634.11455-2-weber.aulendorf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 07:19:22 +0000
Message-Id: <20260814071923.BD48E1F000E9@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The function `amdgpu_dm_atomic_commit_tail` uses `kzalloc` with `G=
FP_KERNEL` and acquires a `mutex`, both of which can sleep, despite being a=
n atomic commit path.
- [High] AMDGPU never updates the privacy screen hardware state because pri=
vacy screen updates force a modeset, but the commit tail skips privacy scre=
en updates during modesets.
--

--- Patch [1]: [PATCH 1/2] drm/amd/display: Skip connector updates without =
a stream ---
commit 3a3a91e5bab6bdb82ebcebf89c73cd8b740ca904
Author: David Weber <weber.aulendorf@gmail.com>

drm/amd/display: Skip connector updates without a stream
   =20
Atomic DPMS can leave a connector assigned to an enabled but inactive
CRTC after the driver has removed its DC stream. A later atomic commit
can then change HDR_OUTPUT_METADATA or Broadcast RGB while leaving the
CRTC mode, routing and active state unchanged.

This patch skips stream updates until a stream exists, preventing null
pointer dereferences when the connector stream-update path is reached
with a NULL stream.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 567bf04979ee5..712e8d3e0a01d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5050,6 +5050,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm=
_atomic_commit *state)
> =20
>  		dm_new_crtc_state =3D to_dm_crtc_state(new_crtc_state);
>  		dm_old_crtc_state =3D to_dm_crtc_state(old_crtc_state);

[Severity: High]
This isn't a bug introduced by this patch, but does this skip logic prevent
privacy screen updates?

In amdgpu_dm_connector_atomic_check(), any change to the privacy screen
software state forces a modeset:

    new_crtc_state->mode_changed =3D true;

However, earlier in this loop in amdgpu_dm_atomic_commit_tail(), connectors
undergoing a modeset are skipped:

    /* Skip any modesets/resets */
    if (!acrtc || drm_atomic_crtc_needs_modeset(new_crtc_state))
        continue;

Since the only call to update the privacy screen hardware is located at the
very end of this loop:

    drm_connector_update_privacy_screen(new_con_state);

Will this cause privacy screen updates to be permanently skipped because th=
ey
force a modeset that bypasses the update code?

> +		/* DPMS-off leaves the connector routed to a streamless CRTC. */
> +		if (!dm_new_crtc_state->stream)
> +			continue;
> =20
>  		scaling_changed =3D is_scaling_state_different(dm_new_con_state,
>  							     dm_old_con_state);

[Severity: High]
This is a pre-existing issue, but are there sleeping functions called from
this atomic context?

Later in amdgpu_dm_atomic_commit_tail(), kzalloc is called with GFP_KERNEL:

    dummy_updates =3D kzalloc(sizeof(struct dc_surface_update) * MAX_SURFAC=
ES, GFP_KERNEL);

And then a mutex is acquired:

    mutex_lock(&dm->dc_lock);

Since drm_atomic_helper_commit_tail() and its variants execute in an atomic
context where sleeping is forbidden, could this kzalloc(..., GFP_KERNEL) and
mutex_lock() cause kernel warnings, system instability, or potential
deadlocks?

Also, if the memory allocation fails, the subsequent hardware programming in
dc_update_planes_and_stream() is silently skipped. Can this lead to an
unrecoverable state mismatch since commit_tail cannot return error codes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813112634.1145=
5-1-weber.aulendorf@gmail.com?part=3D1
