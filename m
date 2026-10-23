Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB82E606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P1WXlcf2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B698112D24;
	Fri, 23 Oct 2026 23:55:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2D1A112D24
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:55:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A27AC43230;
 Fri, 23 Oct 2026 23:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7F21F01829;
 Fri, 23 Oct 2026 23:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792799730;
 bh=/TEKOEdyGLRLDw966kfpxuhl28Q/ZVRJhFU9PH9ywN4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P1WXlcf2LKfZTm7bLdlBEjp7UJhwaVzv5R271eg0cw6ktAhG6CkZQDtfX35BvgSpF
 EUZ0qmqGKa8mMbjfuo5f8RMmDrWBtgtsLsWhl+E819s5qbT8sn8hvGTrt6cPAJl/BU
 VQPoWW//9n26MIujMbGVo04iGZQ6deUYP3kzZ3Gm4e9yo6alszBd7ep+4g3AfGY+yQ
 nsurwR6ItK3do6febbP91dTjjW4CeuVmMveIXG6b9bjq4rp5QMDVhNOgwwUIfJ0dUA
 +dkS/T5TbW0ZQew+r0XH/+XncL0XuEq9/C4JtPbvGXzT3A+phIoGpg6geFxG8NyJy0
 Y8W98J4TBwMKg==
Message-ID: <sashiko-outbox-183438@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/10] drm/msm: release scanout framebuffers only
 after a vblank
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261024-fd-kms-fix-smmu-v5-3-a5b0b284aead@oss.qualcomm.com>
References: <20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com>
 <20261024-fd-kms-fix-smmu-v5-3-a5b0b284aead@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 23:55:29 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/msm: unpin stall in msm_framebuffer_cleanup() on writeback CRT=
C planes
- [High] drm/msm: premature fb unpin in msm_atomic_commit_tail() async path
--

commit ee002ddb1edfe27610ec310afec717b4795eee7e
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm: release scanout framebuffers only after a vblank

This patch defers unpinning retired scanout framebuffers to a
drm_vblank_work scheduled on the CRTC, preventing the display controller
from fetching from an unmapped IOMMU VMA before the next vblank latches the
new configuration. Pending unpin works are tracked per CRTC and released
directly in msm_crtc_vblank_off() when a CRTC is disabled.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/=
msm/disp/dpu1/dpu_plane.c
> index 7b92082d35a64..0e986b533bf07 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -684,7 +684,8 @@ static void dpu_plane_cleanup_fb(struct drm_plane *pl=
ane,
> =20
>  	DPU_DEBUG_PLANE(pdpu, "FB[%u]\n", old_state->fb->base.id);
> =20
> -	msm_framebuffer_cleanup(old_state->fb, old_pstate->needs_dirtyfb);
> +	msm_framebuffer_cleanup(old_state->fb, old_state->crtc,
> +				old_pstate->needs_dirtyfb);
>  }

[Severity: High]
When a CRTC is driven by a standalone writeback encoder, can passing
old_state->crtc here leave the retired source plane framebuffer pinned on
kms->fb_unpin[idx].fbs indefinitely after the writeback completes?

In dpu_crtc_enable(), msm_crtc_vblank_on(crtc) is called for all CRTCs,
which clears vblank->inmodeset and sets kms->fb_unpin[idx].vblank_off =3D
false.

During a standalone writeback commit in msm_atomic_commit_tail(),
kms->funcs->wait_flush() blocks in dpu_encoder_phys_wb_wait_for_commit_done=
()
until dpu_encoder_phys_wb_done_irq() runs:

drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c:dpu_encoder_phys_wb_don=
e_irq()
    dpu_encoder_frame_done_callback(phys_enc->parent, phys_enc, event);
    dpu_encoder_vblank_callback(phys_enc->parent, phys_enc);
    ...
    wake_up_all(&phys_enc->pending_kickoff_wq);

At that point, the hardware has finished reading the input planes and the
only vblank for the one-shot writeback transfer has already been signaled v=
ia
dpu_encoder_vblank_callback() -> dpu_crtc_vblank_callback() ->
drm_crtc_handle_vblank().

Only after wait_flush() returns does msm_atomic_commit_tail() run
drm_atomic_helper_cleanup_planes() -> dpu_plane_cleanup_fb() ->
msm_framebuffer_cleanup(), which schedules msm_fb_unpin_work for
drm_crtc_vblank_count(crtc) + 1.

