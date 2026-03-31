Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD673FF60EE
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 08:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3345B10E948;
	Tue, 31 Mar 2026 08:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eYOeSSSF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4257110E91B
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 08:38:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DBAA4600CB;
 Tue, 31 Mar 2026 08:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CB8C19423;
 Tue, 31 Mar 2026 08:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774946282;
 bh=lkgsi7G8x5At2O5V1snIySUQ9gANaxTJ3/quUuCINCg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eYOeSSSFW0WXX4mmb2MsptPkJdbl34XCp/M4zjYe56EoUT29R9MHtfTXKQPdaNTCC
 km+65bU1EFEOKw5dFVpsTcaiMT//g3eVQ5wQFTIo/I7oJ/THNQwpC5I8OveBHsLJSv
 3TLow+1Vv81z+6ZpRvaJ+yJWkL2V+tUPyY4nPDYssx0+yV1YmWFpME3575WC2Pv8mV
 GFTL9SNY7QSYH4J+O7uv1C5fcawUeC5d6HW7UF+4i8Box0HYi2vuZ4MBWER521nK0Q
 SenJKH1W+1P9Rtm0e28iNy23S+AdcNCUTs9CjfxLv0EdzgY1EGenaxFTOtyUWS9Nz4
 6i/D/wPac9ByA==
Date: Tue, 31 Mar 2026 11:37:58 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
Message-ID: <20260331083758.GA814676@unreal>
References: <20260324234615.3731237-1-zhipingz@meta.com>
 <20260324234615.3731237-2-zhipingz@meta.com>
 <20260325082534.GN814676@unreal> <acW2BwQKaUbS3eL9@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acW2BwQKaUbS3eL9@kbusch-mbp>
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

On Thu, Mar 26, 2026 at 04:41:11PM -0600, Keith Busch wrote:
> On Wed, Mar 25, 2026 at 10:25:34AM +0200, Leon Romanovsky wrote:
> > On Tue, Mar 24, 2026 at 04:46:02PM -0700, Zhiping Zhang wrote:
> > >  struct vfio_device_feature_dma_buf {
> > >  	__u32	region_index;
> > >  	__u32	open_flags;
> > > -	__u32   flags;
> > > -	__u32   nr_ranges;
> > > +	__u32	flags;
> > > +#define VFIO_DMABUF_FL_TPH		(1U << 0) /* TPH info is present */
> > > +#define VFIO_DMABUF_TPH_PH_SHIFT	1         /* bits 1-2: PH (2-bit) */
> > > +#define VFIO_DMABUF_TPH_PH_MASK	0x6U
> > > +#define VFIO_DMABUF_TPH_ST_SHIFT	16        /* bits 16-31: steering tag */
> > > +#define VFIO_DMABUF_TPH_ST_MASK		0xffff0000U
> > 
> > This extension of flags is basically kills future extension of this
> > struct for anything that includes TPH.
> > 
> > Add new
> > enum vfio_device_feature_dma_buf_flags {
> >     VFIO_DMABUF_FL_TPH  = 1 << 0
> > }
> > 
> > > +	__u32	nr_ranges;
> > 
> > add your "__u16 steering_tag" and "__u8 ph" fields here.
> 
> You're suggesting that Ziping append the new fields to the end of this
> struct? I don't think we can modify the layout of a uapi.

He needs to add before flex array. This struct is submitted by the user
and kernel can easily calculate the position of that array.

Something like this:
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index b1d658b8f7b51..d78d915992232 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -237,7 +237,11 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
        if (get_dma_buf.region_index >= VFIO_PCI_ROM_REGION_INDEX)
                return -ENODEV;

-       dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
+       if (!tph_supplied)
+               dma_ranges = memdup_array_user(old_dma_ranges_pos, get_dma_buf.nr_ranges,
+                                      sizeof(*dma_ranges));
+       else
+               dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
                                       sizeof(*dma_ranges));
        if (IS_ERR(dma_ranges))
                return PTR_ERR(dma_ranges);
~


Thanks

> 
> If we can't carve the space for this out of the existing unused flags
> field, I think we'd have to introduce a new vfio device feature that
> basically copies VFIO_DEVICE_FEATURE_DMA_BUF with the extra hints
> fields.
>  
> > >  	struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
> > >  };
