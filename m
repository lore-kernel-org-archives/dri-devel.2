Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7ABAFF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05DF410E2A6;
	Mon, 27 Apr 2026 13:37:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Pg6Yuy/n";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 514CD10E2BD
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 13:37:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E794E42D6A;
 Mon, 27 Apr 2026 13:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C84C19425;
 Mon, 27 Apr 2026 13:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777297072;
 bh=TudIdQcVoshTYDwz889WjIl4Z5pIYCL8L1tx+Zj9C4E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Pg6Yuy/nyI0zl2Lw0CgybWIaWr4LyCPMYjr93c9weHh7o+pDNysIAeWdOitY9P4Rr
 4/j8ONquGBt8npB1/poUCpp7+3yLrxQicG0XipCx4HotqjLjZJkaIu0B0cX6a+gReZ
 1eBztB4q7xOnrO/rqJAqXuuGCrUFdQp88LZRaKY7EWotY92GfF1u4YK3dH8s+CoGmJ
 SRud7NV1LZlGkN7ckkPzpIakhQBt/VhDcVA0MLJaZxU07DKFsAD8jrpMoZGwV6kb7a
 QZO3Tag2Nd/YJ6nMTfm2zEdyT01yHDnHXlkvWrhnYNMK5ZVib8NPIiFoq82B910qCN
 TZbW7VaxidXVQ==
Date: Mon, 27 Apr 2026 16:37:46 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Alex Williamson <alex@shazbot.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Stanislav Fomichev <sdf@meta.com>,
 Keith Busch <kbusch@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
Message-ID: <20260427133746.GJ440345@unreal>
References: <20260420183920.3626389-1-zhipingz@meta.com>
 <20260420183920.3626389-2-zhipingz@meta.com>
 <20260422092327.3f629ad6@shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422092327.3f629ad6@shazbot.org>
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

On Wed, Apr 22, 2026 at 09:23:27AM -0600, Alex Williamson wrote:
> On Mon, 20 Apr 2026 11:39:15 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
> 
> > Add a dma-buf callback that returns raw TPH metadata from the exporter
> > so peer devices can reuse the steering tag and processing hint
> > associated with a VFIO-exported buffer.
> > 
> > Keep the existing VFIO_DEVICE_FEATURE_DMA_BUF uAPI layout intact by
> > using a flag plus one extra trailing entries[] object for the optional
> > TPH metadata. Rename the uAPI field dma_ranges to entries. The
> > nr_ranges field remains the DMA range count; when VFIO_DMABUF_FLAG_TPH
> > is set the kernel reads one extra entry beyond nr_ranges for the TPH
> > metadata.
> > 
> > Add an st_width parameter to get_tph() so the exporter can reject
> > steering tags that exceed the consumer's supported width (8 vs 16 bit).
> > When no TPH metadata was supplied, make get_tph() return -EOPNOTSUPP.
> > 
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 62 +++++++++++++++++++++++-------
> >  include/linux/dma-buf.h            | 17 ++++++++
> >  include/uapi/linux/vfio.h          | 28 ++++++++++++--
> >  3 files changed, 89 insertions(+), 18 deletions(-)

<...>

> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index bb7b89330d35..a0bd24623c52 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1490,16 +1490,36 @@ struct vfio_device_feature_bus_master {
> >   * open_flags are the typical flags passed to open(2), eg O_RDWR, O_CLOEXEC,
> >   * etc. offset/length specify a slice of the region to create the dmabuf from.
> >   * nr_ranges is the total number of (P2P DMA) ranges that comprise the dmabuf.
> > + * When VFIO_DMABUF_FLAG_TPH is set, entries[] contains one extra trailing
> > + * object after the nr_ranges DMA ranges carrying the TPH steering tag and
> > + * processing hint.
> 
> I really don't think we want to design an API where entries is
> implicitly one-off from what's actually there.  This feeds back into
> the below removal of the __counted by attribute, which is a red flag
> that this is the wrong approach.

I believe removing `__counted` is a mistake. In my proposal, the intent  
was to adjust the meaning of the storage object based on the flag bit.  
The size of the array should still be represented correctly.

Thanks
