Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656D6CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:55:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CE8610F3B9;
	Fri,  8 May 2026 07:55:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="TBT8+x/D";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6463E10F1CE
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 15:48:43 +0000 (UTC)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
 by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 646LQfSg2865701
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 08:48:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=7ee0kKFk8CI3AWhXFM+kSfgli3u7LAWrP2aGxa36TIM=; b=TBT8+x/DyOnF
 /jQZcsP6J8KkrIiBxC1vYorXjlDpI2msIlIRN7YnrzQ7S97+CNmrwLuLnmCG39U6
 5WGItgxSXzSKsyUK5/JeGZHK3OSCo85kwy0yA/LYWhmAGPFxnmnfU922K3jm8nIT
 D6kZnU/Jc26lv9Pyx2qJeaEuyB19C8fGbHTaxmaWGRZrReTC5Bn+8kanDEjaxT8e
 olHoml38lvu+IzEADYEmLTw8bRp7+VgZp8YJuALcWXTrcq6+ZooeGRS9oF4bA1Wg
 pcN0TocQODFgyyMk36wtNUKOTOErT/R6G4ig4mssnIp5xVNowY0gRwIekSsw70xe
 6Mknw6Euhw==
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 by m0001303.ppops.net (PPS) with ESMTPS id 4dwcxa13k9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 08:48:42 -0700 (PDT)
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-44d79da8cf7so890475f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 08:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778168921; x=1778773721;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7ee0kKFk8CI3AWhXFM+kSfgli3u7LAWrP2aGxa36TIM=;
 b=JOrwkE9JjqwWi5ziax/nTx+hsvVzoH1FmkuQYHWVOjlF7ITdYOQNn5ug7t3WRN8Z/r
 Qm3OciR3RZD97v1I+OEhCKY/0qDtchfP/Z0ZaJBaiRgixS2eLWMRPY7KGxsCvsRKIsX9
 pbWVhhG1Kwtf3JmGx5QDBwfak+/4FDHKarqoRn8oPlkHKZ+Z2yAkRGxiB4VjIDrTnri1
 YihX904NB0qUI7jx7jur3bBbnvE3E0wXXGy96KewRBjgpKJ0u8zRHAngPPjq4noXZQ5q
 vpPkMe3JOnsQ5qJF3npXSuLCzHWnmUyJyjdpI1oWojRSQpD0RsydIoKG/FIiPxdWXwnL
 Sdkw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/L4GseUuz+JP3d5XeqS8ikMIcFzqcyd3ReVO4TGWw50jEeDOXTo1Pp/yI12Ch/OrhwVE3p2ps5aec=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKkuDjHxQtBu7q62up1BJNUBr1dUFcA8uFFZjBAHSkbT9eTZx6
 U8EE+6p2UiAe0cXjrQ5rNgeV92UJWSyS6EBx5EJiBS3S7WCpvQXqz0I5Olg8cUmPAQcX+AAOoCn
 zr0JdDNuHxGk5TsQUEYYkwWjJ7D+vo8MzvruqykIgMP8nps724ASKhRQBsV5fwlQ1OVoC
X-Gm-Gg: AeBDietnpF1LLePyG32MHFUOAOH676h0hdYD/DsMePKFcyf35hp1QQPIZv2w1kprvC+
 k8o4F7nVMz194S/9FzoFmgpFa8hpVV6+zHpo1QJ4+TaskA/lqYgy9aUnjMdsI4f5x7DFnBqa2iU
 2TS/ljf/uKBAewuOZ57npVr4jKH8yM10axmleUJ1CB+UFC/B7W34x3gsZVPosQ5Aa21yzNMYAms
 zU0x+vc+MEtyepI4uSDgMgYpkECNQ/RQ+jugIf7F1Ghl+35ADErStjHoNt7tYtcMaBVoWiUerJF
 MVYbTImSAONk8DzGi/ApV0f7my1KOewMfcxnxdMvyHoyYN52+3abxI53hd/KqEAMAOHRHsfsavK
 r33x9hMrdgfkf9SBMJq9ZOUhPd2YqOrDwPHFYc7HeorGmPd4SfMiTujML3VRs6QIRdykfHQxJkk
 zWuHEZNscdtUjGoCaPqFgXa3x/it58JgKS5Z7eg27B6Og8i9aoWJrTF9/YMCITdth1AMcLR+ZlB
 90me1P0ODILONgtAZbxuLFKd7lU+mG3ghstgs3S/6np
X-Received: by 2002:a5d:5f48:0:b0:43b:498f:dceb with SMTP id
 ffacd0b85a97d-4515b056b4dmr13924645f8f.9.1778168920701; 
 Thu, 07 May 2026 08:48:40 -0700 (PDT)
