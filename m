Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5D3C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 21:17:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECE5410E027;
	Fri, 28 Aug 2026 21:17:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m3UbwlF0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50B9E10E027
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 21:17:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5A84C60055;
 Fri, 28 Aug 2026 21:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB9E1F000E9;
 Fri, 28 Aug 2026 21:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787951849;
 bh=GLo8mBooKnOSopDa3bIcLHpsUxQkgc18kbwNQlrEuSM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=m3UbwlF0HPkwoD+3xPwc0GUyaAUuVgQXzy/bq70xwpXqEO8waMsIdQcA9Ds13t6Pz
 925QaOZJzDXF3QPisgDNcAPs5/Lhtxavh6PySwa1yEbJnN95Xci4nO1BqzW6NoALUd
 JzqzeTuI908Uxa05U/334EN98OPbUsUoJKoOZ+S9rI94IuGKEJZtVTiN+xhxQQUzxJ
 mXOQzawjvHZTj78D+t9uwMywoRylLHX1rkUP42jglAzpPtFty+7zPYDHmE+QHlSinQ
 ON0n1lJqNNHyr4znys/2jXTiGH0jUpyAEQKPR0DeIfRKyQSYxi42oSLulG3kx92w1M
 pxEnmtJ0GqpDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 16/17] drm/panfrost: Fix races between perfcnt and
 reset sequence
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260828-claude-fixes-v7-16-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-16-72a13b2c125d@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 21:17:28 +0000
Message-Id: <20260828211728.DBB9E1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Hardware reset notifications are permanently lost on interrupted i=
octl waits.
- [High] Unprotected GPU register writes to GPU_CMD race with device reset.
- [Low] Mixing goto-based error handling with scoped_guard() cleanup in the=
 same function.

Pre-existing issues:
- [High] Spurious WARN_ON due to an off-by-one boundary check in panfrost_m=
mu_as_get.
--

commit f478a9bf05ba523f5eb295d8a3b40bf995a8444e
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Fix races between perfcnt and reset sequence

This commit updates the reset sequence to use the reset r/w semaphore to
govern hardware access. It also expands the DRM uAPI for the perfcnt dump
operation to inform userspace when a reset occurs, which resets the counters
back to zero.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
[ ... ]
> @@ -58,25 +63,107 @@ void panfrost_perfcnt_sample_done(struct panfrost_de=
vice *pfdev)
[ ... ]
> +static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev,
> +					u64 *reset_happened)
> +{
[ ... ]
> +dump_retry:
> +	retry =3D false;
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		*reset_happened =3D perfcnt->reset_happened;
> +		perfcnt->reset_happened =3D false;

[Severity: High]
If this wait is interrupted by a signal,=20
wait_for_completion_interruptible_timeout() returns -ERESTARTSYS. Because
we already cleared perfcnt->reset_happened to false above, when the syscall
is automatically restarted, will it see the cleared flag and falsely report
hw_reset =3D 0 to userspace?

Could this cause userspace to permanently lose notifications about hardware=
=20
resets?

> +		if (perfcnt->reset_failed) {
> +			ret =3D panfrost_perfcnt_hw_enable(pfdev);
> +			if (ret)
> +				return ret;
> +			perfcnt->reset_failed =3D false;
> +		}
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
> +	 * of a HW reset. The downside is in the gap between the completion is =
flagged
> +	 * by the GPU IRQ handler and the sempahore taken once again, yet anoth=
er reset
> +	 * could happen, which would lead to a valid sample being discarded. Th=
is is
> +	 * a solution of compromise between ensuring synchronisation with the r=
eset
> +	 * sequence and letting it happen as quickly as possible for jobs to be=
 rerun.
> +	 */
> +
>  	ret =3D wait_for_completion_interruptible_timeout(&pfdev->perfcnt->dump=
_comp,
>  							msecs_to_jiffies(1000));
[ ... ]
> @@ -132,44 +220,19 @@ static int panfrost_perfcnt_enable_locked(struct pa=
nfrost_device *pfdev,
[ ... ]
>  	/*
>  	 * Clear the counters to start from a fresh state.
>  	 */
>  	gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
>  	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);

[Severity: High]
Are these register writes exposed to the exact race condition this patch
intends to fix?=20

Executing gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR) without holding=
=20
pfdev->reset.lock means a concurrent soft reset (which writes=20
GPU_CMD_SOFT_RESET) could race on the GPU_CMD register.

> -	ret =3D panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
> -	if (ret < 0)
> -		goto err_vunmap;
> -
[ ... ]
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		ret =3D panfrost_perfcnt_hw_enable(pfdev);

[Severity: High]
This is a pre-existing issue, but does panfrost_mmu_as_get() contain an=20
off-by-one boundary check that could trigger a spurious kernel warning?=20

Looking at panfrost_mmu_as_get() in drivers/gpu/drm/panfrost/panfrost_mmu.c:

        /*
         * AS can be retained by active jobs or a perfcnt context,
         * hence the '+ 1' here.
         */
        WARN_ON(en >=3D (NUM_JOB_SLOTS + 1));

If a user process submits jobs to all 3 available slots (NUM_JOB_SLOTS =3D =
3)
and simultaneously enables a performance counter session, there are 4
references. atomic_inc_return() returns 4, satisfying 4 >=3D 4, which
erroneously triggers the WARN_ON.

> +		if (ret)
> +			goto err_vunmap;

[Severity: Low]
Does mixing goto with scoped_guard() here violate the subsystem cleanup
guidelines?=20

Jumping to a manual cleanup label from inside a scoped_guard creates=20
confusing ownership semantics.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-claude-fix=
es-v7-0-72a13b2c125d@collabora.com?part=3D16
