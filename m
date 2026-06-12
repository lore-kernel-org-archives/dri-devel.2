Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB43CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 10:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDD7810E5A1;
	Fri, 12 Jun 2026 10:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="a/LeN4fO";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 724FD10E5A1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 10:41:46 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2bf22c18ad3so98055ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 03:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781260906; x=1781865706;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kyKpUSmzhXA86dwYd5qyCKe1OI2XqC/1Gh0xGOzaDhE=;
 b=a/LeN4fOe61c3nQuYy2ZHV2PQbGGJxTChYIakVGVYW6YnG9NttAP9376FPmBWqOt/E
 O0lmBz/UluXc4D0Pz+b04Wc7H8bfDP/gGf8a7FIR6uBJFYEOG6xsYZtjHcYWLmLurzO6
 D0/cz12EZDnqiMm8WeVDU8/hzKV/9T2cKUG6JsUNKPrWz4Q6KbUkQstUWsY6+dq4T/xU
 yq3YgOwwfnuxW++egVJitUYYdlDqu+MVk6JDNKVx/G/Lsd+S9DA2zKgTAr8Ap7Y2jpuU
 7P9pGhZdOneiBcuJEp7fckYnAqi4bxqnGe04X3aj12ZX3BCrpatTC6hSTs8dHIbKPyqd
 UHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781260906; x=1781865706;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kyKpUSmzhXA86dwYd5qyCKe1OI2XqC/1Gh0xGOzaDhE=;
 b=JtBZZdOKBP56TRnqf37alPuYl6EKMra77Hol1VVwdelQgrB1zh4lBqctrv/p5yYfYl
 uIQHvu8+b9jHwJUhHqg8fEQPDeTlcN6pcHvtSbQl3lANbL7nIqqnJp7dLbeYIG4ZBZOI
 PUkE0IEw/6FtIcZqqGsHveWPR+ClQOOAGwftQonJPiY5cp/plAHeRyipPpDk8we5Wcyy
 G2H6KMQ5cO4Fw0Kf8Ek41iq32zDasNPAhdU63DP7J1GRCCOAFp48IYAvgqsi5heGj5rJ
 6NGSSrWilHqZuTKfsIAP4BUmortYzWGLc/2seAgsg+ejjbTXz/fo0iWqzrmb1q97ZOoG
 gqwQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wkxJV9RvmKoqF+AE9F4v7G/eQRRHhCchU2U5f6ZJr2nRFtDECdXWdFZPJMhUwR22MLbj32e9HhrY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwPdtbkl4ij7zLtl1lgZSlPjr4gUe4Z8HaI4tw7JbkCkkN6zZCX
 DxKiegR7IaFXp5aYS2aYuLij9LyMvUbfEFvkDMlYuIMx/PuZ2rjfsLJatp9zJGfOrQ==
X-Gm-Gg: Acq92OEwBs2aUGmsMbNabTNUDUpsuF/MQaj6xI0Qp5Jeos2sWbEiyiXV4YhiIGSnJGX
 +n3ho1dx01nRTPxc5ls6Fm4vv2TyEcTYopLXMzMQOPCUIEQis5x8GO5ntXB9bEDHmn0oGJwaOAN
 RlrBPV4NLlZ1VZ7Y/2lDxhDNner16pQST5CFIgxqVW5IUoQT91/7lpxlAqxg7vqGCHp1CDQNwhL
 fm0CHPt4iVIaq72G76zTheGCHJB4nkW0dkNMCkCWXwKZpSyndZftSCYKnOiJ++IsiYVJXw819Z+
 +gnmKSH9OaiQFsaB2rbOXwsh/NX6iXTER3VACMHQqxSymjPBXHRodgx1WAO7HooinLRDUPxqcEn
 SBU9jafFTyY6SsaovuxNw2+5ZqY9ySApoOghqu5ZawyybXKCThix0odv3vF2FhHosuCp7b7JtZb
 yP1rk0mgfRI4jVWQqEZMCu832l5MHZkBjZF9cAn2g/D621NVMCPh0euCGED8lC
