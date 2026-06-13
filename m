Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617ACCD98DA
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 16:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF30E10EE16;
	Sat, 13 Jun 2026 16:28:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QH5+RgL9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1013D10EE08
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 16:28:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 737FE43466;
 Sat, 13 Jun 2026 16:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8C91F000E9;
 Sat, 13 Jun 2026 16:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781368101;
 bh=vrGX2AVuWYiA1uWbs1I+KENG1SIaWEfWpnSXtx/HkDQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QH5+RgL9N3/JyW+Vfpwqcbz1lGcHLhLljBvKpMeaSkEtCD8AFqoXVPcWOGN/JaTIz
 Wt4Nmb0h3MK7ai17q6Rtf6lxxkcKXQPu+b34eKTQi8hZmUdJofeeyFbi5AcDSo+gsZ
 C4zvGunO3IhynkBg0+Mt+ib5vWqaAB0katn6o52EtLPf0d2voIoSthPa4CSE77BFa/
 065F9j1HxmPxQHRpG083cYUoO5eT1p2gNqm1UerKrFk7Zd8WvwkThfjuMW6xXWic/E
 BzLz0D5cyu6BfnwIESZs0yCjPu+fVFDKAr7LIWrzqNhGiBd8F0+btf0GQQ+kO20wwi
 3YB1uuReNP6IA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 2/4] udmabuf: emit one sg entry per pinned
 folio
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612-tcpdm-large-niovs-v3-2-a3b693e76fcb@meta.com>
References: <20260612-tcpdm-large-niovs-v3-2-a3b693e76fcb@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 16:28:20 +0000
Message-Id: <20260613162821.3C8C91F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Scatterlist segment lengths generated from large folios exceed the=
 importer device's maximum segment constraints, violating the DMA API.

Pre-existing issues:
- [High] Unsynchronized caching of `ubuf->sg` in `begin_cpu_udmabuf()` caus=
es data races and memory leaks.
- [High] Unmapping an sg_table with a hardcoded DMA_BIDIRECTIONAL direction=
 mismatches the original mapped direction.
--

commit 53ed4a59d4fc35b8f3cc16427a92f6e1ca44ddb7
Author: Bobby Eshleman <bobbyeshleman@meta.com>

udmabuf: emit one sg entry per pinned folio

This commit updates get_sg_table() to walk folios and emit one sg entry
per folio, effectively coalescing contiguous runs into large scatterlist
entries. This helps importers that expect dmabuf sg entries to be size
and length aligned.

> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index 94b8ecb892bb1..9b751dd98b120 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
[ ... ]
> +static unsigned int udmabuf_sg_nents(struct udmabuf *ubuf)
> +{
> +	unsigned int nents =3D 0;
> +	pgoff_t i;
> +
> +	for (i =3D 0; i < ubuf->pagecount; i +=3D udmabuf_folio_nr_pages(ubuf, =
i))
> +		nents++;
> +	return nents;
> +}
> +
>  static struct sg_table *get_sg_table(struct device *dev, struct dma_buf =
*buf,
>  				     enum dma_data_direction direction)
>  {
>  	struct udmabuf *ubuf =3D buf->priv;
> -	struct sg_table *sg;
>  	struct scatterlist *sgl;
> -	unsigned int i =3D 0;
> +	struct sg_table *sg;
> +	pgoff_t i, run;
> +	unsigned int nents;
>  	int ret;
> =20
> +	nents =3D udmabuf_sg_nents(ubuf);
> +
>  	sg =3D kzalloc_obj(*sg);
>  	if (!sg)
>  		return ERR_PTR(-ENOMEM);
> =20
> -	ret =3D sg_alloc_table(sg, ubuf->pagecount, GFP_KERNEL);
> +	ret =3D sg_alloc_table(sg, nents, GFP_KERNEL);
>  	if (ret < 0)
>  		goto err_alloc;
> =20
> -	for_each_sg(sg->sgl, sgl, ubuf->pagecount, i)
> -		sg_set_folio(sgl, ubuf->folios[i], PAGE_SIZE,
> +	sgl =3D sg->sgl;
> +	for (i =3D 0; i < ubuf->pagecount; i +=3D run) {
> +		run =3D udmabuf_folio_nr_pages(ubuf, i);
> +		sg_set_folio(sgl, ubuf->folios[i], run << PAGE_SHIFT,
>  			     ubuf->offsets[i]);

[Severity: High]
Does this code assign unconstrained lengths to scatterlist segments without
respecting the importer device's max_seg_size?

If the coalesced run of folios exceeds the importer device's maximum segment
size (checked via dma_get_max_seg_size()), the DMA API mapping might fail
or silently truncate, potentially causing hardware-level data corruption.

Since dma_map_sgtable() cannot split overly large segments, should the
scatterlist be correctly sized prior to mapping by splitting runs that
exceed the device constraints? This would likely also require adjusting
the entry count calculated in udmabuf_sg_nents() above.

> +		sgl =3D sg_next(sgl);
> +	}
> =20
>  	ret =3D dma_map_sgtable(dev, sg, direction, 0);
>  	if (ret < 0)

[Severity: High]
This is a pre-existing issue, but I noticed a potential race condition in
begin_cpu_udmabuf() in drivers/dma-buf/udmabuf.c.

If the DMA_BUF_IOCTL_SYNC ioctl invokes begin_cpu_udmabuf() without
acquiring the dmabuf->resv lock:

begin_cpu_udmabuf() {
    ...
    if (!ubuf->sg) {
        ubuf->sg =3D get_sg_table(dev, buf, direction);
    ...
}

Can concurrent executions by multiple threads on the same file descriptor
simultaneously allocate new sg_table instances and overwrite ubuf->sg?
Could this permanently leak the unreferenced sg_tables and their associated
DMA mappings?

[Severity: High]
This is also a pre-existing issue, but does release_udmabuf() unmap the
sg_table using a hardcoded direction that mismatches the original mapped
direction?

release_udmabuf() {
    ...
    if (ubuf->sg)
        put_sg_table(dev, ubuf->sg, DMA_BIDIRECTIONAL);
    ...
}

Since begin_cpu_udmabuf() allocates and maps the sg_table using the DMA
direction explicitly requested by userspace (e.g., DMA_FROM_DEVICE),
unmapping it unconditionally with DMA_BIDIRECTIONAL violates the DMA API.
Could this corrupt IOMMU state or cause kernel warnings on platforms with
strict IOMMUs or bounce buffers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-tcpdm-larg=
e-niovs-v3-0-a3b693e76fcb@meta.com?part=3D2
