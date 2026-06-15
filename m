Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6EFCD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:18:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7454010EAFF;
	Tue, 16 Jun 2026 18:17:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="S1wL0MJo";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 907EE10E517
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 15:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1781537627;
 bh=1mJsClNx/G2flqy/GWs9bnUaqG6Fe9NMYeb2HFZgaHI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=S1wL0MJo4k35FFb3jGunM7ez67P3C13pBFUQhx1CVwaMa+OOas/gpBx2h/mGl7bun
 wLSGEUIxqaJ70kXp2tQc06/50OxM8WBbx0J2voXpFPI7/yHSK0tMaf1p7l/Shp2d4A
 F6XsWHRZiWAYgdifWpXvUOZlIHHqks3cuQEzAlAFVn9gwKh22hIMBo5ljbzwr1ee7H
 qvUXavgqIh+Kf2+A9Ky13oPg1PT9zf/jsQ5wWudAE9X2k4y6o57ky+Hccum1Vn7S6m
 +wM3Fuf0TgZM5onsu+l/KYyQ5RoIvoqqW47xsHPMaUEg/3eUf5Rt7z8lL7XS4LG+e7
 3WQJKk2t+De9Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4gfDfr2149z4wT4;
 Tue, 16 Jun 2026 01:33:39 +1000 (AEST)
Message-ID: <cfbf7eb8-8fa2-4c21-af1b-7fd3765f6eca@ozlabs.org>
Date: Mon, 15 Jun 2026 16:33:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] vfio/pci: Convert BAR mmap() to use a DMABUF
Content-Language: en-GB
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Pranjal Shrivastava <praan@google.com>, Alistair Popple
 <apopple@nvidia.com>, "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-5-matt@ozlabs.org>
 <DM6PR11MB369015C590F462592D3E508D8C182@DM6PR11MB3690.namprd11.prod.outlook.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <DM6PR11MB369015C590F462592D3E508D8C182@DM6PR11MB3690.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 16 Jun 2026 18:17:58 +0000
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

Hi Kevin,

On 12/06/2026 09:46, Tian, Kevin wrote:
>> From: Matt Evans <matt@ozlabs.org>
>> Sent: Wednesday, June 10, 2026 11:43 PM
>>
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
>> Signed-off-by: Matt Evans <matt@ozlabs.org>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 
> with a nit:
> 
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
> 
> the comment is redundant as it's about internal logic of the callee
> and is well covered by the comment there.

Thanks on both points!  I see what you mean, removed.


Matt

