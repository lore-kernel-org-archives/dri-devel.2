Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3C9C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 829E410E8D1;
	Mon, 13 Jul 2026 10:14:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WI3iRkHt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3AE410E8D0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 10:13:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E4DD3600AA;
 Mon, 13 Jul 2026 10:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4031F000E9;
 Mon, 13 Jul 2026 10:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783937638;
 bh=oi+jDS58zElghpB9qOKXFImoWO1Bw9XEDwuk55tkvBw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WI3iRkHtsNa2UVhiQvflgwrr5Ps09I6gqmHuhfSZ9RCCI7FW90DDcnsT0AfoWxRhx
 l2aeArJJrNoKHFtk9Sup+zxwueM6I+3zFikPJGtCk55PnDtjIe58MoS+fdU7fEQ3i6
 tFpG88n24kYL2JViVxfM35FGIU7/KTqNMV8rPkNSW3ZWB3L/40R/bdLjqbfcwT04bZ
 aJAWejTI0X+5eogiHfGVqjBCVofLPCtXrLMVk3rFia8JtC9+Y79PkVMgTJ73553MU/
 tJZmQHSobZJc3yzZvXeGNJm8b8vACUmVugEbwze4mTKygqntmOPvn0FE+u96RfT0pg
 1/60rLRkupCjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] iommu/dma: Catch scatterlist length overflows
To: "Krzysztof Karas" <krzysztof.karas@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713095812.1014365-3-krzysztof.karas@intel.com>
References: <20260713095812.1014365-1-krzysztof.karas@intel.com>
 <20260713095812.1014365-3-krzysztof.karas@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 10:13:58 +0000
Message-Id: <20260713101358.7B4031F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `__invalidate_sg()` corrupts unprocessed scatterlist segments on m=
apping failure if the scatterlist was previously mapped.
- [High] Silent truncation of `s->length` during IOVA alignment leads to IO=
MMU page table memory leak.
--

--- Patch [2]: [PATCH v3 2/5] iommu/dma: Catch scatterlist length overflows=
 ---
commit 9f9c6b9481d1f01d396391f99642a7f233aa6651
Author: Krzysztof Karas <krzysztof.karas@intel.com>

iommu/dma: Catch scatterlist length overflows

This commit adds an overflow detection for the scatterlist length field
padding in iommu_dma_map_sg(). When a very large mapping uses only one
scatterlist, padding could overflow the length field resulting in small
mappings and left-over bytes in memory.

> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 9abaec0703efb..39da61b4e549e 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
[ ... ]
> @@ -1493,7 +1493,18 @@ int iommu_dma_map_sg(struct device *dev, struct sc=
atterlist *sg, int nents,
>  		 *   time through here (i.e. before it has a meaningful value).
>  		 */
>  		if (pad_len && pad_len < s_length - 1) {
> -			prev->length +=3D pad_len;
> +			unsigned int new_pad_len;
> +			/*
> +			 * For large mappings spanning multiple GBs we
> +			 * may not be able to fit all needed padding into
> +			 * sg->length.
> +			 */
> +			if (check_add_overflow(prev->length, pad_len, &new_pad_len)) {
> +				ret =3D -EOVERFLOW;
> +				goto out_restore_sg;

[Severity: High]
This is a pre-existing issue, but does jumping to out_restore_sg here
corrupt unprocessed scatterlist segments if the list was previously mapped?

If a driver maps, unmaps, and then re-maps a scatterlist, the unmap step
does not reset sg_dma_address() to DMA_MAPPING_ERROR. When this new error
path triggers, __invalidate_sg() will iterate over all segments. For the
unprocessed segments that still contain valid DMA addresses from the previo=
us
mapping, __invalidate_sg() will incorrectly assume they were modified:

drivers/iommu/dma-iommu.c:__invalidate_sg() {
    ...
			if (sg_dma_address(s) !=3D DMA_MAPPING_ERROR)
				s->offset +=3D sg_dma_address(s);
			if (sg_dma_len(s))
				s->length =3D sg_dma_len(s);
    ...
}

Could this overwrite the physical boundaries of the segments, potentially
leading to memory corruption on subsequent DMA operations?

> +			}
> +
> +			prev->length =3D new_pad_len;
>  			iova_len +=3D pad_len;
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but while handling large mappings
spanning multiple GBs, can s->length be silently truncated earlier in this
loop?

Before the padding step, the size_t s_length is aligned and assigned back to
s->length (which is a 32-bit unsigned int):

drivers/iommu/dma-iommu.c:iommu_dma_map_sg() {
    ...
		s_length =3D iova_align(iovad, s_length + s_iova_off);
		s->length =3D s_length;
    ...
}

If the aligned size_t exceeds UINT_MAX, it truncates. The iova_len
calculation uses the non-truncated size_t, allocating correct IOVA space,
but iommu_map_sg() will use the truncated s->length, mapping fewer bytes.

Since iommu_map_sg() succeeds in mapping the smaller size, it returns a
positive value. This triggers the error path:

drivers/iommu/dma-iommu.c:iommu_dma_map_sg() {
    ...
	ret =3D iommu_map_sg(domain, iova, sg, nents, prot, GFP_ATOMIC);
	if (ret < 0 || ret < iova_len)
		goto out_free_iova;
    ...
out_free_iova:
	iommu_dma_free_iova(domain, iova, iova_len, NULL);
    ...
}

Because out_free_iova only frees the IOVA allocator region and does not call
iommu_unmap(), does this permanently leak the hardware IOMMU page table
entries?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713095812.1014=
365-1-krzysztof.karas@intel.com?part=3D2
