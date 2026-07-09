Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7447FC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF2A710E6CD;
	Thu,  9 Jul 2026 16:18:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="tWglgtXm";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12EFA10E6CD
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 16:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1783613884;
 bh=OArR/KeoVpNI247WLRI2TAI/hbwe5M9v3yfS72f/EYE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tWglgtXml7pWfbHECxp6rv6+pl7o+Z6pl8u4VKyh8ZZ2F8rVizDEv5FLgaz1ZsN7Z
 rxppfO+k24cGHc1gPzlsY3LGNqJoFRKoYox17ybUVU+RhbrrjwQCEO/xSNnNeeTcPK
 XYU4vK05nZCRVvkpoWsPQd93LGdruEmDya+3aTut0o82rCsaIi7YWNeZODo4qFSWcU
 5/Hk3Un9hUHlxhmvNDUjMYjAIDBICgHjy0Tea/lIvsoB1DrREnpx0nGmgQ7JvSvoMl
 LiZSCSDCanrPhDrI6JqUArQm72BlLoJIH2OZ5fo9nok0p9/2Ft7cQjuQcQWe0ozzuS
 9lEMaOemERv9Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4gx0Vs2Qmmz58fn;
 Fri, 10 Jul 2026 02:17:56 +1000 (AEST)
Message-ID: <e0ccdfd7-2379-44ae-b579-a0da045d7f1b@ozlabs.org>
Date: Thu, 9 Jul 2026 17:17:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Content-Language: en-GB
To: Logan Gunthorpe <logang@deltatee.com>, Alex Williamson
 <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>
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
 <1cd1b832-082c-4f9c-ab68-706110ddcb25@deltatee.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <1cd1b832-082c-4f9c-ab68-706110ddcb25@deltatee.com>
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

Hi Logan,

On 02/07/2026 21:34, Logan Gunthorpe wrote:
> 
> 
> On 2026-07-02 10:44 a.m., Matt Evans wrote:
>>> So maybe at this point it's fine to enable this on 32bit systems and we
>>> can remove this requirement. However, I think we should do that
>>> explicitly in its own patch, not hide it in this refactoring patch.
>>
>> Your question does prove it's too stealthy as-is. :)  PCI_P2PDMA still
>> can't be enabled on 32-bit systems because of its ZONE_DEVICE -> 
>> MEMORY_HOTPLUG -> 64BIT dependency.  So we're not enabling 32-bit 
>> support for PCI_P2PDMA here, but it's not obvious and so I'll re-add the 
>> `depends on 64BIT`.  At least then it won't be enabled without intention 
>> if someone enables ZONE_DEVICE on 32-bit systems...
> 
> Ok, that all makes sense to me. I would be good with removing the 64BIT
> dependency (as it is is a bit confusing as is) but I think adding
> another patch would be appropriate with some of the commit message notes
> you mentioned in your emails.
> 
> Besides that, I think you can add to this patch:
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks for that.  On second reading, just want to check with you:

I'm intending to repost _retaining_ the 64BIT dependency (i.e. revert
its removal) for simplicity's sake.  Then we can follow up separatey
(outside this series) with a cleanup patch to remove 64BIT, explain,
examine other dependencies etc. as you suggest.  Works for you?

(I want to reduce the diff in this series, and revert since this isn't
truly necessary && wasn't entirely obvious.)

Cheers,


Matt

