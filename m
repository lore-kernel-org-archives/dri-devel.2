Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1E9C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:43:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89FB910E1A7;
	Fri, 31 Jul 2026 17:43:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="L7Wsy1yU";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B869810E1A7
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 17:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1785519798;
 bh=O4v5ey+6wf12sRtrZezV9kbrFwYe7LywDcg1AiBLCVg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=L7Wsy1yU5DXduQebNWrVNE1tBweZF/wEjphURDtOUxgMW6BsT0JGVOrp/C9WHLyjk
 a/rD234abPKpfA+A4ZY7UBaRzMqn3T3pi6MnxB57825OOl8e4ZaQiN+fJsu29O/UDl
 nZ2bMftlLHMJE15jRICqFGYnEWTvBmewTjZaJ9S3recD8WzgqlOW0pJaRm2E8OQhjq
 7kw3uJ9LmW3q/woiNPxhe/MafTifSITl7it8G33J/Pq9xbgBrSDR4e0HprRzc2PWUg
 0nzM2PU4m9/Iyb3NeWqHrF+tL3+HHdRaZ5aG73483ZCT+Ri+uRt4BxanWYXNoqwiqg
 DZ94PCawJvVzw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4hBYM02tCBz4wL7;
 Sat, 01 Aug 2026 03:43:08 +1000 (AEST)
Message-ID: <ecf9b355-9fe1-440b-9281-08671a995139@ozlabs.org>
Date: Fri, 31 Jul 2026 18:43:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] vfio/pci: Add a helper to look up PFNs for DMABUFs
Content-Language: en-GB
To: Pranjal Shrivastava <praan@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Kevin Tian <kevin.tian@intel.com>, Longfang Liu <liulongfang@huawei.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-4-matt@ozlabs.org> <amvWXNRtviKEuUoV@google.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <amvWXNRtviKEuUoV@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Praan,

