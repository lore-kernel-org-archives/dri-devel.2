Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B98C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 04:16:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B83D410E2B8;
	Sat, 27 Jun 2026 04:16:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZMiF/x/q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B624910E2B8
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 04:16:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1CAD4600AA;
 Sat, 27 Jun 2026 04:16:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9890F1F000E9;
 Sat, 27 Jun 2026 04:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782533779;
 bh=m/T8AThJNtgCfRZGPs8Yo8zafBV2QM0kK/B5Mw+IgnE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZMiF/x/qpvhrX8eq1FhMc39wgDBVBTE9SALtZ+P+DAoMNcN78M5CEP8Yw9tCJj75+
 dSMKefzufzx0OAyhodhYhX/dTFBWHnDewDwV9YMUhJRbLhcVmTDimxqhzqcKeohCDd
 6igQon3tbQ1pFHNh5qsOQAFtkPLyAJnt/VZM2hoG78I9eepz9h2kAvImhHfk90EqPp
 989cx5mus10zuOoef1nvPtUQ8It/USdx1WArHZZMQ/Iq4L23XKr4w/pL1KQAnpSQl3
 /bFaKwUTZZz9HCCpuP010Z0bzQf6LQzGwsvnFJ+nhgTZSgoZsStrtEX9CMbdoTUz+g
 cDWvXJp95ZkOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/5] drm/xe: have xe_svm_range embed one
 drm_gpusvm_pages
To: "Honglei Huang" <honglei1.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627035418.3796481-3-honglei1.huang@amd.com>
References: <20260627035418.3796481-1-honglei1.huang@amd.com>
 <20260627035418.3796481-3-honglei1.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 04:16:19 +0000
Message-Id: <20260627041619.9890F1F000E9@smtp.kernel.org>
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
- [Critical] Deferring IOMMU unmapping to the range free callback creates a=
 window where a range is unlinked from the MMU interval tree but its pages =
remain mapped, breaking the MMU notifier security guarantees and allowing D=
MA use-after-free.
--

commit 178f1e1f04007ff8f673ad61f9e9152f411fac61
Author: Honglei Huang <honghuan@amd.com>

drm/xe: have xe_svm_range embed one drm_gpusvm_pages

This commit modifies the drm_gpusvm framework so that the driver takes
responsibility for the page lifecycle by embedding drm_gpusvm_pages. As part
of this, the synchronous unmap in drm_gpusvm_range_remove() was removed, and
xe now unmaps the pages from its range_free callback instead.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 155e3c2e703d9..85fbadc9716a4 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c

[ ... ]

> @@ -1245,8 +1248,6 @@ void drm_gpusvm_range_remove(struct drm_gpusvm *gpu=
svm,
>  		return;
> =20
>  	drm_gpusvm_notifier_lock(gpusvm);
> -	__drm_gpusvm_unmap_pages(gpusvm, &range->pages, npages);
> -	__drm_gpusvm_free_pages(gpusvm, &range->pages);
>  	__drm_gpusvm_range_remove(notifier, range);
>  	drm_gpusvm_notifier_unlock(gpusvm);

[Severity: Critical]
Does this create a window where the pages remain mapped in the IOMMU but the
range is no longer tracked in the MMU interval tree?

If a concurrent CPU munmap() occurs right after this function removes the
range from the interval tree, the MMU notifier (xe_svm_invalidate) won't
find the range. It might return early without waiting for the GPU to finish
unbinding or unmapping the IOMMU, allowing the OS to reallocate physical pa=
ges
while the GPU can still access them.

[ ... ]

> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> index 63da149f3b7fd..77af0a8de63e0 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c

[ ... ]

> @@ -122,8 +123,10 @@ xe_svm_range_alloc(struct drm_gpusvm *gpusvm)
> =20
>  static void xe_svm_range_free(struct drm_gpusvm_range *range)
>  {
> +	drm_gpusvm_free_pages(range->gpusvm, &(to_xe_range(range)->pages),
> +			      drm_gpusvm_range_size(range) >> PAGE_SHIFT);
>  	xe_vm_put(range_to_vm(range));
> -	kfree(range);
> +	kfree(to_xe_range(range));
>  }

[Severity: Critical]
Could deferring the unmap to the free callback lead to a DMA use-after-free
regression if callers hold extra references?

For example, in xe_svm_unmap_address_range(), the code takes an extra
reference via drm_gpusvm_range_get() before triggering the garbage collecto=
r.
The garbage collector calls drm_gpusvm_range_remove(), removing the range
from the interval tree, but this free callback won't run until the extra
reference is dropped later. This keeps the IOMMU mappings alive while the
interval tree tracking is gone, opening up the race with munmap() described
above.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627035418.3796=
481-1-honglei1.huang@amd.com?part=3D3
