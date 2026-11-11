Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDEC606A327
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7/b6R4s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B59D10FA0D;
	Wed, 11 Nov 2026 09:28:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FD0210FA0D
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:28:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 18CBC40287;
 Wed, 11 Nov 2026 09:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BEE1F00A0D;
 Wed, 11 Nov 2026 09:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794389316;
 bh=BAs8gNVDknXpeDCKIoCwlQG66xQTHmkB1lBB1SBVz74=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=L7/b6R4swFUBARQ1iicL3SRLKW5WmjupN0Ig+4XXfQ2qtoQmln9xXUvi4tFgRWZ9y
 F6fha1qzDupdDMYw6WIOXtuhfbebIy+fh3Txzj2tQXdLtO4DWYuKqhobAncFaGB6av
 969cZd4PltOZ7NEU/jhRkKJfRU1A/75LnvnQezoQMVybt3DqKjX3mw5SfwHm4+Wg7X
 /692+xp08vOHeC2o1e/5fI3nA8zH8ii1NnsoLy7PnEMtdUqe1JqMTn4qgVyRfGQQK3
 WoIgOKR1MPKVrRwMrImGTq79Ti6JPZF4fyQOo4PQ0gtOPuJXHwwK+uP8/W/z+OV6eJ
 Aw3T+eakp8Mzg==
Message-ID: <sashiko-outbox-208696@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 4/5] drm/amd/display: turn vblank off in DRM
 across GPU reset
To: "Prike Liang" <Prike.Liang@amd.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261111085534.514957-4-Prike.Liang@amd.com>
References: <20261111085534.514957-1-Prike.Liang@amd.com>
 <20261111085534.514957-4-Prike.Liang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 09:28:35 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] drm/amd/display: active_vblank_irq_count leak in
  dm_gpureset_toggle_vblank()
- [High] drm/amd/display: vblank counter not sampled in
  dm_gpureset_toggle_vblank()
- [Medium] drm/amd/display: stale crtc->enabled check in
  dm_gpureset_toggle_vblank()
- [Medium] drm/amd/display: vblank left off on dm_suspend() zero-streams
  failure
- [Medium] drm/amd/display: vblank refcount imbalance in VRR and
  writeback during reset
--

commit 15abd68686d02333caad7c1d61e5d6d9f0f989e1
Author: Prike Liang <Prike.Liang@amd.com>

drm/amd/display: turn vblank off in DRM across GPU reset

This commit turns DRM vblank off before stopping DC streams during a GPU
reset and restores it once the streams and interrupts are back.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 22d5ac351f87c..2f60ad0746764 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm.c
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

[Severity: Medium]
Can turning vblank off here cause a vblank reference imbalance when a
concurrent atomic commit enables VRR or arms a writeback job?

amdgpu_dm_handle_vrr_transition() and dm_set_writeback() both call
WARN_ON(drm_crtc_vblank_get(...)) outside dm->dc_lock without checking the
return value:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c:amdgpu_dm_handle=
_vrr_transition() {
    ...
		WARN_ON(drm_crtc_vblank_get(new_state->base.crtc) !=3D 0);
		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=3D%u VRR off->on: Get=
 vblank ref\n",
				 __func__, new_state->base.crtc->base.id);

		scoped_guard(mutex, &dm->dc_lock) {
    ...
}

When drm_crtc_vblank_get() returns -EINVAL during the reset, it triggers
the WARN_ON and takes no reference, but disabling VRR or completing the
writeback later still calls drm_crtc_vblank_put() unconditionally.

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
Does this leak dm->active_vblank_irq_count and leave the CRTC's idle state
manager stuck in DM_ISM_STATE_FULL_POWER_RUNNING whenever vblank was
enabled before the reset?

