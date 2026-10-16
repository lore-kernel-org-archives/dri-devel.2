Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25131CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AF501125E8;
	Fri, 16 Oct 2026 07:06:17 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B59971125E8
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 07:06:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6EA5A40615;
 Fri, 16 Oct 2026 07:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C701F000C4;
 Fri, 16 Oct 2026 07:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792134370;
 bh=naF8lKTimbeI6bHpgVLscLsRFRDKFg+r8V/Bk06dWcw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ivFK6mps1y1VGYDOgDzT6ahao0YdocAvDj93UVI1C57s1E6HqYIzgJTqw19XwA81m
 l6By05x+DyqCgw8JpP7OE3FqIRPxjv/e5mK2rutglENFqBnUA5lEKaOsiZs+1aaYPc
 FvOeXI3Ee4G9lOYZTOQMyFcOKuDhne/SuzIyBrEAcBV2vNH6RFiyqzKenBYTuNL+qS
 2U5FpSCvSXCOb0AzJ7I5xmOzr4btWF4lMl5AWGKGcWTYzIrLKQLADvrLLV6n4Seau5
 tpDVTYd4whSUyrTWv57qK7iCII4QncDH+dMvT1dLM3GNn2ZZEOFlel+620NgD5H/bv
 xo7Qie/pc2wYA==
Message-ID: <sashiko-outbox-173900@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/11] ARM: dma-mapping: Implement and expose DMA
 setup functions
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261016-b4-arm32-iommu-dma-cookie-v2-4-b06842a01938@nvidia.com>
References: <20261016-b4-arm32-iommu-dma-cookie-v2-0-b06842a01938@nvidia.com>
 <20261016-b4-arm32-iommu-dma-cookie-v2-4-b06842a01938@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:06:09 +0000
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
- [High] arm-iommu: missing owns_domain check in arm_iommu_attach_device ca=
uses kref warning
--

commit 9a5832f0c5c50cf332fad22584273f026af693a5
Author: Mikko Perttunen <mperttunen@nvidia.com>
ARM: dma-mapping: Implement and expose DMA setup functions

This commit allows the IOMMU core to allocate DMA domains and get the
cookie from the ARM DMA code. It implements ARM versions of
iommu_get_dma_cookie and iommu_put_dma_cookie.

> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 4284950a92469..f2d3e8ec34872 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c

[ ... ]

> @@ -1660,6 +1742,14 @@ void arm_iommu_detach_device(struct device *dev)
>  		return;
>  	}
> =20
> +	/*
> +	 * This pairs with arm_iommu_attach_device() on a driver-owned mapping.
> +	 * A mapping which is merely the cookie of a core-owned default domain
> +	 * must not be torn down from here.
> +	 */
> +	if (WARN_ON(!mapping->owns_domain))
> +		return;
> +

[Severity: High]
Should __arm_iommu_attach_device() also have a similar check for
!mapping->owns_domain?

Mappings created by the IOMMU core via iommu_get_dma_cookie() are
zero-initialized and bypass kref_init(), relying instead on the owns_domain
flag being false to prevent refcount operations.

If a legacy driver saves a device's original core-owned mapping during
initialization and later attempts to restore it by calling
arm_iommu_attach_device(), __arm_iommu_attach_device() will execute:

arch/arm/mm/dma-mapping.c:__arm_iommu_attach_device() {
	...
	err =3D iommu_attach_device(mapping->domain, dev);
	if (err)
		return err;

	kref_get(&mapping->kref);
	...
}

Calling kref_get() on a zero-initialized kref would trigger a refcount warn=
ing
traceback. Does __arm_iommu_attach_device() need a
WARN_ON(!mapping->owns_domain) check to prevent driver interactions with
core-owned mappings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-b4-arm32-i=
ommu-dma-cookie-v2-0-b06842a01938@nvidia.com?part=3D4
