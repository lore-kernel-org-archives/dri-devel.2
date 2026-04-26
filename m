Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C85FF885C
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 10:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CE3310E1B2;
	Sun, 26 Apr 2026 10:52:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Hfr9xNcU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F2A110E1B2
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 10:52:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 61B83600AE;
 Sun, 26 Apr 2026 10:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79468C2BCAF;
 Sun, 26 Apr 2026 10:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777200739;
 bh=lNdbI4/apg1ysSsy83oxwfPftRF4Br9c6ZIns4MKmcA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Hfr9xNcUqlk+qH6bcnj9WFdahdi/+KDiSesUiqrA8reL0MzFxy0++syvclaIlpz3P
 B8JxvylaHT3Xwx9AAhk46IY+t1DMqQv18H4w7NWye3zArUgg6BCSRVoMcntzSOxaiA
 Dg9omC+3ngGzS9FO+aSVbeQ6hlT+J9WVSjMq2JKe7+mXjrRewm+ElgvrIqcp0fQonr
 +VVM/PhE+swJE0L4nVj+Im+kuXQhA7Y3W8xjI3yQ3nEx1QtWstvFCugOTpxwQpx4gw
 BEiEZookIYZUJY2DMvc/slD1qTrSsiUImb3TM9yQfeUekDqstZiXi4xnxbNuk1Tgmj
 2bZ/ygwh33E8g==
Date: Sun, 26 Apr 2026 13:52:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>
Cc: Matt Evans <mattev@meta.com>, Alex Mastro <amastro@fb.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Kevin Tian <kevin.tian@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Pranjal Shrivastava <praan@google.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH 9/9] vfio/pci: Add mmap() attributes to DMABUF feature
Message-ID: <20260426105215.GA440345@unreal>
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-10-mattev@meta.com>
 <20260424183153.GJ3444440@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424183153.GJ3444440@nvidia.com>
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

On Fri, Apr 24, 2026 at 03:31:53PM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 16, 2026 at 06:17:52AM -0700, Matt Evans wrote:
> > A new field is reserved in vfio_device_feature_dma_buf.flags to
> > request CPU-facing memory type attributes for mmap()s of the buffer.
> > Add a flag VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC, which results in WC
> > PTEs for the DMABUF's BAR region.
> > 
> > Signed-off-by: Matt Evans <mattev@meta.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 15 +++++++++++++--
> >  drivers/vfio/pci/vfio_pci_priv.h   |  1 +
> >  include/uapi/linux/vfio.h          | 12 +++++++++---
> >  3 files changed, 23 insertions(+), 5 deletions(-)
> 
> Nice and simple
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> > @@ -1549,8 +1551,12 @@ struct vfio_region_dma_range {
> >  struct vfio_device_feature_dma_buf {
> >  	__u32	region_index;
> >  	__u32	open_flags;
> > -	__u32   flags;
> > -	__u32   nr_ranges;
> > +	__u32	flags;
> > +	/* Flags sub-field reserved for attribute enum */
> > +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_MASK		(0xfU << 28)
> > +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_UC		(0 << 28)
> > +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC		(1 << 28)
> > +	__u32	nr_ranges;

Alex,

The TPH proposal extends the flags field in a similar way, but I suggested
a different approach to conserve bits. At the moment, we spend three bits
on a single feature, which feels wasteful.

What do you think?
https://lore.kernel.org/all/20260409120415.GF86584@unreal/

Thanks
