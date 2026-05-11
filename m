Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF33CD4840
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 17:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2764D10E84A;
	Mon, 11 May 2026 17:51:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uaQBsmfc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C6DA10E84A
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 17:51:14 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AB6CB6001A;
 Mon, 11 May 2026 17:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2E2C2BCB0;
 Mon, 11 May 2026 17:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778521873;
 bh=9Yp/CVYMqyPHBsVwAYn1sN99dUm//BD19OnBzFRd58k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uaQBsmfcDLzI0oyLMmScwlkSABsNwECIqpR0/h+xKOpexzgzViP8Og/wmqTD4O1eF
 o7gjnRHu4CqassvmmeodKtlh3NbW4GDg8HjzPph7s4ZyElHEpfdeEKBIMRR550nSU+
 6IQNVmepFF0Cj19pqwB85nSgqqLBZfjop0NwAW8oEedE4O7mcdUnSjFXQtijvqFqO6
 09u6sQ/bFDGkIwo0v0C+Fm0ixRP9QjtN/Crkynr3upIr8pySL+lfbwNPcOaTRMW31g
 dTOJo/LYuCWyLbQASOoAfbmZAN5UpOnWve8uBiN0EqY1P4htfvnY4BJaNcfp2e8l7D
 lgE6+FEb0QoXw==
Date: Mon, 11 May 2026 20:51:03 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Matt Evans <mattev@meta.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>,
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
Message-ID: <20260511175103.GK15586@unreal>
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-10-mattev@meta.com>
 <20260424183153.GJ3444440@nvidia.com>
 <20260426105215.GA440345@unreal>
 <20260427083644.4ee174cd@shazbot.org>
 <25a4fc45-1b4d-426b-954a-60bf21e9040f@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25a4fc45-1b4d-426b-954a-60bf21e9040f@meta.com>
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

On Mon, May 11, 2026 at 04:30:39PM +0100, Matt Evans wrote:
> Hi Alex, Leon,
> 
> On 27/04/2026 15:36, Alex Williamson wrote:
> > 
> > On Sun, 26 Apr 2026 13:52:15 +0300
> > Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > > On Fri, Apr 24, 2026 at 03:31:53PM -0300, Jason Gunthorpe wrote:
> > > > On Thu, Apr 16, 2026 at 06:17:52AM -0700, Matt Evans wrote:
> > > > > A new field is reserved in vfio_device_feature_dma_buf.flags to
> > > > > request CPU-facing memory type attributes for mmap()s of the buffer.
> > > > > Add a flag VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC, which results in WC
> > > > > PTEs for the DMABUF's BAR region.
> > > > > 
> > > > > Signed-off-by: Matt Evans <mattev@meta.com>
> > > > > ---
> > > > >   drivers/vfio/pci/vfio_pci_dmabuf.c | 15 +++++++++++++--
> > > > >   drivers/vfio/pci/vfio_pci_priv.h   |  1 +
> > > > >   include/uapi/linux/vfio.h          | 12 +++++++++---
> > > > >   3 files changed, 23 insertions(+), 5 deletions(-)
> > > > 
> > > > Nice and simple
> > > > 
> > > > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > > > > @@ -1549,8 +1551,12 @@ struct vfio_region_dma_range {
> > > > >   struct vfio_device_feature_dma_buf {
> > > > >   	__u32	region_index;
> > > > >   	__u32	open_flags;
> > > > > -	__u32   flags;
> > > > > -	__u32   nr_ranges;
> > > > > +	__u32	flags;
> > > > > +	/* Flags sub-field reserved for attribute enum */
> > > > > +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_MASK		(0xfU << 28)
> > > > > +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_UC		(0 << 28)
> > > > > +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC		(1 << 28)
> > > > > +	__u32	nr_ranges;
> > > 
> > > Alex,
> > > 
> > > The TPH proposal extends the flags field in a similar way, but I suggested
> > > a different approach to conserve bits. At the moment, we spend three bits
> > > on a single feature, which feels wasteful.
> > > 
> > > What do you think?
> > > https://lore.kernel.org/all/20260409120415.GF86584@unreal/
> > 
> > I already proposed a very different interface for TPH that decouples
> > the dma-buf creation from setting the TPH values:
> > 
> > https://lore.kernel.org/all/20260423132016.4a25e074@shazbot.org/
> > 
> > This is overall less intrusive than the TPH change proposed, but it
> > could still make sense to align this as an operation on the dma-buf,
> > that can be probed as a separate feature.  Thanks,
> 
> I'll add a VFIO_DEVICE_FEATURE_DMA_BUF_ATTRS in a v2 instead to get in line
> with the TPH work, no worries.
> 
> For the benefit of future hackers, how would you describe the criteria for
> adding flags to this existing field?  

One bit per-feature.

> What hypothetical feature characteristics would be appropriate?  (Maybe it's that these attrs & TPH
> add scalar fields in several bits rather than a simple boolean.) Two of us
> have independently added something that's turned out to be inapproriate so
> some guidance would be good.

Both of you intertwined the signaling bit with the actual data, and that is
what led me to prefer a different approach.

Thanks

> 
> Thanks!
> 
> 
> Matt