When vblank is enabled before the reset, amdgpu_dm_crtc_vblank_control_work=
er()
increments dm->active_vblank_irq_count.  During the reset,
drm_crtc_vblank_off() disables vblank and wakes any waiters so they drop
their references, while amdgpu_dm_crtc_set_vblank() returns early because
amdgpu_in_reset(adev) is true:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c:amdgpu_dm_crtc_set_v=
blank() {
    ...
	if (amdgpu_in_reset(adev))
		return 0;

	if (dm->vblank_control_workqueue) {
    ...
}

In dm_resume(), drm_crtc_vblank_on_config() only calls drm_vblank_enable()
when vblank->refcount !=3D 0 || !vblank->config.offdelay_ms.  Because the
waiters already dropped their references and offdelay_ms is non-zero,
vblank->enabled stays false without ever queueing a disable work item to
decrement dm->active_vblank_irq_count or send
DM_ISM_EVENT_ENTER_IDLE_REQUESTED.  Since dm_ism_commit_idle_optimization_s=
tate()
and amdgpu_dm_commit_streams() require dm->active_vblank_irq_count =3D=3D 0,
display idle power optimizations remain permanently disabled after the
reset.

[Severity: Medium]
Can checking only !acrtc->base.enabled turn vblank back on for a CRTC that
is being disabled or put into DPMS off by a concurrent atomic commit?

CPU0 (DPMS-off commit)            CPU1 (GPU reset)
amdgpu_dm_atomic_commit_tail()
  amdgpu_dm_commit_streams()
    manage_dm_interrupts(..., NULL)
      drm_crtc_vblank_off()
                                  dm_suspend()
                                    mutex_lock(&dm->dc_lock)
    mutex_lock(&dm->dc_lock)
      /* blocks */
                                  dm_resume()
                                    dm_gpureset_toggle_vblank(..., true)
                                      /* acrtc->base.enabled is true */
                                      drm_crtc_vblank_on_config()
                                    mutex_unlock(&dm->dc_lock)
    ...
    remove_stream()
      acrtc->otg_inst =3D -1;       <-- vblank left on with no stream

For a DPMS-off commit (new_crtc_state->enable is true,
new_crtc_state->active is false), amdgpu_dm_commit_streams() calls
manage_dm_interrupts(adev, acrtc, NULL) before taking dm->dc_lock to
disable the cursor and clear acrtc->otg_inst.  Because acrtc->base.enabled
remains true while acrtc->base.state->active is false,
dm_gpureset_toggle_vblank() turns vblank back on, and the resuming commit
then removes the stream without calling drm_crtc_vblank_off() again.

Also, if a CRTC-disabling commit has swapped state in
drm_atomic_helper_swap_state() but has not yet reached
drm_atomic_helper_update_legacy_modeset_state(), acrtc->base.enabled is
still true while acrtc->base.state->adjusted_mode.crtc_clock is 0, causing
drm_calc_timestamping_constants() to log a dotclock =3D 0 error and
drm_crtc_vblank_on_config() to warn.

[ ... ]

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
If amdgpu_dm_commit_zero_streams() fails just below, does the error path
leave DRM vblank turned off?

The failure branch releases dm->cached_dc_state and returns -EINVAL without
re-enabling vblank (or interrupts), and amdgpu_device_ip_resume_phase3()
will skip dm_resume() because ip_block->status.hw was not cleared.

> @@ -1967,6 +2018,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_blo=
ck)
>  		dm_gpureset_commit_state(dm->cached_dc_state, dm);
> =20
>  		dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, true);
> +		dm_gpureset_toggle_vblank(adev, dm->cached_dc_state, true);
> =20
>  		dc_state_release(dm->cached_dc_state);
>  		dm->cached_dc_state =3D NULL;

[Severity: High]
Does drm_crtc_vblank_on_config() in dm_gpureset_toggle_vblank() fail to
reset vblank->last to the post-reset hardware frame counter while
adev->reset_domain->sem is write-locked?

dm_resume() runs in task context while the reset thread holds
down_write(&adev->reset_domain->sem).  When drm_crtc_vblank_on_config()
calls drm_reset_vblank_timestamp() -> amdgpu_get_vblank_counter_kms(),
down_read_trylock(&adev->reset_domain->sem) fails:

drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c:amdgpu_get_vblank_counter_kms() {
    ...
	if (!down_read_trylock(&adev->reset_domain->sem))
		return drm_crtc_vblank_count(crtc);
    ...
}

Instead of sampling the hardware OTG frame counter (which reset to 0 when
the streams were recommitted), drm_reset_vblank_timestamp() records the
pre-reset counter in vblank->last (even with commit "drm/amdgpu: keep
reading the vblank counter in IRQ context during reset", which only reads
the hardware counter when !in_task()).  On the first vblank after the
reset, drm_update_vblank_count() sees cur_vblank < vblank->last and wraps
modulo max_vblank_count (0x00ffffff), jumping the DRM vblank counter
forward by up to 16.7 million frames.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111085534.5149=
57-1-Prike.Liang@amd.com?part=3D4
