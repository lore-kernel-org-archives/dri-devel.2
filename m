Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C110C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 17:42:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 392E110E076;
	Sat, 18 Jul 2026 17:42:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Oge4pb+0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EBA410E076
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 17:42:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 860C240217;
 Sat, 18 Jul 2026 17:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487661F000E9;
 Sat, 18 Jul 2026 17:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784396546;
 bh=zd5DNpxubEKCeNqwMWJvDYs7HAs2wsRMQdgdb2HiRxg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Oge4pb+0Et/MizdeN6ba63QFFl8Dsc0/aiiPQcn0il4zIC5XUNpGVfSSVrlRrha8W
 /hFMlDlzmSkbw4Ji+vwjhyxtBSoMKxVkkDWLsBLH3dFc6O6LRMg1snELj+8yGlcjMo
 kgsHwmSUK3DQIFWHlUa1Hp5TE3/V8D+6icsifupNUNi8sObOEwEkm0sal3l0949Tji
 Wcxc5itEvLvxjTcdxXKoapw6cWeDNEkm6kDYXM7pFjbbZfPTN3RNOc1TWcuq0nzdr3
 8LQf+29ZHNxBAWVV0rSvMtsWpuqg8zI9qMVHQ8fNdje/5uet3zXvZbguWlWCnFCb3L
 VjIEcoJHBLLiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/vc4: Reset the binner overflow allocator on GPU
 reset
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260718-vc4-bin-oom-fixes-v1-2-8cba09558c33@igalia.com>
References: <20260718-vc4-bin-oom-fixes-v1-0-8cba09558c33@igalia.com>
 <20260718-vc4-bin-oom-fixes-v1-2-8cba09558c33@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 17:42:25 +0000
Message-Id: <20260718174226.487661F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Blindly freeing `vc4->bin_alloc_overflow` during GPU reset causes =
a Use-After-Free for queued render jobs that still depend on the binner ove=
rflow memory.
--

--- Patch [2]: [PATCH 2/3] drm/vc4: Reset the binner overflow allocator on =
GPU reset ---
commit 74342beb01de4148c8046f07cd05468691648692
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/vc4: Reset the binner overflow allocator on GPU reset

This commit resets the binner overflow allocator during a GPU reset to
prevent leaking overflow slots. It frees the pending overflow slot and
clears the hardware overflow registers so the re-queued bin job starts
from a clean state.

> diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
> index 7877d493d80e6..9fac1b39e8b98 100644
> --- a/drivers/gpu/drm/vc4/vc4_irq.c
> +++ b/drivers/gpu/drm/vc4/vc4_irq.c

[ ... ]

> @@ -344,6 +344,18 @@ void vc4_irq_reset(struct drm_device *dev)
>  	V3D_WRITE(V3D_INTENA, V3D_DRIVER_IRQS);
> =20
>  	spin_lock_irqsave(&vc4->job_lock, irqflags);
> +
> +	/*
> +	 * The reset wiped the binner's hardware state, and the job that may
> +	 * have been reading overflow memory is torn down just below. Free the
> +	 * current overflow slot and clear the overflow registers so the
> +	 * re-queued BIN job restarts from a clean OOM state.
> +	 */
> +	vc4->bin_alloc_used &=3D ~vc4->bin_alloc_overflow;
> +	vc4->bin_alloc_overflow =3D 0;

[Severity: High]
Does clearing the overflow slot here create a use-after-free for render jobs
that have already completed binning and are waiting in the render queue?

If we have the following sequence:
1. Job A is executing on the render thread.
2. Job B finishes binning, using an overflow slot (tracked in
   vc4->bin_alloc_overflow), and is placed in the render queue.
3. Job C starts binning, hangs, and triggers a GPU reset.

When vc4_irq_reset() runs, it frees the overflow slot used by Job B. Then
vc4_irq_finish_render_job() completes the active render job (Job A) and
submits Job B to the hardware.

Since Job B's overflow memory was just freed, could a subsequent binning job
encounter an out-of-memory condition, allocate this exact same slot, and
overwrite it while Job B is actively reading from it?

> +	V3D_WRITE(V3D_BPOA, 0);
> +	V3D_WRITE(V3D_BPOS, 0);
> +
>  	vc4_cancel_bin_job(dev);
>  	vc4_irq_finish_render_job(dev);
>  	spin_unlock_irqrestore(&vc4->job_lock, irqflags);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718-vc4-bin-oo=
m-fixes-v1-0-8cba09558c33@igalia.com?part=3D2
