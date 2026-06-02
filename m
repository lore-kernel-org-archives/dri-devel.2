Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F4FCD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 18:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A88B710F498;
	Tue,  2 Jun 2026 18:01:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="TIq8E1+7";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B008E10F498
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 18:01:38 +0000 (UTC)
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 652E07op2175875
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 11:01:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=TLuI65oSuDRE65vhzQMOoO1E/g4MwzO7wSZkxf244TE=; b=TIq8E1+7htJB
 lJL0TinyyKQcSMbO9fSTw8UX+CQIBwyy4v7QIWjABAup5GqlgDWYlBhEWy3n5KuB
 r/NlG1xhRZ/63zTsX0RK9U8IwEol4i0k56zq/Zb5jVz6aVDy4NKBKhGjzhx5SSLV
 v7FGN/bXZUQndbr1C/4PmqwmSjKpJ9qWcewGv5R2Lrc6K521RF3iHAbiMJXhUMvg
 OFMBj8D9l28rkMniQsfeBpFYkYAai9aNZ/VN9J5BuI1K7TUH+uDNARacLrtOI6cz
 Sm/BqXlMHXrLOcAfYb8HTW7WSbyi0W1njXBxZvE/b5q428NIuY71gH0l/34V7v3y
 VmuVrZWdyQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ej0j8hsfb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 11:01:37 -0700 (PDT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304e7fc90b1so4512184eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 11:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780423297; x=1781028097;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TLuI65oSuDRE65vhzQMOoO1E/g4MwzO7wSZkxf244TE=;
 b=gCVJ0y7iBkC/zGb3s0/oFYCoumTdOBUxwWhZ6YnQUedtCUxkvCRriZ2vaqFtF+LSZl
 QhAXbZ88yV5B00ie9JpWVvvQfaic6NQIndYuqPt0Lhw82q9TuaW+SkWVqhnjgvN1in4q
 0kcK7A23GA4M8xXbro5kK/UKDJ3rdF9YzQB84MVkIszPdtrT7lfHEQdek3gZkMYQsZoi
 eqT+MBgm5ZWwX8hPTIC2i7pvjd3mjug3TLtk/XG2rQKHPqtulBw3vAkxnEVpQ2wcU826
 1uPAR5O9i8QZMaGj100Vno6SflNSkpyro6QQhWIBT70EYS+PEYO2wKtEkaNe4ORNDYeX
 juYQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9MVBI6HPk0hkiocqxY1udbBwbuTz1Zpxj4hAdD5gYM7TuCA65luzTlI6c75xqcKHVaizNtsGo/kMI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxklXtuQg/UrixLiaeHO1zo2xsXSBexNj1CtvW2yUc9Ajcqr1No
 b6aQq5ro+T8Q/8YEtOw9OUFfDTN9rArYRyMx0ZtJ5GbG0e/fnQuWvKNfkWNYGc4eFJSVCL6/6Hf
 1H6SyYmBJ8i1qPXQM3EInwjPBIBDJikyiuHLQuftiRnZYWnwf1BOND/sTHm3xWrFC+veV
X-Gm-Gg: Acq92OFkwpWJp5MuFeo1jNrkiyJCZlpFb3LLMeOFI2VW7dQ5X1SZK0z2tIxxg7yMug4
 2gXm3iFIyTbcLyNYLC2VWcBjfBfZRuBX8FknYIHRwm+FrDJks1dXXUqdOwPwN1qEfvGvbextAU+
 gumzO7tFZ3IeMkCTr5UFnNVkAdTrsWWiQNMP/IraWwPF45/epPhSzaHI9uVxqjQFadGjkhUOHqs
 OCiGnJTXFauAMToIaaqujWo31QfK6TGYk734lvt8e+PnOhmPr1pskTXmqi0jeVxyfEP94c9cBt0
 QfQUlEtaEgvb8HN4eij55pj0VYSSiFX3MTRzu1FPqg65CnQjLSKWghz5GmrCbN7wqnO6bxeOcp8
 eUVhY96clnLqUporm75bVsA86OgHdKxrNiCc=
X-Received: by 2002:a05:7022:f99:b0:132:f16:a574 with SMTP id
 a92af1059eb24-137d3d09cf1mr7685419c88.7.1780423296175; 
 Tue, 02 Jun 2026 11:01:36 -0700 (PDT)
X-Received: by 2002:a05:7022:f99:b0:132:f16:a574 with SMTP id
 a92af1059eb24-137d3d09cf1mr7685300c88.7.1780423294977; 
 Tue, 02 Jun 2026 11:01:34 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f54db05csm353834c88.8.2026.06.02.11.01.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2026 11:01:34 -0700 (PDT)
Message-ID: <3070025e-5634-4033-af87-d6d99f1c141c@meta.com>
Date: Tue, 2 Jun 2026 19:01:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] vfio/pci: Convert BAR mmap() to use a DMABUF
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
 <20260527102319.100128-5-mattev@meta.com>
 <20260528171544.3d8db4a2@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260528171544.3d8db4a2@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: AvFLkvSF-rSOCfPdQElCx4Xj1itlxDjz
