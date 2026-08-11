Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550A0C5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 15:59:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEC1310ECAE;
	Tue, 11 Aug 2026 15:59:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="oYtFUSh9";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4CD110EC9D
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 15:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1786463939;
 bh=w2QH4sAWrGs+qGmjMe6f4fRXH0fwoJH3v8g792kcikI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=oYtFUSh98nkPETDOM+fvRJ5xc3OYCXwPMqlxjLprkqpxbAdV2TdqS1eCP9l3nHa4A
 aXe6errSeEVv1iamPg66CeyPSS4/exUN/enyoT+kKw7UHX7C+YJJIX4qRljR4Fu03G
 gSq5mykH/Eef/DHUPuKmXoZg7d3WVmXe1NhVOheKMObXcgs+aap1m4O3DfhvlnNxz1
 Tag5ujnt6PnTPIaMgckFgp12v2lhro4oyiO4jZsxp4pQWrJb0srmEu1yP+bQozRbKC
 hMOZy9FOIxzSVYkPcPtGNtajl8kUTAskCrNZUydWXydhQbID4+dSMmYGPaaNrFVO9Y
 hO1uWDahbsQWQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4hKGWX4HM7z4w2b;
 Wed, 12 Aug 2026 01:58:47 +1000 (AEST)
Message-ID: <291625a2-f281-4c05-b51f-553018a34b08@ozlabs.org>
Date: Tue, 11 Aug 2026 16:58:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] vfio/pci: Clean up BAR zap and revocation
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>, Longfang Liu
 <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-8-matt@ozlabs.org>
 <20260729115204.2a9a50b2@shazbot.org>
 <6a964960-722c-44b5-837d-9d582aeb0a3c@ozlabs.org>
 <20260804141022.71b6429d@shazbot.org>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <20260804141022.71b6429d@shazbot.org>
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

Hi Alex,

On 04/08/2026 21:10, Alex Williamson wrote:
> On Thu, 30 Jul 2026 15:47:13 +0100
> Matt Evans <matt@ozlabs.org> wrote:
> 
>> Hi Alex,
>>
>> On 29/07/2026 18:52, Alex Williamson wrote:
>>> On Wed, 15 Jul 2026 18:47:30 +0100
>>> Matt Evans <matt@ozlabs.org> wrote:  
>>>> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
>>>> index 9a1674c152aa..e2b4252e7c3f 100644
>>>> --- a/include/linux/vfio_pci_core.h
>>>> +++ b/include/linux/vfio_pci_core.h
>>>> @@ -134,6 +134,7 @@ struct vfio_pci_core_device {
>>>>  	bool			pm_intx_masked;
>>>>  	bool			pm_runtime_engaged;
>>>>  	bool			sriov_active;
>>>> +	bool			zap_bars_on_revoke;
>>>>  	struct pci_saved_state	*pci_saved_state;
>>>>  	struct pci_saved_state	*pm_save;
>>>>  	int			ioeventfds_nr;  
>>>
>>> This should be in the bitfield usage group since it's only modified at
>>> init time.  
>>
>> This was intentional, but happy to change it if you're certain ofc.  Is
>> it inconceivable that a sub-driver could set it after init?  I'd say
>> they _shouldn't_, but only review will stop them and this placement
>> intended to be cautious.  It seemed a low cost way to avoid issues
>> around synchronisation on the bitfield.
> 
> I'd agree with the statement that they shouldn't, it would be difficult
> to synchronize setting the flag once there are any active mappings of
> the BARs.  Also, if we put it in the bitfield category under the
> comment that the value is only modified at setup/release, it documents
> the intentions, hopefully to the extent the author or reviewers notice.
> An argument can always be made to change it if there's a worthwhile use
> case.  Thanks,

(Having noticed in moving this to the bitfield; my previous reply didn't
supply the real reason it wasn't in the bitfield.)

Isn't the init-time 'event horizon' for writing the bitfield the
vfio_register_group_dev() in vfio_pci_core_register_device(), after
which synchronisation is needed?

The hisi_acc_vfio_pci driver's .probe calls
vfio_pci_core_register_device() and _after that_ sets
zap_bars_on_revoke, and that's now in the "needs synchronisation to
write the bitfield" phase.

(Re-reading my comment in vfio_pci_core_register_device() I'd noted
this, "Drivers can opt out after registration".  Has to be done after by
definition as the default's set in vfio_pci_core_register_device().)

The concern is just blatting neighbours in the bitfield, not the window
of time before the flag's set.  The flag's an opt-out of a safe but (for
this driver) unnecessary zap, so having it unset for a short time is OK.

I still think this really should be a standalone bool, not a bit in the
bitfield.  It has to be set after registration and having to take a lock
to do that has downsides.

Thanks,


Matt

