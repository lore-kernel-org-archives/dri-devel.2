Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B452B606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 07:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b+i0YPO2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B042A10E2CA;
	Mon, 26 Oct 2026 07:29:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07F9210E2CA;
 Mon, 26 Oct 2026 07:29:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B148E40C0B;
 Mon, 26 Oct 2026 07:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4D41F01825;
 Mon, 26 Oct 2026 07:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792999767;
 bh=ngHZ//LensErVgUP2h/uzFikKxMQwlzgpBXqi8Yu/yQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b+i0YPO2tFv0VV+dtBHvsJwUb9SYfN4ge7VwvQYtWPXaaBYsbA8M0rtNpQV4w4+c9
 OTxQOpI2Xc1fKLgio0pFeZ2Tze7F4HnBrYDqI50brJ/vc4+mEiFN0rG0urTKtY1RqB
 KcI8YgPQkFu0kng/eganHfrm3yX/9bZw0aCzRE5voy85U61sIuWm3QHxZEy12QUGA1
 cMvrkvgwG3Uh2C56NNqYeSE21gyXzH0zCs6xkQdHbriojuw70/CoVCELX5dhaRYnQ+
 7mNQQ+NGOIYxnxCV7bjUoN+72dLodZSoJuJKIpBOQikBLCjc3w2vyjjQem9B0WXOsG
 R+F2aUGWqdAkQ==
Message-ID: <sashiko-outbox-184660@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/26] dma-buf: Route SGT related actions through
 attach->map_type
To: "Alistair Popple" <apopple@nvidia.com>, dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 media-ci@linuxtv.org
In-Reply-To: <20261026053623.202642-5-apopple@nvidia.com>
References: <20261026053623.202642-1-apopple@nvidia.com>
 <20261026053623.202642-5-apopple@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 07:29:26 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dma-buf: dma_buf_get_sgt_ops() called before !attach NULL check
--

commit b7db1c5ac9aaaa1115dc4420ef21a9d03108a96b
Author: Jason Gunthorpe <jgg@ziepe.ca>

dma-buf: Route SGT related actions through attach->map_type

This commit routes sg_table map, unmap, and debugfs dump operations through
attach->map_type instead of calling attach->dmabuf->ops directly.

> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 16a7fbb8aaabe..348b47f266b48 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -1253,12 +1253,14 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
>  struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *attac=
h,
>  					enum dma_data_direction direction)
>  {
> +	const struct dma_buf_mapping_sgt_exp_ops *sgt_exp_ops =3D
> +		dma_buf_get_sgt_ops(attach);
>  	struct sg_table *sg_table;
>  	signed long ret;
> =20
>  	might_sleep();
> =20
> -	if (WARN_ON(!attach || !attach->dmabuf))
> +	if (WARN_ON(!attach || !attach->dmabuf || !sgt_exp_ops))
>  		return ERR_PTR(-EINVAL);

[ ... ]

> @@ -1366,15 +1368,18 @@ void dma_buf_unmap_attachment(struct dma_buf_atta=
chment *attach,
>  				struct sg_table *sg_table,
>  				enum dma_data_direction direction)
>  {
> +	const struct dma_buf_mapping_sgt_exp_ops *sgt_exp_ops =3D
> +		dma_buf_get_sgt_ops(attach);
> +
>  	might_sleep();
> =20
> -	if (WARN_ON(!attach || !attach->dmabuf || !sg_table))
> +	if (WARN_ON(!attach || !attach->dmabuf || !sg_table || !sgt_exp_ops))
>  		return;

[Severity: Medium]
Can calling dma_buf_get_sgt_ops(attach) in the variable initializers of
dma_buf_map_attachment() and dma_buf_unmap_attachment() cause a null
pointer dereference when attach is null?

In include/linux/dma-buf-mapping.h, dma_buf_get_sgt_ops() unconditionally
dereferences attach:

static inline const struct dma_buf_mapping_sgt_exp_ops *
dma_buf_get_sgt_ops(struct dma_buf_attachment *attach)
{
	if (attach->map_type.type !=3D &dma_buf_mapping_sgt_type)
		return NULL;
	return container_of(attach->map_type.exp_ops,
			    struct dma_buf_mapping_sgt_exp_ops, ops);
}

Because dma_buf_get_sgt_ops(attach) runs before the WARN_ON(!attach || ...)
checks in both functions, passing a null attach will dereference a null
pointer instead of triggering the warning and returning early, and the
compiler may also optimize away the subsequent !attach checks.

Note that while the dma_buf_map_attachment() path is refactored in a later
commit in this series ("dma-buf: Let the exporter select mapping type at
pin/map") when __dma_buf_sgt_map_attachment() is split out after the
WARN_ON(!attach || !attach->dmabuf) check, dma_buf_unmap_attachment()
(later renamed to dma_buf_sgt_unmap_attachment() in "treewide: Rename
dma_buf_unmap_attachment(_unlocked) to dma_buf_sgt_*") keeps the
dma_buf_get_sgt_ops(attach) call before WARN_ON(!attach || ...).

Should sgt_exp_ops be initialized after the !attach check in both
functions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026053623.2026=
42-1-apopple@nvidia.com?part=3D4