Because the writeback encoder is one-shot and has no free-running timing
engine (and subsequent commits without a new writeback job skip kickoff in
dpu_crtc_commit_kickoff() when !dpu_encoder_is_valid_for_commit(encoder)),
no further vblank arrives to run the work, leaving the drm_framebuffer
reference, prepare_count pin, kms->vm VMA, and vblank reference held until
another writeback job is submitted or the CRTC is disabled.

[ ... ]

> diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
> index 9a207c1e85837..d836d6dd7f3ec 100644
> --- a/drivers/gpu/drm/msm/msm_kms.c
> +++ b/drivers/gpu/drm/msm/msm_kms.c

[ ... ]

> +/*
> + * Publish and schedule the work in one go under the lock, as
> + * msm_crtc_vblank_off() frees whatever it finds on the list.
> + */
> +static bool msm_kms_fb_unpin_schedule(struct msm_kms_fb_unpin *pending,
> +				      struct msm_fb_unpin_work *unpin,
> +				      struct drm_crtc *crtc)
> +{
> +	guard(spinlock)(&pending->lock);
> +
> +	if (pending->vblank_off)
> +		return false;
> +
> +	list_add_tail(&unpin->node, &pending->fbs);
> +
> +	if (drm_vblank_work_schedule(&unpin->base,
> +				     drm_crtc_vblank_count(crtc) + 1, true) =3D=3D 1)
> +		return true;

[Severity: High]
Could scheduling the unpin for drm_crtc_vblank_count(crtc) + 1 unpin and
unmap the old cursor framebuffer one frame too early on the timer-deferred
async path in msm_atomic_commit_tail()?

When a legacy cursor update changes or disables the cursor framebuffer
(state->legacy_cursor_update =3D true), DPU1 and MDP4 do not implement
atomic_async_check, and mdp5_plane_atomic_async_check() rejects framebuffer
changes (plane->state->fb !=3D new_plane_state->fb). As a result, the commit
goes through msm_atomic_commit_tail() with async =3D can_do_async(state,
&async_crtc) =3D=3D true:

drivers/gpu/drm/msm/msm_atomic.c:msm_atomic_commit_tail()
    if (async) {
        if (!(kms->pending_crtc_mask & crtc_mask)) {
            ...
            if (drm_crtc_next_vblank_start(async_crtc, &vsync_time))
                goto fallback;

            wakeup_time =3D ktime_sub(vsync_time, ms_to_ktime(1));

            msm_hrtimer_queue_work(&timer->work, wakeup_time,
                    HRTIMER_MODE_ABS);
        }

        kms->funcs->disable_commit(kms);
        unlock_crtcs(kms, crtc_mask);
        drm_atomic_helper_commit_hw_done(state);
        drm_atomic_helper_cleanup_planes(dev, state);
        ...
        return;
    }

In this branch, kms->funcs->flush_commit() has not been called yet; writing
CTL_FLUSH is deferred to timer->work (msm_atomic_pending_work ->
msm_atomic_async_commit), while drm_atomic_helper_cleanup_planes() runs
immediately and schedules msm_kms_fb_unpin_work for
drm_crtc_vblank_count(crtc) + 1.

If msm_atomic_commit_tail() runs during the Vertical Front Porch (line >
vactive_end), dpu_crtc_get_scanout_position() returns a negative vpos:

drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:dpu_crtc_get_scanout_position()
    if (line < vactive_start)
        line -=3D vactive_start;
    else if (line > vactive_end)
        line =3D line - vfp_end - vactive_start;
    else
        line -=3D vactive_start;

This causes drm_crtc_next_vblank_start() to return vsync_time at the end of
frame N + 1 (before vblank N + 2), while drm_crtc_vblank_count(crtc) is
still N until the VSYNC interrupt fires at line =3D 1. Similarly, if the
cursor update arrives within 1ms of vsync_time or timer->work runs after
programmable fetch start / vblank N + 1, flush_commit() will not latch
until vblank N + 2, but msm_kms_fb_unpin_work will run at vblank N + 1 and
detach the VMA while the hardware is still scanning out the old framebuffer
during frame N + 1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-fd-kms-fix=
-smmu-v5-0-a5b0b284aead@oss.qualcomm.com?part=3D3
