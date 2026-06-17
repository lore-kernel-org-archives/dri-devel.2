Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE4BCD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8831210EFA8;
	Wed, 17 Jun 2026 10:56:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C9qYxHP/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8095F10EFA8
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 10:56:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DA4BD600AA;
 Wed, 17 Jun 2026 10:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D4B1F000E9;
 Wed, 17 Jun 2026 10:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781693796;
 bh=fFrUJIRwAC0PpbzdjriZIa15dSDBZjaM5KTM4UbK9JA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=C9qYxHP/SrTWO4RYMo9QbaAs4FjoMM1hwZgfSXILhMBXtJKPJ6mwrubc2wDEoyJtV
 CvwKBb9iW8wGknGM2nkue6e3tdOEVaj+8egJCrTHg0IdpaHxKQHGDnIhHvwLq2R5zW
 aryzfSF6EwApZWU8/CYW3jGUyUKWpMMkX5OPF537t+wo/+nePVhpR8Gy13wQ8gESjE
 Or/HE04YSt2xknn/JsK6722z7MAe5PRjSF2pSJugojWmQ1Tvy+aJSThsL0BRXj0bEj
 Du7ULOBlSSffZZEnThpA4uYQcs7KNa/xAtrkItyGlhtgzRw85PyC0edMSHyfUoAn0U
 3/yTtkuOwTH1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] drm/xe: have xe_svm_range embed one
 drm_gpusvm_pages
To: "Honglei Huang" <honglei1.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260617103602.1491609-4-honglei1.huang@amd.com>
References: <20260617103602.1491609-1-honglei1.huang@amd.com>
 <20260617103602.1491609-4-honglei1.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 10:56:36 +0000
Message-Id: <20260617105636.73D4B1F000E9@smtp.kernel.org>
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
- [High] Device memory mappings are leaked in the error path of drm_gpusvm_=
get_pages() because device_unmap is skipped.
--

commit 25e4cbe499297aaf84b70f35d35aa1d25e43829b
Author: Honglei Huang <honghuan@amd.com>

    drm/xe: have xe_svm_range embed one drm_gpusvm_pages
   =20
    With drm_gpusvm_pages now self contained, make xe stop relying
    on the drm_gpusvm_range pages and take responsibility for the page
    lifecycle on the driver side.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index d6407c94cdda3..7af535853c380 100644
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

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
drm_gpusvm_get_pages() leak device memory mappings?

In drm_gpusvm_get_pages(), if a device page is successfully mapped via
dpagemap->ops->device_map(), but a subsequent page mapping fails, the code
jumps to the err_unmap label and calls __drm_gpusvm_unmap_pages() to clean =
up:

err_unmap:
	svm_pages->flags.has_dma_mapping =3D true;
	__drm_gpusvm_unmap_pages(gpusvm, svm_pages, num_dma_mapped);

Inside __drm_gpusvm_unmap_pages(), the loop uses the dpagemap loaded from
svm_pages->dpagemap to resolve the callback:

			else if (dpagemap && dpagemap->ops->device_unmap)
				dpagemap->ops->device_unmap(dpagemap,
							    dev, addr);

Since svm_pages->dpagemap isn't updated until the end of drm_gpusvm_get_pag=
es()
upon complete success, it remains NULL (or holds a stale reference) during
err_unmap. Will this evaluate to false and skip the required device_unmap
operations for the newly mapped device pages?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617103602.1491=
609-1-honglei1.huang@amd.com?part=3D3
