Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DFA606A32E
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FbX1UOiX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A815110ECE9;
	Mon, 26 Oct 2026 09:16:29 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B663310ECE0;
 Mon, 26 Oct 2026 09:16:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BF408601EF;
 Mon, 26 Oct 2026 09:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592B81F031E3;
 Mon, 26 Oct 2026 09:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793006182;
 bh=jOX8HNX/sDLo6StqernrOTL5C1m7uvZYbmSW8LiQpAo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FbX1UOiXHR/vJHs5jCn0BgfgIuNzUilCYsO0JiG7DmbZG5ZP47t+K5mgsciYA97E9
 5+RKOalANcXsYhX69Sje9VpyRzR8Rfhw/6swfp6iuGmS2L7tu/yBV2aW9Y1PXMj/Yo
 7II3boWVkjYomv0LDKJ/AcLIR33OwHSsTp778KyEA/JQ4GT3YRryqE7RoFyVHkWxTT
 LssesAWjCqkC6rTO1ZiBcUOlc4KJ5bGv+AOe+y9hiWbDJN1Sjvlm67XZutA9+WfUha
 FapGNkxTMmCZF3ycDfJkYRGMUq2PT+ix3KBnyJxfDuvFE9zrfFCWBUyRtTNd4soJoT
 Rhmh8e8Y7KgCQ==
Message-ID: <sashiko-outbox-184753@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/26] RDMA/uverbs: Use the SGT_P2P mapping type
To: "Alistair Popple" <apopple@nvidia.com>, dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 media-ci@linuxtv.org
In-Reply-To: <20261026053623.202642-17-apopple@nvidia.com>
References: <20261026053623.202642-1-apopple@nvidia.com>
 <20261026053623.202642-17-apopple@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:16:21 +0000
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
- [High] RDMA/uverbs: use-after-free in uverbs_dmabuf_match_mapping() after=
 unbind
--

commit 573a52ef0d548646c203780dd26bd3aa8dbc3284
Author: Jason Gunthorpe <jgg@ziepe.ca>

RDMA/uverbs: Use the SGT_P2P mapping type

This commit converts the RDMA uverbs dma-buf exporter to use the SGT_P2P
mapping type via uverbs_dmabuf_match_mapping() and removes the
uverbs_dmabuf_attach() callback.

> diff --git a/drivers/infiniband/core/uverbs_std_types_dmabuf.c b/drivers/=
infiniband/core/uverbs_std_types_dmabuf.c
> index 2411ebee69e2d..3c5c3ea2cf556 100644
> --- a/drivers/infiniband/core/uverbs_std_types_dmabuf.c
> +++ b/drivers/infiniband/core/uverbs_std_types_dmabuf.c

[ ... ]

> @@ -76,13 +67,30 @@ static void uverbs_dmabuf_release(struct dma_buf *dma=
buf)
>  	uverbs_uobject_release(&priv->uobj);
>  }
> =20
> -static const struct dma_buf_ops uverbs_dmabuf_ops =3D {
> -	.attach =3D uverbs_dmabuf_attach,
> +static const struct dma_buf_mapping_sgt_exp_ops uverbs_dma_buf_sgt_ops =
=3D {
>  	.map_dma_buf =3D uverbs_dmabuf_map,
>  	.unmap_dma_buf =3D uverbs_dmabuf_unmap,
> +};
> +
> +static int uverbs_dmabuf_match_mapping(struct dma_buf_match_args *args)
> +{
> +	struct ib_uverbs_dmabuf_file *priv =3D args->dmabuf->priv;
> +	struct dma_buf_mapping_match sgt_match[1];
> +
> +	if (WARN_ON(!dev_is_pci(priv->provider->owner)))
> +		return -EINVAL;
> +
> +	sgt_match[0] =3D DMA_BUF_EMAPPING_SGT_P2P(
> +		&uverbs_dma_buf_sgt_ops, to_pci_dev(priv->provider->owner));
> +
> +	return dma_buf_match_mapping(args, sgt_match, ARRAY_SIZE(sgt_match));
> +}

[Severity: High]
Can uverbs_dmabuf_match_mapping() cause a use-after-free of priv->provider
and priv->provider->owner if an importer attaches to the dma-buf after the
exporting PCI/RDMA driver unbinds or the PCI device is removed?

During UVERBS_METHOD_DMABUF_ALLOC, priv->provider is populated via
ib_dev->ops.mmap_get_pfns() -> mlx5_ib_mmap_get_pfns() ->
pcim_p2pdma_provider():

drivers/pci/p2pdma.c:pcim_p2pdma_provider() {
	...
	p2p =3D rcu_dereference_protected(pdev->p2pdma, 1);
	if (WARN_ON(!p2p))
		/* Someone forgot to call to pcim_p2pdma_init() before */
		return NULL;

	return &p2p->mem[bar];
}

Because struct pci_p2pdma is allocated with devm_kzalloc(&pdev->dev, ...) in
pcim_p2pdma_init(), its lifetime is tied to the PCI driver binding rather
than the exported dma-buf file.

When the driver is unbound or hot-unplugged while userspace still holds the
dma-buf fd open, ib_uverbs_remove_one() calls ib_uverbs_free_hw_resources()
-> uverbs_destroy_ufile_hw() -> uverbs_dmabuf_fd_destroy_uobj():

drivers/infiniband/core/uverbs_std_types_dmabuf.c:uverbs_dmabuf_fd_destroy_=
uobj() {
	...
	dma_resv_lock(uverbs_dmabuf->dmabuf->resv, NULL);
	if (!uverbs_dmabuf->revoked) {
		uverbs_dmabuf->revoked =3D true;
		list_del(&uverbs_dmabuf->dmabufs_elm);
		dma_buf_invalidate_mappings(uverbs_dmabuf->dmabuf);
		dma_resv_wait_timeout(uverbs_dmabuf->dmabuf->resv,
				      DMA_RESV_USAGE_BOOKKEEP, false,
				      MAX_SCHEDULE_TIMEOUT);
		wait_for_comp =3D true;
	}
	dma_resv_unlock(uverbs_dmabuf->dmabuf->resv);
	...
}

After revoking and waiting for active mappings to unmap,
ib_uverbs_remove_one() sets wait_clients =3D 0 and returns without waiting =
for
open dma-buf fds to close. Once the PCI driver remove completes, devres fre=
es
struct pci_p2pdma (leaving priv->provider dangling), and if the PCI device =
is
removed, struct pci_dev (priv->provider->owner) can also be freed since
struct ib_uverbs_dmabuf_file does not hold a pci_dev_get() reference.

Previously, uverbs_dmabuf_attach() only checked attachment->peer2peer, and
priv->provider was only accessed inside uverbs_dmabuf_map() under
dma_resv_lock() after checking !priv->revoked.

With this change, dma_buf_mapping_attach() invokes
uverbs_dmabuf_match_mapping() without holding dmabuf->resv or checking
priv->revoked, and unconditionally dereferences priv->provider->owner and
passes the pci_dev to dma_buf_match_mapping() -> dma_buf_sgt_match() ->
pci_p2pdma_distance().

Notice that commit 9770a3eb805c ("vfio/pci: Change the DMA-buf exporter to
use mapping_type") earlier in this series avoided this same issue in
vfio_pci_dmabuf.c by storing a reference-counted struct pci_dev pointer in
priv->pdev for the lifetime of the dma-buf and passing priv->pdev in
match_mapping(). Should uverbs_std_types_dmabuf.c similarly hold a reference
or synchronize against revocation here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026053623.2026=
42-1-apopple@nvidia.com?part=3D16
