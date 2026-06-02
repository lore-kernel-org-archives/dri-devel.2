Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C021FCD6E68
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 16:37:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2060010F398;
	Tue,  2 Jun 2026 16:37:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="brcsqM3s";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AB2F10F398
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 16:37:44 +0000 (UTC)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 652EIbaq3944814
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 09:37:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=JaI89Wggv+m77fH63fQe+3epu7CJNe/5q/9Y6SRKmH0=; b=brcsqM3sFqRv
 6NFORFPsKgFa9mENs8X1TFSHUuTUAfm/cI0B8hjI4apfh/X1RyhAsKe5wuc3kCMA
 Dje7w0722dwJ1/QzS9RXo5f0OYbIZ62nSfv9c9Bbv/IirIF1QKEBMMUfKMLi3E/h
 gxkUIZlZTEfpb56to9EDjrg+hnGkLd0hTn5L5Vym3EOSZs6SVAR2MW9RP09USsh/
 6RE8/pKKV6Y6PeREA7kw8kJmO/ak7IZYNY6ctOR/pvkpwYA6ymNVLJHxvzGWwe8i
 kkF9UWVWEWbcsdvF9fh4i3XlB09MbiWejOC2Osr6/ocglJlk7yR3wJZRuF2DYz/P
 1QEIutWKVg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ej0tq91uy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 09:37:43 -0700 (PDT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-137eff27f36so966787c88.1
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 09:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780418263; x=1781023063;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JaI89Wggv+m77fH63fQe+3epu7CJNe/5q/9Y6SRKmH0=;
 b=iDFOjoU9KClJR4XgrRWfG8I62mTxjii5lgxQk/6T/05mXZ0puP2DPMyRYgi5H/c+kj
 wHawWl9+cLrtl5gRqtpBtssRhr6C5nbnfvOddDeX751mXb/LG7O3fBU/Qh30X/Mf/5Wo
 05IMs4OOH5yUb+KXxNeLTIOjtKQOGEO8W477ZnN88Id3r7vCu4tSpjcYO63VJbRuqL5W
 wPAYaFqm4IbrQ952pUODQxAWFrJNr+WdncPWFL52iLk72iNuu7NMMZ3YgNZwVUGhQWNr
 MTyh3D543K/jQWb68Yxzxl8fsdTJUyetQuvdnnqGVs3w70DHhlHMoZSQB3IqA8dGkKfD
 +jvQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ831dk/bzlFYCQn5lX8o/ByGUZPvEWTV+fvEPxkDWRxf7UePspyPAcZch+M5IOwGvZt6rG2Q+/UDjM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+IrM3yycm+DAm5ivrbeUlSc9F3qDlXEQJ1F5BZzy8j3RxgFi1
 VhthMmnlfdsBYlvCy+xVmJ3zgvj0SnRlqiRocsZ210HV2JFqahzZUv9MUkVyqRVsCRLlxvk7a5y
 HeEUa1e7+cNWkLkIaQE4caiYWJLqybMcn3rEuviK+lXrJSzpvK8JE+muveFHmuOOLjPE4
X-Gm-Gg: Acq92OFsCeCnDADVaXAkQuz9z9VOo3siYB1eIV3nl4sj0o1CTUVPYKI64GEopRaSa4H
 pVZHkgmOOObnM4CBm14++9E5Jqd2dIDiwyaBqjP2evmeIUCc66IcXcGUTlzbCIU+r+IinGhDZ5E
 9xmYGhS9Y1DHzAtpjy/pJ2PjXcGYDMlbPk637e6E2qhkJELLNcyiaCUS/aFBYGiA/TLASnIrltk
 hy7OqJkmHoOdr8dCUVoTkYrAQBUJFHZo8T7x0yI/1AwFGVohkL8Iaya/+7McPGfVmYfe3NE9EJz
 P5QrY+WbEFsgbdpMb7OO/pqLVTzDDKRKA8yDfMXo/zmGt174pjbjk91dIYRcmNcA8X0eCUmnKWb
 hNz++vkhni2jvNNdsDg8QrNIqF4gafMo3vbxSNm9b
X-Received: by 2002:a05:7022:1a84:b0:11a:fb3c:568b with SMTP id
 a92af1059eb24-137d423bfe1mr6867345c88.17.1780418262980; 
 Tue, 02 Jun 2026 09:37:42 -0700 (PDT)
X-Received: by 2002:a05:7022:1a84:b0:11a:fb3c:568b with SMTP id
 a92af1059eb24-137d423bfe1mr6867319c88.17.1780418262207; 
 Tue, 02 Jun 2026 09:37:42 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5489d17sm159385c88.1.2026.06.02.09.37.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2026 09:37:41 -0700 (PDT)
Message-ID: <71936818-dc94-47bc-9f17-59005553dd73@meta.com>
Date: Tue, 2 Jun 2026 17:37:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] vfio/pci: Add a helper to look up PFNs for DMABUFs
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Pranjal Shrivastava <praan@google.com>, Alistair Popple
 <apopple@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260527102319.100128-1-mattev@meta.com>
 <20260527102319.100128-3-mattev@meta.com>
 <20260527163837.02be1e7c@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260527163837.02be1e7c@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: slEESCqUPSHvMNMEeNV_1jP9_G6emhhG
