Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BEECD6E6B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 07:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4F6A11A4BE;
	Fri,  5 Jun 2026 07:03:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FVw2+DsW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3BA511A4BE
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 07:03:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6554640929;
 Fri,  5 Jun 2026 07:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2234B1F00899;
 Fri,  5 Jun 2026 07:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780643031;
 bh=thH+xSmRJ1p6dFMBZ3hCjI7fi88DZ7AkWXao4AYRp8s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FVw2+DsWpy2wK5av9l0leoiIWq6JhOKhGJXx/JjScaMOGqxnT7j6hvVswF5wLgyfF
 4craqBz0YKoGO3RIJnyUgFrGG9Q1XthDP19ot7lQtvG0iLqA9spK9Z87affEcrG+Zj
 a18uBES1hpo/SmP1+DvtsxBx6TVedhSIRRlmSd/wEzNkzGo2n1AIj/eP490MY421jx
 n+UUVe2kioiMuxVi9r8J+b3a0lLoGQ5y6qUHNLkkBVvSCjp3fF1WBE33Ix7aPbTV/c
 jkDkCM+CobAg1pseVlyiRcJvbw3Mg2Ri9kIZv0Gl1tsV3ZaTt0/wPFhA1Y/PBYE5lt
 HeMyo8dZb7wuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 2/4] udmabuf: emit one sg entry per pinned folio
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
In-Reply-To: <20260603-tcpdm-large-niovs-v1-2-f37a4ac6726c@meta.com>
References: <20260603-tcpdm-large-niovs-v1-2-f37a4ac6726c@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 07:03:50 +0000
Message-Id: <20260605070351.2234B1F00899@smtp.kernel.org>
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
- [High] The scatterlist construction merges contiguous pages into a single=
 segment without respecting the importing device's DMA maximum segment size=
 constraints, which can also overflow the 32-bit SG length field for gigaby=
te-sized folios.
--

commit 0cf8c9573968c851d2a1981909f322167f021ced
Author: Bobby Eshleman <bobbyeshleman@meta.com>

udmabuf: emit one sg entry per pinned folio

This commit updates get_sg_table() to walk folios and emit one scatterlist
entry per contiguous run of pages in a folio. It coalesces entries for large
folios instead of emitting strictly one sg entry per PAGE_SIZE.

> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index 94b8ecb892bb1..f28dd3788adad 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c

[ ... ]

> +/* Count the contiguous folio runs in @ubuf, one sg entry per run. */
> +static unsigned int udmabuf_sg_nents(struct udmabuf *ubuf)
> +{
> +	unsigned int nents =3D 0;
> +	pgoff_t i;
> +
> +	for (i =3D 0; i < ubuf->pagecount; i +=3D udmabuf_folio_nr_pages(ubuf, =
i))
> +		nents++;

[Severity: High]
Does this count assume each contiguous run can always fit into a single
scatterlist entry?

If the importing device has a restrictive DMA maximum segment size, will th=
is
under-allocate the sg_table since large runs might need to be split across
multiple entries?

> +	return nents;
> +}
> +
>  static struct sg_table *get_sg_table(struct device *dev, struct dma_buf =
*buf,
>  				     enum dma_data_direction direction)
>  {

[ ... ]

> -	for_each_sg(sg->sgl, sgl, ubuf->pagecount, i)
> -		sg_set_folio(sgl, ubuf->folios[i], PAGE_SIZE,
> +	sgl =3D sg->sgl;
> +	for (i =3D 0; i < ubuf->pagecount; i +=3D run) {
> +		run =3D udmabuf_folio_nr_pages(ubuf, i);
> +		sg_set_folio(sgl, ubuf->folios[i], run << PAGE_SHIFT,
>  			     ubuf->offsets[i]);

[Severity: High]
Can run << PAGE_SHIFT exceed the importing device's maximum DMA segment
size (dma_get_max_seg_size(dev))?

If the hardware descriptors are limited (e.g. to 64KB), a large merged
segment might get truncated during I/O by the importing driver.

Also, if a system supports gigantic folios (e.g., 16GB HugeTLB), could
run << PAGE_SHIFT exceed UINT_MAX? sg_set_folio() stores the length in the
32-bit sg->length field, which would silently truncate the value.

> +		sgl =3D sg_next(sgl);
> +	}
> =20
>  	ret =3D dma_map_sgtable(dev, sg, direction, 0);
>  	if (ret < 0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-tcpdm-larg=
e-niovs-v1-0-f37a4ac6726c@meta.com?part=3D2
