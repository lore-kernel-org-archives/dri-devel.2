Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B50CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 15:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 235DE10E4A8;
	Mon, 15 Jun 2026 15:08:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ZGFauvW4";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A56F10E49D
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 15:08:05 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2c0b1a48855so177685ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781536085; x=1782140885;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EeLNOUGcyQ4NWkfW/DAB6S96aMOzAOJTH9w4j6T6BeY=;
 b=ZGFauvW4KyJDHQewYyG3qgH2wsPQ/gMFvL/3CscLgDajZkOoVGuA0CxcomrBvVXBKZ
 hJM2uBqslNNBv/ygBDSrZoQWq/fQw7kvV1UMsEatWp2NigqXOFS+lt6TJWOH+f+P33Nh
 lYVgY+STeXLsogDMSLXzypgmL716cLX7HxOr6uwEd0Un2Gm2GN1hyAJJ7oKgkTvG2phk
 Ig344n0MRfB3BkGexDK9mVHToxAZGAzYCIrEcWN2fKNwnS6+O9JLIOhEB7aXQa9xrEt4
 VWW6xfOqITvbaIar1k4PG+c0EwZA4J7xPQiGg9vJoHFLSLeflrx26qSZmv4pJimEW+7l
 3ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781536085; x=1782140885;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EeLNOUGcyQ4NWkfW/DAB6S96aMOzAOJTH9w4j6T6BeY=;
 b=ZPCQf4hBiw2LMSM/DOg4oKogcdTMvyM1ewxKfNExmdu5iyBM6eca9LKLz9SxkVHaci
 rIwp1NS2ol3Zk3wfns/rhDwuQPBx5HI2bDJw4OruIksH+cJEjh8aNDuRrPOicBtW5L4A
 Z4oL4BeI3aN0ifEMQoXP3CHTNKxmRmhE9gyaz5CbOhcnMqKfpsyZeWNUMdcZOv2QtT3k
 3cuhr7yr3uCp04OBM6r0yZWG3tn1AuHLdNhhraR5PCTQhZK3ObybtvN5zJzrxGIvaKwr
 NduvuaB69rNHxY+iHo63psMRijZ9ALazeBoIKOWnknDgnI57qq/RYY1joZbSrLMFksv9
 flOQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+DwdYSrp7GuQZP1SCpy3OYoDkrCczU20CjWlUi0AuuqDSmVCo2DByThj7QhgTsEA9U8QleiYt/yWA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz45Lhn36eNH+ctqMCohrzSF8//vzlLMDzC9ir+a/i74/kexNDB
 7EmviWhwBVxNcq5kSRyN1GEjz55XsLb+tG+ISQvnKJe/dLTgOguszdCUnoDmXd/iZw==
X-Gm-Gg: Acq92OEvF15LHK4Ll37RLxYrodi6W55lRi/I7KUeDXxEzNWwfFo/PCOC6XHYubErOst
 1dOL+xB6zeNSXSCWgvd7nO+TxUL4h/YFK3tRX0p8aIbpudTiK5p82KsTZ2ILs89PUdqrtAUMsy9
 Wnvn1mciwEMW0N3ZVyTySiZwNu/iiVH4g/T6yOnJqYnCdTgnQEY63bKjl2acGQXdGH3MV5j8f4Y
 mo395NHcJTLVHfUpXEPvOoQNdZ5A0rErB9wx7W9JNu+JZKOjcTQfqvi/gaB0nAgyMfr8820uL5D
 4oQdb0EgjFPiiMPYLDoto9bDQzkWnfTw1vhlEjVintmK+lXdZDqmbgzmZ3nj4T1Hm8j0/CvfRfA
 p0x2ZbVWbnxpe4k22sIzJcpC2xXstjqxyXO+QA9oV+pe+b2fHDWvYD+g2knLsR5VaUvZIhBinXI
 uqBDBYhMiYnkN5zwQ5n//wXeRIGPjyA1cJrQN6carhGd+zjILuynp+TK2xDcKl
X-Received: by 2002:a17:903:320b:b0:2c0:c3ac:fdf9 with SMTP id
 d9443c01a7336-2c69689a4aamr525115ad.14.1781536084472; 
 Mon, 15 Jun 2026 08:08:04 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com.
 [34.142.255.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f7c6c5dsm102831385ad.21.2026.06.15.08.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 08:08:03 -0700 (PDT)
Date: Mon, 15 Jun 2026 15:07:55 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Kevin Tian <kevin.tian@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/9] vfio/pci: Add a helper to look up PFNs for DMABUFs
Message-ID: <ajAVSx9gPz1KkIbF@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-3-matt@ozlabs.org>
 <aisa6H-a-176MXhC@google.com>
 <effb66ee-764b-4823-b6e4-c932a1f60f8d@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <effb66ee-764b-4823-b6e4-c932a1f60f8d@ozlabs.org>
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

