Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3257ECD98C5
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 07:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B91D110ECE8;
	Sat, 13 Jun 2026 07:46:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nNsfCW+9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E576210ECE7
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 07:46:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CEC0D4024C;
 Sat, 13 Jun 2026 07:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9771E1F000E9;
 Sat, 13 Jun 2026 07:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781336778;
 bh=PYE4HvMrL3pc2k3JwB1CNaEw5rcSLTHD6S/Wt3v7KYM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nNsfCW+96SLciectEBIf89mdGl4KoNs/LZ+8LDg1I2T0BXiWVP7+Rg8uMdQ5cbNOC
 wXvhGGR4aX3e+pM33XxOCJHftli6QieL3LqGinGFl5ZgPvAhZVXMoNWu9SBS9kXH0+
 jyhR1BkFb3F6IAbzUvfH+WCbFr0QOdQodACEROzBRejb361AQfohLjFmiGd5E9780Y
 LGVe2qCu7upqK/H1UU0yBN0263FpuLMjb8BGY6zCmM64VOgyqZUBoRZggJ+BnuD7Ij
 q4u52Txy7VR68EqjQKhZiIC5U8fkISyviBmQHbGvayRiyI2j0zjhxXH7x4m889U6zz
 t+HH56P2Rx/sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 2/4] udmabuf: emit one sg entry per pinned
 folio
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260611-tcpdm-large-niovs-v2-2-ee2bf15e7523@meta.com>
References: <20260611-tcpdm-large-niovs-v2-2-ee2bf15e7523@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 07:46:18 +0000
Message-Id: <20260613074618.9771E1F000E9@smtp.kernel.org>
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
- [High] Coalesced scatterlist entries bypass the importer device's maximum=
 segment size and boundary limits, and can overflow the 32-bit scatterlist =
length field (`UINT_MAX`), leading to DMA mapping failures or hardware trun=
cation.

Pre-existing issues:
- [High] Concurrent CPU access ioctls cause a race in `begin_cpu_udmabuf`, =
leaking `sg_table` structures and DMA mappings.
- [High] Unmapping `ubuf->sg` with `DMA_BIDIRECTIONAL` when it was mapped w=
ith an arbitrary `direction` violates the DMA API.
--

commit be9ab332488f96f68bf591e95126d2d679acf5e3
Author: Bobby Eshleman <bobbyeshleman@meta.com>

udmabuf: emit one sg entry per pinned folio

This commit modifies udmabuf to emit one scatterlist entry per folio rather
than one per page. It aggregates contiguous pages within a folio to emit
larger scatterlist entries.

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

[Severity: High]
Does udmabuf_sg_nents() calculate the number of SG entries without accounti=
ng
for necessary segment splits based on device limits?=20

If the importer device has a smaller maximum segment size, passing an
oversized segment might violate the DMA API contract.

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
> +		sgl =3D sg_next(sgl);
> +	}

[Severity: High]
Can the coalesced size in get_sg_table() bypass the importer device's
maximum segment size and boundary limits?

Since the coalesced segment is never bounded by dma_get_max_seg_size(dev),
a very large segment could cause IOMMU faults or hardware truncation when
programmed.

Additionally, for huge folios on architectures supporting sizes greater
than 4GB, is it possible that run << PAGE_SHIFT overflows the 32-bit length
field in struct scatterlist, causing sg_set_folio() to silently truncate
the value?

[ ... ]
> static int begin_cpu_udmabuf(struct dma_buf *buf,
>                              enum dma_data_direction direction)
> {
[ ... ]
> 	if (!ubuf->sg) {
> 		ubuf->sg =3D get_sg_table(dev, buf, direction);
> 		if (IS_ERR(ubuf->sg)) {

[Severity: High]
This isn't a bug introduced by this patch, but does checking and populating
the ubuf->sg pointer concurrently in begin_cpu_udmabuf() without
synchronization allow multiple threads to map and overwrite the same pointe=
r?

If multiple tasks invoke the DMA_BUF_IOCTL_SYNC ioctl simultaneously without
holding dmabuf->resv or any other lock, they could see !ubuf->sg as true.
This could allocate multiple sg_table structures and leak the previously
assigned tables and their DMA mappings.

[ ... ]
> static int release_udmabuf(struct inode *inode, struct file *file)
> {
[ ... ]
> 	if (ubuf->sg)
> 		put_sg_table(dev, ubuf->sg, DMA_BIDIRECTIONAL);

[Severity: High]
This is a pre-existing issue, but does unconditionally unmapping the cached
sg_table with DMA_BIDIRECTIONAL in release_udmabuf() violate the DMA API if
it was initially mapped with an arbitrary direction?

In begin_cpu_udmabuf(), ubuf->sg is mapped using a caller-provided direction
such as DMA_FROM_DEVICE. Unmapping with a mismatched direction can cause
IOMMU faults, corrupt state tracking, or lead to kernel panics on systems
with strict IOMMUs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-tcpdm-larg=
e-niovs-v2-0-ee2bf15e7523@meta.com?part=3D2
