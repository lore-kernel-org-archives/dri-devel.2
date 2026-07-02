Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7794C43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D70F10F56E;
	Thu,  2 Jul 2026 18:42:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Oay3GZcq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0463010F56E
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 18:42:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 32FA7601CB;
 Thu,  2 Jul 2026 18:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1161F00A3D;
 Thu,  2 Jul 2026 18:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783017732;
 bh=mSNaagGrGaEd7SbyyZ4Ns3brb6JZz2ddeOYEpwPmzWc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Oay3GZcqNn4Hv7Y+UbdXvC9TLgQHkXU1MI5/GIq6rHdjdLK6WHdhLhzu5xv99F2Wy
 yQa0u1n5rN2ZcoXnC/3iqvoAFvBcNN6bPbzQkUDEUeSCUkDjTzKGAy2sKKweuLNEOm
 XG/Ux3fxLGY9aiXj9Bs5adOOB/dJta7Je7U0j351CPpSilM99sBgXbcFAG2A0DoLlZ
 oEjiCvYbfLdT3GCEiRB/uUvZLwVR33An3+6ioc4scujTp1GnvyJ7hMldpbP+Zia1PZ
 39nMe9qmBJ2ZhoRhYtPDhsDV4DTlDLK4zdXTfe80OyzV4nORI0Y9KTR/8jACJMpXUZ
 nFeQwF+aL0Mew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 4/4] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: dri-devel@lists.freedesktop.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260702181025.2694961-5-zhipingz@meta.com>
References: <20260702181025.2694961-1-zhipingz@meta.com>
 <20260702181025.2694961-5-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 18:42:12 +0000
Message-Id: <20260702184212.AD1161F00A3D@smtp.kernel.org>
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

New issues:
- [Medium] Failure to re-query PCIe TPH metadata upon DMA-buf invalidation

Pre-existing issues:
- [High] Memory leak of struct mlx5_st_idx_data in mlx5_st_dealloc_index()
--

commit e39795c3bd224c81bae70b87815075c4489e3f9e
Author: Zhiping Zhang <zhipingz@meta.com>
Subject: RDMA/mlx5: get tph for p2p access when registering dma-buf mr

This commit allows the mlx5 importer to query a dma-buf exporter's chosen
PCIe TLP Processing Hint (TPH) Steering Tag. It updates MR registration to
use this metadata for p2p access and program requester-side TPH on the
outbound mkey, falling back to no-TPH routing if unavailable.

> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
> index e6b74955d95dc..55216ae637614 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
[ ... ]
> @@ -903,6 +947,52 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_atta=
ch_ops =3D {
>  	.invalidate_mappings =3D mlx5_ib_dmabuf_invalidate_cb,
>  };
> =20
> +static void get_pci_tph_mr_dmabuf(struct mlx5_ib_dev *dev, struct dma_bu=
f *dmabuf,
> +				  u16 *st_index, u8 *ph)

[Severity: Medium]
When an unpinned DMA-buf MR is invalidated and then subsequently faulted ba=
ck
in via pagefault_dmabuf_mr() in drivers/infiniband/hw/mlx5/odp.c, the driver
calls ib_umem_dmabuf_map_pages() to map the pages, but it doesn't seem to
re-query the TPH metadata using get_pci_tph_mr_dmabuf() or
dma_buf_get_pci_tph().

Since the exporter might move the memory and change the preferred TPH steer=
ing
tag, does the driver need to re-evaluate the TPH metadata upon invalidation
and re-mapping to ensure DMA traffic isn't sent to a stale or suboptimal
NUMA node?

> +{
> +	u16 local_st_index;
> +	u16 steering_tag;
[ ... ]
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/lib/st.c
> index 997be91f0a135..bf14a7a6df15e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
[ ... ]
> @@ -152,8 +147,46 @@ int mlx5_st_alloc_index(struct mlx5_core_dev *dev, e=
num tph_mem_type mem_type,
>  	mutex_unlock(&st->lock);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(mlx5_st_alloc_index_by_tag);
[ ... ]
> +EXPORT_SYMBOL_GPL(mlx5_st_get_index);
> +
>  int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index)
>  {
>  	struct mlx5_st_idx_data *idx_data;

[Severity: High]
This is a pre-existing issue, but I noticed it while reviewing this patch
since this patch broadens its exposure.

In mlx5_st_dealloc_index(), when the use count reaches zero:

	if (refcount_dec_and_test(&idx_data->usecount)) {
		xa_erase(&st->idx_xa, st_index);
		/* We leave PCI config space as was before, no mkey will refer to it */
	}

Is there a memory leak here? The dynamically allocated idx_data is erased f=
rom
the xarray but does not appear to be passed to kfree().

Since unprivileged users can repeatedly create and destroy MRs, could this
lead to kernel memory exhaustion over time?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702181025.2694=
961-1-zhipingz@meta.com?part=3D4