X-Received: by 2002:a17:902:da81:b0:2c0:c14c:bf37 with SMTP id
 d9443c01a7336-2c3e1919896mr2258415ad.16.1781260905357; 
 Fri, 12 Jun 2026 03:41:45 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com.
 [34.142.255.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c4327acae2sm15759755ad.52.2026.06.12.03.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 03:41:44 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:41:36 +0000
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
Subject: Re: [PATCH v3 4/9] vfio/pci: Convert BAR mmap() to use a DMABUF
Message-ID: <aiviYEi17tewEQg0@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-5-matt@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610154327.37758-5-matt@ozlabs.org>
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

On Wed, Jun 10, 2026 at 04:43:18PM +0100, Matt Evans wrote:
> Convert the VFIO device fd fops->mmap to create a DMABUF representing
> the BAR mapping, and make the VMA fault handler look up PFNs from the
> corresponding DMABUF.  This supports future code mmap()ing BAR
> DMABUFs, and iommufd work to support Type1 P2P.
> 
> First, vfio_pci_core_mmap() uses the new
> vfio_pci_core_mmap_prep_dmabuf() helper to export a DMABUF
> representing a single BAR range.  Then, the vfio_pci_mmap_huge_fault()
> callback is updated to understand revoked buffers, and uses the new
> vfio_pci_dma_buf_find_pfn() helper to determine the PFN for a given
> fault address.
> 
> Now that the VFIO DMABUFs can be mmap()ed, vfio_pci_dma_buf_move()
> zaps PTEs (used on the revocation and cleanup paths).
> 
> CONFIG_VFIO_PCI_CORE now unconditionally depends on
> CONFIG_DMA_SHARED_BUFFER and CONFIG_PCI_P2PDMA_CORE.  The
> CONFIG_VFIO_PCI_DMABUF feature conditionally includes support for
> VFIO_DEVICE_FEATURE_DMA_BUF, depending on the availability of
> CONFIG_PCI_P2PDMA.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  drivers/vfio/pci/Kconfig           |  5 +-
>  drivers/vfio/pci/Makefile          |  3 +-
>  drivers/vfio/pci/vfio_pci_core.c   | 75 +++++++++++++++++++-----------
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 12 +++++
>  drivers/vfio/pci/vfio_pci_priv.h   | 11 +----
>  5 files changed, 67 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index 296bf01e185e..67a2ae1fbc04 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -6,6 +6,8 @@ config VFIO_PCI_CORE
>  	tristate
>  	select VFIO_VIRQFD
>  	select IRQ_BYPASS_MANAGER
> +	select PCI_P2PDMA_CORE
> +	select DMA_SHARED_BUFFER
>  
>  config VFIO_PCI_INTX
>  	def_bool y if !S390
> @@ -56,7 +58,8 @@ config VFIO_PCI_ZDEV_KVM
>  	  To enable s390x KVM vfio-pci extensions, say Y.
>  
>  config VFIO_PCI_DMABUF
> -	def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
> +	def_bool y if PCI_P2PDMA
> +	depends on VFIO_PCI_CORE
>  
>  source "drivers/vfio/pci/mlx5/Kconfig"
>  
[...]  
>  int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>  				   struct vm_area_struct *vma,
> @@ -532,6 +538,10 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
>  	struct vfio_pci_dma_buf *tmp;
>  
>  	lockdep_assert_held_write(&vdev->memory_lock);
> +	/*
> +	 * Holding memory_lock ensures a racing VMA fault observes
> +	 * priv->revoked properly.
> +	 */

Nit: This comment should appear before the lockdep_assert_held_write()
Also, it is slightly verbose.. (not against it though).

>  
>  	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
>  		if (!get_file_active(&priv->dmabuf->file))
> @@ -549,6 +559,8 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
>  			if (revoked) {
>  				kref_put(&priv->kref, vfio_pci_dma_buf_done);
>  				wait_for_completion(&priv->comp);
> +				unmap_mapping_range(priv->dmabuf->file->f_mapping,
> +						    0, priv->size, 1);

Have we run this series with lockdep enabled?
I guess it'd be nice to check with lockdep once..

Apart from these, 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
