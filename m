Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF944FEA830
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 08:49:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3574310E821;
	Wed, 25 Mar 2026 08:49:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ltb7Z1iY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8917810E821
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 08:49:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 50C8E40DF9;
 Wed, 25 Mar 2026 08:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBF7C4CEF7;
 Wed, 25 Mar 2026 08:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774428573;
 bh=oWiu4XCakpEEWouFgjSkDQdwlQEePei3CI0lNENWLjQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ltb7Z1iYmSiPVmQYAbIrLOoN+Nr2Z+YdWmZOZaSTD/tsGAbbSQRbqSofeHb6qkCbh
 HKUW7VOg2Ihj0GIAPLLWBjynlKhsHh3Ys3KDc29Rem+kGcBhxtPhTWgQH2s4UvjB46
 gz/mVcWtL9ytM4SfSAClINJgkRMfa7FQF0FvLbaDA1RbbtL3H2i5hOfKVAd/GhZh2M
 /BV3cQA1QnK0kpl2xBsgdzcQdJUI1J7mUw8J3yUnCIGH3oxndxR9uhWCd629HuDhsK
 r7tD79zZiypj5bDBgmOipZkFwp0QdNFlX71D9qbfujgxE19uX75sx/HMaKAn6au5kl
 9EpfLDDNEDCJw==
Date: Wed, 25 Mar 2026 10:25:34 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
Message-ID: <20260325082534.GN814676@unreal>
References: <20260324234615.3731237-1-zhipingz@meta.com>
 <20260324234615.3731237-2-zhipingz@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324234615.3731237-2-zhipingz@meta.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, Mar 24, 2026 at 04:46:02PM -0700, Zhiping Zhang wrote:
> This patch adds a callback to get the tph info on DMA buffer exporters.
> The tph info includes both the steering tag and the process hint (ph).
> 
> The steering tag and ph are encoded in the flags field of
> vfio_device_feature_dma_buf instead of adding new fields to the uapi
> struct, to preserve ABI compatibility.
> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 26 ++++++++++++++++++++++++--
>  include/linux/dma-buf.h            | 30 ++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h          |  9 +++++++--
>  3 files changed, 61 insertions(+), 4 deletions(-)

<...>

> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index bb7b89330d35..e2a8962641d2 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1505,8 +1505,13 @@ struct vfio_region_dma_range {
>  struct vfio_device_feature_dma_buf {
>  	__u32	region_index;
>  	__u32	open_flags;
> -	__u32   flags;
> -	__u32   nr_ranges;
> +	__u32	flags;
> +#define VFIO_DMABUF_FL_TPH		(1U << 0) /* TPH info is present */
> +#define VFIO_DMABUF_TPH_PH_SHIFT	1         /* bits 1-2: PH (2-bit) */
> +#define VFIO_DMABUF_TPH_PH_MASK	0x6U
> +#define VFIO_DMABUF_TPH_ST_SHIFT	16        /* bits 16-31: steering tag */
> +#define VFIO_DMABUF_TPH_ST_MASK		0xffff0000U

This extension of flags is basically kills future extension of this
struct for anything that includes TPH.

Add new
enum vfio_device_feature_dma_buf_flags {
    VFIO_DMABUF_FL_TPH  = 1 << 0
}

> +	__u32	nr_ranges;

add your "__u16 steering_tag" and "__u8 ph" fields here.

>  	struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
>  };
> 
> --
> 2.52.0
> 
> 