On Mon, Jun 15, 2026 at 03:27:01PM +0100, Matt Evans wrote:

Hi Matt,
> 
> On 11/06/2026 21:30, Pranjal Shrivastava wrote:
> > On Wed, Jun 10, 2026 at 04:43:16PM +0100, Matt Evans wrote:
> >> Add vfio_pci_dma_buf_find_pfn(), which a VMA fault handler can use to
> >> find a PFN.
> >>
> >> This supports multi-range DMABUFs, which typically would be used to
> >> represent scattered spans but might even represent overlapping or
> >> aliasing spans of PFNs.
> >>
> >> Because this is intended to be used in vfio_pci_core.c, we also need
> >> to expose the struct vfio_pci_dma_buf in the vfio_pci_priv.h header.
> >>
> >> Signed-off-by: Matt Evans <matt@ozlabs.org>

[...]

> >> +
> >> +	const unsigned long pagesize = PAGE_SIZE << order;
> >> +	unsigned long vma_off = ((vma->vm_pgoff - priv->vma_pgoff_adjust) <<
> >> +				 PAGE_SHIFT) & VFIO_PCI_OFFSET_MASK;
> >> +	unsigned long rounded_page_addr = ALIGN_DOWN(address, pagesize);
> >> +	unsigned long rounded_page_end = rounded_page_addr + pagesize;
> >> +	unsigned long page_buf_offset;
> >> +	unsigned long page_buf_offset_end;
> >> +	unsigned long range_buf_offset = 0;
> >> +	unsigned int i;
> >> +
> >> +	if (rounded_page_addr < vma->vm_start || rounded_page_end > vma->vm_end) {
> >> +		if (order > 0)
> >> +			return -EAGAIN;
> >> +
> >> +		/* A fault address outside of the VMA is absurd. */
> >> +		WARN(1, "Fault addr 0x%lx outside VMA 0x%lx-0x%lx\n",
> >> +		     address, vma->vm_start, vma->vm_end);
> > 
> > This could flood dmesg if triggered repeatedly by userspace :( 
> > Since a fault outside the VMA is an invalid access that already results
> > in a SIGBUS, we could probably avoid the WARN here?
> > Perhaps pr_warn_ratelimited() should suffice?
> 
> I'm OK moving to a pr_warn_ratelimited().  Note though that this case is
> "genuinely impossible" currently and the check exists in case something
> changes elsewhere.  (Re your flood comment, am I missing a way for
> userspace to trigger this?  The scenario is a faulthandler for a VMA
> getting a VA outside the bounds of that VMA; such a fault address
> wouldn't match that VMA.)

I should've been explicit, I guess I worded it wrong, my bad.
I didn't mean that a user-space could hit this on it's own. However,
I meant to say if there's a bug in core mm during some future work,
dmesg being flooded by stackdumps gets messy (especially during dev) as
the underlying reason might get missed in the flood. Hence, I prefer
moving to pr_warn_ratelimited.

> 
> >> +		return -EFAULT;
> >> +	}
> >> +
> >> +	/*
> >> +	 * page_buff_offset[_end] is the span of DMABUF offsets
> >> +	 * corresponding to the faulting page:
> >> +	 */
> >> +	if (unlikely(check_add_overflow(rounded_page_addr - vma->vm_start,
> >> +					vma_off, &page_buf_offset) ||
> >> +		     check_add_overflow(page_buf_offset, pagesize,
> >> +					&page_buf_offset_end)))
> >> +		return -EFAULT;
> >> +
> >> +	for (i = 0; i < priv->nr_ranges; i++) {
> >> +		size_t range_len = priv->phys_vec[i].len;
> >> +		phys_addr_t range_start = priv->phys_vec[i].paddr;
> >> +
> >> +		/*
> >> +		 * If the current range starts after the page's span,
> >> +		 * this and any future range won't match.  Bail early.
> >> +		 */
> >> +		if (page_buf_offset_end <= range_buf_offset)
> >> +			break;
> >> +
> >> +		if (page_buf_offset >= range_buf_offset &&
> >> +		    page_buf_offset_end <= range_buf_offset + range_len) {
> >> +			/*
> >> +			 * The faulting page is wholly contained
> >> +			 * within the span represented by the range.
> >> +			 * Validate PFN alignment for the order:
> >> +			 */
> >> +			unsigned long pfn = (range_start + page_buf_offset -
> >> +					     range_buf_offset) / PAGE_SIZE;
> > 
> > Minor nit: I'm aware that decent compilers convert pow(2) divides to >> 
> > However, we seem to be using `>> PAGE_SHIFT` across vfio-pci. E.g.:
> > 
> > return (pci_resource_start(vdev->pdev, index) >> PAGE_SHIFT) + pgoff;
> > unsigned long pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
> > 
> > Let's consider using the same pattern?
> 
> (Do you know of a compiler that both builds the kernel and does NOT
> perform this transformation?  I am confident that resulting object code
> will be OK here.)
> 

I guess most of the modern compiler do, I was just referring to the
style across the file. I don't have any strong opinion.

> In an earlier revision I was using shifts but they were fairly messy
> compared to this expression, which arises from a request by Jason.
> 

Yea, looking back at Jason's comment [1], I think he was mainly pointing out
that the common factor (PAGE_SIZE) could be grouped together. But again,
no strong feeling about this, just picked up a pattern across the file. 
If it breaks on some compiler we can fix it later..

> >> +
> >> +			if (IS_ALIGNED(pfn, 1 << order)) {
> >> +				*out_pfn = pfn;
> >> +				return 0;
> >> +			}
> >> +			/* Retry with smaller order */
> >> +			return -EAGAIN;
> >> +		}
> >> +		range_buf_offset += range_len;
> >> +	}
> >> +
> >> +	/*
> >> +	 * A hugepage straddling a range boundary will fail to match a
> >> +	 * range, but the address will (eventually) match when retried
> >> +	 * with a smaller page.
> >> +	 */
> >> +	if (order > 0)
> >> +		return -EAGAIN;
> >> +
> >> +	/*
> >> +	 * If we get here, the address fell outside of the span
> >> +	 * represented by the (concatenated) ranges.  Setup of a
> > 
> > Nit: double space before "Setup" and "But" below.
> 
> I liked Alex's response :-)  This is common practice for monospaced text
> since increasing inter-sentence spacing helps readability in paragraph
> blocks (see Documentation/ for many examples ...).
> 

Ack. :)

> >> +	 * mapping must ensure that the VMA is <= the total size of
> >> +	 * the ranges, so this should never happen.  But, if it does,
> >> +	 * force SIGBUS for the access and warn.
> >> +	 */
> >> +	WARN_ONCE(1, "No range for addr 0x%lx, order %d: VMA 0x%lx-0x%lx pgoff 0x%lx, %u ranges, size 0x%zx\n",
> >> +		  address, order, vma->vm_start, vma->vm_end, vma->vm_pgoff,
> >> +		  priv->nr_ranges, priv->size);
> >> +
> >> +	return -EFAULT;
> > 
> > The fall-through logic at the end feels a bit redundant.
> > 
> > If we've exhausted the phys_vec list without finding a match, returning
> > -EAGAIN for order > 0 seems like the correct fallback behavior.
> 
> This path can happen (for order > 0) e.g. mis-alignment of VA versus the
> PFN, i.e. is likely...
> 
> > However, the subsequent WARN_ONCE for the order == 0 seems unnecessary?
> > An out-of-bounds access is an error that should simply return -EFAULT 
> > (converting to SIGBUS) without polluting the kernel log with stackdumps?
> 
> ...but the only way this can happen, for order == 0, is if the VMA
> extends beyond the underlying resource.  For example, if the VMA is
> larger than the DMABUF size (the total length of phys ranges set up
> inside the DMABUF).  Both VFIO BAR mmap() and a DMABUF mmap() disallow
> mapping off the end of the underlying resource.  That is, this also
> "cannot happen" but if logic changes elsewhere then we will really want
> to know about hitting this case -- the check is not redundant.

I didn't mean to imply that the path itself is impossible or won't 
happen.. I just meant that the logic / structure felt a bit redundant at
the end of the function..

Instead of having the separate `if (order > 0)` block falling through to
the base case, I suggest it could be cleaner as:

	ret = order ? -EAGAIN : -EFAULT;

	if (ret == -EFAULT)
		pr_warn_ratelimited(...);

	return ret;

But again, that's a preference. I'd leave that to your judgement.

> 
> Still, it doesn't need a regdump/backtrace (at least while this is only
> called from one spot), so a pr_warn_* is better.
> 

Ack.

Thanks,
Praan