X-Received: by 2002:a5d:5f48:0:b0:43b:498f:dceb with SMTP id
 ffacd0b85a97d-4515b056b4dmr13924574f8f.9.1778168920112; 
 Thu, 07 May 2026 08:48:40 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde?
 (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055f2203csm21318765f8f.37.2026.05.07.08.48.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 08:48:39 -0700 (PDT)
Message-ID: <c746c3a7-37df-49a6-9000-a3b67ae206ab@meta.com>
Date: Thu, 7 May 2026 16:48:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] vfio/pci: Add a helper to look up PFNs for DMABUFs
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Pranjal Shrivastava <praan@google.com>, Alistair Popple
 <apopple@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-3-mattev@meta.com>
 <20260424181510.GF3444440@nvidia.com>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260424181510.GF3444440@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: fYkRjBrYHNR1-WDAFmL-_4TsvC2P7oIb
X-Proofpoint-GUID: fYkRjBrYHNR1-WDAFmL-_4TsvC2P7oIb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1OCBTYWx0ZWRfXxbG+ZN8XUFC+
 qYxSLYKTVM9dFCOEVaL7i5AVoTCpbpYxOMQv2hU7MDWyLOnwWrRPEkSUsoE/ri7C4wUjQ0ahG2/
 6Mw60d6K5XOL68N4S0Vd2qlFT023dsOVIIcyJnZGFyTnB8o5X1T4rYz9NmlJq0f9AvRrFQ78jIG
 zt1a/Rj3PStU2Lds5PMesvqQ/4jP4o4L3iSAasVAz4uLgj9IpQEmZ6a76p8l+fXFNWOnK2Yq63c
 i9UZcZvZzEyPjzXoPLQV9lYyn15eRcQSgTQdAhhXS6GzZlJg/8Q90dPBSh1gs7Ccr7gpXiSvmsE
 LxzDSj53/xrnyK8lHV5vfgzRXQEAQ5HfDoLQBOuliOSGKcRSxnEMaX3V3b8io0Igh68a7oK76h+
 Hc8fngtfoAy88K66ylLYX7c0W0X/lw3zRNm4UfgG1Iz/06H5vkoWOt52ahXcc/2uH7uRKPFkcHF
 JdzHeD1tdYZZdWIDQjw==
X-Authority-Analysis: v=2.4 cv=SoCgLvO0 c=1 sm=1 tr=0 ts=69fcb45a cx=c_pps
 a=I6ewnrIBtnKHmb6SxpX7Vg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=VabnemYjAAAA:8 a=PVx_5XRel0ZW2V4eVl8A:9
 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Mailman-Approved-At: Fri, 08 May 2026 07:55:51 +0000
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

Hi Jason,

On 24/04/2026 19:15, Jason Gunthorpe wrote:
> 
> On Thu, Apr 16, 2026 at 06:17:45AM -0700, Matt Evans wrote:
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
>>   drivers/vfio/pci/vfio_pci_dmabuf.c | 124 ++++++++++++++++++++++++++---
>>   drivers/vfio/pci/vfio_pci_priv.h   |  19 +++++
>>   2 files changed, 130 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> index 04478b7415a0..8b6bae56bbf2 100644
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
>> @@ -106,6 +93,117 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
>>   	.release = vfio_pci_dma_buf_release,
>>   };
>>   
>> +int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_buf *vpdmabuf,
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
>> +	 */
>> +
>> +	const unsigned long pagesize = PAGE_SIZE << order;
>> +	unsigned long rounded_page_addr = address & ~(pagesize - 1);
> 
> ALIGN_DOWN(address, pagesize);

Oops, right, fixed.

>> +	unsigned long rounded_page_end = rounded_page_addr + pagesize;
>> +	unsigned long buf_page_offset;
>> +	unsigned long buf_offset = 0;
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
>> +	if (unlikely(check_add_overflow(rounded_page_addr - vma->vm_start,
>> +					vma->vm_pgoff << PAGE_SHIFT, &buf_page_offset)))
>> +		return -EFAULT;
> 
>> +
>> +	for (i = 0; i < vpdmabuf->nr_ranges; i++) {
>> +		size_t range_len = vpdmabuf->phys_vec[i].len;
>> +		phys_addr_t range_start = vpdmabuf->phys_vec[i].paddr;
>> +
>> +		/*
>> +		 * If the current range starts after the page's span,
>> +		 * this and any future range won't match.  Bail early.
>> +		 */
>> +		if (buf_page_offset + pagesize <= buf_offset)
>> +			break;
> 
> No overflow check on this +? If we are worried order is so large that
> the first needs a check then this would too..

In the earlier check it's not order being large but the vm_pgoff, but 
yes an overflow check wouldn't hurt here.  Added.

I've found (my) choice of variable names here awkward, and have renamed 
them to make it a bit clearer as to what's the page being searched for 
and what's the range, etc.

>> +
>> +		if (buf_page_offset >= buf_offset &&
>> +		    buf_page_offset + pagesize <= buf_offset + range_len) {
> 
>> +			/*
>> +			 * The faulting page is wholly contained
>> +			 * within the span represented by the range.
>> +			 * Validate PFN alignment for the order:
>> +			 */
>> +			unsigned long pfn = (range_start >> PAGE_SHIFT) +
>> +				((buf_page_offset - buf_offset) >> PAGE_SHIFT);
> 
> (range_start + (buf_page_offset - buf_offset)) / PAGE_SIZE;

WFM, done.

Thank you,

Matt

