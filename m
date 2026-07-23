Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E31C531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 11:01:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71AFF10F094;
	Thu, 23 Jul 2026 11:01:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WkHIqeHv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C15710F094
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 11:01:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D531740813;
 Thu, 23 Jul 2026 11:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857041F000E9;
 Thu, 23 Jul 2026 11:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784804475;
 bh=4Fdv52UAG26bht8vYiSsIcFaUXIjoL7acJb7mCvfl3M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WkHIqeHvA+lWKU84yv9gd2zq0Bf1SXQefWW+J4JZxPfb6hiRqi4pwx9HmAFRQT2rE
 B1d0vtSEw6iyvJ5k0vi5xkaqBwUZdVq91dXh7XetEHnkhBNHACY2cvzFPQ4eJyl0MW
 /r/ZOz9yzPG7CMMVSo1IUKLWiFDwT2qTll5Nx8fH4rI/g3kGyXH9Sl8Tg4zDDHk+ud
 1WryNlx8Mfs+T/Qx16ByjatccWJbonW6Q6NXMa7zShNzSNqSIabOsAp8FdiavVYSwU
 YxzlnbuO46PzuBB5e+TOEnav4DUHwOzsBu1b/Q6im6X1tHX252Sm2ugy8+WoY+zh9s
 NvbJK0ohcWWVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/5] iommu/dma: Catch scatterlist length overflows
To: "Krzysztof Karas" <krzysztof.karas@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723102542.3245495-3-krzysztof.karas@intel.com>
References: <20260723102542.3245495-1-krzysztof.karas@intel.com>
 <20260723102542.3245495-3-krzysztof.karas@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 11:01:15 +0000
Message-Id: <20260723110115.857041F000E9@smtp.kernel.org>
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
- [Critical] The newly added scatterlist length overflow check `(s_length &=
 UINT_MAX) =3D=3D 0` is mathematically flawed. It fails to catch integer ov=
erflow on both 32-bit and 64-bit systems, leaving the critical truncation b=
ug unpatched, and introduces a regression by falsely rejecting legitimate z=
ero-length mappings.
--

--- Patch [2]: [PATCH v4 2/5] iommu/dma: Catch scatterlist length overflows=
 ---
commit 4c74567e86992a6211d4380e8e5bea4668d3e722
Author: Krzysztof Karas <krzysztof.karas@intel.com>

iommu/dma: Catch scatterlist length overflows

It is possible, when a very large mapping uses only one scatterlist,
that padding overflows scatterlist's length field. This results in
silently wrapping the value, smaller than desired mappings, and leaving
mapped bytes in memory. This commit addresses this issue by adding
overflow detection.

> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 9abaec0703efb..5be5d1f3c9f82 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1477,6 +1478,12 @@ int iommu_dma_map_sg(struct device *dev, struct sc=
atterlist *sg, int nents,
>  		sg_dma_len(s) =3D s_length;
>  		s->offset -=3D s_iova_off;
>  		s_length =3D iova_align(iovad, s_length + s_iova_off);
> +		if ((s_length & UINT_MAX) =3D=3D 0) {

[Severity: Critical]
Does this check actually catch integer overflows?

On 64-bit systems, s_length is a size_t, so this bitwise AND merely checks
if the lowest 32 bits are exactly zero. It will fail to detect an overflow
unless the aligned size is an exact multiple of 4GB.

On 32-bit systems, s_length + s_iova_off wraps before this check, so
s_length would just be a small wrapped value and bypass the check entirely.

Additionally, won't this incorrectly reject legitimate zero-length mappings?

If the overflow check is bypassed on a 64-bit system, s_length is truncated
to 32 bits when assigned to s->length below. iommu_map_sg() will then map
the truncated size while iova_len accumulates the full 64-bit size. The
partial mapping will trigger the error path later in the function:

	ret =3D iommu_map_sg(domain, iova, sg, nents, prot, GFP_ATOMIC);
	if (ret < 0 || ret < iova_len)
		goto out_free_iova;

	return __finalise_sg(dev, sg, nents, iova);

out_free_iova:
	iommu_dma_free_iova(domain, iova, iova_len, NULL);

This frees the IOVA back to the allocator without calling iommu_unmap(),
leaving the pages mapped and potentially causing device isolation breakdown
when the IOVA is reallocated.

> +			/* Prevent possible wrapping upon assignment to s->length. */
> +			ret =3D -EOVERFLOW;
> +			goto out_restore_sg;
> +		}
> +
>  		s->length =3D s_length;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723102542.3245=
495-1-krzysztof.karas@intel.com?part=3D2
