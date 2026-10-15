Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F9BCC6B38
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 042B91121A9;
	Thu, 15 Oct 2026 18:46:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47B641121A9
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 18:45:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EBFC842ABF;
 Thu, 15 Oct 2026 18:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17F91F000C4;
 Thu, 15 Oct 2026 18:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792089956;
 bh=7OXp4u+J1qGZcGziYsrRPePgjwYKF03UaI+9pJGw7yM=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=bVV081NsCzygwCOtP8yzWj1sK/6ww+9nUjPqXaaEjRWBHY+HfluIygqhl38iWMYiF
 APrVUvH8VOurLB8FNalED+9oKBRKsbdGJwt3D5Hr2q/yLMZyCbZmF0DQDbutppM3j4
 RHjLtLOeSmRLD8uT49XrhTn9WWPXy2Zc8BbF0H+QMR0S5Gj9WQ00XARwCPzRGllXXa
 Uxyqx+Jp5y+vs3msP6Id3GMQ+lnM5qGAX0OiEGZ97IW64il2qOf+QqG52OS2sV3knJ
 5Zxc2RM9sJVDWXRDLRynm8hRlGvauvrkOtcxnRwBUxKOdyf4NPM6vaD459l/5lvDBF
 1NkUro9ZIMS/Q==
Message-ID: <sashiko-outbox-173324@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1] accel/amdxdna: wait uninterruptibly for jobs in the
 HMM invalidate callback
To: "Lizhi Hou" <lizhi.hou@amd.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261015183248.3414119-1-lizhi.hou@amd.com>
References: <20261015183248.3414119-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 18:45:56 +0000
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
- [High] mm: circular locking deadlock between MMU notifier and IOMMU page =
fault
--

commit b2f7ee3cb752f6d69d4b4ef2181868d9befe8e3c
Author: Matthew Brost <matthew.brost@intel.com>

accel/amdxdna: wait uninterruptibly for jobs in the HMM invalidate callback

This commit changes the BO wait in aie2_hmm_invalidate() to be
uninterruptible and not time-limited, since MMU notifiers cannot fail a
blockable invalidation.

> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie=
2_ctx.c
> index d927c8c9d557a..9d38703501963 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -1280,16 +1280,12 @@ int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, =
struct amdxdna_sched_job *job,
>  void aie2_hmm_invalidate(struct amdxdna_gem_obj *abo,
>  			 unsigned long cur_seq)
>  {
> -	struct amdxdna_dev *xdna =3D to_xdna_dev(to_gobj(abo)->dev);
> -	struct drm_gem_object *gobj =3D to_gobj(abo);
> -	long ret;
> -
> -	ret =3D dma_resv_wait_timeout(gobj->resv, DMA_RESV_USAGE_BOOKKEEP,
> -				    true, MAX_SCHEDULE_TIMEOUT);
> -	if (!ret)
> -		XDNA_ERR(xdna, "Failed to wait for bo, ret %ld", ret);
> -	else if (ret =3D=3D -ERESTARTSYS)
> -		XDNA_DBG(xdna, "Wait for bo interrupted by signal");
> +	/*
> +	 * The pages must not be released while the device may still access
> +	 * them, so this wait must be neither interruptible nor time limited.
> +	 */
> +	dma_resv_wait_timeout(to_gobj(abo)->resv, DMA_RESV_USAGE_BOOKKEEP,
> +			      false, MAX_SCHEDULE_TIMEOUT);

[Severity: High]
Does this introduce a circular locking deadlock with the IOMMU page fault
handler?

Since aie2_hmm_invalidate() is called from MMU interval notifiers (for
example, during munmap), it executes with the mmap_lock held for writing. By
performing an uninterruptible wait here for the BO's fences to signal, we
block waiting on the GPU job.

If that GPU job triggers an IOMMU page fault (IOPF), iommu_sva_handle_iopf()
will attempt to acquire mmap_read_lock() to handle the fault:

drivers/iommu/iommu-sva.c:iommu_sva_handle_iopf() {
    ...
    mmap_read_lock(mm);
    ...
    ret =3D handle_mm_fault(vma, prm->addr, fault_flags, NULL);
    ...
}

This creates a circular dependency:
1. The MMU notifier holds mmap_lock and waits for the GPU job.
2. The GPU job stalls waiting for the IOPF handler.
3. The IOPF handler waits for the mmap_lock.

Additionally, if the Timeout Detection and Recovery (TDR) is disabled
(which is supported via the tdr_timeout_ms module parameter), this deadlock
is permanent and freezes the process. Even with TDR enabled, resolving a
page fault by timing out and resetting the hardware is a functional regress=
ion
and a severe performance penalty.

>  }
> =20
>  int aie2_hwctx_heap_expand(struct amdxdna_hwctx *hwctx,

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015183248.3414=
119-1-lizhi.hou@amd.com?part=3D1
