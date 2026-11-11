Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571CC606A334
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ew7SYgA6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6FEE10F9B6;
	Wed, 11 Nov 2026 09:09:44 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C5E210F9B6
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:09:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 432CD637DC;
 Wed, 11 Nov 2026 09:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19001F00A05;
 Wed, 11 Nov 2026 09:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794388177;
 bh=ev8TwzbAoRhim8iJ3d3wItTcbuDYwwVoHEmIQ/BOWvU=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Ew7SYgA6VbqOMDKZNySZsAr4R65lW9juHeBAZkriWY4YCpBsm+sSKHfRgRtnix9fM
 aW3sA69+HcJm0R5lmcLiNhdZMIo+nNzctM9LJ3O8v31zCuDE6gfosnls8w8xMzB1Wu
 qrMoO8vZGATAsfU8STT1PKSECLaXhWiAXrKMFQCG1P1uy5iCBwVcS3QpcA5uTNorjd
 XIaJ1DU1ysoiTasvTKOtD4oHU+Jd0TLaikjGHwWSDUhdMFSlNDg1/s8TlwqDVzwyGs
 1bF/qVaI02UU9auN47CxmVJx5myM5dawfnOpXB4NPXpl26ZbZ58+j8frwknW+PyjZC
 lOfG12O9cm9ow==
Message-ID: <sashiko-outbox-208665@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] drm/amdgpu: keep reading the vblank counter in IRQ
 context during reset
To: "Prike Liang" <Prike.Liang@amd.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261111083534.514290-5-Prike.Liang@amd.com>
References: <20261111083534.514290-1-Prike.Liang@amd.com>
 <20261111083534.514290-5-Prike.Liang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 09:09:36 +0000
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
- [High] drm/amdgpu: missing Signed-off-by trailer in commit message
- [High] drm/amdgpu: self-exclusion of reset task in
  amdgpu_get_vblank_counter_kms()
- [Medium] drm/amdgpu: vblank->last corruption in
  amdgpu_get_vblank_counter_kms()
- [Medium] drm/amdgpu: in_task() in amdgpu_get_vblank_counter_kms() true
  in threaded IRQ
- [Low] drm/amdgpu: commit message omits vblank->last fallback change
--

commit 65f179edc9e1f1c857a1c9cda00e5004a70269a6
Author: Prike Liang <Prike.Liang@amd.com>

> drm/amdgpu: keep reading the vblank counter in IRQ context during reset
>
> amdgpu_get_vblank_counter_kms() returns the cached vblank->last instead
> of reading the hardware counter whenever it can't take
> reset_domain->sem for reading. The vblank interrupt reads the counter
> through the same callback via drm_crtc_handle_vblank(), so once GPU
> recovery holds the semaphore for writing, every vblank interrupt sees
> diff =3D=3D 0 and the DRM vblank count stops advancing. The CRTCs keep
> scanning out until dm_suspend() turns vblank off and stops the streams,
> though, which only happens after the rest of the recovery preparation.
>
> Vblank waits in that window don't see a vblank anymore. They only end
> when dm_suspend() turns vblank off, or after a second with the
> "vblank wait timed out" warning if that takes longer. The fbdev damage
> worker is likely to be waiting already, because recovery prints
> "GPU reset begin!" right before it takes the semaphore.
>
> Vblank interrupts only arrive while a CRTC is scanning out, so the
> interrupt path can read the hardware counter.
> amdgpu_device_skip_hw_access() likewise only checks the reset semaphore
> in task context. Only back off in task context, so the interrupt path
> keeps the count moving until DM turns vblank off.
>
> Fixes: f2bc71d16e73 ("drm/amdgpu: serialize vblank counter reads against =
GPU reset")
> Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Cc: James Lin <pinglei.lin@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Assisted-by: Copilot:claude-opus-5.5

[Severity: High]
The commit message is missing a Signed-off-by: trailer.

[Severity: Low]
Prior to this patch, f2bc71d16e73 ("drm/amdgpu: serialize vblank counter
reads against GPU reset") returned drm_crtc_vblank_count(crtc) rather than
vblank->last when the trylock failed.  Should the commit message describe
changing the fallback return value from drm_crtc_vblank_count(crtc) to
drm_crtc_vblank_crtc(crtc)->last instead of stating that it already
returned vblank->last?

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 8e7e522a89e42..07d178031abb5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1691,6 +1691,7 @@ u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *=
crtc)
>  	struct drm_device *dev =3D crtc->dev;
>  	unsigned int pipe =3D crtc->index;
>  	struct amdgpu_device *adev =3D drm_to_adev(dev);
> +	bool locked =3D false;
>  	int vpos, hpos, stat;
>  	u32 count;
> =20
> @@ -1698,9 +1699,26 @@ u32 amdgpu_get_vblank_counter_kms(struct drm_crtc =
*crtc)
>  		DRM_ERROR("Invalid crtc %u\n", pipe);
>  		return -EINVAL;
>  	}
> -	if (!down_read_trylock(&adev->reset_domain->sem))
> -		return drm_crtc_vblank_count(crtc);
> =20
> +	/*
> +	 * A GPU reset is in progress and the display hardware cannot be read
> +	 * safely. Return the hardware counter value DRM already cached rather
> +	 * than the software vblank count: the core feeds this callback's
> +	 * result back into vblank->last, and a software count lives in a
> +	 * different numeric domain, which later trips
> +	 * drm_WARN_ON_ONCE(cur_vblank !=3D vblank->last) in
> +	 * drm_update_vblank_count().
> +	 *
> +	 * Only task context has to back off. Vblank interrupts only arrive
> +	 * while a CRTC is scanning out, so the interrupt path can read the
> +	 * hardware, and it has to keep counting: vblank waits that already
> +	 * sleep when a reset takes the semaphore never complete otherwise.
> +	 */
> +	if (in_task()) {
> +		if (!down_read_trylock(&adev->reset_domain->sem))
> +			return drm_crtc_vblank_crtc(crtc)->last;
> +		locked =3D true;
> +	}

