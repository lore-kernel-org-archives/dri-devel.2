Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A9C606A328
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 06:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbDQrMrk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B513910E6BD;
	Fri,  6 Nov 2026 06:44:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A96610E46E;
 Fri,  6 Nov 2026 06:43:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2739E605F2;
 Fri,  6 Nov 2026 06:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821611F008A1;
 Fri,  6 Nov 2026 06:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793947437;
 bh=8JY5aYoae4gvBbGk4R/fq3xUEJBzbKgMtlay4eixobA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QbDQrMrkPXpwdJ515CqCnJKHunE0bw/QVPFTeeFwSipUdFcS1rxJvGwGXHVt0Vl5N
 Nq11O6ftPpVVX6JkkuzwhfYzRXOqUBxq/a5CIhFG5v17CSqsBXKb6dGbB0iY1F+ENG
 ZTO4tdBdYb5boCwYCI5q4QxVCm30PW42W1WzewE/sGxdWNLZ5Tn7o204dME3M7qW0R
 EVMqUicXUUYBZIclN+4PXkaI93AqT+zK0mSx9aCSH501OQYQevmasMNten7MsMQH5q
 +2PAv/pV/1xRtVhQjjhxpY+dcQTEQYLvhnu6X8CzC6pBGU5uZrEhlrrIIo98MG8NMG
 JXgtCczkedcyw==
Message-ID: <sashiko-outbox-200933@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/23] RDMA/uverbs: Use the SGT_P2P mapping type
To: "Alistair Popple" <apopple@nvidia.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261105-dma_mapping_type_v4-v2-17-78b8dc9ae80a@nvidia.com>
References: <20261105-dma_mapping_type_v4-v2-0-78b8dc9ae80a@nvidia.com>
 <20261105-dma_mapping_type_v4-v2-17-78b8dc9ae80a@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 06:43:57 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] RDMA/uverbs: commit message contradicts
  uverbs_dmabuf_match_mapping()
--

commit f919774da72af458231453cd6f22c8076d245156
Author: Jason Gunthorpe <jgg@ziepe.ca>

RDMA/uverbs: Use the SGT_P2P mapping type

This commit converts uverbs dmabuf from an attach callback checking
attachment->peer2peer to a match_mapping callback using
DMA_BUF_EMAPPING_SGT_REQUIRES_P2P().

>     RDMA/uverbs: Use the SGT_P2P mapping type
>    =20
>     Very similar to habana, except the rejection of unsupported
>     pci_p2p_dma_distance() is done inside map not attach via
>     dma_buf_phys_vec_to_sgt().
>    =20
>     Convert this directly to a SGT_P2P match which will prevent matching =
if
>     dma_buf_phys_vec_to_sgt() would fail.
>    =20
>     Remove the now empty attach function.
>    =20
>     Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>     Signed-off-by: Alistair Popple <apopple@nvidia.com>
>=20
> diff --git a/drivers/infiniband/core/uverbs_std_types_dmabuf.c b/drivers/=
infiniband/core/uverbs_std_types_dmabuf.c
> index 8d8c997a48834..0bae578c3d78e 100644
> --- a/drivers/infiniband/core/uverbs_std_types_dmabuf.c
> +++ b/drivers/infiniband/core/uverbs_std_types_dmabuf.c

[ ... ]

> @@ -95,13 +86,30 @@ static void uverbs_dmabuf_release(struct dma_buf *dma=
buf)
>  	uverbs_uobject_put(&priv->uobj);
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
> +	struct dma_buf_mapping_match sgt_match[1];
> +
> +	/*
> +	 * MMIO, so the importer must accept P2P. The provider is only valid
> +	 * under the dma_resv lock while not revoked, so the distance check is
> +	 * left to dma_buf_phys_vec_to_sgt() at map time, as before.
> +	 */
> +	sgt_match[0] =3D DMA_BUF_EMAPPING_SGT_REQUIRES_P2P(&uverbs_dma_buf_sgt_=
ops);

[Severity: Medium]
Does the commit message match the implementation in
uverbs_dmabuf_match_mapping()?

The commit title and changelog state that this converts uverbs to a SGT_P2P
match which prevents matching if dma_buf_phys_vec_to_sgt() would fail due to
an unsupported pci_p2p_dma_distance().

However, uverbs_dmabuf_match_mapping() uses
DMA_BUF_EMAPPING_SGT_REQUIRES_P2P() rather than DMA_BUF_EMAPPING_SGT_P2P().
As noted in the code comment, DMA_BUF_EMAPPING_SGT_REQUIRES_P2P() only chec=
ks
that the importer accepts P2P (replacing the !attachment->peer2peer check in
uverbs_dmabuf_attach()) and leaves the P2P distance check to
dma_buf_phys_vec_to_sgt() at map time because priv->provider is only valid
under the dma_resv lock while not revoked.

Should the commit title and message be updated to reflect that
DMA_BUF_EMAPPING_SGT_REQUIRES_P2P() is used instead of SGT_P2P, and that the
distance check remains at map time?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-dma_mappin=
g_type_v4-v2-0-78b8dc9ae80a@nvidia.com?part=3D17
