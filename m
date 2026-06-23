Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588CBCD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 17:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B10CB10EC2E;
	Tue, 23 Jun 2026 17:47:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="Kki45cJZ";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C7C710EC2E
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 17:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1782236848;
 bh=YnpLj85EVGFLS082aT9C1I8KDlkyXpsPGbTho/uxSLo=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=Kki45cJZWsx9YAZgIjFlNXBh4gxmehNd4vPdhDGqbXNckYAUWcNK5NrOjxPnNhA0I
 QtvyyFV0Eoh8ZNWJ7aIXyTto6helylau76gRUqZWbHqMWu67oqEojo8vwKq+EsHq6N
 qCqcCGyNAYXq6mJLW+VOFY+Z41U9sdcsKlCkoZYyHf6ZwhMlYFnVbTEvkDeIp8eWCU
 l96EoKWxeFlRbsj1l3UQV2fwAJuTACjiUyG5IG6lkYNHFMY9/TH/nv4V27mR0Ii/oD
 g4Jpo55fotZNFVbkMuFlvwAb3414y7QDk/0X40yG4cgrli+myDrMBQmXrhUoGuIT0C
 y7iLzj3Cuv5fA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4glCFN67bcz4wB7;
 Wed, 24 Jun 2026 03:47:20 +1000 (AEST)
Message-ID: <feaefa41-9f67-4d4f-a3e0-282dca41f3eb@ozlabs.org>
Date: Tue, 23 Jun 2026 18:47:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Content-Language: en-GB
From: Matt Evans <matt@ozlabs.org>
To: Robin Murphy <robin.murphy@arm.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>
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
 <81a9d212-996e-42e1-aabf-b120a13e94c3@arm.com>
 <88a9ebaa-8637-4290-b299-acae0e3065f8@ozlabs.org>
In-Reply-To: <88a9ebaa-8637-4290-b299-acae0e3065f8@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Robin, me,

On 23/06/2026 16:59, Matt Evans wrote:
> Heya Robin,
> 
> On 23/06/2026 16:48, Robin Murphy wrote:
>> On 12/06/2026 3:31 pm, Matt Evans wrote:
>>> Hi Kevin, Pranjal, (+Robin, hi!)
>>
>> Oh hey there! :)
>>
>>> On 12/06/2026 04:39, Tian, Kevin wrote:
>>>>> From: Pranjal Shrivastava <praan@google.com>
>>>>> Sent: Friday, June 12, 2026 2:38 AM
>>>>>
>>>>> On Wed, Jun 10, 2026 at 04:43:15PM +0100, Matt Evans wrote:
>>>>>> --- a/drivers/pci/Kconfig
>>>>>> +++ b/drivers/pci/Kconfig
>>>>>> @@ -206,11 +206,7 @@ config PCIE_TPH
>>>>>>   config PCI_P2PDMA
>>>>>>       bool "PCI peer-to-peer transfer support"
>>>>>>       depends on ZONE_DEVICE
>>>>>> -    #
>>>>>> -    # The need for the scatterlist DMA bus address flag means PCI
>>>>> P2PDMA
>>>>>> -    # requires 64bit
>>>>>> -    #
>>>>>> -    depends on 64BIT
>>>>>> +    select PCI_P2PDMA_CORE
>>>>>>       select GENERIC_ALLOCATOR
>>>>>>       select NEED_SG_DMA_FLAGS
>>>>>>       help
>>>>>
>>>>> Nit: Did we drop depends on 64BIT intentionally here? I guess the full
>>>>> PCI_P2PDMA stack still selects NEED_SG_DMA_FLAGS? IIRC,
>>>>> NEED_SG_DMA_FLAGS doesn't select 64BIT?
>>>>
>>>> seems that comment is stale. According to the commit msg:
>>>>
>>>> " it would make vfio-pci only available if CONFIG_ZONE_DEVICE is
>>>> present (e.g. 64-bit systems), "
>>>>
>>>> so it sounds a redundant dependency hence is removed.
>>>
>>> This was intentional.  In practice there is still a dependency on 64BIT
>>> for PCI_P2PDMA, but it is because of ZONE_DEVICE (and mem hotplug).  The
>>> key need is PCI_P2PDMA_CORE is available on !64BIT for VFIO, but I
>>> didn't see a requirement from PCI_P2PDMA itself (as opposed to its
>>> dependencies).  If I've missed one, I can put it back...
>>>
>>> But NEED_SG_DMA_FLAGS doesn't smell quite right; I see from comments in
>>>
>>>    af2880ec44021 ("scatterlist: add dedicated config for DMA flags")
>>>
>>> that it assumes 64BIT, but it seems to be missing a "depends on 64BIT".
>>>
>>> Robin -- should that depend on 64BIT?
>>
>> Indeed, looking at the history it seems like that was overlooked, but it
>> worked out at the time since the only selector of NEED_SG_DMA_FLAGS was
>> PCI_P2PDMA as you say. If we're now generalising then moving the
>> explicit 64BIT dependency to NEED_SG_DMA_FLAGS itself sounds like the
>> right thing to do.
> 
> Cheers for confirming.  I'll send a patch separate to this series (since
> the deps work out OK for PCI_P2PDMA for the reasons mentioned).

I think we were wrong, NEED_SG_DMA_FLAGS doesn't _need_ 64BIT.

Other than P2PDMA, the other consumer of NEED_SG_DMA_FLAGS is IOMMU_DMA,
and turns out if one builds an i386 kernel with INTEL_IOMMU (or some
other configs, like Xen) then NEED_SG_DMA_FLAGS is enabled on 32-bit
builds too.

The scatterlist.h comments af2880ec44021 touched are just saying that
_since_ P2PDMA depends on 64BIT, there _is_ circumstantial padding so
let's use it for flags.  It doesn't require 64BIT.

For example struct scatterlist isn't pushed over some special (e.g.
power-of-two) size when NEED_SG_DMA_FLAGS is enabled on 32-bit; I can't
find a reason it should be prevented on 32-bit builds (and found cases
above in which it is already enabled in them).

So I won't change the NEED_SG_DMA_FLAGS dependencies after all.  Sorry
for the noise -- as ever if I've missed something do please explain.

(I'll continue with removing the P2PDMA dependency on 64BIT because it
seems P2PDMA's dependencies rely on 64BIT, though P2PDMA itself doesn't.)

Thanks,


Matt
