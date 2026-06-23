Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CF5CDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 15:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56E1A10E7CA;
	Tue, 23 Jun 2026 15:48:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Bo+JWdlj";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id EB36110E7CA
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 15:48:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D130016F8;
 Tue, 23 Jun 2026 08:48:08 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDC803F62B;
 Tue, 23 Jun 2026 08:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782229693; bh=NJqkEZcWa1A5YciYaSbIuAPL/MnbLkuiSpwUoNgaw8A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Bo+JWdlj2ADWTVgzFv+6PqCl48iOPpg92u2k+0c2TeJ3N/RurCTpn86f1qiS/jSsR
 63I52Za56NNbj3HMlm9X7FzRlLcP42vWhhLC7JrK3xQqxot8x772iEorlLECXDJgNp
 W2rPKXAW7W9lWYjrw/Dk3RKu7VEAkBmxVWDXoxGg=
Message-ID: <81a9d212-996e-42e1-aabf-b120a13e94c3@arm.com>
Date: Tue, 23 Jun 2026 16:48:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
To: Matt Evans <matt@ozlabs.org>, "Tian, Kevin" <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-2-matt@ozlabs.org> <aisAc1HRn2Wa4F9p@google.com>
 <DM6PR11MB36904ED2E1D2C646644F67668C182@DM6PR11MB3690.namprd11.prod.outlook.com>
 <0dfadf98-a904-4e6a-b078-5caf27bc7922@ozlabs.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <0dfadf98-a904-4e6a-b078-5caf27bc7922@ozlabs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 12/06/2026 3:31 pm, Matt Evans wrote:
> Hi Kevin, Pranjal, (+Robin, hi!)

Oh hey there! :)

> On 12/06/2026 04:39, Tian, Kevin wrote:
>>> From: Pranjal Shrivastava <praan@google.com>
>>> Sent: Friday, June 12, 2026 2:38 AM
>>>
>>> On Wed, Jun 10, 2026 at 04:43:15PM +0100, Matt Evans wrote:
>>>> --- a/drivers/pci/Kconfig
>>>> +++ b/drivers/pci/Kconfig
>>>> @@ -206,11 +206,7 @@ config PCIE_TPH
>>>>   config PCI_P2PDMA
>>>>   	bool "PCI peer-to-peer transfer support"
>>>>   	depends on ZONE_DEVICE
>>>> -	#
>>>> -	# The need for the scatterlist DMA bus address flag means PCI
>>> P2PDMA
>>>> -	# requires 64bit
>>>> -	#
>>>> -	depends on 64BIT
>>>> +	select PCI_P2PDMA_CORE
>>>>   	select GENERIC_ALLOCATOR
>>>>   	select NEED_SG_DMA_FLAGS
>>>>   	help
>>>
>>> Nit: Did we drop depends on 64BIT intentionally here? I guess the full
>>> PCI_P2PDMA stack still selects NEED_SG_DMA_FLAGS? IIRC,
>>> NEED_SG_DMA_FLAGS doesn't select 64BIT?
>>
>> seems that comment is stale. According to the commit msg:
>>
>> " it would make vfio-pci only available if CONFIG_ZONE_DEVICE is
>> present (e.g. 64-bit systems), "
>>
>> so it sounds a redundant dependency hence is removed.
> 
> This was intentional.  In practice there is still a dependency on 64BIT
> for PCI_P2PDMA, but it is because of ZONE_DEVICE (and mem hotplug).  The
> key need is PCI_P2PDMA_CORE is available on !64BIT for VFIO, but I
> didn't see a requirement from PCI_P2PDMA itself (as opposed to its
> dependencies).  If I've missed one, I can put it back...
> 
> But NEED_SG_DMA_FLAGS doesn't smell quite right; I see from comments in
> 
>    af2880ec44021 ("scatterlist: add dedicated config for DMA flags")
> 
> that it assumes 64BIT, but it seems to be missing a "depends on 64BIT".
> 
> Robin -- should that depend on 64BIT?

Indeed, looking at the history it seems like that was overlooked, but it 
worked out at the time since the only selector of NEED_SG_DMA_FLAGS was 
PCI_P2PDMA as you say. If we're now generalising then moving the 
explicit 64BIT dependency to NEED_SG_DMA_FLAGS itself sounds like the 
right thing to do.

Cheers,
Robin.