X-Authority-Analysis: v=2.4 cv=avKCzyZV c=1 sm=1 tr=0 ts=6a1f06d7 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VabnemYjAAAA:8
 a=W66DtvnrEJvMCsljMtwA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE2MCBTYWx0ZWRfXxmKVnhDYbHW1
 4QwirjbneasWueCNCySj4ICQgaK2TRNjaIU5aEl+vxRj85L9OsoVXaY+n4GTixS8oEfPss1m85L
 GHOCLLCmbF8gLlNVhjrTcmwjUmUg4pFhAyxKfIak/dKu+Ygk2B5nD7As8QWP0djv6dgosdrkOCJ
 JKadOR0uBokTR1eFAgX/+BGozaeJycMxb+YRk9uqKu/KUHGg7OvzZXO5SpyNfOxHIISyKCfGGBi
 W2O6lLoPH9nj8TbNPVTH63gE9eZD9xnftoqOJF9Zrwp2Gw9rOaQv3yYGsYSjylk/v5fzXSC7i7t
 Qlg1w6cKjoSWnKOyxKxE3hi8EqaI2sZxSrllHIyfo+0p5Zk2RX5bfjbp1Or9Slxn6uYVFaOWhhS
 K0Qx4tT90l2x8U54Gp45xYeBqjG9i0kylv2qT8acMCApgwvd8R0xR30BpACc07j3tyfcryxnI2O
 8JzGP5G5K18BZIQipYw==
X-Proofpoint-ORIG-GUID: slEESCqUPSHvMNMEeNV_1jP9_G6emhhG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
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

Hi Alex,

On 27/05/2026 23:38, Alex Williamson wrote:
> 
> On Wed, 27 May 2026 03:23:05 -0700
> Matt Evans <mattev@meta.com> wrote:
> 
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
>> Signed-off-by: Matt Evans <mattev@meta.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_dmabuf.c | 142 ++++++++++++++++++++++++++---
>>   drivers/vfio/pci/vfio_pci_priv.h   |  20 ++++
>>   2 files changed, 149 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> index c16f460c01d6..0d132c4ca95f 100644
>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> @@ -9,19 +9,6 @@
>>   
>>   MODULE_IMPORT_NS("DMA_BUF");
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
>>   static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
>>   				   struct dma_buf_attachment *attachment)
>>   {
>> @@ -106,6 +93,135 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
>>   	.release = vfio_pci_dma_buf_release,
>>   };
>>   
>> +int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_buf *vpdmabuf,
> 
> This private dmabuf object pointer is named priv pretty consistently
> throughout the rest of the file.

Right you are, fixed.

>> +			      struct vm_area_struct *vma,
>> +			      unsigned long address,
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
>> +	 * - The page would cross the edge of the VMA
>> +	 * - The page isn't entirely contained within a range
>> +	 * - We find a range, but the final PFN isn't aligned to the
>> +	 *   requested order.
>> +	 *
>> +	 * (Upon failure, the caller is expected to try again with a
>> +	 * smaller order; the tests above will always succeed for
>> +	 * order=0 as the limit case.)
>> +	 *
>> +	 * It's suboptimal if DMABUFs are created with neigbouring
>> +	 * ranges that are physically contiguous, since hugepages
>> +	 * can't straddle range boundaries.  (The construction of the
>> +	 * ranges vector should merge such ranges.)
>> +	 *
>> +	 * Finally, vma_pgoff_adjust is used for a DMABUF representing
>> +	 * a VFIO BAR mmap, which is created from the start of the
>> +	 * offset region.  It should be zero, or equal vm_pgoff.
>> +	 */
>> +
>> +	const unsigned long pagesize = PAGE_SIZE << order;
>> +	unsigned long vma_off = ((vma->vm_pgoff - vpdmabuf->vma_pgoff_adjust) <<
>> +				 PAGE_SHIFT) & VFIO_PCI_OFFSET_MASK;
>> +	unsigned long rounded_page_addr = ALIGN_DOWN(address, pagesize);
>> +	unsigned long rounded_page_end = rounded_page_addr + pagesize;
>> +	unsigned long page_buf_offset;
>> +	unsigned long range_buf_offset = 0;
>> +	unsigned int i;
>> +
>> +	if (rounded_page_addr < vma->vm_start || rounded_page_end > vma->vm_end) {
>> +		if (order > 0)
>> +			return -EAGAIN;
>> +
>> +		/* A fault address outside of the VMA is absurd. */
>> +		WARN(1, "Fault addr 0x%lx outside VMA 0x%lx-0x%lx\n",
>> +		     address, vma->vm_start, vma->vm_end);
>> +		return -EFAULT;
>> +	}
>> +
>> +	if (vpdmabuf->vma_pgoff_adjust != 0 &&
>> +	    vpdmabuf->vma_pgoff_adjust != (vma->vm_pgoff &
>> +					   (VFIO_PCI_OFFSET_MASK >> PAGE_SHIFT))) {
>> +		WARN(1, "Unexpected vma_pgoff_adjust 0x%lx (vm_pgoff 0x%lx)\n",
>> +		     vpdmabuf->vma_pgoff_adjust, vma->vm_pgoff);
>> +		return -EFAULT;
>> +	}
> 
> This appears to be user trigger'able, by causing a vma to be split, and
> also unnecessary as it seems the math works out correctly for the split
> case.