X-Authority-Analysis: v=2.4 cv=Ke3idwYD c=1 sm=1 tr=0 ts=6a1f1a81 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22 a=VabnemYjAAAA:8
 a=X6LgIXqp_Fj0wCoY6GEA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE3NCBTYWx0ZWRfX8a0uqPGwgsDD
 E4WIJtcis55N6Dym/mPyxgXu1gPrUD+zTGEIcuEPZFztCV3kB6lJcUXC40Tfj4EGuegbRtrGg3D
 HPvGz6ZA4U2X7g91+Fj07nOa+L1jYZS9/YBaBzYMDrD1b7fpWU0LctoTklVRsom5aP8rzeGykHi
 nQlq4MtNaAB6eDSbcCQcUSdOJIU7fRC6Eq3iPUykXIC7OT7J20i8kjat3JIP05JnKY72gnBO1Gs
 /4Abd0qBNNTaejAjPoiri7uV88D6wxs1Lo70HCDROdK4ln2sdanKbsdz4bi3zQyPaIfcehCBtzN
 5AAk+xESwNEHSA867XKjA3xCHXkCKU7cgyfRQmz58jtQcY9HZt0/oAHtVW7bQiG9WSxma6h8rCc
 iasVA1DJEA5XULO6B0TQnAOg3G9SFWlI+95TiuxvYPM4zlbcJQKlT8d3NG+em7wOuSq5bvhoqpQ
 joC+D44lv0VP1ZIUUbg==
X-Proofpoint-GUID: AvFLkvSF-rSOCfPdQElCx4Xj1itlxDjz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
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

