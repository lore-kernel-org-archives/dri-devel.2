Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C97C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 06:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E064610E702;
	Tue, 29 Sep 2026 06:00:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RvRhLmmO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6D5910E702
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 06:00:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8A79D42CBF;
 Tue, 29 Sep 2026 06:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371041F00893;
 Tue, 29 Sep 2026 06:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790661628;
 bh=34/90y0vTePiDgWFWoHxOSdJS+jIGnSly115TQfJU3w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RvRhLmmO4O0Vjp6UzSjlCj8o5UR5BF2KQmmOTRicsGh0Jbva6Wu7A/40/yvxE9xbT
 dR4QvuFyF6ywg/opoxjf5Rzf46mv/XkZDeCQjg6ZVDbPrF7Vqv/HToyyjRWrmB58gZ
 NIFzZLNomM5OnRUJF056xF27kiqZmXdAVKjfknmHk3WvWgi0fGY69kiPoUZAkstviI
 svyuAZm6hAa5Fjaqx46JBZgE28TzgEk6VG76Qek1adOsIOJ2v5OTqsGbMNrNXtcLIK
 VQbQrrpdFKBwttm1QqStCk6lCIr9iPAya6W/OWba76aAqBV8MiHCCwjrAmG0zgmaJ+
 Ea3SOVhQ4oB4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] udmabuf: respect the device's maximum segment size
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260929054835.94118-1-kmehltretter@gmail.com>
References: <20260929054835.94118-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:00:27 +0000
Message-Id: <20260929060028.371041F00893@smtp.kernel.org>
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
- [High] dma-buf: udmabuf CPU mapping fails on arches with PAGE_SIZE > 64KB
--

commit 8fabdc29555a534a611bda125124d9a796d8f300
Author: Karl Mehltretter <kmehltretter@gmail.com>

udmabuf: respect the device's maximum segment size

The commit fixes how get_sg_table() allocates scatterlists by passing the
device's maximum segment size to the scatterlist allocator. It returns
-EINVAL if the limit is smaller than PAGE_SIZE.

> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index df6dd00462423..018937435356e 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -133,15 +133,22 @@ static struct sg_table *get_sg_table(struct device =
*dev, struct dma_buf *buf,
>  {
>  	struct udmabuf *ubuf =3D buf->priv;
>  	struct sg_table *sg;
> +	unsigned int max_segment;
>  	int ret;
> =20
> +	max_segment =3D dma_get_max_seg_size(dev);
> +	/* The SG allocator requires a segment limit of at least PAGE_SIZE. */
> +	if (max_segment < PAGE_SIZE)
> +		return ERR_PTR(-EINVAL);

[Severity: High]
Does this unintentionally cause CPU mappings to unconditionally fail on
architectures with a PAGE_SIZE larger than 64KB?

When dma_buf_begin_cpu_access() is called for a udmabuf, it invokes
get_sg_table() using udmabuf_misc.this_device.

Because this misc device is initialized without setting up dma_parms or
max_segment_size:

drivers/dma-buf/udmabuf.c:udmabuf_dev_init() {
    ...
	ret =3D dma_coerce_mask_and_coherent(udmabuf_misc.this_device,
					   DMA_BIT_MASK(64));
    ...
}

dma_get_max_seg_size() blindly returns the fallback default of SZ_64K.

On architectures with a 256KB PAGE_SIZE (such as Hexagon or PowerPC), this
new validation evaluates to 65536 < 262144, unconditionally returning
-EINVAL and breaking all CPU mappings.

> +
>  	sg =3D kzalloc_obj(*sg);
>  	if (!sg)
>  		return ERR_PTR(-ENOMEM);
> =20
> -	ret =3D sg_alloc_table_from_pages(sg, ubuf->pages, ubuf->pagecount, 0,
> -					ubuf->pagecount << PAGE_SHIFT,
> -					GFP_KERNEL);
> +	ret =3D sg_alloc_table_from_pages_segment(sg, ubuf->pages, ubuf->pageco=
unt,
> +						0, ubuf->pagecount << PAGE_SHIFT,
> +						max_segment,
> +						GFP_KERNEL);
>  	if (ret < 0)
>  		goto err_alloc;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929054835.9411=
8-1-kmehltretter@gmail.com?part=3D1
