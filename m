Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC56CD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 06:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 076D410E0EB;
	Wed, 13 May 2026 06:31:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uqdZ45UX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2851810E0EB
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 06:31:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 937C643C81;
 Wed, 13 May 2026 06:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F359C2BCB7;
 Wed, 13 May 2026 06:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778653906;
 bh=dVOFz/bl1fNPd0bokrJcl/tAwN7bpIUq/3LFpzWp43Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uqdZ45UXAX1WAlZgKRMy0HztMJ7Bdo6H23kfG1Whj8GIFyR5UFFzqD0wF96AALbn2
 vzWEVoeaF5HNiu6zoy8+UpVk2pCgEy8Ilm+Om3XBiPq17bi/3Q+f86U6dB+XZUwz0Q
 sY/IiNQDMMnW5KQKuJQtzdFi86MrtfXTn1ZaOyFYof+QG5XRPsU9ojAbP0cedXUj2Z
 Biqu1EVdKMgwKlN0GDy37F0FxemOLyCn9HXCFY05bF257zs09G9nQnekx+/mY6+18A
 v6QBVgJqZ1whX1koob6aDDsbx1mFUDt4NrPxgBHO8EYgE+x3xOEwXAXFqSY/AdLCOg
 ZCqRoM7ND7KMA==
Date: Wed, 13 May 2026 09:31:41 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: fengchengwen <fengchengwen@huawei.com>,
 Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Keith Busch <kbusch@kernel.org>,
 Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 kvm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] vfio: add dma-buf get_tph callback and
 DMA_BUF_TPH feature
Message-ID: <20260513063141.GC15586@unreal>
References: <20260430200704.352228-1-zhipingz@meta.com>
 <20260430200704.352228-2-zhipingz@meta.com>
 <09995589-b81d-4cb7-a313-15a943d8b28d@huawei.com>
 <CAH3zFs2x2QebpqDC0qwQg_GP2FVs-qqNxPupck40cEHNrBMEsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH3zFs2x2QebpqDC0qwQg_GP2FVs-qqNxPupck40cEHNrBMEsA@mail.gmail.com>
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

On Wed, May 06, 2026 at 11:23:19AM -0700, Zhiping Zhang wrote:
> On Tue, May 5, 2026 at 11:58 PM fengchengwen <fengchengwen@huawei.com> wrote:
> >
> > >
> > On 5/1/2026 4:06 AM, Zhiping Zhang wrote:
> > > Add a dma-buf callback that returns raw TPH metadata from the exporter
> > > so peer devices can reuse the steering tag and processing hint
> > > associated with a VFIO-exported buffer.
> > >
> > > Add a new VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl that takes the fd from
> > > VFIO_DEVICE_FEATURE_DMA_BUF along with a steering tag and processing
> > > hint, validates the fd is a vfio-exported dma-buf belonging to this
> > > device, and stores the TPH values under memory_lock. This keeps the
> > > existing VFIO_DEVICE_FEATURE_DMA_BUF uAPI completely unchanged.
> > >
> > > The user sequences setting TPH on the dma-buf before the importer
> > > consumes it.
> > >
> > > Add an st_width parameter to get_tph() so the exporter can reject
> > > steering tags that exceed the consumer's supported width (8 vs 16 bit).
> > > When no TPH metadata was supplied, get_tph() returns -EOPNOTSUPP.
> > >
> > > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > >
> > > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> > > --- a/drivers/vfio/pci/vfio_pci_core.c
> > > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > > @@ -1534,6 +1534,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
> > >               return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
> > >       case VFIO_DEVICE_FEATURE_DMA_BUF:
> > >               return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
> > > +     case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> > > +             return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
> > > +                                                      argsz);
> > >       default:
> > >               return -ENOTTY;
> > >       }
> > > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > @@ -19,6 +19,9 @@ struct vfio_pci_dma_buf {
> > >       u32 nr_ranges;
> > >       struct kref kref;
> > >       struct completion comp;
> > > +     u16 steering_tag;
> > > +     u8 ph;
> > > +     u8 tph_present : 1;
> > >       u8 revoked : 1;
> > >  };
> > >
> > > @@ -69,6 +72,22 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attachment,
> > >       return ret;
> > >  }
> > >
> > > +static int vfio_pci_dma_buf_get_tph(struct dma_buf *dmabuf, u16 *steering_tag,
> > > +                                 u8 *ph, u8 st_width)
> > > +{
> > > +     struct vfio_pci_dma_buf *priv = dmabuf->priv;
> > > +
> > > +     if (!priv->tph_present)
> > > +             return -EOPNOTSUPP;
> > > +
> > > +     if (st_width < 16 && priv->steering_tag > ((1U << st_width) - 1))
> > > +             return -EINVAL;
> >
> > The checker will failed in following cases:
> > 1. If the exporter passed 8bit st, and importer support 16bit st, then it will pass
> >    the checker.
> > 2. The exporter enabled 16bit st and its st is < 256 (note: the pcie protocol doesn't
> >    restrict 16bit-st must >=256), and importer only support 8bit st, then it will also
> >    pass the checker
> >
> > Suggest userspace passing both st(8bit) and extend-st(16bit), and importer chose the
> > right one.
> >
> 
>  Agreed — 8-bit ST and 16-bit Extended ST are distinct namespaces
> (firmware returns
> them as separate fields with separate validity bits), so a numeric
> range check is insufficient.
> For v3 I'll change the uAPI to carry both, gated by a flags field:
> 
>   #define VFIO_DMA_BUF_TPH_ST (1 << 0)  /* steering_tag valid */
>   #define VFIO_DMA_BUF_TPH_ST_EXT (1 << 1)  /* steering_tag_ext valid
> */
>   struct vfio_device_feature_dma_buf_tph {
>       __s32 dmabuf_fd;
>       __u32 flags;
>       __u16 steering_tag;       /* 8-bit ST */
>       __u16 steering_tag_ext;   /* 16-bit Extended ST */

I wonder whether `steering_tag` and `steering_tag_ext` can coexist  
and hold different values at the same time.

BTW, please send your patches with diffstat.

Thanks

>       __u8  ph;
>       __u8  reserved[3];
>   };
> 
> get_tph() then picks the field matching the importer's st_width and
> returns -EOPNOTSUPP
> if that one isn't valid.
> 
> Thanks,
> Zhiping
