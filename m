Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E540C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:48:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6084D10E4C7;
	Tue, 30 Jun 2026 10:48:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LZM2MWzz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D413C10E4C7
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 10:48:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7964F40995;
 Tue, 30 Jun 2026 10:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9B21F000E9;
 Tue, 30 Jun 2026 10:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782816525;
 bh=qbyeHVUQ51m6cwk3s9wN9GiWEcVWe2AywLrQ8dKt8dQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LZM2MWzz7qHDeth73NccS7xiAUy0wujYBb015LJ9m6zBk5ui3Qo2kGamGLtXOoKCP
 ifiR36DDdpjVctMsrK1u4f6EIgaMjS/Esys0ohDIpe45219CzHyNOKceqjv/r08ONb
 5eA9ci7KUkRfnDs/Yi1+7yHj6XuKKcAe1fCRsy8F9Tf+gHj8aFCMORVEhy/E3tYHPm
 SQIy4hu30SaICLdGmVIfMKe0CjcQS8296TnhNZuoQzdZ5CtgcSLCFjcLbyjq0HGqkw
 E2VBfyMMpC9AoDilisUr8gCbtxp5H5lumvpdpYPTkZvkTvL3MLnbLsUKHwUP1SqoS9
 BEy7K8zjZ1+Qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/5] drm/gpusvm: move struct drm_gpusvm_pages out of
 struct drm_gpusvm_range
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260630083307.381909-5-honghuan@amd.com>
References: <20260630083307.381909-1-honghuan@amd.com>
 <20260630083307.381909-5-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 10:48:44 +0000
Message-Id: <20260630104845.3C9B21F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Device memory mapping leak on error path due to late dpagemap assi=
gnment.
- [High] System pages are incorrectly passed to device_unmap during mixed m=
apping cleanup when IOVA is used.
- [Medium] Direct read of `range->base.flags.migrate_devmem` in `xe_svm_all=
oc_vram` without `READ_ONCE` can cause a data race.
--

commit e379316e89e810abd61f491527f08c65a115928f
Author: Honglei Huang <honghuan@amd.com>
Subject: drm/gpusvm: move struct drm_gpusvm_pages out of struct drm_gpusvm_=
range

This commit separates physical pages and MM VA ranges abstractly by removing
the embedded pages object from the range structure. It drops range-level pa=
ge
wrappers in favor of direct driver usage of drm_gpusvm_pages helpers. The
documentation is also updated to reflect the new 1:1 and N:1 driver layouts.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index b0e9a2db10803..e0fd0b2fcc5ee 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c

[ ... ]

> @@ -1638,29 +1695,6 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  }
>  EXPORT_SYMBOL_GPL(drm_gpusvm_get_pages);

[Severity: High]
This is a pre-existing issue, but does drm_gpusvm_get_pages() permanently
leak device mappings if an error occurs?

When mapping a batch of device pages, if a failure occurs:

drm_gpusvm_get_pages()
    err =3D -EFAULT;
    goto err_unmap;

The code jumps to err_unmap to rollback, and __drm_gpusvm_unmap_pages()
checks svm_pages->dpagemap to determine if it should invoke device_unmap.
However, svm_pages->dpagemap is only assigned at the very end of the
success path:

    drm_pagemap_put(svm_pages->dpagemap);
    svm_pages->dpagemap =3D dpagemap;

Because it is still NULL during the error rollback, will the mapped device
pages be skipped and leaked?

[ ... ]

> @@ -1691,29 +1725,6 @@ void drm_gpusvm_unmap_pages(struct drm_gpusvm *gpu=
svm,
>  }
>  EXPORT_SYMBOL_GPL(drm_gpusvm_unmap_pages);

[Severity: High]
This is a pre-existing issue, but are system pages incorrectly passed to
device_unmap() during mixed mapping cleanup when IOVA is used?

In __drm_gpusvm_unmap_pages(), the cleanup loop checks system pages:

    if (!use_iova && addr->proto =3D=3D DRM_INTERCONNECT_SYSTEM)
        dma_unmap_page(...);
    else if (dpagemap && dpagemap->ops->device_unmap)
        dpagemap->ops->device_unmap(dpagemap, dev, addr);

If use_iova is true, the first condition evaluates to false for system
pages, causing them to fall through to the else-if branch. Since dpagemap
is non-NULL in a mixed mapping, will the driver-specific device_unmap()
callback be incorrectly executed on the system page?

> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> index 3f38283111cca..2862104aa1b20 100644
> --- a/include/drm/drm_gpusvm.h
> +++ b/include/drm/drm_gpusvm.h

[ ... ]

> @@ -189,7 +188,6 @@ struct drm_gpusvm_range {
>  	struct kref refcount;
>  	struct interval_tree_node itree;
>  	struct list_head entry;
> -	struct drm_gpusvm_pages pages;
>  	struct drm_gpusvm_range_flags flags;
>  };

[Severity: Medium]
This is a pre-existing issue, but can reading flags.migrate_devmem without
READ_ONCE() cause a data race?

In the xe driver's xe_svm_alloc_vram() function, there is a direct read of
the bitfield:

    xe_assert(range_to_vm(&range->base)->xe,
              range->base.flags.migrate_devmem);

The unmapped and partial_unmap flags within the range->base.flags union
are concurrently updated using WRITE_ONCE() under notifier_lock during MMU
notifier execution (e.g., drm_gpusvm_range_set_unmapped).

Since xe_assert executes outside the notifier_lock, this compiles to a
non-atomic load of the underlying word. Could a concurrent WRITE_ONCE() to
the same word cause a data race or false assertion trigger here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630083307.3819=
09-1-honghuan@amd.com?part=3D4
