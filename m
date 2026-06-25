Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3330FCDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81E5110F2C7;
	Thu, 25 Jun 2026 13:57:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mXnfFI7N";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C26FE10F2C7
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:57:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 65D5F43493;
 Thu, 25 Jun 2026 13:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69871F000E9;
 Thu, 25 Jun 2026 13:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782395831;
 bh=NqQw8FDB52G6YD9rgP8N8A8CHJ4OWPfKj9+2HaJs2z0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mXnfFI7NXUK3ZrxmTtlD3/8XlCpErIHeYvFY6NPdIM12gEc0B7gINCbc+o5TBEFc7
 AfxFO9VPtU7JZm4WOwa1XWa1NYnec7mMLxKZnR5UwAMlId4GaT9+qELe71nYu7NfOd
 CYTmlhsSvUG32Q8EiwDD9hCrKotwnJvwkra8tzzV29pOJ2eFQrStQLhrRJqR6Rg4Q7
 o8OBRyxGEAMZoE3fU5naOM1KlrpDBGokds8++VOTwUrYW3JQWglMp0VGJp1xiU4hYT
 E8xi7k3UWFp3RC8lsSd4/xbFKe81OxnGtiInBOb2dggrf5ooUEqAsEK4fNTTxE+/EQ
 7wxY+IFyJWuEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drivers/iommu: Unroll unsuccessful mapping
To: "Krzysztof Karas" <krzysztof.karas@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625134342.1102921-2-krzysztof.karas@intel.com>
References: <20260625134342.1102921-1-krzysztof.karas@intel.com>
 <20260625134342.1102921-2-krzysztof.karas@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 13:57:10 +0000
Message-Id: <20260625135710.C69871F000E9@smtp.kernel.org>
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
- [High] iommu_map_sg() fails to map accumulated scatterlist segments if th=
ey are followed by a physically contiguous bus address segment, leading to =
silent partial mapping drops. The patch mitigates the resulting resource le=
ak in iommu_dma_map_sg() but leaves this root cause unaddressed.
--

commit 28ae7323f36f7853e142160b68651789c5fed2b2
Author: Krzysztof Karas <krzysztof.karas@intel.com>

drivers/iommu: Unroll unsuccessful mapping

This commit addresses an issue where partially successful IOMMU mappings
could leave untouched bytes unmapped, potentially leading to memory leaks.
It updates iommu_dma_map_sg() to unmap any partially mapped bytes before
freeing the IOVA and returning an error.

> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index e8d4c2dac4da8..78a12c12b5eae 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1515,8 +1515,14 @@ int iommu_dma_map_sg(struct device *dev, struct sc=
atterlist *sg, int nents,
>  	 * implementation - it knows better than we do.
>  	 */
>  	ret =3D iommu_map_sg(domain, iova, sg, nents, prot, GFP_ATOMIC);
> -	if (ret < 0 || ret < iova_len)
> +	if (ret < 0 || ret < iova_len) {
> +		if (ret > 0) {
> +			/* Unmap partially mapped bytes before freeing IOVA */
> +			if (iommu_unmap(domain, iova, ret) !=3D ret)
> +				ret =3D -EIO;
> +		}
>  		goto out_free_iova;
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but while this mitigates the
resulting resource leak in iommu_dma_map_sg() when a short map occurs, does
the underlying cause of the short map still exist in iommu_map_sg()?

Looking at iommu_map_sg() in drivers/iommu/iommu.c:

	while (i <=3D nents) {
		phys_addr_t s_phys =3D sg_phys(sg);

		if (len && s_phys !=3D start + len) {
			ret =3D iommu_map_nosync(domain, iova + mapped, start,
					len, prot, gfp);
			if (ret)
				goto out_err;

			mapped +=3D len;
			len =3D 0;
		}

		if (sg_dma_is_bus_address(sg))
			goto next;

If a normal scatterlist segment is followed by a P2PDMA bus address segment
that happens to be physically contiguous with it (s_phys =3D=3D start + len=
),
the flush condition is bypassed. The bus segment is then skipped via goto n=
ext,
leaving the accumulated len of the normal segment trapped.

If this happens at the end of the list, the normal segment is never flushed
and silently dropped, leading to a short map where mapped < total_len.

Could this lead to valid DMA mapping requests failing or devices performing
DMA into unmapped IOVA space if callers don't strictly validate the mapped
length?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625134342.1102=
921-1-krzysztof.karas@intel.com?part=3D1
