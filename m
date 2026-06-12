Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC08DCD98D2
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 15:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E18110E0C6;
	Sun, 14 Jun 2026 15:44:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="EOwLg45D";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03CB910F54F
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 14:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1781274721;
 bh=oYg/1sibtgFfC9/h6xF284nz/nnSd5DreUIEPAixkoI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EOwLg45DKjx6iDaghDYk9kK4wwjCVOjCkcg4exJJahYAnqK8izc/mcAILa15V1Lw+
 WZvY5lJJPBAuzY0sfq6YxCSuit092SWgMIATHqOj8MQvDZYd9grb5T+2Y4kgT27Xqq
 4WTUNvtPu/f8LO0RtR4DSWesenP11MoRP5ideV8DmBKUmPJid3QS6nttKavPg4/3jW
 nhJ0zA+9NVczIGTE9zDZ0/wp+ntipstalerasNPLL8tfLvg2Rx46Oad+JjtpviFiif
 6JmXWN7efNklF145UDNG7QB9DrJCcpGL+9n6y1jSIMMz9cgSmLZF0Sgm4vVDj8p+QG
 CSy5Imknap0HA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4gcMQx0gWPz58ld;
 Sat, 13 Jun 2026 00:31:52 +1000 (AEST)
Message-ID: <0dfadf98-a904-4e6a-b078-5caf27bc7922@ozlabs.org>
Date: Fri, 12 Jun 2026 15:31:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Content-Language: en-GB
To: "Tian, Kevin" <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>, Robin Murphy <robin.murphy@arm.com>
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
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <DM6PR11MB36904ED2E1D2C646644F67668C182@DM6PR11MB3690.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 14 Jun 2026 15:44:15 +0000
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

Hi Kevin, Pranjal, (+Robin, hi!)

On 12/06/2026 04:39, Tian, Kevin wrote:
>> From: Pranjal Shrivastava <praan@google.com>
>> Sent: Friday, June 12, 2026 2:38 AM
>>
>> On Wed, Jun 10, 2026 at 04:43:15PM +0100, Matt Evans wrote:
>>> --- a/drivers/pci/Kconfig
>>> +++ b/drivers/pci/Kconfig
>>> @@ -206,11 +206,7 @@ config PCIE_TPH
>>>  config PCI_P2PDMA
>>>  	bool "PCI peer-to-peer transfer support"
>>>  	depends on ZONE_DEVICE
>>> -	#
>>> -	# The need for the scatterlist DMA bus address flag means PCI
>> P2PDMA
>>> -	# requires 64bit
>>> -	#
>>> -	depends on 64BIT
>>> +	select PCI_P2PDMA_CORE
>>>  	select GENERIC_ALLOCATOR
>>>  	select NEED_SG_DMA_FLAGS
>>>  	help
>>
>> Nit: Did we drop depends on 64BIT intentionally here? I guess the full
>> PCI_P2PDMA stack still selects NEED_SG_DMA_FLAGS? IIRC,
>> NEED_SG_DMA_FLAGS doesn't select 64BIT?
> 
> seems that comment is stale. According to the commit msg:
> 
> " it would make vfio-pci only available if CONFIG_ZONE_DEVICE is
> present (e.g. 64-bit systems), "
> 
> so it sounds a redundant dependency hence is removed.

This was intentional.  In practice there is still a dependency on 64BIT
for PCI_P2PDMA, but it is because of ZONE_DEVICE (and mem hotplug).  The
key need is PCI_P2PDMA_CORE is available on !64BIT for VFIO, but I
didn't see a requirement from PCI_P2PDMA itself (as opposed to its
dependencies).  If I've missed one, I can put it back...

But NEED_SG_DMA_FLAGS doesn't smell quite right; I see from comments in

  af2880ec44021 ("scatterlist: add dedicated config for DMA flags")

that it assumes 64BIT, but it seems to be missing a "depends on 64BIT".

Robin -- should that depend on 64BIT?


Cheers,


Matt


