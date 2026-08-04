Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBCDC55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 19:02:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 201D010EB56;
	Tue,  4 Aug 2026 19:02:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ly7s/WQD";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C0310EB56
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 19:02:04 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2cacef7d299so23845ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 12:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785870124; x=1786474924;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o7hc3yljc5+LxUHQxs78+dkD3Zfo1reE/uEECJBVPac=;
 b=ly7s/WQDt3FfiTTQnlsrsVs9UOAg6E9+HUfZ8BRUfWKe66CJkQbpCKI84OLueoQv+0
 KUKkVvJ1mcCxeZkulnzL3TL1mcW4ZIGEnFDCBP8WpHbz+X9CVSiILTXkRLlEmmUcJ7p3
 c7Km2T8gMM8DvFgdFD8msJtlBM4z4TfHQtkZPlTIb0Xv+y8zINFFArBRn7q5noHn2kvJ
 cM5c2D59VjBLGxTt2jicjp8wC5k/uHDvAeicEUIR22cHdgSwvXbUH4vDe2tbYnT9xCS4
 0ONCaOlmTKclH3tAOIVbMdcD2kbNJODo9KsGQ+9QrezFDWm5mk0S4772DvPgpbRgA1Kb
 ebzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785870124; x=1786474924;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o7hc3yljc5+LxUHQxs78+dkD3Zfo1reE/uEECJBVPac=;
 b=dVQthFUKYyMCWSI5x55ESPbLkfQbay+VWKIA7rwPRZngmLjKqBOKqQjLVd9XlwbvFP
 IOt/Srpr/3iEBKAskxiyUR9mr0ojLvUg6PB3Kt9Q48qK0qpfXMpbs2V9TN8i9SBoVtGB
 cIr/z/rgS+jvYWjlxly+TzlOzCGws246RLLE58rkELN3tVi/ZJJfhMkhUDfFommiYRqo
 euiqr6pRIPps0OkXx24qGWIKCxxMKKuH39odJiQmCR+kz4WhqDtt33buvRk+ybUUQcR0
 iQjwYVLqBO30fQHgudoS5XqYLx3DeCj5FITMZv3xHCDDuT/OOcIeqgghGIRACkq+SvJG
 b/wA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+mLj7VjD8ej8ppRCvIqG6FzctHVtLQpGMLlGnKqBtqfI5Zs6+7IM2aJqp2k9V+1+6ffqbovjmONY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyesBbwyHaTSU+EKiERrpxcyC7NMqcFK7oA4BpF5sjS+Jt3xmpJ
 nLZn15vHfClUxVuA0obAqzzLnLlmVI7egkv3RgAWqbDv8XPXNkje7IEjmvK6FC+mvQ==
X-Gm-Gg: AR+sD11SSkDhYBr9ixwIct3EFKvgvZykqL8GopESpR0cK9pmrNTE/LDJ6qi2vtuNQJM
 FtorVyRKAPGDfJBolXoG1eWnd5jPbHt+OTrbgCViFgGl9pVN9hQgzqOnu6rwGU6lN5CUmpNCFIn
 hjDfjNDHLov2Oq83ooow8QZdxFPT/txeQ6i8YNXyDPooqaO4wJDvEyf0/r3eItU1+PHoi5i7axC
 fjFDKMJaEjawFAn79ylYm4N44XZSwtJ3jshJECIcYKr8bI1jvkLNm9cFJWuMSBBMQV2sEm5vWNv
 Hk5ka3SY4X+PLOSxA9gvjf/VjTWE8C3I/IfugsYxg0SePeNBR9kSYJrKu/ryi6OKSXNZHBUyyo8
 ZgyZdtgif8/wLzElXv6kAezgZZXPz3O/vSY9GlBUNSolUNqHOdOILh7AhqVk/Ia3at1yhYMx5Gn
 LbVmDyFDCCKzrY8VwgIuXm99XvEMeUoPQSL2zBOPKbjiqSE3QfTDlr4JFSZW5JB3WkSEXRSTLr4
 x4XgkrubB9fPP6LTtUSVi4=
X-Received: by 2002:a17:903:3c23:b0:2ca:cbe5:c3af with SMTP id
 d9443c01a7336-2d0caf6bbb3mr2044475ad.7.1785870123058; 
 Tue, 04 Aug 2026 12:02:03 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com.
 [34.124.168.21]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f2e2c2326sm201840b3a.10.2026.08.04.12.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 12:02:02 -0700 (PDT)
