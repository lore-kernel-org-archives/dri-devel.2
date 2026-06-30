Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81827C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:54:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E642710EBBB;
	Tue, 30 Jun 2026 08:54:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VHrU5hLw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0218D10EBD0
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 08:54:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D123400F7;
 Tue, 30 Jun 2026 08:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462441F000E9;
 Tue, 30 Jun 2026 08:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782809674;
 bh=IGsaiQKLJAkl6j/KLX+Yx1QtF4a1Vef/32MV95+GytY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VHrU5hLw6s628vH4H0cENVV5ertR1ks9lofUXedOmTpSvp8wdweJTGZnR8VsiggXH
 GwsQJ8U+pD0hoAD/4yqOXNoVzfclZKHJbBm3GPXeaIX2C2HA2swp1HpxLuHwOVSeGK
 7DVEo4fS4WBKmzJLrPvMS9d1s1Mj6WthWRRTNpcNhvyymZl+OqZcWDFW+ZNQ9LQrYh
 GmX3Xh634nYUpI5s85H20XBay4wtIcpQYXulPo3G9Nm2OlJIOfGpn4EHeiQXKFI9Bb
 HWYrbcOjpYYNob/t1KeuvdyKcWV6RdC43h09iKH2FPvs+9QN95iAgNhMMgUyo3g/KG
 kguZrtfQNZ1Zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/5] drm/xe: have xe_svm_range embed one
 drm_gpusvm_pages
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260630083307.381909-4-honghuan@amd.com>
References: <20260630083307.381909-1-honghuan@amd.com>
 <20260630083307.381909-4-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 08:54:33 +0000
Message-Id: <20260630085434.462441F000E9@smtp.kernel.org>
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
- [High] The framework's cleanup function `drm_gpusvm_fini` violates the ne=
wly established contract for `drm_gpusvm_range_remove` by not DMA unmapping=
 pages before removal, creating a potential IOMMU use-after-free vulnerabil=
ity.
--

commit ce3cfca046dfb562114ff18565b9dc3974af3c6b
Author: Honglei Huang <honghuan@amd.com>
Subject: drm/xe: have xe_svm_range embed one drm_gpusvm_pages

With drm_gpusvm_pages now self contained, make xe stop relying
on the drm_gpusvm_range pages and take responsibility for the page
lifecycle on the driver side.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1228,12 +1228,17 @@ EXPORT_SYMBOL_GPL(drm_gpusvm_free_pages);
>   * This function removes the specified GPU SVM range and also removes th=
e parent
>   * GPU SVM notifier if no more ranges remain in the notifier. The caller=
 must
>   * hold a lock to protect range and notifier removal.
> + *
> + * This function does not unmap or free the drm_gpusvm_pages, the driver=
 owns
> + * that lifecycle. The caller must DMA unmap the range's pages before ca=
lling
> + * this function, so a range is never removed from the MMU interval tree=
 while
> + * still DMA mapped. Typically the driver calls drm_gpusvm_unmap_pages()=
 first.
> + * And the range_free callback's drm_gpusvm_free_pages() is a final fall=
back safe
> + * net.
>   */
>  void drm_gpusvm_range_remove(struct drm_gpusvm *gpusvm,
>  			     struct drm_gpusvm_range *range)
>  {

[Severity: High]
Does this new contract break the framework's cleanup function?

Looking at drm_gpusvm_fini() in drm_gpusvm.c, it calls drm_gpusvm_range_rem=
ove()
directly on remaining ranges after unregistering the MMU notifier:

		mmu_interval_notifier_remove(&notifier->notifier);
		notifier->flags.removed =3D true;

		drm_gpusvm_for_each_range_safe(range, __next, notifier, 0,
					       LONG_MAX)
			drm_gpusvm_range_remove(gpusvm, range);

Since drm_gpusvm_range_remove() no longer synchronously unmaps the pages, a=
nd
instead relies on the final kref_put() to execute the DMA unmap, could an
elevated refcount on a range indefinitely delay the DMA unmap?=20

This would mean the pages remain DMA mapped even though the MMU notifier has
been destroyed. If the OS frees or repurposes these physical pages, the GPU
IOMMU mapping would still point to them, creating a potential use-after-free
regression.

Can we ensure pages are unmapped here, or is there another way to close this
window?

> -	unsigned long npages =3D npages_in_range(drm_gpusvm_range_start(range),
> -					       drm_gpusvm_range_end(range));
>  	struct drm_gpusvm_notifier *notifier;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630083307.3819=
09-1-honghuan@amd.com?part=3D3
