Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72148606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MvxwWJyF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CE6F1121BB;
	Thu, 19 Nov 2026 08:56:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFA121121BB;
 Thu, 19 Nov 2026 08:56:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 944A241785;
 Thu, 19 Nov 2026 08:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D69D1F000C4;
 Thu, 19 Nov 2026 08:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795078600;
 bh=ydABW8dbshJMKhQpJa1JWwlSldIaEo4ZW6aZ3nVB+yY=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=MvxwWJyFNQM9xtKNxcuxq/R05JEA3NXrSYANOVrODUqhpuo+IGaRfqRk0vSMf5iX/
 QUKiOnjU4Z5Y8h2TTT+7oUO17Tf7TPTk5zrVI5v23p4HvHkaoJ+4HteTXUBDjJMA3z
 Ccipin1HiC6XQRAZyjrx2upEUYKCWcVdYjjpiz17c0skgljNitcXTpaqIl5/ShDgEC
 Zd5VR3wni09djCTgV518zocZz9irLlOVouomW3lLjzfagkF2lbZgNouuaeHZD9wK4J
 mqZBDcOG8xVcdfa0Dt/ujU12GBT1KL/Q62sRqQ4q9mYBXAIebqnf2ucCg+dQuF90JV
 Hi23UPwi+rpVg==
Message-ID: <sashiko-outbox-222747@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] drm/amd/display: turn vblank off in DRM across
 GPU reset
To: "Prike Liang" <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261119082424.554841-5-Prike.Liang@amd.com>
References: <20261119082424.554841-1-Prike.Liang@amd.com>
 <20261119082424.554841-5-Prike.Liang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 08:56:39 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/amd/display: active_vblank_irq_count leak in
  dm_gpureset_toggle_vblank()
- [High] drm/amd/display: race and UAF on acrtc->base.state in
  dm_gpureset_toggle_vblank()
- [Medium] drm/amd/display: dm_gpureset_toggle_vblank() enables vblank
  on DPMS-off CRTC
- [Medium] drm/amd/display: missing vblank rollback in dm_suspend() on
  reset error path
--

commit 55fe8aa3c39160c8faed0a29af7b0acd9dcda97b
Author: Prike Liang <Prike.Liang@amd.com>

drm/amd/display: turn vblank off in DRM across GPU reset

This commit adds dm_gpureset_toggle_vblank() to call drm_crtc_vblank_off()
before stopping streams in dm_suspend() and drm_crtc_vblank_on_config()
after restoring them in dm_resume() during a GPU reset, along with KUnit
tests.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 4184d8fda10ea..b39c975e0e33a 100644
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
Does turning vblank off during reset leak dm->active_vblank_irq_count and
leave acrtc->ism out of idle when vblank was enabled before the reset?

Before the reset starts, enabling vblank queues vblank_control_work with
enable =3D true to amdgpu_dm_crtc_vblank_control_worker(), which increments
dm->active_vblank_irq_count and sends DM_ISM_EVENT_EXIT_IDLE_REQUESTED.

When dm_suspend() calls drm_crtc_vblank_off() during reset,
drm_vblank_disable_and_save() calls amdgpu_dm_crtc_set_vblank(crtc, false)
and sets vblank->enabled =3D false, but amdgpu_dm_crtc_set_vblank() returns
early without queuing vblank_control_work because amdgpu_in_reset(adev) is
true.  drm_crtc_vblank_off() then wakes any waiters (such as
drm_fb_helper_damage_work), which drop their vblank references.  When
dm_resume() later calls drm_crtc_vblank_on_config(), vblank->refcount is 0
and config.offdelay_ms is non-zero, so vblank->enabled stays false and no
matching disable work is ever queued.  Because
dm_ism_commit_idle_optimization_state() requires
dm->active_vblank_irq_count =3D=3D 0, display idle power optimizations rema=
in
blocked after the reset.

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

[Severity: High]
Can reading acrtc->base.state->adjusted_mode here race with a concurrent
atomic commit and cause a use-after-free?

