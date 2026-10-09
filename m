Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BCECA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4570210E9D2;
	Fri,  9 Oct 2026 14:39:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h+z/FDdX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6460D10E9D2
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 14:39:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DA37760098;
 Fri,  9 Oct 2026 14:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6725C1F00893;
 Fri,  9 Oct 2026 14:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791556765;
 bh=tEjnCtSmR4nndaOHOBuIH6gNSaVPsM4HRgDUydCWYWI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h+z/FDdXB9dDVzaOQVLAjiXzAxr8+iJOgEEHsTWYgW3oQcYqa1f3LfmQrR/kcNKAl
 fbrmTFrJXnmf+pjpTFGRv8dhOF+GAXVD07/4hvpr2QCm/3B7CC+5P1OsnCMKL6qU7p
 30DJ5XJVtZe8YajAz49flVVDcaD0FhNsGCPU2/JhKgH2xeMn379NcBX8uHuCySOQ22
 y5XXUunWg1nBnTTGEw84iJeagJnnn9Wj5SytALuIHinuMa0wSDf4z/Af5qm5OHG5dS
 hFOXmactQlKimvdWlrY8t9PcEnfJZaT4MDq/tt5QKXF4db3DET41c1TqzHWbDvYbip
 zLcR3rMUO7u3A==
Message-ID: <sashiko-outbox-165725@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 15/15] drm/panfrost: Fix races between perfcnt and
 reset sequence
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261009-claude-fixes-v14-15-cb743b3b973b@collabora.com>
References: <20261009-claude-fixes-v14-0-cb743b3b973b@collabora.com>
 <20261009-claude-fixes-v14-15-cb743b3b973b@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 14:39:24 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] drm/panfrost: data race on perfcnt->state drops reset notificati=
ons
- [Medium] drm/panfrost: Race between delayed perfcnt interrupt and dump re=
-initialization
- [Low] drm/panfrost: cleanup subsystem violation mixing goto and scoped_gu=
ard
--

commit a3c7a0f93b13c20ffb612831ca0de295364a95de
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Fix races between perfcnt and reset sequence

Formerly, the reset sequence would race with panfrost_mmu_as_put()
when tearing down a perfcnt session. On top of that, poking GPU
registers to program a perfcnt session or obtaining a dump might lead to
undefined behaviour when done at the same time a reset was ongoing.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index b3f71d7fd82a9..a9def452d5ef9 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c

[ ... ]

> -static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
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
> +
> +		reinit_completion(&pfdev->perfcnt->dump_comp);
> +
> +		gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
> +		gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
> +		gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_CLEAN_CACHES_COMPLETED |
> +						GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);

[Severity: Medium]
Is there a race condition between reinit_completion() and clearing pending
interrupts?

If a previous dump request timed out, a delayed interrupt could still be
raised by the hardware.

Since panfrost_perfcnt_dump_locked() executes without disabling hardirqs,
could a concurrent interrupt handler execute right after reinit_completion()
but before GPU_INT_CLEAR?

This would spuriously signal the completion and cause the subsequent wait to
return immediately while the hardware is still writing counter data.

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
>  	if (!ret)
>  		ret =3D -ETIMEDOUT;
> -	else if (ret > 0)
> -		ret =3D 0;
> =20
> -	return ret;
> +	/* We need to restore perfcnt state so the next successful dump can rel=
ay it to UM */
> +	if (ret < 0) {
> +		perfcnt->state |=3D *state;

[Severity: Medium]
Does this unprotected read-modify-write drop reset notifications?

When panfrost_perfcnt_dump_locked() exits early with an error, the code has
already released the reset read semaphore. Concurrently, a reset might
happen and panfrost_perfcnt_reset() could write the interrupted flag to
perfcnt->state:

    perfcnt->state |=3D PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET;

Since the assignment here performs a non-atomic read-modify-write without
holding the semaphore, won't it clobber the reset flags written by the
reset sequence, hiding them from userspace?

> +		*state =3D 0;
> +		return ret;
> +	}

[ ... ]

> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		/*
> +		 * Clear the counters to start from a fresh state.
> +		 */
> +		gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> +		gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
> =20
> -	gpu_write(pfdev, GPU_PERFCNT_CFG, cfg);
> +		ret =3D panfrost_perfcnt_hw_enable(pfdev);
> +		if (ret)
> +			goto err_vunmap;

[Severity: Low]
Does this goto violate the cleanup and guard subsystem rules?

The kernel documentation for the cleanup subsystem explicitly forbids mixing
traditional goto-based error handling and scope-based guard() declarations
in the same function. Mixing them creates confusing ownership semantics and
can lead to LIFO ordering bugs on scope exit.

> =20
> -	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> +		perfcnt->user =3D user;
> +		perfcnt->state =3D 0;
> +	}
> =20
>  	/* The BO ref is retained by the mapping. */
>  	drm_gem_object_put(&bo->base);
> =20
> -	perfcnt->user =3D user;
> -
>  	return 0;
> =20
>  err_vunmap:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-claude-fix=
es-v14-0-cb743b3b973b@collabora.com?part=3D15
