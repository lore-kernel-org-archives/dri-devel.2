Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2829606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UebERdyA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A4BB10FA05;
	Wed, 11 Nov 2026 09:19:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C928010E28A
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:19:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D595063BB0;
 Wed, 11 Nov 2026 09:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489321F00A05;
 Wed, 11 Nov 2026 09:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794388759;
 bh=YnphlhXiHCo99McvrScs28Qk/SFzbZH4FbeN88AR3rQ=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=UebERdyA/6i8Ypk01nc/yvnnRyjNsLVFk1a2e7l8eWd5n8CurhqLFUFqol2n1NE2+
 JRQWBaYsyUvXS2WE38YWSbcuYow+tTQwYRACLKNB0RDpktujOn7GlKFTN8p9kPdDCq
 KaYaCB5FbTLUYgWpwFbNu+9wdndAEuJ2ogEPtj8SZscHuXdADJ6/4U+RIbXimxHh+6
 iYYW+4gecE6nMBgCh2xLEcN0/GWg2NXjgPlTYMpI8gVTfLFV2fM8PpLd+pjv8pwjDm
 SgAv05YWaVJ4Opfrwro2WnMGGM3dtSM7dvAD7mTDqiQGRvGCusjF6FV6x1HxYbCQMq
 6yDfP9LUOKebQ==
Message-ID: <sashiko-outbox-208682@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] drm/amd/display: turn vblank off in DRM across GPU
 reset
To: "Prike Liang" <Prike.Liang@amd.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261111083534.514290-4-Prike.Liang@amd.com>
References: <20261111083534.514290-1-Prike.Liang@amd.com>
 <20261111083534.514290-4-Prike.Liang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 09:19:18 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] drm/amd/display: missing Signed-off-by trailer in commit
  message
- [High] drm/amd/display: dm_gpureset_toggle_vblank() leaks
  active_vblank_irq_count
- [High] drm/amd/display: stale vblank->last in
  dm_gpureset_toggle_vblank() on resume
- [Medium] drm/amd/display: racy crtc state access in
  dm_gpureset_toggle_vblank()
- [Medium] drm/amd/display: vblank left disabled on dm_suspend()
  zero-streams error
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] drm/amd/display: dc_lock deadlock in handle_hpd_rx_irq() during
  GPU reset [1]
--

commit d669822b620fb7fc244d14e47f0566cf3ab18695
Author: Prike Liang <Prike.Liang@amd.com>

