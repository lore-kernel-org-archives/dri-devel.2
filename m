Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B7DCD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 16:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AC8D10E28E;
	Wed, 27 May 2026 16:52:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=deltatee.com header.i=@deltatee.com header.b="hKKQDdIr";
	dkim-atps=neutral
X-Greylist: delayed 2687 seconds by postgrey-1.36 at gabe;
 Wed, 27 May 2026 16:52:20 UTC
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE44410E28E
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 16:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
 MIME-Version:Date:Message-ID:content-disposition;
 bh=qGgbZA7gj3eEje/Kt3h0lR6kJ8rSI8Qm0mNt/KdiiAg=; b=hKKQDdIrR+jWwnj24G+ln2wtbI
 dqLuifKrJ1IXNelOU+BQve3+wXU3dNpcHAqIpwfFWbRuzpdMBbEoZEURfIlX3FyOZbDB0V6U2zy0F
 tGJiCdbanctZEtuWZEc6Ctk4z8ZY/m6I58gtn1PuvZolrRTGKRZm57hzhNjrGR5XyHwNAXbmyhjQc
 YxQdPm9C0dkk+aNXmXyJi1bGuIT5XS/9RVo5R5qwEiNZf12fPWzrOUCArdpSJYEDRGqxHeVyHTzla
 fSY3zJeaAzjwNg+t29KhK1Npb/Oa6Yl5CyzWl7nGKurmy3jhZ8GrWFQuMN9hWfvqoM+9p8sc85bSp
 gztv1aSA==;
Received: from d142-179-236-232.abhsia.telus.net ([142.179.236.232]
 helo=[192.168.11.155]) by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.98.2)
 (envelope-from <logang@deltatee.com>) id 1wSGn0-00000001YTC-0svZ;
 Wed, 27 May 2026 10:07:26 -0600
Message-ID: <843e8525-5927-45b5-a3e2-a5ec16234398@deltatee.com>
Date: Wed, 27 May 2026 10:07:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Matt Evans <mattev@meta.com>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Kevin Tian <kevin.tian@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Pranjal Shrivastava <praan@google.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260527102319.100128-1-mattev@meta.com>
 <20260527102319.100128-2-mattev@meta.com>
Content-Language: en-US
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260527102319.100128-2-mattev@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 142.179.236.232
X-SA-Exim-Rcpt-To: mattev@meta.com, alex@shazbot.org, leon@kernel.org,
 jgg@nvidia.com, amastro@fb.com, christian.koenig@amd.com, bhelgaas@google.com,
 mngyadam@amazon.de, dmatlack@google.com, bjorn@kernel.org,
 sumit.semwal@linaro.org, kevin.tian@intel.com, ankita@nvidia.com,
 praan@google.com, apopple@nvidia.com, vivek.kasireddy@intel.com,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 1/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
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



On 2026-05-27 04:23, Matt Evans wrote:
> The P2PDMA code currently provides two features under the same
> CONFIG_PCI_P2PDMA option:
> 
>  1.  Locate providers via pcim_p2pdma_provider()
>  2.  Manage actual P2P DMA
> 
> Other code (such as vfio-pci) depends on 1, without having a hard
> dependency on 2.
> 
> A future commit expands the use of DMABUF in vfio-pci for non-P2P
> scenarios, relying on pcim_p2pdma_provider() always being present.  If
> that depended on CONFIG_PCI_P2PDMA, it would make vfio-pci only
> available if CONFIG_ZONE_DEVICE is present (e.g. 64-bit systems), even
> when P2P is not needed.
> 
> To resolve this, introduce CONFIG_PCI_P2PDMA_CORE which contains the
> basic provider functionality to make it available even if the
> CONFIG_PCI_P2PDMA feature is disabled or unavailable due to
> !CONFIG_ZONE_DEVICE.  Users such as vfio-pci can enable their own P2P
> features based off the original CONFIG_PCI_P2PDMA (available when
> CONFIG_ZONE_DEVICE is set).
> 
> Signed-off-by: Matt Evans <mattev@meta.com>

Largely this looks good to me. I have one minor nit below that you can
apply or not. Either way, feel free to add:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>


>  static void pci_p2pdma_release(void *data)
>  {
>  	struct pci_dev *pdev = data;
> @@ -241,11 +251,13 @@ static void pci_p2pdma_release(void *data)
>  		synchronize_rcu();
>  	xa_destroy(&p2pdma->map_types);
>  
> +#ifdef CONFIG_PCI_P2PDMA
>  	if (!p2pdma->pool)
>  		return;
>  
>  	gen_pool_destroy(p2pdma->pool);
>  	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
> +#endif
>  }

I'm personally not a fan of adding #ifdefs inside functions like this.
This instance is small and easy to understand, but it can quickly become
a bit of a mess if we start adding more features. I probably would have
created a pci_p2pdma_release_pool() helper which does the inverse of
pci_p2pdma_setup_pool(), it would be called in pci_p2pdma_release() and
an empty implementation would be provided in the case where
CONFIG_PCI_P2PDMA is not set.

Logan
