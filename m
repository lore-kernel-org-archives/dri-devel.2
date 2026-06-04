Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06219CD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:27:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65CBE11A2FB;
	Thu,  4 Jun 2026 20:27:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HEEpirqS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 039B911A2FB
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:27:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D562140906;
 Thu,  4 Jun 2026 20:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924201F00893;
 Thu,  4 Jun 2026 20:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780604841;
 bh=7wOOwOd1vftgTlO09RYDjtGaFcov3a+yHBhROh9+4gs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HEEpirqSKKMCzFbA5bD+1naUavfFciko9ZrHJr5hnYMY+rjZX+VxmEFqYyJlgZH1t
 vZBfv9rsHeQMmEC9jCbzyPtH9FXG569UFiqprt/HxulKdoxY3m0tA3mjEIi61zAGO4
 UNk8dGquW6NqSrGMrFkYz7mQ6izjBFkqtqHRaZLG3oa6FhC49x8VJiAM/Z0XmLGYpm
 KedyYOScTjovPUhMZMHiaP8f18+kxhjhEQXPxKQ3ieBq/XcfmG9fSPDSCoEBI9iLuS
 YX5USo/U6PGyD/RFdOyqVR+81EvggdlHdVmE2YiIeqbN/zGYQai35IMYasbHtHFvib
 2h0x4aMDTYFOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] drm/msm: Recover HW before retire hung submit
To: "Akhil P Oommen" <akhilpo@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260605-assorted-fixes-june-v1-2-2caa04f7287c@oss.qualcomm.com>
References: <20260605-assorted-fixes-june-v1-2-2caa04f7287c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:27:20 +0000
Message-Id: <20260604202721.924201F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] Early fence signaling allows concurrent unmapping of shared BOs be=
fore the hung GPU is stopped, reproducing the exact pagefaults the patch in=
tended to fix.
- [High] Concurrent GPU progress during hang recovery causes the recovery l=
ogic to double-increment the fence and silently drop a subsequent, unexecut=
ed submit.
--

commit 3c515db3794c4f1061da14c3adffcf64bbdd2fc5
Author: Jie Zhang <jie.zhang@oss.qualcomm.com>

drm/msm: Recover HW before retire hung submit

During recovery, it is not safe to retire the hung submit before we
recover the GPU. Retiring the submit triggers BO free and that can
result in GPU pagefaults since the GPU may be actively accessing those
BOs.

To fix this, retire the submits after gpu recovery is complete in
recover_worker().

> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index 18ed00e5f143b..9ac7740a87f01 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -552,11 +552,11 @@ static void recover_worker(struct kthread_work *wor=
k)
>  		msm_update_fence(ring->fctx, fence);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but can concurrent GPU progress
during hang recovery cause the recovery logic to double-increment the fence
and silently drop a subsequent, unexecuted submit?

In recover_worker(), the hung submit is identified early using:

    submit =3D find_submit(cur_ring, cur_ring->memptrs->fence + 1);

Because the GPU is not halted during the time it takes to capture the crash
state, it may legitimately finish the hung submit and concurrently write
the next fence value to ring->memptrs->fence.

Later in the function (just above this hunk), the loop reads the updated
fence:

    uint32_t fence =3D ring->memptrs->fence;
    ...
    if (ring =3D=3D cur_ring)
        ring->memptrs->fence =3D ++fence;

This explicitly increments the already-updated fence and writes the next
value back to shared memory. retire_submits() will then retire the
unexecuted submit corresponding to that next fence, skipping it entirely
while userspace receives a success signal.


[Severity: High]
This is a pre-existing issue, but does early fence signaling still allow
concurrent unmapping of shared BOs before the hung GPU is stopped,
reproducing the exact pagefaults this patch intended to fix?

While this patch moves retire_submits() to happen after
gpu->funcs->recover(), the call to msm_update_fence() remains before the
recovery.

Because msm_update_fence() advances the fence context's completed_fence to
include the hung submit, any concurrent thread calling
dma_fence_is_signaled() (such as userspace polling a sync_file) will
observe the updated completed_fence.

This causes dma_fence_is_signaled() to wake up all waiters and allows them
to unmap the shared memory from the GPU page tables while the GPU is still
actively executing.

Should the loop containing msm_update_fence() also be moved after
gpu->funcs->recover() to completely close this window?

> =20
> +	gpu->funcs->recover(gpu);
> +
>  	/* retire completed submits, plus the one that hung: */
>  	retire_submits(gpu);
> =20
> -	gpu->funcs->recover(gpu);
> -
>  	/*
>  	 * Replay all remaining submits starting with highest priority
>  	 * ring

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-assorted-f=
ixes-june-v1-0-2caa04f7287c@oss.qualcomm.com?part=3D2