acrtc->base.state is protected by acrtc->base.mutex, while dm_resume() only
holds dm->dc_lock.  Since 1a2b3c4d5e6f is not blocking DRM clients during
recovery (ebc3351cc4a9 ("drm/amdgpu: remove suspend/resume DRM clients
during GPU recovery")), a non-modeset commit on the active CRTC that
updates no enabled planes (planes_count =3D=3D 0 with
acrtc_state->active_planes > 0 in amdgpu_dm_commit_planes()) never takes
dm->dc_lock:

CPU0                                  CPU1
drm_atomic_helper_commit()
  drm_atomic_helper_swap_state()
    /* swaps acrtc->base.state */
                                      dm_resume()
                                        dm_gpureset_toggle_vblank(..., true)
                                          mode =3D &acrtc->base.state->adju=
sted_mode
  commit_tail()
    amdgpu_dm_atomic_commit_tail()
    drm_atomic_commit_put()
      amdgpu_dm_crtc_destroy_state()
        kfree(old_crtc_state)
                                          drm_calc_timestamping_constants(.=
.., mode)
                                            <-- use-after-free

Even for a modeset commit turning the CRTC off that later waits on
dm->dc_lock in amdgpu_dm_commit_streams(), drm_atomic_helper_swap_state()
installs the disabled new_crtc_state (with adjusted_mode.crtc_clock =3D=3D =
0)
before commit_tail() runs drm_atomic_helper_update_legacy_modeset_state()
to clear acrtc->base.enabled, so dm_gpureset_toggle_vblank() can still see
acrtc->base.enabled =3D=3D true while reading the zeroed new_crtc_state.
Could dm_gpureset_toggle_vblank() derive the timing from the cached
dc_stream_state in state->streams[i] instead of dereferencing
acrtc->base.state?

> +
> +		/* Keep the off delay that manage_dm_interrupts() configured. */
> +		config =3D drm_crtc_vblank_crtc(&acrtc->base)->config;
> +		drm_crtc_vblank_on_config(&acrtc->base, &config);
> +	}
> +}
> +EXPORT_IF_KUNIT(dm_gpureset_toggle_vblank);

[Severity: Medium]
Can a concurrent DPMS-off commit waiting on dm->dc_lock leave DRM vblank
enabled on an inactive CRTC?

For a DPMS-off commit (new_crtc_state->enable =3D=3D true,
new_crtc_state->active =3D=3D false),
drm_atomic_helper_update_legacy_modeset_state() keeps acrtc->base.enabled
as true.  In amdgpu_dm_commit_streams(), the commit first calls
manage_dm_interrupts(adev, acrtc, NULL) (turning vblank off) and then
blocks on mutex_lock(&dm->dc_lock) to disable the cursor before
remove_stream() sets acrtc->otg_inst =3D -1:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:amdgpu_dm_commit_streams(=
) {
    ...
		if (old_crtc_state->active &&
		    (!new_crtc_state->active ||
		     drm_atomic_crtc_needs_modeset(new_crtc_state))) {
			manage_dm_interrupts(adev, acrtc, NULL);
			amdgpu_dm_ism_flush(&acrtc->ism);
			dc_stream_release(dm_old_crtc_state->stream);
		}
    ...
		if (old_crtc_state->active && !new_crtc_state->active) {
			struct dc_cursor_position position;

			memset(&position, 0, sizeof(position));
			mutex_lock(&dm->dc_lock);
    ...
}

While the commit is blocked there, acrtc->otg_inst still matches the cached
stream and acrtc->base.enabled is true, so dm_gpureset_toggle_vblank()
calls drm_crtc_vblank_on_config().  When dm_resume() drops dm->dc_lock, the
DPMS-off commit finishes removing the stream without calling
manage_dm_interrupts() again, leaving drm_crtc_vblank_get() succeeding on a
CRTC with no active stream.

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
If amdgpu_dm_commit_zero_streams() fails right after this, dm_suspend()
frees dm->cached_dc_state and returns -EINVAL without re-enabling vblank
(or interrupts).  Because amdgpu_ip_block_suspend() leaves
ip_block->status.hw set to true on error, amdgpu_device_ip_resume_phase3()
skips dm_resume(), leaving DRM vblank permanently off on the active CRTCs.
Should dm_gpureset_toggle_vblank() and dm_gpureset_toggle_interrupts() be
rolled back on that error path, or called after
amdgpu_dm_commit_zero_streams() succeeds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119082424.5548=
41-1-Prike.Liang@amd.com?part=3D5
