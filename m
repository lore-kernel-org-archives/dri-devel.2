Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDA2C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA40610E1BA;
	Wed, 29 Jul 2026 10:47:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G6hNtxpR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C59410E1BA
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 10:47:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 31D5760A9C;
 Wed, 29 Jul 2026 10:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16401F000E9;
 Wed, 29 Jul 2026 10:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785322034;
 bh=kko61iql7IxXDdNpritEPleTPQygBzQRIkrxome506E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G6hNtxpRy9ejYiNDhwz50WdDjEJK0fQYQJ2SCOPVOG/sQzNyDQ0VaUva/nFgbnjri
 URGp6HrolJUkNQpRUh/v5DFPadimPla+A+K/Afz8BIfxfqiez49eqgv4iEOOIzGj9o
 /uWoTsl7iWHwcxY97kDZSGPqMaGVrHIXMZfKR0j8SYUHrYLWQtfW5h3rHxdw/IW7K0
 blPEljd30wTynKgsV8qGuRdUpwu6G6aInSp4a+WgO3s/4oeIDeUDQ3Dopy4gKSmSPZ
 DUSIikphc/mPDpMP39TDXetN4N/iFd5LFQmrunZiTCPBhrlC+6+kmjOwBW9ISeuIGf
 UqZIe5NqRQz3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/radeon: restore hardware polling in
 fence_is_signaled to fix performance regression
To: 2564278112@qq.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <tencent_BB2A7CAE632BA0AC08D9296E78A15786200A@qq.com>
References: <tencent_BB2A7CAE632BA0AC08D9296E78A15786200A@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 10:47:14 +0000
Message-Id: <20260729104714.B16401F000E9@smtp.kernel.org>
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
- [High] Calling `radeon_fence_activity()` in `.signaled` callback consumes=
 hardware state without waking up wait queues, leading to permanent hangs.
- [Medium] Acquiring an `rw_semaphore` in the `dma_fence_ops.signaled` call=
back violates wait-context rules and can crash PREEMPT_RT kernels.
--

--- Patch [1]: [PATCH] drm/radeon: restore hardware polling in fence_is_sig=
naled to fix performance regression ---
commit 23682e8220434ea07b863fe650003e08c35ce798
Author: Wang Jiang <jiangwang@kylinos.cn>

drm/radeon: restore hardware polling in fence_is_signaled to fix performanc=
e regression

This commit restores hardware polling by calling radeon_fence_activity()
wrapped in down_read_trylock() inside radeon_fence_is_signaled(). This is
intended to fix performance regressions without re-introducing deadlocks.

> diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/rade=
on/radeon_fence.c
> index 02a40e4750c7d..299865569252d 100644
> --- a/drivers/gpu/drm/radeon/radeon_fence.c
> +++ b/drivers/gpu/drm/radeon/radeon_fence.c
> @@ -360,6 +360,13 @@ static bool radeon_fence_is_signaled(struct dma_fenc=
e *f)
>  	if (atomic64_read(&rdev->fence_drv[ring].last_seq) >=3D seq)
>  		return true;
> =20
> +	if (down_read_trylock(&rdev->exclusive_lock)) {
> +		radeon_fence_activity(rdev, ring);

[Severity: High]
Does this consume the hardware state and drop the wake signal?

When a thread calls dma_fence_is_signaled() via polling, it invokes
radeon_fence_is_signaled(), which then calls radeon_fence_activity().=20
The hardware sequence is read, last_seq is advanced, and it returns true.

However, radeon_fence_is_signaled() intentionally drops this return value a=
nd
skips wake_up_all(). Later, when the actual hardware interrupt fires,
radeon_fence_process() calls radeon_fence_activity() again.

Because last_seq was already advanced, it sees no new activity
(seq <=3D last_seq), returns false, and skips wake_up_all().

Could this steal the wake event and cause tasks waiting on fences to hang
indefinitely?

> +		up_read(&rdev->exclusive_lock);

[Severity: Medium]
Is it safe to manipulate an rw_semaphore in the dma_fence_ops.signaled
callback?

The dma_fence_ops.signaled callback can be called from atomic context or
directly from a foreign device's hardirq handler due to cross-device
dependencies.

While down_read_trylock() avoids sleeping on acquire, up_read() still
manipulates the underlying lock state. On PREEMPT_RT, this is an rt_mutex,
and manipulating it from hardirq context violates RT constraints, potential=
ly
leading to a crash.

> +
> +		if (atomic64_read(&rdev->fence_drv[ring].last_seq) >=3D seq)
> +			return true;
> +	}
>  	return false;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_BB2A7CAE632=
BA0AC08D9296E78A15786200A@qq.com?part=3D1