On 29/05/2026 00:15, Alex Williamson wrote:
> 
> On Wed, 27 May 2026 03:23:07 -0700
> Matt Evans <mattev@meta.com> wrote:
> 
>> Convert the VFIO device fd fops->mmap to create a DMABUF representing
>> the BAR mapping, and make the VMA fault handler look up PFNs from the
>> corresponding DMABUF.  This supports future code mmap()ing BAR
>> DMABUFs, and iommufd work to support Type1 P2P.
>>
>> First, vfio_pci_core_mmap() uses the new
>> vfio_pci_core_mmap_prep_dmabuf() helper to export a DMABUF
>> representing a single BAR range.  Then, the vfio_pci_mmap_huge_fault()
>> callback is updated to understand revoked buffers, and uses the new
>> vfio_pci_dma_buf_find_pfn() helper to determine the PFN for a given
>> fault address.
>>
>> Now that the VFIO DMABUFs can be mmap()ed, vfio_pci_dma_buf_move()
>> zaps PTEs (used on the revocation and cleanup paths).
>>
>> CONFIG_VFIO_PCI_CORE now unconditionally depends on
>> CONFIG_DMA_SHARED_BUFFER and CONFIG_PCI_P2PDMA_CORE.  The
>> CONFIG_VFIO_PCI_DMABUF feature conditionally includes support for
>> VFIO_DEVICE_FEATURE_DMA_BUF, depending on the availability of
>> CONFIG_PCI_P2PDMA.
>>
>> Signed-off-by: Matt Evans <mattev@meta.com>
>> ---
>>   drivers/vfio/pci/Kconfig           |  4 +-
>>   drivers/vfio/pci/Makefile          |  3 +-
>>   drivers/vfio/pci/vfio_pci_core.c   | 79 +++++++++++++++++++-----------
>>   drivers/vfio/pci/vfio_pci_dmabuf.c | 12 +++++
>>   drivers/vfio/pci/vfio_pci_priv.h   | 11 +----
>>   5 files changed, 68 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
>> index 296bf01e185e..9197343a7301 100644
>> --- a/drivers/vfio/pci/Kconfig
>> +++ b/drivers/vfio/pci/Kconfig
>> @@ -6,6 +6,8 @@ config VFIO_PCI_CORE
>>   	tristate
>>   	select VFIO_VIRQFD
>>   	select IRQ_BYPASS_MANAGER
>> +	select PCI_P2PDMA_CORE
>> +	select DMA_SHARED_BUFFER
>>   
>>   config VFIO_PCI_INTX
>>   	def_bool y if !S390
>> @@ -56,7 +58,7 @@ config VFIO_PCI_ZDEV_KVM
>>   	  To enable s390x KVM vfio-pci extensions, say Y.
>>   
>>   config VFIO_PCI_DMABUF
>> -	def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
>> +	def_bool y if PCI_P2PDMA
> 
> This largely only breaks consistency, but should VFIO_PCI_CORE become a
> 'depends on' rather than dropped entirely?

That makes more sense, avoids the file being built if !VFIO_PCI...  Fixed.

