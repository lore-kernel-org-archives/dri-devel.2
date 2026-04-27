Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4972FF8868
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 18:35:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FE6510E2CE;
	Mon, 27 Apr 2026 18:35:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O1pRr7EI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDCB610E2CE
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 18:35:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1124960138;
 Mon, 27 Apr 2026 18:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CFEC19425;
 Mon, 27 Apr 2026 18:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777314921;
 bh=dt17/Yw/X7ftyXzeJoajfSmoBv1aq9SCt2MF5Y2JdVM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=O1pRr7EI1PG1hjtjKdpAdfc+2s7DW0qoJ5kB20Ugw89Jv80juk123xO1KqCYRJP62
 i1fX+6A1M+MoaYEi705G2F+4y73YfmHnG+UYMTpX8UCi5kh9q6fI3dlsDXg6ykxjjO
 bnECLzldef1WsMK+ZycKb8ibIoPXIPgZ9PK4xnuQ7JThI9vBxqJAXtG6zLt8N/jYGQ
 +mRl8XWRM2a1bPrYVRemksBiIcZUBV2udHlt7IQVsC8VfIGj/3wpN++CXKC1TUxDPE
 YcB/RMUHxzycUhlVghl/khiwAz5yC1ETvZpkenO/AJgRmoecHc6DRHmd5Ii60qwPXU
 5Cmi32sxE5O6A==
Date: Mon, 27 Apr 2026 21:35:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Alex Williamson <alex@shazbot.org>, Stanislav Fomichev <sdf@meta.com>,
 Keith Busch <kbusch@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
Message-ID: <20260427183513.GK440345@unreal>
References: <20260420183920.3626389-1-zhipingz@meta.com>
 <20260420183920.3626389-2-zhipingz@meta.com>
 <20260422092327.3f629ad6@shazbot.org>
 <20260427133746.GJ440345@unreal>
 <CAH3zFs2Sy0mv=QkK4VSV+MVR=ef_CdoxMhTFgzaqoZ+uSOpxoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH3zFs2Sy0mv=QkK4VSV+MVR=ef_CdoxMhTFgzaqoZ+uSOpxoQ@mail.gmail.com>
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

On Mon, Apr 27, 2026 at 07:28:57AM -0700, Zhiping Zhang wrote:
> On Mon, Apr 27, 2026 at 6:37 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > >
> > On Wed, Apr 22, 2026 at 09:23:27AM -0600, Alex Williamson wrote:
> > > On Mon, 20 Apr 2026 11:39:15 -0700
> > > Zhiping Zhang <zhipingz@meta.com> wrote:
> > >
> > > > Add a dma-buf callback that returns raw TPH metadata from the exporter
> > > > so peer devices can reuse the steering tag and processing hint
> > > > associated with a VFIO-exported buffer.
> > > >
> > > > Keep the existing VFIO_DEVICE_FEATURE_DMA_BUF uAPI layout intact by
> > > > using a flag plus one extra trailing entries[] object for the optional
> > > > TPH metadata. Rename the uAPI field dma_ranges to entries. The
> > > > nr_ranges field remains the DMA range count; when VFIO_DMABUF_FLAG_TPH
> > > > is set the kernel reads one extra entry beyond nr_ranges for the TPH
> > > > metadata.
> > > >
> > > > Add an st_width parameter to get_tph() so the exporter can reject
> > > > steering tags that exceed the consumer's supported width (8 vs 16 bit).
> > > > When no TPH metadata was supplied, make get_tph() return -EOPNOTSUPP.
> > > >
> > > > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > > > ---
> > > >  drivers/vfio/pci/vfio_pci_dmabuf.c | 62 +++++++++++++++++++++++-------
> > > >  include/linux/dma-buf.h            | 17 ++++++++
> > > >  include/uapi/linux/vfio.h          | 28 ++++++++++++--
> > > >  3 files changed, 89 insertions(+), 18 deletions(-)
> >
> > <...>
> >
> > > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > > index bb7b89330d35..a0bd24623c52 100644
> > > > --- a/include/uapi/linux/vfio.h
> > > > +++ b/include/uapi/linux/vfio.h
> > > > @@ -1490,16 +1490,36 @@ struct vfio_device_feature_bus_master {
> > > >   * open_flags are the typical flags passed to open(2), eg O_RDWR, O_CLOEXEC,
> > > >   * etc. offset/length specify a slice of the region to create the dmabuf from.
> > > >   * nr_ranges is the total number of (P2P DMA) ranges that comprise the dmabuf.
> > > > + * When VFIO_DMABUF_FLAG_TPH is set, entries[] contains one extra trailing
> > > > + * object after the nr_ranges DMA ranges carrying the TPH steering tag and
> > > > + * processing hint.
> > >
> > > I really don't think we want to design an API where entries is
> > > implicitly one-off from what's actually there.  This feeds back into
> > > the below removal of the __counted by attribute, which is a red flag
> > > that this is the wrong approach.
> >
> > I believe removing `__counted` is a mistake. In my proposal, the intent
> > was to adjust the meaning of the storage object based on the flag bit.
> > The size of the array should still be represented correctly.
> >
> > Thanks
> 
> Thanks Leon — you're right that __counted_by should be preserved. In
> your approach, when the flag is set, the last entry in the array
> carries the TPH data, so the effective DMA range count is nr_ranges -
> 1.

It is correct only if you keep the original name *nr_range*. However, the
variable name is worth changing to something clearer, such as
*nr_array_elements*.

> 
> That said, after discussing internally, we're leaning toward
> introducing a new VFIO device feature with dedicated TPH fields (as
> Alex suggested too), to avoid overloading vfio_region_dma_range with a
> union that changes semantics based on position.
> 
> Would you have concerns with that direction? I'll post a v3 with the
> new approach.

I don’t have any concerns. My only worry was about “stealing” too many  
bits from the flags variable, and you’ve avoided that here.

Thanks
