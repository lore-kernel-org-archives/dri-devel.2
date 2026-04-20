Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37C9F36C28
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 06:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13DEE10E0F8;
	Mon, 20 Apr 2026 06:34:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ferli2cG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A6E710E0F8
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 06:34:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0626F42DE2;
 Mon, 20 Apr 2026 06:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDE9C19425;
 Mon, 20 Apr 2026 06:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776666856;
 bh=SIQzikZxZrp71GghANcUxQ34/VjF6aP3rRJUnE4qCP0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ferli2cGr0NulEsabkChnw3zEB6FRv162hX/dUU+qBVnao9EBzZ/UbCTXcYJK95YT
 9hHCCNaUTp6TYIwUtfw/AsX3bZXymXbQR7MQMQ44aDjdx1ZlMpV8hUYMcujSEcR454
 J7ZWrp0TNt7d6tHYs9bZOu7qoXctDQuHXGZALhr+0sP5+ub98rzuAQeJj81AnLLNVG
 Pc0lHdaXgajlQCpnSTIWFrooAeIiupbYNMujX8uW6ZvCMUJmP5zJid9v2rvFE6KPgt
 fzL/CDnGdhfmxbLG3WsxnBM8SvFhNhAiyU4nC6/JtJF79tkLrIcNrSnSPqLXO9sbrv
 72pq1x20ubACQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org
Cc: sumit.semwal@linaro.org, benjamin.gaignard@collabora.com,
 Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com,
 christian.koenig@amd.com, m.szyprowski@samsung.com,
 robin.murphy@arm.com, jgg@ziepe.ca, leon@kernel.org,
 sean.anderson@linux.dev, ptesarik@suse.com,
 catalin.marinas@arm.com, suzuki.poulose@arm.com,
 steven.price@arm.com, thomas.lendacky@amd.com,
 john.allen@amd.com, ashish.kalra@amd.com,
 suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH v5 1/2] dma-mapping: introduce DMA_ATTR_CC_SHARED for
 shared memory
In-Reply-To: <20260325192352.437608-2-jiri@resnulli.us>
References: <20260325192352.437608-1-jiri@resnulli.us>
 <20260325192352.437608-2-jiri@resnulli.us>
Date: Mon, 20 Apr 2026 12:04:06 +0530
Message-ID: <yq5atst6ywbl.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Jiri Pirko <jiri@resnulli.us> writes:

> From: Jiri Pirko <jiri@nvidia.com>
>
> Current CC designs don't place a vIOMMU in front of untrusted devices.
> Instead, the DMA API forces all untrusted device DMA through swiotlb
> bounce buffers (is_swiotlb_force_bounce()) which copies data into
> shared memory on behalf of the device.
>
> When a caller has already arranged for the memory to be shared
> via set_memory_decrypted(), the DMA API needs to know so it can map
> directly using the unencrypted physical address rather than bounce
> buffering. Following the pattern of DMA_ATTR_MMIO, add
> DMA_ATTR_CC_SHARED for this purpose. Like the MMIO case, only the
> caller knows what kind of memory it has and must inform the DMA API
> for it to work correctly.
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v4->v5:
> - rebased on top od dma-mapping-for-next
> - s/decrypted/shared/
> v3->v4:
> - added some sanity checks to dma_map_phys and dma_unmap_phys
> - enhanced documentation of DMA_ATTR_CC_DECRYPTED attr
> v1->v2:
> - rebased on top of recent dma-mapping-fixes
> ---
>  include/linux/dma-mapping.h | 10 ++++++++++
>  include/trace/events/dma.h  |  3 ++-
>  kernel/dma/direct.h         | 14 +++++++++++---
>  kernel/dma/mapping.c        | 13 +++++++++++--
>  4 files changed, 34 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 677c51ab7510..db8ab24a54f4 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -92,6 +92,16 @@
>   * flushing.
>   */
>  #define DMA_ATTR_REQUIRE_COHERENT	(1UL << 12)
> +/*
> + * DMA_ATTR_CC_SHARED: Indicates the DMA mapping is shared (decrypted) f=
or
> + * confidential computing guests. For normal system memory the caller mu=
st have
> + * called set_memory_decrypted(), and pgprot_decrypted must be used when
> + * creating CPU PTEs for the mapping. The same shared semantic may be pa=
ssed
> + * to the vIOMMU when it sets up the IOPTE. For MMIO use together with
> + * DMA_ATTR_MMIO to indicate shared MMIO. Unless DMA_ATTR_MMIO is provid=
ed
> + * a struct page is required.
> + */
> +#define DMA_ATTR_CC_SHARED	(1UL << 13)
>=20=20
>  /*
>   * A dma_addr_t can hold any valid DMA or bus address for the platform. =
 It can
> diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
> index 63597b004424..31c9ddf72c9d 100644
> --- a/include/trace/events/dma.h
> +++ b/include/trace/events/dma.h
> @@ -34,7 +34,8 @@ TRACE_DEFINE_ENUM(DMA_NONE);
>  		{ DMA_ATTR_PRIVILEGED, "PRIVILEGED" }, \
>  		{ DMA_ATTR_MMIO, "MMIO" }, \
>  		{ DMA_ATTR_DEBUGGING_IGNORE_CACHELINES, "CACHELINES_OVERLAP" }, \
> -		{ DMA_ATTR_REQUIRE_COHERENT, "REQUIRE_COHERENT" })
> +		{ DMA_ATTR_REQUIRE_COHERENT, "REQUIRE_COHERENT" }, \
> +		{ DMA_ATTR_CC_SHARED, "CC_SHARED" })
>=20=20
>  DECLARE_EVENT_CLASS(dma_map,
>  	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index b86ff65496fc..7140c208c123 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -89,16 +89,24 @@ static inline dma_addr_t dma_direct_map_phys(struct d=
evice *dev,
>  	dma_addr_t dma_addr;
>=20=20
>  	if (is_swiotlb_force_bounce(dev)) {
> -		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> -			return DMA_MAPPING_ERROR;
> +		if (!(attrs & DMA_ATTR_CC_SHARED)) {
> +			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> +				return DMA_MAPPING_ERROR;
>=20=20
> -		return swiotlb_map(dev, phys, size, dir, attrs);
> +			return swiotlb_map(dev, phys, size, dir, attrs);
> +		}
> +	} else if (attrs & DMA_ATTR_CC_SHARED) {
> +		return DMA_MAPPING_ERROR;
>  	}
>

What is this check for? If we are requesting a DMA mapping with
DMA_ATTR_CC_SHARED, shouldn=E2=80=99t it be allowed? If not, how would we r=
each
the conditional below where we convert the physical address to a DMA
address using phys_to_dma_unencrypted()?. Also, how is this supposed to
interact with is_swiotlb_force_bounce()?=E2=80=9D

>=20=20
>  	if (attrs & DMA_ATTR_MMIO) {
>  		dma_addr =3D phys;
>  		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
>  			goto err_overflow;
> +	} else if (attrs & DMA_ATTR_CC_SHARED) {
> +		dma_addr =3D phys_to_dma_unencrypted(dev, phys);
> +		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
> +			goto err_overflow;
>  	} else {
>  		dma_addr =3D phys_to_dma(dev, phys);
>  		if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||

-aneesh
