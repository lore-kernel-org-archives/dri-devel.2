Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D656CC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 20:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24A8B10E49B;
	Thu,  2 Jul 2026 20:35:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=deltatee.com header.i=@deltatee.com header.b="cU4+yxkJ";
	dkim-atps=neutral
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0D5710E49B
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 20:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
 MIME-Version:Date:Message-ID:content-disposition;
 bh=JzUSZhPWqNWNKTHl/0jMtxGhpz8F8LscUgrhOQUpk4Y=; b=cU4+yxkJdxAeS4yui7R8BmYTUJ
 DRYWdLNFmn4IzYyA8GI4JMvn5I+ao4YCJoKHqHlZBXELhVQOR7+rbnR5az5v/BkfQgJToWwrgHqdK
 bkyzMrds8fKOwiAy9eQt43KyjnGykPEVoAe3We6O105RJ3FqGfgbPe2c3N//eYM+RF2KlpkmplnRX
 ZyFUAT2Yl+gEox2QjrPI7AH2qNf8wELNWJcyEDHIcdGl009phubiaMKzFVqgmjyy33HlREsTWdv3X
 6RaWLz4M8MAKVnPl1dKbctoJ3kYc+JvbGJAMeQtwUQhSvSUPSEtpYv4AZtpLxXiHnJMSl2eirkvTa
 pSPZ8pZQ==;
Received: from [104.157.31.28] (helo=[192.168.1.251])
 by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.98.2)
 (envelope-from <logang@deltatee.com>) id 1wfO8O-000000071tG-1qho;
 Thu, 02 Jul 2026 14:35:45 -0600
Message-ID: <1cd1b832-082c-4f9c-ab68-706110ddcb25@deltatee.com>
Date: Thu, 2 Jul 2026 14:34:25 -0600
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
 <26f74cf0-8892-4672-b0e1-1f1a385c42bb@deltatee.com>
 <aecbbc66-c154-4439-a6ae-84dc012b0f8d@ozlabs.org>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <aecbbc66-c154-4439-a6ae-84dc012b0f8d@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
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



On 2026-07-02 10:44 a.m., Matt Evans wrote:
>> So maybe at this point it's fine to enable this on 32bit systems and we
>> can remove this requirement. However, I think we should do that
>> explicitly in its own patch, not hide it in this refactoring patch.
> 
> Your question does prove it's too stealthy as-is. :)  PCI_P2PDMA still
> can't be enabled on 32-bit systems because of its ZONE_DEVICE -> 
> MEMORY_HOTPLUG -> 64BIT dependency.  So we're not enabling 32-bit 
> support for PCI_P2PDMA here, but it's not obvious and so I'll re-add the 
> `depends on 64BIT`.  At least then it won't be enabled without intention 
> if someone enables ZONE_DEVICE on 32-bit systems...

Ok, that all makes sense to me. I would be good with removing the 64BIT
dependency (as it is is a bit confusing as is) but I think adding
another patch would be appropriate with some of the commit message notes
you mentioned in your emails.

Besides that, I think you can add to this patch:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan
