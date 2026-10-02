Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E74CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E439D10E584;
	Fri,  2 Oct 2026 09:14:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FMlEm9g2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C39E610E584;
 Fri,  2 Oct 2026 09:14:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AC8CB41087;
 Fri,  2 Oct 2026 09:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617E81F00893;
 Fri,  2 Oct 2026 09:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790932470;
 bh=8pdfmfs36HJsST5ZhqymEx8i55HW4Q35sSRnv116vLY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FMlEm9g2H3l+byH4NKCeQMGl+OrLOZcMVzAAX+LK+KQCEGm0rJZF5wowp/JGgssPh
 kFPY4UTfPjgO1qbfB9o/9ZvKjRrSDbsSHIOadtpcq7fv++wyIs20sgR3vbcQE0+qwT
 rPcaMKVE0UJicEU9pPO0jqEPymqqfB/H51tDukFMY617FqyRPB6KQw5fd3XKIxE6yL
 rwe1n+AJEI1Y/F9ykd1prIpUBX3D7dWIHR//jh2EP/44qeFz9HfWGianJiT3LnvG/3
 J/IueOPZumrFxa/nw7KLsV50aMhEAo8U1418hpGHXVw+1JQfsaGhYKBN+9jm28GF0e
 eK7PNcVBVEE4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] iommu/dma: Catch scatterlist length overflows
To: "Krzysztof Karas" <krzysztof.karas@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
In-Reply-To: <20261002053320.3145901-1-krzysztof.karas@intel.com>
References: <20261002053320.3145901-1-krzysztof.karas@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:30 +0000
Message-Id: <20261002091430.617E81F00893@smtp.kernel.org>
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
- [Medium] iommu/dma: missed scatterlist length overflow on 32-bit architec=
tures
--

commit c8808dcafa857db06b75cf791820b2414095b3cc
Author: Krzysztof Karas <krzysztof.karas@intel.com>

iommu/dma: Catch scatterlist length overflows

It is possible, when a very large mapping uses only one scatterlist, that
padding overflows scatterlist's length field. Address this issue by adding
overflow detection for scatterlist length field.

> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 58c624513cd43..06edb4056dc1b 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1477,6 +1477,11 @@ int iommu_dma_map_sg(struct device *dev, struct sc=
atterlist *sg, int nents,
>  		sg_dma_len(s) =3D s_length;
>  		s->offset -=3D s_iova_off;
>  		s_length =3D iova_align(iovad, s_length + s_iova_off);
> +		if (overflows_type(s_length, s->length)) {
> +			ret =3D -EOVERFLOW;
> +
> +			goto out_restore_sg;
> +		}

[Severity: Medium]
Does this catch scatterlist length wrapping on 32-bit architectures?

If a caller provides a scatterlist segment with a length close to 4GB
on a 32-bit system, s_length and s_iova_off are both size_t. Their addition
and the subsequent iova_align() will silently wrap around in 32-bit
arithmetic before the overflows_type() check is reached.

Because s_length has already wrapped, overflows_type() will evaluate if the
wrapped 32-bit value fits inside a 32-bit unsigned int (s->length), which
always returns false.

In contrast, the subsequent pad_len check correctly uses
check_add_overflow(), avoiding this pitfall. Could a similar approach be
used here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002053320.3145=
901-1-krzysztof.karas@intel.com?part=3D1
