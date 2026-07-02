Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A91C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 585D410F47D;
	Thu,  2 Jul 2026 15:46:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=deltatee.com header.i=@deltatee.com header.b="NMJlC0W9";
	dkim-atps=neutral
X-Greylist: delayed 1906 seconds by postgrey-1.36 at gabe;
 Thu, 02 Jul 2026 15:46:44 UTC
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3BA910F48B
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
 MIME-Version:Date:Message-ID:content-disposition;
 bh=kyJzbfSqoUXaNBv1Ig4SDg9TeDVODqylZdwHs0c6zpw=; b=NMJlC0W9kihForMdCYYnlLUQ6m
 Eo6IW7rO0b1c3osWSWCUUldacbvkYcIHJHIs657/dhe4oEXiTtpTQ/dWk3ifTTLUQaEbidde5h+Za
 PcycMOPmLVTwDWHJQDPiDcGfQFjTrxGqlbaAn1kK1DM5rhbiznK9fasb+RfVbru6MJxXbEPCEc2BB
 ISWRcrKmHu4YocW7NLlTKBCzF8RiOcqDAlrl1qmazF+AWcg8m31/uJD0FplDbG195cflmPyzGuwqL
 1GZfpCJbvEWPB56K9HdzIMLEdCpT6Q5vbDcy9K/PQB2P0uo3+xF6t8DCMd8+dsioqd8R68fxzYcGo
 8krZuUbA==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([96.51.150.74]
 helo=[10.0.33.8]) by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.98.2)
 (envelope-from <logang@deltatee.com>) id 1wfJcc-00000006yLj-3jeO;
 Thu, 02 Jul 2026 09:46:39 -0600
Message-ID: <26f74cf0-8892-4672-b0e1-1f1a385c42bb@deltatee.com>
Date: Thu, 2 Jul 2026 09:45:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>
Cc: Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260701171245.90111-1-matt@ozlabs.org>
 <20260701171245.90111-3-matt@ozlabs.org>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260701171245.90111-3-matt@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 96.51.150.74
X-SA-Exim-Rcpt-To: matt@ozlabs.org, alex@shazbot.org, leon@kernel.org,
 jgg@nvidia.com, amastro@fb.com, christian.koenig@amd.com, bhelgaas@google.com,
 kevin.tian@intel.com, praan@google.com, mngyadam@amazon.de,
 dmatlack@google.com, bjorn@kernel.org, sumit.semwal@linaro.org,
 ankita@nvidia.com, apopple@nvidia.com, vivek.kasireddy@intel.com,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 02/10] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
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



On 2026-07-01 11:12 a.m., Matt Evans wrote:>
>  PCI POWER CONTROL
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 33c88432b728..59d70bc84cc9 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -206,11 +206,7 @@ config PCIE_TPH
>  config PCI_P2PDMA
>  	bool "PCI peer-to-peer transfer support"
>  	depends on ZONE_DEVICE
> -	#
> -	# The need for the scatterlist DMA bus address flag means PCI P2PDMA
> -	# requires 64bit
> -	#
> -	depends on 64BIT
> +	select PCI_P2PDMA_CORE

Can we remove this dependency on 64BIT? Althogh it looks like
af2880ec440 complicated the issue a bit.

If I remember correctly, the original reason for this is because on
64bit systems dma_flags fit into unusued space in struct scatterlist and
on 32bit systems this space didn't exist and thus adding the flag
required increasing the size of the structure which wasn't desirable at
the time.

But af2880ec440 introduced CONFIG_NEED_SG_DMA_FLAGS which doesn't depend
on 64bit which means if CONFIG_IOMMU_DMA and CONFIG_SWIOTLB are now set
on 32bit systems that structure will grow quite a bit.

So maybe at this point it's fine to enable this on 32bit systems and we
can remove this requirement. However, I think we should do that
explicitly in its own patch, not hide it in this refactoring patch.

Logan
