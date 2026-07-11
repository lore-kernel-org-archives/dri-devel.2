Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF8BC43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 03:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B112E10E2A9;
	Sat, 11 Jul 2026 03:45:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ToZw0tyx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6493510E2A9
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 03:45:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0349041FD3;
 Sat, 11 Jul 2026 03:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F551F000E9;
 Sat, 11 Jul 2026 03:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783741523;
 bh=viDOOzpfwcVWzpAsb6JK8vfjR6gmgHw1g5ta+QmYFGA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ToZw0tyxUdwg5Px5lAkD0EIMspOJSt6GEkY7LrMHWnbPXE/YKlwzDpDvu3tm+3/4L
 GkERIokB7P9u0ZoLD/N/h47SoGeMvMCTX80TeDKx3cR0SIVy8rCss0iYeKkvFMlkYy
 Uo773xk7MkadLjVHxOLjjiVyH4oXGw6t0Hw9EFPHFAsIxoXZaFuxnbqiCGva52bIjE
 l/zsP3c1pG2DhxgT8Zkid1C4OBrVsDtd9kScKd6h40y8CNUHAu6dfLbmc/KoF+hy5A
 /qm0FQ3iHfzqZSzs7N1birIyAXV3lH8svhrDgkVzw7MlkCegQOpDu1NG18o1mSdvZZ
 Gg7wx0hPsEZuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: Fix writeback completion timing
To: "Alex Hung" <alex.hung@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711033159.3096477-1-alex.hung@amd.com>
References: <20260711033159.3096477-1-alex.hung@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 03:45:23 +0000
Message-Id: <20260711034523.B8F551F000E9@smtp.kernel.org>
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

New issues:
- [High] Lockless state machine corruption on overlapping writeback jobs st=
alls fences and leaks vblank references.

Pre-existing issues:
- [High] Unconditional memory leak of dc_writeback_info structure in dm_set=
_writeback.
--

--- Patch [1]: [PATCH] drm/amd/display: Fix writeback completion timing ---
commit d7178e82119f1d066c5082ca676728119bef3a13
Author: Alex Hung <alex.hung@amd.com>

drm/amd/display: Fix writeback completion timing

Hold a vblank reference while writeback is pending and signal the out
fence on the second vblank instead of using mdelay(). Add
amdgpu_dm_crtc_complete_writeback() to finish and clean up writeback
from both the IRQ and teardown paths.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b97ceabe61736..90ee250e6e360 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
[ ... ]
> @@ -4988,6 +4989,7 @@ static void dm_set_writeback(struct amdgpu_display_=
manager *dm,
>  	 * cannot run its matching vblank_put before this get.
>  	 */
>  	WARN_ON(drm_crtc_vblank_get(&acrtc->base));
> +	acrtc->wb_frame_done =3D false;
>  	acrtc->wb_pending =3D true;

[Severity: High]
Does this lockless state update cause issues if userspace submits another
writeback job immediately?

Since page flip events can signal on the first vblank, userspace could
submit a new atomic commit before the second vblank occurs. If a new
job is submitted in this window, dm_set_writeback() will overwrite
acrtc->wb_frame_done =3D false and acrtc->wb_pending =3D true without
holding a lock to protect the active job's state.

[Severity: High]
This is a pre-existing issue, but does this function leak the memory
allocated for wb_info?

Earlier in dm_set_writeback(), wb_info is allocated:

	wb_info =3D kzalloc(sizeof(*wb_info), GFP_KERNEL);

Then it is passed to dc_stream_add_writeback():

	dc_stream_add_writeback(dm->dc, crtc_state->stream, wb_info);

Since dc_stream_add_writeback() copies the structure by value into the
stream's array and does not take ownership of the pointer, it seems the
originally allocated wb_info pointer is never freed before returning.
Could this lead to continuous kernel memory leakage when userspace streams
writeback?

>  }
> =20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> index c5467f34c51f1..4de7fb264cb26 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -1974,23 +1974,26 @@ static void dm_crtc_high_irq(void *interrupt_para=
ms)
>  		return;
> =20
>  	if (acrtc->wb_conn && acrtc->wb_pending) {
> -		struct dc_stream_state *stream =3D acrtc->dm_irq_params.stream;
> -		unsigned int v_total, refresh_hz;
> -
> -		v_total =3D stream->adjust.v_total_max ?
> -			  stream->adjust.v_total_max : stream->timing.v_total;
> -		refresh_hz =3D div_u64((uint64_t) stream->timing.pix_clk_100hz *
> -			     100LL, (v_total * stream->timing.h_total));
> -		mdelay(1000 / refresh_hz);
> -
> -		/*
> -		 * Completion (signalling the out fence and releasing the vblank
> -		 * reference taken in dm_set_writeback()) is handled by the shared
> -		 * helper, which is also used by the teardown path.
> -		 */
> -		if (amdgpu_dm_crtc_complete_writeback(acrtc))
> +		if (acrtc->wb_frame_done) {

[Severity: High]
If the state was overwritten by a new commit as mentioned above, will this
read wb_frame_done =3D=3D false on the second vblank?

If so, it seems it would take the else branch, set wb_frame_done =3D true
again, and completely skip calling amdgpu_dm_crtc_complete_writeback()
for the original job, potentially stalling the out-fence permanently and
leaking a vblank reference.

> +			/*
> +			 * Second vblank: the DMA for the captured frame has
> +			 * had a full frame period to flush to memory. Signal
> +			 * the out fence now.
> +			 */
> +			amdgpu_dm_crtc_complete_writeback(acrtc);
> +		} else {
> +			/*
> +			 * First vblank after arming: the frame has been
> +			 * scanned out and the DMA is finishing. Disable
> +			 * writeback immediately to prevent the hardware from
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711033159.3096=
477-1-alex.hung@amd.com?part=3D1