> drm/amd/display: turn vblank off in DRM across GPU reset
>
> For a GPU reset, dm_suspend() stops all streams with
> amdgpu_dm_commit_zero_streams() and toggles the OTG interrupts
> directly, and dm_resume() restores the cached DC state the same way.
> Neither goes through manage_dm_interrupts(), so DRM is never told that
> vblank stops: drm_crtc_vblank_get() keeps succeeding while no vblank
> interrupt can arrive until the streams are back.
>
> Since commit ebc3351cc4a9 ("drm/amdgpu: remove suspend/resume DRM
> clients during GPU recovery"), the fbdev client keeps running during
> recovery, and its damage worker rate-limits display updates with
> drm_client_modeset_wait_for_vblank(). Every display update during the
> reset then waits for a vblank that never comes, until the wait times
> out and warns:
>
>   amdgpu 0000:03:00.0: [drm] vblank wait timed out on crtc 0
>   WARNING: drivers/gpu/drm/drm_vblank.c:1320 at drm_crtc_wait_one_vblank+=
0x194/0x200
>   Workqueue: events drm_fb_helper_damage_work
>   Call Trace:
>    drm_client_modeset_wait_for_vblank+0x63/0x80
>    drm_fb_helper_damage_work+0x89/0x1a0
>
> FBIO_WAITFORVSYNC runs into the same timeout, and DRM_IOCTL_WAIT_VBLANK
> sleeps until its own 3 second timeout.
>
> Do what a regular CRTC disable does: call drm_crtc_vblank_off() for the
> CRTCs of the cached DC state before their streams are stopped, and
> drm_crtc_vblank_on_config() with their existing configuration once the
> streams and interrupts are restored. drm_crtc_vblank_get() then fails
> for the duration of the reset, so drm_client_modeset_wait_for_vblank()
> doesn't wait at all, and DRM_IOCTL_WAIT_VBLANK waiters are woken up.
> Page flips that get to amdgpu_dm_commit_planes() meanwhile have their
> event sent right away, see the previous patch.
>
> drm_crtc_vblank_off() also clears the vblank timestamping constants,
> which a modeset sets again before it turns vblank back on. Recompute
> them from the CRTC state after the reset as well; otherwise the vblank
> timestamp query in drm_crtc_vblank_on_config() warns about an
> uninitialized mode.
>
> A modeset that waits for dc_lock during the reset may be turning one of
> these CRTCs off. Leave vblank off for a CRTC that is no longer enabled;
> amdgpu_dm_crtc_set_vblank() would refuse to enable vblank on it anyway.
>
> Neither call can block on the reset: drm_crtc_vblank_off() only takes
> spinlocks and flushes the DRM vblank worker, which DM doesn't use, and
> amdgpu_dm_crtc_set_vblank() doesn't queue vblank_control_work during a
> reset. Unlike suspending the DRM clients, this doesn't make recovery
> wait for anything that may itself depend on the reset.
>
> Add KUnit tests for the new helper.
>
> Fixes: ebc3351cc4a9 ("drm/amdgpu: remove suspend/resume DRM clients durin=
g GPU recovery")
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Assisted-by: Copilot:claude-opus-5.5

[Severity: High]
The commit message is missing a Signed-off-by: trailer from the author.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 22d5ac351f87c..2f60ad0746764 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1494,6 +1494,56 @@ STATIC_IFN_KUNIT void dm_gpureset_toggle_interrupt=
s(struct amdgpu_device *adev,
>  }
>  EXPORT_IF_KUNIT(dm_gpureset_toggle_interrupts);
> =20
> +/**
> + * dm_gpureset_toggle_vblank() - Turn DRM vblank off or on around a GPU =
reset
> + * @adev: amdgpu device
> + * @state: DC state whose streams the reset stops and restores
> + * @enable: false before the streams are stopped, true once they are res=
tored
> + *
> + * The GPU reset path stops and restores the streams through DC directly=
 and
> + * bypasses manage_dm_interrupts(). Turn vblank off in DRM like a CRTC
> + * disable does, so that drm_crtc_vblank_get() fails while no vblank
> + * interrupt can arrive, instead of letting vblank waiters such as the f=
bdev
> + * damage worker sleep until they time out.
> + */
> +STATIC_IFN_KUNIT void dm_gpureset_toggle_vblank(struct amdgpu_device *ad=
ev,
> +						struct dc_state *state, bool enable)
> +{
> +	struct drm_vblank_crtc_config config;
> +	struct amdgpu_crtc *acrtc;
> +	int i;
> +
> +	for (i =3D 0; i < state->stream_count; i++) {
> +		int otg_inst =3D state->stream_status[i].primary_otg_inst;
> +
> +		acrtc =3D amdgpu_dm_get_crtc_by_otg_inst(adev, otg_inst);
> +		if (!acrtc)
> +			continue;
> +
> +		if (!enable) {
> +			drm_crtc_vblank_off(&acrtc->base);
> +			continue;
> +		}

[Severity: High]
Does turning vblank off here leak dm->active_vblank_irq_count when vblank
was enabled before the reset?

When vblank was enabled prior to the reset, amdgpu_dm_crtc_set_vblank()
queued vblank_control_work, which incremented dm->active_vblank_irq_count
and sent DM_ISM_EVENT_EXIT_IDLE_REQUESTED to acrtc->ism.

During the reset, drm_crtc_vblank_off() calls
drm_vblank_disable_and_save() -> amdgpu_dm_crtc_set_vblank(crtc, false)
and sets vblank->enabled =3D false, but amdgpu_dm_crtc_set_vblank() returns
early because amdgpu_in_reset(adev) is true:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c:amdgpu_dm_crtc_set_v=
blank() {
    ...
	if (amdgpu_in_reset(adev))
		return 0;
    ...
}

drm_crtc_vblank_off() then wakes vblank->queue so waiters drop their
vblank references.  On resume, drm_crtc_vblank_on_config() sees
vblank->refcount =3D=3D 0 and config.offdelay_ms > 0, so it leaves
vblank->enabled as false without re-enabling vblank.  No matching disable
work ever runs, leaving dm->active_vblank_irq_count permanently elevated
and preventing dm_ism_commit_idle_optimization_state() and
amdgpu_dm_commit_streams() from re-enabling display idle optimizations
(dc_allow_idle_optimizations(dm->dc, true)).

> +
> +		/*
> +		 * A modeset waiting for dc_lock may be turning the CRTC off,
> +		 * and amdgpu_dm_crtc_set_vblank() refuses to enable vblank on
> +		 * it then. Leave its vblank off.
> +		 */
> +		if (!acrtc->base.enabled)
> +			continue;
> +
> +		/* drm_crtc_vblank_off() cleared the timestamping constants. */
> +		drm_calc_timestamping_constants(&acrtc->base,
> +						&acrtc->base.state->adjusted_mode);
> +
> +		/* Keep the off delay that manage_dm_interrupts() configured. */
> +		config =3D drm_crtc_vblank_crtc(&acrtc->base)->config;
> +		drm_crtc_vblank_on_config(&acrtc->base, &config);
> +	}
> +}
> +EXPORT_IF_KUNIT(dm_gpureset_toggle_vblank);

[Severity: High]
Does drm_crtc_vblank_on_config() leave vblank->last set to the pre-reset
frame count while the OTG hardware counter has restarted from 0?

During GPU recovery, the reset thread holds down_write(&adev->reset_domain-=
>sem)
across both dm_suspend() and dm_resume().  When dm_gpureset_toggle_vblank()
calls drm_crtc_vblank_off() and drm_crtc_vblank_on_config() ->
drm_reset_vblank_timestamp(), both query amdgpu_get_vblank_counter_kms() in
task context:

drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c:amdgpu_get_vblank_counter_kms() {
    ...
	if (!down_read_trylock(&adev->reset_domain->sem))
		return drm_crtc_vblank_count(crtc);
    ...
}

Because down_read_trylock() fails while reset_domain->sem is write-locked,
drm_update_vblank_count() on suspend stores the truncated 64-bit software
counter into the 24-bit hardware baseline vblank->last.  Even with commit
"drm/amdgpu: keep reading the vblank counter in IRQ context during reset"
later in this series returning vblank->last in task context,
drm_reset_vblank_timestamp() in dm_resume() still cannot read the post-reset
OTG hardware counter (which dc_commit_streams() just reset to 0) and stores
the old pre-reset vblank->last back into vblank->last.  When the first
post-reset vblank IRQ or drm_vblank_enable() reads the hardware counter
near 0, drm_update_vblank_count() computes (cur_vblank - vblank->last) &
max_vblank_count (0x00ffffff), jumping the software vblank counter forward
by up to ~16.7 million frames.

[Severity: Medium]
Can dm_gpureset_toggle_vblank() race with a concurrent atomic commit that
is deactivating or updating the CRTC?

CPU0 (atomic commit)              CPU1 (GPU reset)
amdgpu_dm_atomic_commit_tail()
  amdgpu_dm_commit_streams()
    manage_dm_interrupts(..., NULL)
      drm_crtc_vblank_off()
    ...
    mutex_lock(&dm->dc_lock)
      <blocks>
                                  dm_resume()
                                    ...
                                    dm_gpureset_toggle_vblank(..., true)
                                      if (!acrtc->base.enabled)
                                      drm_crtc_vblank_on_config()
                                    mutex_unlock(&dm->dc_lock)
    remove_stream(adev, acrtc, ...)
    dc_commit_streams()

On a DPMS-off commit (old_crtc_state->active && !new_crtc_state->active
with new_crtc_state->enable =3D=3D true), acrtc->base.enabled remains true.
amdgpu_dm_commit_streams() calls manage_dm_interrupts(adev, acrtc, NULL) to
turn vblank off before acquiring dm->dc_lock and calling remove_stream() to
clear acrtc->otg_inst.  If GPU reset runs while amdgpu_dm_commit_streams()
is waiting on dm->dc_lock, dm_gpureset_toggle_vblank() sees
acrtc->base.enabled =3D=3D true and turns vblank back on, after which
amdgpu_dm_commit_streams() removes the stream and finishes with vblank left
enabled on an inactive CRTC.

In addition, for a full CRTC disable (new_crtc_state->enable =3D=3D false),
drm_atomic_helper_swap_state() swaps acrtc->base.state to the disabled state
(with adjusted_mode.crtc_clock =3D=3D 0) before
drm_atomic_helper_update_legacy_modeset_state() clears acrtc->base.enabled,
so dm_gpureset_toggle_vblank() can pass a zeroed mode to
drm_calc_timestamping_constants() and trigger drm_WARN_ON_ONCE() in
drm_crtc_vblank_on_config().  And because dm_gpureset_toggle_vblank() does
not hold crtc->mutex, a concurrent fast atomic commit that does not take
dm->dc_lock can swap and free acrtc->base.state while
acrtc->base.state->adjusted_mode is being read.

Would getting the mode from state->streams[i] and checking
acrtc->base.state->active (or reconciling with the ongoing commit) avoid
reading acrtc->base.state unlocked and re-enabling vblank on a deactivating
CRTC?

> @@ -1628,6 +1678,7 @@ static int dm_suspend(struct amdgpu_ip_block *ip_bl=
ock)
>  			return -ENOMEM;
>  		}
> =20
> +		dm_gpureset_toggle_vblank(adev, dm->cached_dc_state, false);
>  		dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
> =20
>  		res =3D amdgpu_dm_commit_zero_streams(dm->dc);

[Severity: Medium]
If amdgpu_dm_commit_zero_streams() fails just below this, does the error
path leave vblank and OTG interrupts disabled?

On error, dm_suspend() frees dm->cached_dc_state and returns -EINVAL, so
amdgpu_ip_block_suspend() leaves ip_block->status.hw as true and
amdgpu_device_ip_resume_phase3() skips dm_resume(), leaving DRM vblank and
display interrupts permanently off for the active CRTCs.

[Severity: High]
This problem wasn't introduced by this patch, but can dm_suspend() deadlock
on dm->dc_lock with a concurrent HPD RX IRQ worker during GPU reset
[1]?

CPU0                              kworker
----                              -------
mutex_lock(&dm->dc_lock)
                                  handle_hpd_rx_irq()
flush_work(&handler->work)
                                  mutex_lock(&adev->dm.dc_lock)

 *** DEADLOCK ***

CPU0: dm_suspend() -> amdgpu_dm_irq_suspend() -> flush_low_context_interrup=
t()
kworker: dm_irq_work_func() -> handle_hpd_rx_irq()

In the amdgpu_in_reset(adev) branch, dm_suspend() acquires dm->dc_lock
before calling amdgpu_dm_irq_suspend(), which flushes the low-context HPD
RX work queue while handle_hpd_rx_irq() takes adev->dm.dc_lock around
dc_link_detect().

[1] https://sashiko.dev/#/bug/linux-f34e9965-c69d-47c0-99f8-2d9e9bfb8858

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111083534.5142=
90-1-Prike.Liang@amd.com?part=3D4
