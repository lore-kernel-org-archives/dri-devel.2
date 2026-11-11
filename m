Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F41E606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bC9WR99l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41ACF10FA0F;
	Wed, 11 Nov 2026 09:28:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4DFC10FA0D
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:28:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6F19240287;
 Wed, 11 Nov 2026 09:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BEE1F00A06;
 Wed, 11 Nov 2026 09:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794389310;
 bh=9xs3t2w5c8v0QL/UGf3ITtSxA4c691Drv1qqziAEOXA=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=bC9WR99l8gxlNKAlZowklynbr6vl/TXy02P4FCpN0tEoManeiLFec7idXuq+DV0YS
 CqY8ilD3PKYJ7m9n71E5RnwMJPhFbZ5ejU+/jCmAmdw1TDmR5WqWFIHazAA591YdjU
 wRhhrQwri0UUYgkGEXXDJ5yrUDI/D/x8tpxluPkMlniNlxRlPsNvFhjh+jIlXLT0Lf
 jWA92yvKy6g2JmZGsSya2nXxguFmTBGRBKraPsevHdWPjp/oXEeqossn8zrgq1ZgIN
 jd3yXcvcQE1HjhjAGP8JmLe7yXnH+sQOyJa78hGdZ9KYDlo1AfN1/1bkcdJsqodf1P
 3p/UvmWbmT0WQ==
Message-ID: <sashiko-outbox-208694@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 5/5] drm/amdgpu: keep reading the vblank counter
 in IRQ context during reset
To: "Prike Liang" <Prike.Liang@amd.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261111085534.514957-5-Prike.Liang@amd.com>
References: <20261111085534.514957-1-Prike.Liang@amd.com>
 <20261111085534.514957-5-Prike.Liang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 09:28:29 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/amdgpu: vblank counter jump after reset in
  amdgpu_get_vblank_counter_kms()
- [Low] drm/amdgpu: commit message and Fixes SHA mismatch in
  amdgpu_get_vblank_counter_kms()
--

commit 6af07d5a30227ace169063264412acdd7272d49f
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
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

[Severity: Low]
Prior to this patch, amdgpu_get_vblank_counter_kms() returned
drm_crtc_vblank_count(crtc) rather than drm_crtc_vblank_crtc(crtc)->last
when down_read_trylock() failed.  Should the commit message mention
changing that fallback from the software counter to vblank->last?

Also, f2bc71d16e73 ("drm/amdgpu: serialize vblank counter reads against
GPU reset") is not an ancestor in this tree's history, where that commit
is 51a4359f7431 ("drm/amdgpu: serialize vblank counter reads against GPU
reset").

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

[Severity: Medium]
Does returning vblank->last here prevent dm_resume() from re-baselining
vblank->last after an ASIC reset, causing vblank->count to jump forward by
up to ~16.7 million frames?

During GPU recovery, amdgpu_device_gpu_recover() holds reset_domain->sem
for writing on the recovery worker thread (where in_task() is true) across
amdgpu_device_asic_reset().  The ASIC reset zeroes the 24-bit hardware
frame counter, and dm_resume() then runs:

  dm_resume()
    -> dm_gpureset_toggle_vblank()
      -> drm_crtc_vblank_on_config()
        -> drm_reset_vblank_timestamp()
          -> get_vblank_counter_and_timestamp()
            -> amdgpu_get_vblank_counter_kms()

Because the recovery thread itself holds the write lock on
reset_domain->sem, down_read_trylock() fails and returns the stale
pre-reset vblank->last instead of reading the reset hardware counter (0).
drm_reset_vblank_timestamp() stores that stale pre-reset value back into
vblank->last.  On the first post-reset vblank interrupt,
drm_update_vblank_count() computes:

  diff =3D (cur_vblank - vblank->last) & max_vblank_count;

With cur_vblank near 0 and vblank->last still holding the pre-reset count,
this wraps modulo max_vblank_count (0x00ffffff) and advances the DRM
vblank counter by millions of bogus frames (and similarly stops
dm_suspend() -> drm_crtc_vblank_off() from sampling the final pre-reset
hardware counter).  Unlike amdgpu_device_skip_hw_access(), which allows
access when the current task holds the write lock on reset_domain->sem,
down_read_trylock() also rejects the reset thread itself.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111085534.5149=
57-1-Prike.Liang@amd.com?part=3D5