[Severity: High]
Does down_read_trylock(&adev->reset_domain->sem) also exclude the GPU
recovery task itself during dm_resume()?

amdgpu_device_gpu_recover() holds reset_domain->sem for writing across
amdgpu_device_asic_reset().  After the ASIC reset zeroes the 24-bit
hardware frame counter, dm_resume() runs in task context while still
holding the write lock and calls dm_gpureset_toggle_vblank() ->
drm_crtc_vblank_on_config() -> drm_reset_vblank_timestamp() ->
amdgpu_get_vblank_counter_kms().  Because down_read_trylock() fails even
for the write-lock owner, drm_reset_vblank_timestamp() stores the stale
pre-reset vblank->last instead of the zeroed post-reset hardware counter.
On the first post-reset vblank interrupt or query,
drm_update_vblank_count() computes (cur_vblank - vblank->last) &
max_vblank_count with cur_vblank < vblank->last, wrapping around
0x00ffffff and jumping the DRM vblank counter forward by ~16.7 million
frames.

[Severity: Medium]
Can returning vblank->last in task context corrupt vblank->last when
vblank is enabled during the reset preparation window?

If vblank was disabled before reset and a task (such as
drm_fb_helper_damage_work) calls drm_vblank_get() -> drm_vblank_enable()
after reset_domain->sem is write-locked but before dm_suspend() runs,
amdgpu_dm_crtc_set_vblank() calls drm_crtc_vblank_restore() when IPS and
self-refresh are enabled with disable_immediate:

drivers/gpu/drm/drm_vblank.c:drm_vblank_restore() {
    ...
	get_vblank_counter_and_timestamp(dev, pipe, &cur_vblank,
					 &t_vblank, false);

	diff_ns =3D ktime_to_ns(ktime_sub(t_vblank, vblank->time));
	if (framedur_ns)
		diff =3D DIV_ROUND_CLOSEST_ULL(diff_ns, framedur_ns);
    ...
	vblank->last =3D (cur_vblank - diff) & max_vblank_count;
}

Because amdgpu_get_vblank_counter_kms() returns the stale vblank->last as
cur_vblank while drm_get_last_vbltimestamp() ->
amdgpu_crtc_get_scanout_position() still reads the display registers
without holding reset_domain->sem (triggering the lockdep assert in
amdgpu_device_skip_hw_access()), drm_vblank_restore() sets vblank->last to
(vblank->last - diff) & max_vblank_count.  The next vblank interrupt then
reads the real hardware counter in hardirq context and compares it against
(vblank->last - diff), double-counting diff (or wrapping around
max_vblank_count if IPS/PSR reset the hardware counter while vblank was
off).

[Severity: Medium]
Does checking in_task() still back off in the vblank interrupt handler
when forced IRQ threading (CONFIG_PREEMPT_RT or threadirqs) is enabled?

amdgpu_irq_init() requests the IRQ without IRQF_NO_THREAD, so under forced
IRQ threading amdgpu_irq_handler() runs in irq_forced_thread_fn() under
local_bh_disable().  That sets SOFTIRQ_DISABLE_OFFSET rather than
HARDIRQ_MASK or SOFTIRQ_OFFSET, so in_task() returns true and the threaded
vblank interrupt handler still takes the trylock backoff path and returns
vblank->last during reset.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111083534.5142=
90-1-Prike.Liang@amd.com?part=3D5
