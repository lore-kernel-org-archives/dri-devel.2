Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF0EC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 04:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A359110F794;
	Sat, 27 Jun 2026 04:12:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NjRk01FP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11D0610F794
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 04:12:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 20A04600AA;
 Sat, 27 Jun 2026 04:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFAE1F000E9;
 Sat, 27 Jun 2026 04:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782533559;
 bh=AGKNYDcSHY9l2vXL6yaAjRNGMIA7Y+0Zg5OF6o1gRzk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NjRk01FPtaxhZi4Qo+1u95JmNpJjArze4cfhEahjrZhRPxgA21unXaHoJNZ4aYMpT
 E2BaYnqaYYdZSzKYTZ7FGGFWz2na8MKHpDkr6WJOHbK/JNKIXyV+3rEgCXUHSKMsti
 Bv5tmgxkIdd8otcURoA16kuPTF+t5ewhiYUj8Pq5zIE+5eNzfR4aefKZuGmkDQLwPM
 jzZ9Ta16BUK+8n0m4EavP9Hbbux3jK4SP30LtYMdw+TFSa9m/l9vI+KjMmvPATaX8c
 bzKUkVOmZWhnwPurBhZNAFKYk/+TAlewt2CTiOScMotOKEv9F2ow90/loKdaMbM7tm
 1U+KGC/e+Ge1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] drm/xe: have xe_svm_range embed one
 drm_gpusvm_pages
To: "Honglei Huang" <honglei1.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627034303.3795627-4-honglei1.huang@amd.com>
References: <20260627034303.3795627-1-honglei1.huang@amd.com>
 <20260627034303.3795627-4-honglei1.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 04:12:39 +0000
Message-Id: <20260627041239.9FFAE1F000E9@smtp.kernel.org>
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
- [Critical] Removing __drm_gpusvm_unmap_pages() from drm_gpusvm_range_remo=
ve() allows IOMMU mappings to persist after the range is removed from the M=
MU notifier interval tree, leading to a critical DMA use-after-free.
--

commit 90b6fd39f4a128d4e1069b7728beb37bbd137e69
Author: Honglei Huang <honghuan@amd.com>

    drm/xe: have xe_svm_range embed one drm_gpusvm_pages

This commit makes drm_gpusvm_pages self-contained and moves the lifecycle
responsibility to the driver. It introduces drm_gpusvm_init_pages() and upd=
ates
drm_gpusvm_range_remove() to avoid unmapping pages directly.

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
> =20

[Severity: Critical]
Could removing __drm_gpusvm_unmap_pages() here allow IOMMU mappings to pers=
ist
after the range is removed from the MMU notifier interval tree?

If another thread holds an extra reference to the range (for example, throu=
gh
xe_svm_unmap_address_range() calling drm_gpusvm_range_get() before invoking
the garbage collector), drm_gpusvm_range_remove() will remove the range from
the interval tree without unmapping the IOMMU.

During this window, if a concurrent CPU munmap() triggers the MMU notifier,=
 it
appears the notifier would fail to find the range in the interval tree and
return immediately. Would this result in a regression where the CPU frees t=
he
physical pages while the GPU retains active DMA access to them?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627034303.3795=
627-1-honglei1.huang@amd.com?part=3D3
