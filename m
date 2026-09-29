Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792BEC9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:00:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2F3610E287;
	Tue, 29 Sep 2026 04:00:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gfHPfBrE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0BF710E287
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:00:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1548160515;
 Tue, 29 Sep 2026 04:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956951F000FF;
 Tue, 29 Sep 2026 04:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790654431;
 bh=Lci/YH3rtzNL5A0GnjggI8Dnep7wLd9OW51Vl2CYIOI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gfHPfBrEz6lldASlrj/4X+6AfxqTby4gK1LAhmRJgenBob2t9VMfebpt+QDFt2ndS
 4VQXcFB2Y2soLD3aHKaur8kETYq/zmwwEd0hk+TqnBSatsS+VaAQVELs4EdrVD++Ti
 xVFl/v5qkkKxmo8R6XT3f5zbDWmxVfXPLMXlk33sGVDGzqW4pzKMc6s2xaU677Yd+P
 dSoN8X2PY1jFI96K044V3ln9YicaXOtJvb0632lvJre4V/u1GZ0GiHOQv+61RCHaLP
 7a351xgwbEXSJklS934FSFbaKJoXNgvMdDcjRdzTbF0JbTwCaZvjq2+4B9wGRG8Ua1
 /cmUQJ3ns/haA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 15/15] drm/panfrost: Fix races between perfcnt and
 reset sequence
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929-claude-fixes-v12-15-62beb08de207@collabora.com>
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
 <20260929-claude-fixes-v12-15-62beb08de207@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:00:31 +0000
Message-Id: <20260929040031.956951F000FF@smtp.kernel.org>
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
- [Medium] drm/panfrost: perfcnt state flag lost when dump ioctl is interru=
pted by signal
- [Low] drm/panfrost: goto mixing with scoped_guard in panfrost_perfcnt_ena=
ble_locked
--

commit fdd119adb59d54bffaacf2ad45f065092d48a919
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
Subject: drm/panfrost: Fix races between perfcnt and reset sequence

This commit uses the reset r/w semaphore when disabling and re-enabling
perfcnt configuration, and in the enable/dump ioctls where device registers
are being accessed. It also expands the DRM uAPI for the perfcnt dump
operation so that user space is aware of hardware resets. Finally, it
bumps the DRM driver minor number.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index b3f71d7fd82a9..13521e078ce76 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
[ ... ]
> @@ -58,43 +70,161 @@ void panfrost_perfcnt_sample_done(struct panfrost_de=
vice *pfdev)
[ ... ]
> +static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev, u=
32 *state)
>  {
> -	u64 gpuva;
> +	struct panfrost_perfcnt *perfcnt =3D pfdev->perfcnt;
> +	u64 gpuva =3D perfcnt->mapping->mmnode.start << PAGE_SHIFT;
>  	int ret;
> =20
> -	reinit_completion(&pfdev->perfcnt->dump_comp);
> -	gpuva =3D pfdev->perfcnt->mapping->mmnode.start << PAGE_SHIFT;
> -	gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
> -	gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
> -	gpu_write(pfdev, GPU_INT_CLEAR,
> -		  GPU_IRQ_CLEAN_CACHES_COMPLETED |
> -		  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> -	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_SAMPLE);
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		*state =3D perfcnt->state;
> +		if (perfcnt->state & PANFROST_PERFCNT_SESSION_DEAD)
> +			return -EIO;
> +
> +		perfcnt->state =3D 0;

[Severity: Medium]
If wait_for_completion_interruptible_timeout() is interrupted by a signal, =
it
returns -ERESTARTSYS. The syscall will be restarted, but the internal state
(perfcnt->state) has been cleared here and is never restored on the error
path.

Does this mean the restarted ioctl will read a clean state and lose the res=
et
flag that was present before the wait?

> +
> +		reinit_completion(&pfdev->perfcnt->dump_comp);
> +
> +		gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
> +		gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
> +		gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_CLEAN_CACHES_COMPLETED |
> +						GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> +		gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_SAMPLE);
> +	}
> +
> +	/*
> +	 * Here we release the reset semaphore because perfcnt should not get i=
n the way
> +	 * of a HW reset. Besides, a legitimate reset might be issued during th=
e wait.
> +	 */
>  	ret =3D wait_for_completion_interruptible_timeout(&pfdev->perfcnt->dump=
_comp,
>  							msecs_to_jiffies(1000));
> +
> +	/* A reset might come through in the gap between the completion returni=
ng and the following
> +	 * check, but because no sample was produced, we don't care to relay th=
e state back to UM.
> +	 */
>  	if (!ret)
> -		ret =3D -ETIMEDOUT;
> -	else if (ret > 0)
> +		return -ETIMEDOUT;
> +
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		*state |=3D perfcnt->state;
> +
> +		/* UM must re-enable their session before requesting new dumps. */
> +		if (perfcnt->state & PANFROST_PERFCNT_SESSION_DEAD)
> +			return -EIO;
> +
> +		/* If we faced a reset during our SAMPLE, the user needs to try again.=
 */
> +		if (perfcnt->state & PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET)
> +			return -EAGAIN;
> +
> +		/* Only when we know no re-eanble or re-dump is required, we can afford
> +		 * to reset the internal state. Otherwise it must be kept so that later
> +		 * ioctls know about error situations in this DUMP and work around it.
> +		 */
> +		perfcnt->state =3D 0;
> +	}
> +
> +	if (ret > 0)
>  		ret =3D 0;
> =20
>  	return ret;
>  }
[ ... ]
> @@ -122,54 +252,30 @@ static int panfrost_perfcnt_enable_locked(struct pa=
nfrost_device *pfdev,
[ ... ]
>  	panfrost_gem_internal_set_label(&bo->base, "Perfcnt sample buffer");
> =20
> -	/*
> -	 * Clear the counters to start from a fresh state.
> -	 */
> -	gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> -	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
[ ... ]
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		/*
> +		 * Clear the counters to start from a fresh state.
> +		 */
> +		gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> +		gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
> =20
> -		ret =3D panfrost_perfcnt_hw_enable(pfdev);
> +		ret =3D panfrost_perfcnt_hw_enable(pfdev);
> +		if (ret)
> +			goto err_vunmap;

[Severity: Low]
Are we mixing goto-based cleanup with scope-based cleanup helpers here?

The Linux kernel cleanup subsystem guidelines explicitly forbid mixing
goto-based error handling with __free() or guard() cleanups in the same
function to prevent ownership confusion.

Should this function be updated to use either scope-based cleanups
consistently, or traditional goto-based cleanups?

> =20
> -	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> +		perfcnt->user =3D user;
> +		perfcnt->state =3D 0;
> +	}
> =20
>  	/* The BO ref is retained by the mapping. */
>  	drm_gem_object_put(&bo->base);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-claude-fix=
es-v12-0-62beb08de207@collabora.com?part=3D15