Good spot, fixed.  I added a VMA split case to the [RFC] 
vfio_dmabuf_mmap_test, thanks for spotting this.

>> +
>> +	if (unlikely(check_add_overflow(rounded_page_addr - vma->vm_start,
>> +					vma_off, &page_buf_offset)))
>> +		return -EFAULT;
>> +
>> +	for (i = 0; i < vpdmabuf->nr_ranges; i++) {
>> +		unsigned long page_buf_offset_end;
>> +		size_t range_len = vpdmabuf->phys_vec[i].len;
>> +		phys_addr_t range_start = vpdmabuf->phys_vec[i].paddr;
>> +
>> +		if (unlikely(check_add_overflow(page_buf_offset, pagesize,
>> +						&page_buf_offset_end)))
>> +			return -EFAULT;
> 
> Why is this inside the loop, the args are invariant of anything
> modified in the loop.  Thanks,

Right; I slipped up when renaming/refactoring the additions, that 
definitely goes above.  Fixed!


Thanks,


Matt


> 
> Alex
> 
>> +		/*
>> +		 * If the current range starts after the page's span,
>> +		 * this and any future range won't match.  Bail early.
>> +		 */
>> +		if (page_buf_offset_end <= range_buf_offset)
>> +			break;
>> +
>> +		if (page_buf_offset >= range_buf_offset &&
>> +		    page_buf_offset_end <= range_buf_offset + range_len) {
>> +			/*
>> +			 * The faulting page is wholly contained
>> +			 * within the span represented by the range.
>> +			 * Validate PFN alignment for the order:
>> +			 */
>> +			unsigned long pfn = (range_start + page_buf_offset -
>> +					     range_buf_offset) / PAGE_SIZE;
>> +
>> +			if (IS_ALIGNED(pfn, 1 << order)) {
>> +				*out_pfn = pfn;
>> +				return 0;
>> +			}
>> +			/* Retry with smaller order */
>> +			return -EAGAIN;
>> +		}
>> +		range_buf_offset += range_len;
>> +	}
>> +
>> +	/*
>> +	 * A hugepage straddling a range boundary will fail to match a
>> +	 * range, but the address will (eventually) match when retried
>> +	 * with a smaller page.
>> +	 */
>> +	if (order > 0)
>> +		return -EAGAIN;
>> +
>> +	/*
>> +	 * If we get here, the address fell outside of the span
>> +	 * represented by the (concatenated) ranges.  Setup of a
>> +	 * mapping must ensure that the VMA is <= the total size of
>> +	 * the ranges, so this should never happen.  But, if it does,
>> +	 * force SIGBUS for the access and warn.
>> +	 */
>> +	WARN_ONCE(1, "No range for addr 0x%lx, order %d: VMA 0x%lx-0x%lx pgoff 0x%lx, %u ranges, size 0x%zx\n",
>> +		  address, order, vma->vm_start, vma->vm_end, vma->vm_pgoff,
>> +		  vpdmabuf->nr_ranges, vpdmabuf->size);
>> +
>> +	return -EFAULT;
>> +}
>> +
>>   /*
>>    * This is a temporary "private interconnect" between VFIO DMABUF and iommufd.
>>    * It allows the two co-operating drivers to exchange the physical address of
>> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
>> index fca9d0dfac90..c8f6f959056a 100644
>> --- a/drivers/vfio/pci/vfio_pci_priv.h
>> +++ b/drivers/vfio/pci/vfio_pci_priv.h
>> @@ -23,6 +23,20 @@ struct vfio_pci_ioeventfd {
>>   	bool			test_mem;
>>   };
>>   
>> +struct vfio_pci_dma_buf {
>> +	struct dma_buf *dmabuf;
>> +	struct vfio_pci_core_device *vdev;
>> +	struct list_head dmabufs_elm;
>> +	size_t size;
>> +	struct phys_vec *phys_vec;
>> +	struct p2pdma_provider *provider;
>> +	u32 nr_ranges;
>> +	struct kref kref;
>> +	struct completion comp;
>> +	unsigned long vma_pgoff_adjust;
>> +	u8 revoked : 1;
>> +};
>> +
>>   bool vfio_pci_intx_mask(struct vfio_pci_core_device *vdev);
>>   void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev);
>>   
>> @@ -114,6 +128,12 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
>>   	return (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
>>   }
>>   
>> +int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_buf *vpdmabuf,
>> +			      struct vm_area_struct *vma,
>> +			      unsigned long address,
>> +			      unsigned int order,
>> +			      unsigned long *out_pfn);
>> +
>>   #ifdef CONFIG_VFIO_PCI_DMABUF
>>   int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>   				  struct vfio_device_feature_dma_buf __user *arg,
> 