Date: Tue, 4 Aug 2026 19:01:53 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Kevin Tian <kevin.tian@intel.com>, Longfang Liu <liulongfang@huawei.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 3/9] vfio/pci: Add a helper to look up PFNs for DMABUFs
Message-ID: <anI3IZVZm16BOIc5@google.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-4-matt@ozlabs.org>
 <amvWXNRtviKEuUoV@google.com>
 <ecf9b355-9fe1-440b-9281-08671a995139@ozlabs.org>
 <cfae30ec-18ed-4f06-bf96-ef294a8c2744@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfae30ec-18ed-4f06-bf96-ef294a8c2744@ozlabs.org>
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

On Mon, Aug 03, 2026 at 07:22:06PM +0100, Matt Evans wrote:

Hi Matt,

> Hi Praan,
> 
> On 31/07/2026 18:43, Matt Evans wrote:
> > Hi Praan,
> > 
> > On 30/07/2026 23:55, Pranjal Shrivastava wrote:
> >> On Wed, Jul 15, 2026 at 06:47:26PM +0100, Matt Evans wrote:
> >>> Add vfio_pci_dma_buf_find_pfn(), which a VMA fault handler can use to
> >>> find a PFN.
> >>>
> >>> This supports multi-range DMABUFs, which typically would be used to
> >>> represent scattered spans but might even represent overlapping or
> >>> aliasing spans of PFNs.
> >>>
> >>> Because this is intended to be used in vfio_pci_core.c, we also need
> >>> to expose the struct vfio_pci_dma_buf in the vfio_pci_priv.h header.
> >>>
> >>> Signed-off-by: Matt Evans <matt@ozlabs.org>
> >>> ---
> >>>  drivers/vfio/pci/vfio_pci_dmabuf.c | 153 ++++++++++++++++++++++++++---
> >>>  drivers/vfio/pci/vfio_pci_priv.h   |  20 ++++
> >>>  2 files changed, 160 insertions(+), 13 deletions(-)
> >>>
> >>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> >>> index c16f460c01d6..7c047400dfd1 100644
> >>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> >>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> >>> @@ -9,19 +9,6 @@
> >>>  
> >>>  MODULE_IMPORT_NS("DMA_BUF");
> >>>  
> >>> -struct vfio_pci_dma_buf {
> >>> -	struct dma_buf *dmabuf;
> >>> -	struct vfio_pci_core_device *vdev;
> >>> -	struct list_head dmabufs_elm;
> >>> -	size_t size;
> >>> -	struct phys_vec *phys_vec;
> >>> -	struct p2pdma_provider *provider;
> >>> -	u32 nr_ranges;
> >>> -	struct kref kref;
> >>> -	struct completion comp;
> >>> -	u8 revoked : 1;
> >>> -};
> >>> -
> >>>  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> >>>  				   struct dma_buf_attachment *attachment)
> >>>  {
> >>> @@ -106,6 +93,146 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
> >>>  	.release = vfio_pci_dma_buf_release,
> >>>  };
> >>>  
> >>> +int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_buf *priv,
> >>> +			      struct vm_area_struct *vma,
> >>> +			      unsigned long fault_addr,
> >>> +			      unsigned int order,
> >>> +			      unsigned long *out_pfn)
> >>> +{
> >>> +	/*
> >>> +	 * Given a VMA (start, end, pgoffs) and a fault address,
> >>> +	 * search the corresponding DMABUF's phys_vec[] to find the
> >>> +	 * range representing the address's offset into the VMA, and
> >>> +	 * its PFN.
> >>> +	 *
> >>> +	 * The phys_vec[] ranges represent contiguous spans of VAs
> >>> +	 * upwards from the buffer offset 0; the actual PFNs might be
> >>> +	 * in any order, overlap/alias, etc.  Calculate an offset of
> >>> +	 * the desired page given VMA start/pgoff and address, then
> >>> +	 * search upwards from 0 to find which span contains it.
> >>> +	 *
> >>> +	 * On success, a valid PFN for a page sized by 'order' is
> >>> +	 * returned into out_pfn.
> >>> +	 *
> >>> +	 * Failure occurs if:
> >>> +	 * - A hugepage would cross the edge of the VMA,
> >>> +	 * - A hugepage isn't entirely contained within a range
> >>> +	 *   (including where it straddles the boundary between
> >>> +	 *   ranges),
> >>> +	 * - We find a range, but the final PFN isn't aligned to the
> >>> +	 *   requested order.
> >>> +	 *
> >>> +	 * Upon failure, -EAGAIN is returned and the caller is
> >>> +	 * expected to try again with a smaller order, which will
> >>> +	 * eventually succeed (order=0 will always work).
> >>> +	 *
> >>> +	 * It's suboptimal if DMABUFs are created with neighbouring
> >>> +	 * ranges that are physically contiguous, since hugepages
> >>> +	 * can't straddle range boundaries.  (The construction of the
> >>> +	 * ranges should merge them in this case.)
> >>> +	 *
> >>> +	 * Finally, vma_pgoff_adjust is used with a DMABUF created for
> >>> +	 * a VFIO BAR mmap: a BAR mapped with vm_pgoff > 0 creates a
> >>> +	 * DMABUF such that byte 0 of the VMA corresponds to byte 0 of
> >>> +	 * the DMABUF and byte 'vm_pgoff << PAGE_SHIFT' into the BAR.
> >>> +	 * To avoid double-offsetting in this scenario, subtracting
> >>> +	 * vma_pgoff_adjust from this (non-zero) vm_pgoff generates
> >>> +	 * the effective offset.
> >>> +	 */
> >>> +
> >>> +	const unsigned long pagesize = PAGE_SIZE << order;
> >>> +	unsigned long vma_off = ((vma->vm_pgoff - priv->vma_pgoff_adjust) <<
> >>> +				 PAGE_SHIFT) & VFIO_PCI_OFFSET_MASK;
> >>
> >> Maybe I'm getting ahead of myself here.. but it seems like this
> >> restricts us to only mapping DMABUFs at offsets < 1TB due to the 
> >> VFIO_PCI_OFFSET_MASK (since we have HBMs on PCI devices now, hitting 1TB
> >> may not be a very distant future).
> > 
> > This is a really good question, thanks for raisiing it.  It is not too
> > forward-thinking at all.
> > 
> >> While I understand this mask is needed to drop the BAR encoding in the
> >> high bits. 
> >>
> >> My worry is, if in the future a user were to export a massive
> >> contiguous DMABUF (e.g., >1TB of aggregated HBM) and tried to mmap deep
> >> into it (passing an offset >= 1TB), this bitwise AND would silently drop
> >> the high bits, leading to silent data corruption.
> > 
> > One of the big advantages of DMABUF export was that the range could be
> > huge and unencumbered by the VFIO_PCI_OFFSET_SHIFT of the traditional
> > mmap() interface.  It's a way to mmap huge BARs without having to change
> > the user-visible shift).  So definitely this is a relevant concern.
> > 
> >> I think we should explicitly reject such an mmap with -EINVAL like:
> >>
> >> +const unsigned long pagesize = PAGE_SIZE << order;
> >> +unsigned long vma_off = (vma->vm_pgoff - priv->vma_pgoff_adjust) << PAGE_SHIFT;
> >>
> >> +/*
> >> + * Prevent silent wrap-around if the user mmaps a DMABUF at an
> >> + * offset greater than the VFIO index mask allows.
> >> + */
> >> +if (unlikely(vma_off > VFIO_PCI_OFFSET_MASK))
> >> +    return -EINVAL;
> >>
> >> +vma_off &= VFIO_PCI_OFFSET_MASK;
> > 
> > Agreed, for now this absolutely should not silently wrap if the offset
> > is > 1TB, and we live with the restriction that a DMABUF sized >1TB
> > can't be mapped with such an offset.  (We can still, say, map all of a
> > 16TB DMABUF with offset=0, which is good.).  I'll add a check, thanks
> > for pointing this out.
> > 
> > I suggest as something to revisit later, we flag for a DMABUF (maybe an
> > evolution of vma_pgoff_adjust) to differentiate whether this masking
> > needs to be applied (traditional mmap() path) or not (DMABUF mmap()),
> > and then offsets can be arbitrarily large.
> 
> Having tinkered, the two-step approach I suggested isn't great because
> userspace has no easy way to know that step 2 has occurred and that
> large offsets are "now supported".
> 
> The second problem is this isn't just a limitation to not do an mmap()
> with offset approaching 1TB, because you could run into trouble just
> mapping, say, a 2TB BAR and then splitting it by unmapping a hole in the
> middle:  the second VMA now has a huge offset.
> 
> It seems a proper fix is easy though:
> 
>  unsigned long vma_off = (vma->vm_pgoff - priv->vma_pgoff_adjust) <<
> 	 		  PAGE_SHIFT;  /* No masking! */
> 
> Then in vfio_pci_core_mmap_prep_dmabuf(),
> 
>  priv->vma_pgoff_adjust = vma->vm_pgoff;
> 
> I.e., if vma_pgoff_adjust just includes the region index up high, it
> cancels out the (same) index in the vm_pgoff.  Thus regular mmap should
> work (up to the 1TB offset), and DMABUF VMAs can have arbitrarily large
> offsets.

This looks good to me! I traced through both mmap paths to verify how 
vma_pgoff_adjust handles the offsets and it looks like this works 
perfectly for both.

Cheers,
Praan