On 30/07/2026 23:55, Pranjal Shrivastava wrote:
> On Wed, Jul 15, 2026 at 06:47:26PM +0100, Matt Evans wrote:
>> Add vfio_pci_dma_buf_find_pfn(), which a VMA fault handler can use to
>> find a PFN.
>>
>> This supports multi-range DMABUFs, which typically would be used to
>> represent scattered spans but might even represent overlapping or
>> aliasing spans of PFNs.
>>
>> Because this is intended to be used in vfio_pci_core.c, we also need
>> to expose the struct vfio_pci_dma_buf in the vfio_pci_priv.h header.
>>
>> Signed-off-by: Matt Evans <matt@ozlabs.org>
>> ---
>>  drivers/vfio/pci/vfio_pci_dmabuf.c | 153 ++++++++++++++++++++++++++---
>>  drivers/vfio/pci/vfio_pci_priv.h   |  20 ++++
>>  2 files changed, 160 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> index c16f460c01d6..7c047400dfd1 100644
>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> @@ -9,19 +9,6 @@
>>  
>>  MODULE_IMPORT_NS("DMA_BUF");
>>  
>> -struct vfio_pci_dma_buf {
>> -	struct dma_buf *dmabuf;
>> -	struct vfio_pci_core_device *vdev;
>> -	struct list_head dmabufs_elm;
>> -	size_t size;
>> -	struct phys_vec *phys_vec;
>> -	struct p2pdma_provider *provider;
>> -	u32 nr_ranges;
>> -	struct kref kref;
>> -	struct completion comp;
>> -	u8 revoked : 1;
>> -};
>> -
>>  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
>>  				   struct dma_buf_attachment *attachment)
>>  {
>> @@ -106,6 +93,146 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
>>  	.release = vfio_pci_dma_buf_release,
>>  };
>>  
>> +int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_buf *priv,
>> +			      struct vm_area_struct *vma,
>> +			      unsigned long fault_addr,
>> +			      unsigned int order,
>> +			      unsigned long *out_pfn)
>> +{
>> +	/*
>> +	 * Given a VMA (start, end, pgoffs) and a fault address,
>> +	 * search the corresponding DMABUF's phys_vec[] to find the
>> +	 * range representing the address's offset into the VMA, and
>> +	 * its PFN.
>> +	 *
>> +	 * The phys_vec[] ranges represent contiguous spans of VAs
>> +	 * upwards from the buffer offset 0; the actual PFNs might be
>> +	 * in any order, overlap/alias, etc.  Calculate an offset of
>> +	 * the desired page given VMA start/pgoff and address, then
>> +	 * search upwards from 0 to find which span contains it.
>> +	 *
>> +	 * On success, a valid PFN for a page sized by 'order' is
>> +	 * returned into out_pfn.
>> +	 *
>> +	 * Failure occurs if:
>> +	 * - A hugepage would cross the edge of the VMA,
>> +	 * - A hugepage isn't entirely contained within a range
>> +	 *   (including where it straddles the boundary between
>> +	 *   ranges),
>> +	 * - We find a range, but the final PFN isn't aligned to the
>> +	 *   requested order.
>> +	 *
>> +	 * Upon failure, -EAGAIN is returned and the caller is
>> +	 * expected to try again with a smaller order, which will
>> +	 * eventually succeed (order=0 will always work).
>> +	 *
>> +	 * It's suboptimal if DMABUFs are created with neighbouring
>> +	 * ranges that are physically contiguous, since hugepages
>> +	 * can't straddle range boundaries.  (The construction of the
>> +	 * ranges should merge them in this case.)
>> +	 *
>> +	 * Finally, vma_pgoff_adjust is used with a DMABUF created for
>> +	 * a VFIO BAR mmap: a BAR mapped with vm_pgoff > 0 creates a
>> +	 * DMABUF such that byte 0 of the VMA corresponds to byte 0 of
>> +	 * the DMABUF and byte 'vm_pgoff << PAGE_SHIFT' into the BAR.
>> +	 * To avoid double-offsetting in this scenario, subtracting
>> +	 * vma_pgoff_adjust from this (non-zero) vm_pgoff generates
>> +	 * the effective offset.
>> +	 */
>> +
>> +	const unsigned long pagesize = PAGE_SIZE << order;
>> +	unsigned long vma_off = ((vma->vm_pgoff - priv->vma_pgoff_adjust) <<
>> +				 PAGE_SHIFT) & VFIO_PCI_OFFSET_MASK;
> 
> Maybe I'm getting ahead of myself here.. but it seems like this
> restricts us to only mapping DMABUFs at offsets < 1TB due to the 
> VFIO_PCI_OFFSET_MASK (since we have HBMs on PCI devices now, hitting 1TB
> may not be a very distant future).

This is a really good question, thanks for raisiing it.  It is not too
forward-thinking at all.

> While I understand this mask is needed to drop the BAR encoding in the
> high bits. 
>
> My worry is, if in the future a user were to export a massive
> contiguous DMABUF (e.g., >1TB of aggregated HBM) and tried to mmap deep
> into it (passing an offset >= 1TB), this bitwise AND would silently drop
> the high bits, leading to silent data corruption.

One of the big advantages of DMABUF export was that the range could be
huge and unencumbered by the VFIO_PCI_OFFSET_SHIFT of the traditional
mmap() interface.  It's a way to mmap huge BARs without having to change
the user-visible shift).  So definitely this is a relevant concern.

> I think we should explicitly reject such an mmap with -EINVAL like:
> 
> +const unsigned long pagesize = PAGE_SIZE << order;
> +unsigned long vma_off = (vma->vm_pgoff - priv->vma_pgoff_adjust) << PAGE_SHIFT;
> 
> +/*
> + * Prevent silent wrap-around if the user mmaps a DMABUF at an
> + * offset greater than the VFIO index mask allows.
> + */
> +if (unlikely(vma_off > VFIO_PCI_OFFSET_MASK))
> +    return -EINVAL;
> 
> +vma_off &= VFIO_PCI_OFFSET_MASK;

Agreed, for now this absolutely should not silently wrap if the offset
is > 1TB, and we live with the restriction that a DMABUF sized >1TB
can't be mapped with such an offset.  (We can still, say, map all of a
16TB DMABUF with offset=0, which is good.).  I'll add a check, thanks
for pointing this out.

I suggest as something to revisit later, we flag for a DMABUF (maybe an
evolution of vma_pgoff_adjust) to differentiate whether this masking
needs to be applied (traditional mmap() path) or not (DMABUF mmap()),
and then offsets can be arbitrarily large.


Cheers,


Matt


>> +	unsigned long rounded_page_addr = ALIGN_DOWN(fault_addr, pagesize);
>> +	unsigned long rounded_page_end = rounded_page_addr + pagesize;
>> +	unsigned long fault_offset;
>> +	unsigned long fault_offset_end;
>> +	unsigned long range_start_offset = 0;
>> +	unsigned int i;
>> +	int ret;
>> +
> 
> 
> Thanks,
> Praan

