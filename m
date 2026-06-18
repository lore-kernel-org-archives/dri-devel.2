Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59ED1CD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 06:17:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7620110E495;
	Thu, 18 Jun 2026 06:17:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="huZmLZbF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0707D10E495
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 06:17:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B0DCF40220;
 Thu, 18 Jun 2026 06:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BDF1F000E9;
 Thu, 18 Jun 2026 06:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781763448;
 bh=hD7swbo4B/8YcoEal48pPqzhr+J6bm+ySo/zqmFXHl4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=huZmLZbFKVUf+f4OcehC4RNc/WeMOZNUceqv9B0T/S/i/4VdHKJ4rKcjymQ0sV0ZL
 CK7aRi2EEEwZatXtX3J9H/RNKNRz1yCWxRluuHoZUX6pi/AG1v7FM6Dh9kAno6deO2
 JphzXGZ4oXkbJwV+U44hIkOP8gln95IIDF46cagbf6nOEHF/gOCtPnvF81HrnyGhIn
 P9Lmn73YJmMLfs5syd+FH+Hafin3xurcHjfAsn2ricv5r9jJwgOJwYHP/avtCxiKR7
 nxM+m/WA1nXOP3ff4RZeOM1Ay7PpH5EbkhvmSs+X6bBj2BkRYhuQWqmaqiOI+e/GeU
 Fz/o8XYuG2LAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: do not enter fs_reclaim under notifier_lock
 in lockdep training
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260618055216.56191-1-mikhail.v.gavrilov@gmail.com>
References: <20260618055216.56191-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 06:17:28 +0000
Message-Id: <20260618061728.75BDF1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Removing the `fs_reclaim` lockdep annotation silences a true-posit=
ive warning about a real ABBA deadlock between memory reclaim and GPU reset=
, rather than fixing the underlying bug.
--

commit 4896f663f62249014930226b2bc964c2419486d0
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

drm/amdgpu: do not enter fs_reclaim under notifier_lock in lockdep training

The commit removes the fs_reclaim_acquire() and fs_reclaim_release() calls
from amdgpu_lockdep_init() to silence a circular locking dependency warning,
claiming it is a false positive.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_lockdep.c
> index d5d71fd7c70d0..eeb3b5007f80f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> @@ -150,12 +150,6 @@ int amdgpu_lockdep_init(void)
>  	/* Level 6: Reset control lock */
>  	mutex_lock(&reset_ctl.reset_lock);
> =20
> -	/*
> -	 * Mark potential memory reclaim boundary.
> -	 * GPU operations might trigger memory allocation/reclaim.
> -	 */
> -	fs_reclaim_acquire(GFP_KERNEL);
> -

[Severity: High]
This is a pre-existing issue, but does removing this lockdep annotation
silence a true-positive warning about a real ABBA deadlock?

While the circular dependency might not happen in the same thread, couldn't=
 a
cross-thread deadlock occur between memory reclaim and GPU reset?

For example, if Thread A executes the MMU notifier amdgpu_hmm_invalidate_gf=
x()
(e.g., during direct reclaim), it acquires adev->notifier_lock and blocks in
dma_resv_wait_timeout() waiting for a hardware fence:

drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c:amdgpu_hmm_invalidate_gfx() {
	...
	mutex_lock(&adev->notifier_lock);
	...
	r =3D dma_resv_wait_timeout(vm_root->tbo.base.resv,
				  DMA_RESV_USAGE_BOOKKEEP, false,
				  MAX_SCHEDULE_TIMEOUT);
}

If Thread B (the GPU reset thread) takes down_write(&adev->reset_domain->se=
m)
to reset the GPU and signal the fences, and performs GFP_KERNEL allocations,
it could be forced into direct memory reclaim (fs_reclaim). This would invo=
ke
the MMU notifier, attempting to acquire adev->notifier_lock, forming a cycl=
e.

Would it be better to fix the underlying deadlock by wrapping the GPU reset
path with memalloc_noreclaim_save() or memalloc_noio_save() to prevent it
from entering memory reclaim, instead of removing the lockdep annotation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618055216.5619=
1-1-mikhail.v.gavrilov@gmail.com?part=3D1
