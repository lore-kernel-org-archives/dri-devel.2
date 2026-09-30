Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0353CA5FC7
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5102010E25C;
	Wed, 30 Sep 2026 14:32:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g7eb6PkZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C5B610E25C
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 14:32:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4254843420;
 Wed, 30 Sep 2026 14:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476821F00893;
 Wed, 30 Sep 2026 14:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790778761;
 bh=C8YotGbPpTw8fr4pGnkC5Uowc5xDPlhqj6/H6+qjLVQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=g7eb6PkZBOpj4//48iMPaLuU6J5ykwBODB2lvFBuyn8/AHuDAX1gdNPbqabkNY0SH
 vJ6QsnP+H2oNx6z+SBuMG9s2hj2/Ux+ofsOeOqdxlnvzPtkj0kEeY0a30tkhIRv93c
 cu/Hgglwg1U0ckdVtNkD0hQGTGZfeS/tJ7nnjV2/ztNfSvKtj1Oi9RvYtjfzslqXya
 LYXhdI883ZoVWo8mZEweA8DVSU5V5rJcZPlIltFtfWLyGeYwwR7UywHgbU5YTzu1Lc
 omctTAq70INmIdlBwx35izI23SIazv890eiUVKU0I/ziohHH0803OuaWHZGfiwUA5v
 NcTlNAXcbckoA==
Date: Wed, 30 Sep 2026 17:32:37 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
 Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v8 16/23] dma-buf: Let importers ask how peer-to-peer
 traffic is routed
Message-ID: <20260930143237.GI3401365@unreal>
References: <20260928-fix-p2p-acs-v4-0-v8-16-404453b9c435@nvidia.com>
 <607e8903-a979-4d78-bf08-447321c03119@amd.com>
 <20260929132305.GJ563127@unreal>
 <720dbac3-24f6-4c91-899e-e205865c1fd1@amd.com>
 <20260929175737.GK563127@unreal>
 <eeef5951-825e-459f-b474-bf8c59588446@amd.com>
 <20260930081832.GA3401365@unreal>
 <4549640c-f4a5-4dac-9be3-2e5aa127555c@amd.com>
 <20260930114356.GC3401365@unreal>
 <fbdc710d-7be1-4021-83c2-548c798d9d14@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbdc710d-7be1-4021-83c2-548c798d9d14@amd.com>
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

On Wed, Sep 30, 2026 at 01:52:39PM +0200, Christian König wrote:
> On 9/30/26 13:43, Leon Romanovsky wrote:
> > On Wed, Sep 30, 2026 at 10:34:56AM +0200, Christian König wrote:
> >> On 9/30/26 10:18, Leon Romanovsky wrote:
> ...
> >>>
> >>> At a minimum, exporters need to pass `p2pdma_provider`.
> >>
> >> No, exactly that is a no-go. The neither the framework nor the importer should see the p2pdma_provider.
> >>
> >> Only fully translated addresses where the DMA access should happen.
> >>
> >>>
> >>> If I keep the “dma-buf: Let exporters hand out the P2PDMA provider behind a
> >>> buffer” patch, I can move the P2P TLP types back into `p2pdma.c` and export
> >>> only the function that indicates whether ATS is required.
> >>>
> >>> Is it ok?
> >>
> >> What you can do is to forward declare enum pci_p2pdma_map_type and than pass that 1 to 1 from the exporter to the importer.
> > 
> > Unfortunately, neither suggestion applies to RDMA NICs. They need to know,
> > before mapping addresses, whether to create the memory region with ATS
> > enabled.
> 
> The design principle here is that the final location and access path of the data isn't determined when the buffer is created.
> 
> The importer first need to attach before it can query such information from the exporter.

In attach yes, this is why importer digs in dma_buf ops to get
p2pdma_provide, however it is before addresses are known.

> > The importer needs a way to obtain device information from the exporter so
> > that it can configure itself correctly.
> 
> That won't work with DMA-buf then, the exporter is completely opaque to the importer and that is for really good reasons.
> 
> Why in the world does the importer needs to know the information from the exporter before the mapping is created?
> 
> It is the exporter who decides how data is accessed by the importer and not the other way around.

There are several reasons:

1. This is how DMA-BUF MRs are built in RDMA. In mlx5, they rely on the ODP
   mechanism, which requires an MKEY to be created first. See commit
   90da7dc8206a (“RDMA/mlx5: Support dma-buf based userspace memory region”).
2. P2P routing is a property of devices, not memory. It is known and remains
   stable.
3. See the VFIO TPH ST discussion, where the requirement to obtain the
   exporter’s P2P information in the importer was raised again.

Thanks
