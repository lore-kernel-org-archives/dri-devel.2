Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0FEC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B69610E360;
	Wed,  1 Jul 2026 10:59:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GbE51LBp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C178D10E360
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 10:59:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 35A62601DF;
 Wed,  1 Jul 2026 10:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C341D1F000E9;
 Wed,  1 Jul 2026 10:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782903563;
 bh=ffs/vcNI89HjrLezuIU7106z8qfrp/twYIGAgp9iuGA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GbE51LBpM/NSjXw0229MX1h2G8HEB37WWYiNmul99ueSFrSbhuk2lAoBrUkykWowT
 jS8SsmA0ibfwQNux+01XyfwEtOV1bi6ZgfSm6o2ZmGq0GxLVxHliW+4CkvgYJVsIbc
 /GNC1LBXnLvqGyi91xjvLobMlyY+cv+xdq1j/sHpgucMWLLzIlcxQ0coOMiG7YASrn
 9qz8RBk7fpEP2N69VWcv6v7rr9lNiprWtBOXMHbP6aymr8KiG3oGgWEUikRvx0fJAi
 jFgJSzADJOl5jLQTNWUXTDa/YNqcwgqR9LWPDZ9jcup/W8t9zAgjjJ82q5ixGSqUnn
 6FieHXIh6d35g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] drivers/iommu: Catch scatterlist length overflows
To: "Krzysztof Karas" <krzysztof.karas@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701104437.236979-4-krzysztof.karas@intel.com>
References: <20260701104437.236979-1-krzysztof.karas@intel.com>
 <20260701104437.236979-4-krzysztof.karas@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 10:59:23 +0000
Message-Id: <20260701105923.C341D1F000E9@smtp.kernel.org>
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
- [High] The newly added `overflows_type` check fails to detect integer ove=
rflow on 32-bit architectures.
- [Medium] Explicitly assigned error code `-EOVERFLOW` is dead code because=
 it is unconditionally clobbered by the cleanup path.
--

commit 97ce5598e53bd4b56cac94c57bc68e63d7d39019
Author: Krzysztof Karas <krzysztof.karas@intel.com>

drivers/iommu: Catch scatterlist length overflows

This commit adds an overflow check to prevent scatterlist length fields
from silently wrapping when adding padding for large mappings. This helps
avoid truncated mappings and memory leaks in the IOMMU layer.

> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index e8d4c2dac4da8..02ff84e9c0427 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1493,8 +1493,18 @@ int iommu_dma_map_sg(struct device *dev, struct sc=
atterlist *sg, int nents,
>  		 *   time through here (i.e. before it has a meaningful value).
>  		 */
>  		if (pad_len && pad_len < s_length - 1) {
> -			prev->length +=3D pad_len;
> -			iova_len +=3D pad_len;
> +			if (overflows_type(prev->length + pad_len, prev->length)) {

[Severity: High]
Does this check work correctly on 32-bit architectures?

Because prev->length + pad_len is evaluated before the macro checks it, on a
32-bit architecture this addition will silently wrap before overflows_type
receives it. The macro would then check if the already-wrapped 32-bit value
fits into a 32-bit integer, which trivially succeeds.

Would it be better to use check_add_overflow(prev->length, pad_len,
&prev->length) here instead?

> +				/*
> +				 * For large mappings spanning multiple GBs we
> +				 * may not be able to fit all needed padding into
> +				 * sg->length.
> +				 */
> +				ret =3D -EOVERFLOW;
> +				goto out_restore_sg;

[Severity: Medium]
Will this -EOVERFLOW error code ever actually be returned?

Looking at the error handling path at the end of iommu_dma_map_sg():

out_restore_sg:
	__invalidate_sg(sg, nents);
out:
	if (ret !=3D -ENOMEM && ret !=3D -EREMOTEIO)
		return -EINVAL;
	return ret;

It appears the explicitly assigned -EOVERFLOW is unconditionally clobbered
and replaced by -EINVAL.

> +			} else {
> +				prev->length +=3D pad_len;
> +				iova_len +=3D pad_len;
> +			}
>  		}
> =20
>  		iova_len +=3D s_length;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701104437.2369=
79-1-krzysztof.karas@intel.com?part=3D3
