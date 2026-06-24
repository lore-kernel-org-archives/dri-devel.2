Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569CACDB481
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 14:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B288410E082;
	Wed, 24 Jun 2026 14:31:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Xcj86EXk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B33910E082
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 14:31:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D9FB04139A;
 Wed, 24 Jun 2026 14:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183991F000E9;
 Wed, 24 Jun 2026 14:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782311483;
 bh=dMJlxp8QipVxy2M9SnWzpGrx6rBzEVmcbiBu62OC/Ew=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Xcj86EXknUiizWzaPEFY1ZJZBKFKp44sKaQgJw4AKDhpmLbVWGfhD2saUODX1WBt2
 qYc2Akrz3AmSr0iitaVzc/maSTOWGR6/7qYP1rCXN4BfB2DbEdkYST9ZV0KE5sMbBu
 RgFSAihK8C3KYHuaPxwiOzFOCH3jCehmSVuGwbVeZerU7KpMWXBO5AO2o5qderwYCn
 qiH5Zm8pa1kbYM//LH4iVQq2DjoIZodWIVytV/2tLOINXQYgIExyPRR3Mo/L3NqFYi
 OoVIfoGbe0L0GMLeGllR+qC2wkmTefZnIhRgPxseduf1fZBepZKgngNip8+o+Az1zV
 G230X6Y0L/zpQ==
Date: Wed, 24 Jun 2026 17:31:19 +0300
From: Leon Romanovsky <leon@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Pranjal Shrivastava <praan@google.com>, David Hu <xuehaohu@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 jmoroni@google.com, kpberry@google.com, chriscli@google.com,
 sashiko-bot@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
Message-ID: <20260624143119.GA124186@unreal>
References: <20260621222130.1667453-1-xuehaohu@google.com>
 <20260623015459.1153884-1-xuehaohu@google.com>
 <20260623094446.4a8fc2ed@pumpkin> <ajryxMaT5evDUxaq@google.com>
 <20260623235350.6540eaa2@pumpkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260623235350.6540eaa2@pumpkin>
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

On Tue, Jun 23, 2026 at 11:53:50PM +0100, David Laight wrote:
> On Tue, 23 Jun 2026 20:55:32 +0000
> Pranjal Shrivastava <praan@google.com> wrote:
> 
> > On Tue, Jun 23, 2026 at 09:44:46AM +0100, David Laight wrote:
> > 
> > Hi David,
> > 
> > > On Tue, 23 Jun 2026 01:54:59 +0000
> > > David Hu <xuehaohu@google.com> wrote:
> > >   
> > > > Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> > > > This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> > > > first entry, resulting in non-page-aligned DMA addresses for all
> > > > subsequent entries.  
> > > 
> > > There is a separate issue of whether this code is even needed at all.
> > > Where can transfers over 2G (never mind 4G) actually come from.
> > > 
> > > The read, write and similar system calls limit transfers to INT_MAX
> > > (even on 64bit) and a lot of driver code will need fixing it longer
> > > lengths are allowed though.
> > > io_uring better enforce the same limits.
> > > So the transfers can come directly from userspace.
> > > 
> > > Not only that but you also need a single physically contiguous buffer.
> > > Good luck allocating that!
> > > 
> > > Now maybe there are some peer-to-peer places where the large buffer
> > > is device memory, but they will be unusual and probably need
> > > special treatment anyway.
> > >   
> > 
> > I agree that traditional VFS read/write face the MAX_RW_COUNT limit 
> > (~2GB), and io_uring has its limits, but I'm a little confused by the
> > push to enforce these limits here in the SGL code?
> > 
> > File I/O seems to be only one side of the picture. In my view, this fix
> > is necessary and certainly has a use-case:
> > 
> > For example, the RDMA subsystem has the capability to import dmabufs [1],
> > which gives rise to use cases for dmabuf beyond standard file ops 
> > (via VFS/io_uring). 
> > 
> > In these scenarios, GPU HBM can be exported as dmabufs. With recent GPUs,
> > HBM capacity can be in the order of hundreds of GBs [2]. RDMA can employ
> > infrastructure like the vfio-dmabuf-exporter [3] or similar dmabuf 
> > exporters to frequently move huge blocks of data via P2PDMA.
> 
> Ok, that explains where big buffers can come from.
> I just wasn't sure.
> 
> > If we restrict incoming dmabuf transfers to fit within VFS-centric 
> > limits (2GB), we impose unnecessary overhead on the RDMA stack, forcing
> > it to manage a significantly higher number of memory registrations. By 
> > cleanly splitting these massive contiguous device buffers into 
> > page-aligned SGL entries, we directly improve the efficiency of P2P 
> > transfers and memory registration.
> 
> But a divide by '4G - PAGE_SIZE' is also non-trivial and (I think affects
> a lot of io) when the quotient is always 1.
> Splitting into 2G chunks is a lot cheaper.
> 
> > Since this change doesn't seem to have a negative impact on standard file
> > I/O or break existing VFS constraints, I'm curious why we shouldn't 
> > support splitting these >4GB P2P transfers? Am I missing something?
> 
> I was only wondering whether it was needed...
> It does bring up the question of why the >4GB transfers even need splitting.
> But that is another question.

Just a side note:

In our vision, we aim to transition DMABUF to use physical  
addresses directly https://lore.kernel.org/all/0-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com/  
and eliminate the scatter‑gather layer from the DMABUF path.

Thanks

> 
> If you want to split large transfers into 4G-PAGE_SIZE blocks
> it is probably worth having a quick test that returns 1 for 'small' buffers.
> 
> 	David
> 
> > 
> > Thanks,
> > Praan
> > 
> > [1] https://elixir.bootlin.com/linux/v7.1.1/source/drivers/infiniband/core/umem_dmabuf.c#L174 
> > [2] https://nvdam.widen.net/s/fdvdqvfvj2/hopper-h200-nvl-product-brief (Table 2-2)
> > [3] https://elixir.bootlin.com/linux/v7.1.1/source/drivers/vfio/pci/vfio_pci_dmabuf.c#L297
> > 
> 