>>   
>>   source "drivers/vfio/pci/mlx5/Kconfig"
>>   
>> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
>> index 6138f1bf241d..881452ea89be 100644
>> --- a/drivers/vfio/pci/Makefile
>> +++ b/drivers/vfio/pci/Makefile
>> @@ -1,8 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   
>> -vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
>> +vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o vfio_pci_dmabuf.o
>>   vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
>> -vfio-pci-core-$(CONFIG_VFIO_PCI_DMABUF) += vfio_pci_dmabuf.o
>>   obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
>>   
>>   vfio-pci-y := vfio_pci.o
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 041243a84d81..c5f934905ce0 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -1683,18 +1683,6 @@ void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev, u16 c
>>   	up_write(&vdev->memory_lock);
>>   }
>>   
>> -static unsigned long vma_to_pfn(struct vm_area_struct *vma)
>> -{
>> -	struct vfio_pci_core_device *vdev = vma->vm_private_data;
>> -	int index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
>> -	u64 pgoff;
>> -
>> -	pgoff = vma->vm_pgoff &
>> -		((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
>> -
>> -	return (pci_resource_start(vdev->pdev, index) >> PAGE_SHIFT) + pgoff;
>> -}
>> -
>>   vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
>>   				   struct vm_fault *vmf,
>>   				   unsigned long pfn,
>> @@ -1722,23 +1710,42 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
>>   					   unsigned int order)
>>   {
>>   	struct vm_area_struct *vma = vmf->vma;
>> -	struct vfio_pci_core_device *vdev = vma->vm_private_data;
>> -	unsigned long addr = vmf->address & ~((PAGE_SIZE << order) - 1);
>> -	unsigned long pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
>> -	unsigned long pfn = vma_to_pfn(vma) + pgoff;
>> -	vm_fault_t ret = VM_FAULT_FALLBACK;
>> -
>> -	if (is_aligned_for_order(vma, addr, pfn, order)) {
>> -		scoped_guard(rwsem_read, &vdev->memory_lock)
>> -			ret = vfio_pci_vmf_insert_pfn(vdev, vmf, pfn, order);
>> -	}
>> +	struct vfio_pci_dma_buf *priv = vma->vm_private_data;
>> +	struct vfio_pci_core_device *vdev;
>> +	unsigned long pfn = 0;
>> +	vm_fault_t ret = VM_FAULT_SIGBUS;
>>   
>> -	dev_dbg_ratelimited(&vdev->pdev->dev,
>> -			   "%s(,order = %d) BAR %ld page offset 0x%lx: 0x%x\n",
>> -			    __func__, order,
>> -			    vma->vm_pgoff >>
>> -				(VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT),
>> -			    pgoff, (unsigned int)ret);
>> +	/*
>> +	 * We can rely on the existence of both a DMABUF (priv) and
>> +	 * the VFIO device it was exported from (vdev).  This fault's
>> +	 * VMA was established using vfio_pci_core_mmap_prep_dmabuf()
>> +	 * which transfers ownership of the VFIO device fd to the
>> +	 * DMABUF, and so the VFIO device is held open because the
>> +	 * VMA's vm_file (DMABUF) is open.
>> +	 *
>> +	 * Since vfio_pci_dma_buf_cleanup() cannot have happened,
>> +	 * vdev must be valid; we can take memory_lock.
>> +	 */
>> +	vdev = READ_ONCE(priv->vdev);
> 
> The above comment argues that vdev is stable, so why do we need to
> access it with READ_ONCE()?

Fixed as of my reply to your review of [7/8].

> 
>> +
>> +	scoped_guard(rwsem_read, &vdev->memory_lock) {
>> +		if (!priv->revoked) {
>> +			int pres = vfio_pci_dma_buf_find_pfn(priv, vma,
>> +							     vmf->address,
>> +							     order, &pfn);
>> +
>> +			if (pres == 0)
>> +				ret = vfio_pci_vmf_insert_pfn(vdev, vmf,
>> +							      pfn, order);
>> +			else if (pres == -EAGAIN)
>> +				ret = VM_FAULT_FALLBACK;
>> +		}
>> +
>> +		dev_dbg_ratelimited(&vdev->pdev->dev,
>> +				    "%s(order = %d) PFN 0x%lx, VA 0x%lx, pgoff 0x%lx: 0x%x\n",
>> +				    __func__, order, pfn, vmf->address,
>> +				    vma->vm_pgoff, (unsigned int)ret);
> 
> Looks like this should still be outside the scope of the memory_lock.

Argh, I think I stuffed a rebase there, thanks for that.  I should've 
caught that in my local review.  Fixed!

(Reply flurry pausing now;  still working on implementing the suggestion 
for "[PATCH v2 6/9] vfio/pci: Clean up BAR zap and revocation" and 
refactoring for "[PATCH v2 1/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE", 
but will post a v3 in a day or two.  As ever, thanks for the reviews.)


Matt


> Thanks,
> 
> Alex
> 
>> +	}
>>   
>>   	return ret;
>>   }
>> @@ -1763,6 +1770,7 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
>>   	unsigned int index;
>>   	u64 phys_len, req_len, pgoff, req_start;
>>   	void __iomem *bar_io;
>> +	int ret;
>>   
>>   	index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
>>   
>> @@ -1802,7 +1810,20 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
>>   	if (IS_ERR(bar_io))
>>   		return PTR_ERR(bar_io);
>>   
>> -	vma->vm_private_data = vdev;
>> +	/*
>> +	 * Create a DMABUF with a single range corresponding to this
>> +	 * mapping, and wire it into vma->vm_private_data.  The VMA's
>> +	 * vm_file becomes that of the DMABUF, and the DMABUF takes
>> +	 * ownership of the VFIO device file (put upon DMABUF
>> +	 * release).  This maintains the behaviour of a live VMA
>> +	 * mapping holding the VFIO device file open.
>> +	 */
>> +	ret = vfio_pci_core_mmap_prep_dmabuf(vdev, vma,
>> +					     pci_resource_start(pdev, index),
>> +					     req_len, index);
>> +	if (ret)
>> +		return ret;
>> +
>>   	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>>   	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
>>   
>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> index 782408c08a5e..f7797f58d44b 100644
>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> @@ -9,6 +9,7 @@
>>   
>>   MODULE_IMPORT_NS("DMA_BUF");
>>   
>> +#ifdef CONFIG_VFIO_PCI_DMABUF
>>   static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
>>   				   struct dma_buf_attachment *attachment)
>>   {
>> @@ -25,6 +26,7 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
>>   
>>   	return 0;
>>   }
>> +#endif /* CONFIG_VFIO_PCI_DMABUF */
>>   
>>   static void vfio_pci_dma_buf_done(struct kref *kref)
>>   {
>> @@ -89,7 +91,9 @@ static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
>>   }
>>   
>>   static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
>> +#ifdef CONFIG_VFIO_PCI_DMABUF
>>   	.attach = vfio_pci_dma_buf_attach,
>> +#endif
>>   	.map_dma_buf = vfio_pci_dma_buf_map,
>>   	.unmap_dma_buf = vfio_pci_dma_buf_unmap,
>>   	.release = vfio_pci_dma_buf_release,
>> @@ -263,6 +267,7 @@ static int vfio_pci_dmabuf_export(struct vfio_pci_core_device *vdev,
>>   	return 0;
>>   }
>>   
>> +#ifdef CONFIG_VFIO_PCI_DMABUF
>>   /*
>>    * This is a temporary "private interconnect" between VFIO DMABUF and iommufd.
>>    * It allows the two co-operating drivers to exchange the physical address of
>> @@ -461,6 +466,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>   	kfree(dma_ranges);
>>   	return ret;
>>   }
>> +#endif /* CONFIG_VFIO_PCI_DMABUF */
>>   
>>   int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>>   				   struct vm_area_struct *vma,
>> @@ -535,6 +541,10 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
>>   	struct vfio_pci_dma_buf *tmp;
>>   
>>   	lockdep_assert_held_write(&vdev->memory_lock);
>> +	/*
>> +	 * Holding memory_lock ensures a racing VMA fault observes
>> +	 * priv->revoked properly.
>> +	 */
>>   
>>   	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
>>   		if (!get_file_active(&priv->dmabuf->file))
>> @@ -552,6 +562,8 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
>>   			if (revoked) {
>>   				kref_put(&priv->kref, vfio_pci_dma_buf_done);
>>   				wait_for_completion(&priv->comp);
>> +				unmap_mapping_range(priv->dmabuf->file->f_mapping,
>> +						    0, priv->size, 1);
>>   				/*
>>   				 * Re-arm the registered kref reference and the
>>   				 * completion so the post-revoke state matches the
>> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
>> index 06dc0fd3e230..d38e1b98b2e9 100644
>> --- a/drivers/vfio/pci/vfio_pci_priv.h
>> +++ b/drivers/vfio/pci/vfio_pci_priv.h
>> @@ -138,13 +138,13 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>>   				   struct vm_area_struct *vma,
>>   				   u64 phys_start, u64 req_len,
>>   				   unsigned int res_index);
>> +void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev);
>> +void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked);
>>   
>>   #ifdef CONFIG_VFIO_PCI_DMABUF
>>   int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>   				  struct vfio_device_feature_dma_buf __user *arg,
>>   				  size_t argsz);
>> -void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev);
>> -void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked);
>>   #else
>>   static inline int
>>   vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>> @@ -153,13 +153,6 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>   {
>>   	return -ENOTTY;
>>   }
>> -static inline void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
>> -{
>> -}
>> -static inline void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev,
>> -					 bool revoked)
>> -{
>> -}
>>   #endif
>>   
>>   #endif
> 

