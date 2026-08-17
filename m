Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1F5C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDD0D10E70E;
	Mon, 17 Aug 2026 10:11:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c6quof9b";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6CDE10E3ED;
 Mon, 17 Aug 2026 10:11:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EF4C8600AE;
 Mon, 17 Aug 2026 10:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799001F000E9;
 Mon, 17 Aug 2026 10:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786961470;
 bh=6Som8vlNfZLuSjF8FYgXhkMJXuB15ZoSkS2/KaXFr2U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c6quof9b14T+iMxgA0QfSufxxzSc0LbSnIe4rLHqBEiAmIB7S5Y0NOM16yBgvxY6A
 NHPgSVxp1A3WcwkoK/jtJd2FReeWSLdZgb+EfDXGEn0NrUj/j17unelgu2IQHV7rh0
 tMofqIExsm6I5kOxfszHi8LkQtWCjjdXzQ1zY4ZkCV1uZOxjjdvTq3XV7nXe4/LCuR
 ZJhMC8sAKT5Yp0gTbQciyv5wEZtDopjCsSt9T22a4O/gV4/4jpmXqMirkGTQkt7BYl
 sJKa1X14mKcppG2MSv6MnY9KhEs/1bV+cvqwWisVTCZ1WoMtuZQ7/3toSyihCKxd5y
 T83aNx9J0GmwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/6] iommu/dma: Catch scatterlist length overflows
To: "Krzysztof Karas" <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260817095648.2438192-4-krzysztof.karas@intel.com>
References: <20260817095648.2438192-1-krzysztof.karas@intel.com>
 <20260817095648.2438192-4-krzysztof.karas@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 10:11:10 +0000
Message-Id: <20260817101110.799001F000E9@smtp.kernel.org>
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
- [High] Error path `out_restore_sg` corrupts unprocessed elements of reuse=
d scatterlists.
- [High] Accumulator `iova_len` silently overflows on 32-bit systems for ma=
ppings exceeding 4GB.
--

--- Patch [3]: [PATCH v5 3/6] iommu/dma: Catch scatterlist length overflows=
 ---
commit 955c8f50877d1e47058e0056fd63e5f20f4d62b9
Author: Krzysztof Karas <krzysztof.karas@intel.com>
Subject: iommu/dma: Catch scatterlist length overflows

This commit introduces overflow detection for scatterlist length fields to
prevent silent wrapping when very large mappings use only one scatterlist.
It adds check_add_overflow() and overflows_type() checks to
iommu_dma_map_sg(), failing early if limits are exceeded.

> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 9a07eb39336eb..61cb64bcbd3cc 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
[ ... ]
> @@ -1476,7 +1478,22 @@ int iommu_dma_map_sg(struct device *dev, struct sc=
atterlist *sg, int nents,
>  		sg_dma_address(s) =3D s_iova_off;
>  		sg_dma_len(s) =3D s_length;
>  		s->offset -=3D s_iova_off;
> -		s_length =3D iova_align(iovad, s_length + s_iova_off);
> +
> +		if (check_add_overflow(s_length, s_iova_off, &s_length_tmp)) {
> +			ret =3D -EOVERFLOW;
> +			goto out_restore_sg;
> +		}

[Severity: High]
This isn't a bug introduced by this patch, but these newly added early retu=
rn
paths make it much more likely to trigger a pre-existing issue in
__invalidate_sg().

If a driver reuses a scatterlist without calling sg_init_table(), and the
subsequent mapping fails here during element iteration, __invalidate_sg() w=
ill
loop over all elements rather than just the processed ones.

For unvisited elements, sg_dma_address(s) retains the stale IOVA from a
previous mapping. __invalidate_sg() erroneously adds this stale IOVA to
s->offset:

drivers/iommu/dma-iommu.c:__invalidate_sg() {
    ...
    if (sg_dma_address(s) !=3D DMA_MAPPING_ERROR)
        s->offset +=3D sg_dma_address(s);
    ...
}

Will this corrupted offset lead to wild physical address calculations in
sg_phys() upon retry or buffer access, resulting in arbitrary DMA memory
corruption?

[ ... ]
> @@ -1493,7 +1510,18 @@ int iommu_dma_map_sg(struct device *dev, struct sc=
atterlist *sg, int nents,
>  		 *   time through here (i.e. before it has a meaningful value).
>  		 */
>  		if (pad_len && pad_len < s_length - 1) {
> -			prev->length +=3D pad_len;
> +			unsigned int new_prev_len;
> +			/*
> +			 * For large mappings spanning multiple GBs we
> +			 * may not be able to fit all needed padding into
> +			 * sg->length.
> +			 */
> +			if (check_add_overflow(prev->length, pad_len, &new_prev_len)) {
> +				ret =3D -EOVERFLOW;
> +				goto out_restore_sg;
> +			}
> +
> +			prev->length =3D new_prev_len;
>  			iova_len +=3D pad_len;

[Severity: High]
This is a pre-existing issue, but since the patch addresses scatterlist len=
gth
overflows, could iova_len silently overflow here on 32-bit systems for
mappings exceeding 4GB?

If the size_t iova_len accumulator wraps around when adding pad_len or
s_length, it would lead to an undersized IOVA allocation. iommu_map_sg()
would then map the full physical memory range, overrunning the allocated IO=
VA
space and corrupting IOMMU page tables.

Should there be overflow checks for iova_len accumulation as well?

>  		}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817095648.2438=
192-1-krzysztof.karas@intel.com?part=3D3
