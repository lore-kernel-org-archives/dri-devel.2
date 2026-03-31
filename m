Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 847A8109B461
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:00:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D810E10ED29;
	Tue, 31 Mar 2026 13:00:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D1GvVZwr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F7D710E9B2
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 13:00:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EB443434D9;
 Tue, 31 Mar 2026 13:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5715FC19423;
 Tue, 31 Mar 2026 13:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774962009;
 bh=Aid6A4kU1rFuiXFfYoqlUcE12Y1zwl4OGNPuijYgxwQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=D1GvVZwrBJF+RmNmadu1Zd61sTNOaNDCVjyCiMVFWQWQUMH+6Zzw1Hz9oznH2f3ks
 ljnsOTeYS0CRUSQrFS62kxo3o64EI2TpzBCxN9YSxtR1BxnimRdrdbRJ8y+vT/5pXU
 6ieoDwrOo6tkLAJP7hqhT7bXIx4yxGfg/E4FdIipIi1mejoJD0XpfZrs6bQnMwQFfB
 uiHpGijKiTtJ/HdI8OxLMiqKha8jj/0Mbfxjx5oCFIwRfLoyLosrSvvdg42a1BQ87h
 ASGO07Q6376XU49mwx6thSd118eOZPEc3avvWEdnznnVHDetxJ5BpVRMlfQAqSb+Dz
 9S//mLmMysm2g==
Date: Tue, 31 Mar 2026 07:00:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
Message-ID: <acvFV8c5QVxnt3Em@kbusch-mbp>
References: <20260324234615.3731237-1-zhipingz@meta.com>
 <20260324234615.3731237-2-zhipingz@meta.com>
 <20260325082534.GN814676@unreal> <acW2BwQKaUbS3eL9@kbusch-mbp>
 <20260331083758.GA814676@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331083758.GA814676@unreal>
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

On Tue, Mar 31, 2026 at 11:37:58AM +0300, Leon Romanovsky wrote:
> On Thu, Mar 26, 2026 at 04:41:11PM -0600, Keith Busch wrote:
> > 
> > You're suggesting that Ziping append the new fields to the end of this
> > struct? I don't think we can modify the layout of a uapi.
> 
> He needs to add before flex array. This struct is submitted by the user
> and kernel can easily calculate the position of that array.

No, you can't just do that. Existing applications would break when they
compile against the updated kernel header. They don't know about this
new "tph" supplied flag, but they'll all accidently use the new
dma_ranges offset. 
 
> Something like this:
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index b1d658b8f7b51..d78d915992232 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -237,7 +237,11 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>         if (get_dma_buf.region_index >= VFIO_PCI_ROM_REGION_INDEX)
>                 return -ENODEV;
> 
> -       dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
> +       if (!tph_supplied)
> +               dma_ranges = memdup_array_user(old_dma_ranges_pos, get_dma_buf.nr_ranges,
> +                                      sizeof(*dma_ranges));
> +       else
> +               dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
>                                        sizeof(*dma_ranges));
>         if (IS_ERR(dma_ranges))
>                 return PTR_ERR(dma_ranges);
> ~
