Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0CFCDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 11:08:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D54D310E2E7;
	Tue, 23 Jun 2026 11:08:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="cMqCQd61";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F13D10E2E7
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 11:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1782212926;
 bh=oRLUVj38EuP2J4LoI+n0itLP4n8PZdzZFqOvvhcE7RM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cMqCQd61to2RMTd50gLHX4EQRg3EY1Ev62PA5OfCA0InlQQm+x4R3uC7ywQPH7iUv
 803WdO3/IU3lp8pwyDKc+okPSmbv0MCJLy7CVJqjujc/JG4fdo09YAH9D8KFz30RdZ
 flm1600i9mpfJRzgHwtZ9RI3mQTVnq/jH/dhsUIaVpH9ywYwCjchyZCeVu+o5zgf8i
 do24J3BlR6G4shCvdxS0WOcZH4ac3Ww9YZpZ97O66TTqfP+KYBfgExQzAstlDwsbYy
 eihexuWI6xPt68gtW3rUA1ucdenrQ95aDce/5r0blkPKmwFVzJlx3zKj/KZ6S0mILM
 r/DO6cqLEjvqg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4gl2PJ2QFPz4wCJ;
 Tue, 23 Jun 2026 21:08:35 +1000 (AEST)
Message-ID: <fbb2b1a6-594f-48eb-887f-7cf0cdd4c336@ozlabs.org>
Date: Tue, 23 Jun 2026 12:08:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] vfio/pci: Clean up BAR zap and revocation
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>, Leon Romanovsky <leon@kernel.org>,
 Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-7-matt@ozlabs.org> <aixgZQiBQKgS7yIM@google.com>
 <DM6PR11MB3690489DB5FA611413BF60558CE52@DM6PR11MB3690.namprd11.prod.outlook.com>
 <ajGbRE3WWJxNxcrg@google.com>
 <BYAPR11MB3687AE280241C9E00B46FCF98CE42@BYAPR11MB3687.namprd11.prod.outlook.com>
 <24f34e59-7c3b-4b56-83bf-cb07e3f369a6@ozlabs.org>
 <20260619133116.GB278945@nvidia.com>
 <55ea7422-08d8-4c92-aa59-8ff6f9e9d781@ozlabs.org>
 <20260622171336.7d13f548@shazbot.org>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <20260622171336.7d13f548@shazbot.org>
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

On 23/06/2026 00:13, Alex Williamson wrote:
> On Fri, 19 Jun 2026 16:13:17 +0100
> Matt Evans <matt@ozlabs.org> wrote:
> 
>> Hi Jason,
>>
>> On 19/06/2026 14:31, Jason Gunthorpe wrote:
>>> On Thu, Jun 18, 2026 at 05:02:58PM +0100, Matt Evans wrote:
>>>   
>>>> My understanding is that the sequences above wake a device that happens
>>>> to have previously been put into D3, and AFAICT it could only have got
>>>> there because of a previous vfio_pci_set_power_state().  Seems its only
>>>> caller is from the emulation of PCI_PM_CTRL using
>>>> vfio_lock_and_set_power_state(), and this zaps/revokes BAR access before
>>>> a transition to D3.  Similarly, an attempt to access a BAR via an
>>>> ioctl/through vfio_pci_core_do_io_rw() fails the D3 check in
>>>> __vfio_pci_memory_enabled(), and besides will try to take the memory_lock.  
>>>
>>> I thought the general design was the bars were made inaccessible
>>> before going to a low power state, and remain inaccessible while it is
>>> in low power?
>>>
>>> So the order of D0 doesn't matter. If it is not in D0 then there is no
>>> mappings and zap/revoke is a NOP.
>>>
>>> If is it in D0 then it doesn't matter because D0 is a nop.  
>> Yes, that's what I'm getting at. :)  If it's in D3 then BARs are
>> inaccessible, so as long as we go into D0 before the DMABUF move, the
>> order of the zap relative to the "go to D0" doesn't matter.
> 
> I believe this is correct as well, but importantly we cannot assume
> that a stray read or write just returns -1 or gets dropped.  This is
> exactly why we have such hard protections against the user accessing
> the device while it's disabled.  Not all platforms, even within
> architectures that might otherwise be considered lenient of such
> accesses, consider this benign and might escalate to system level
> faults.

We are in enthusiastic agreement here.

> Let's be careful not to frame this as "the access doesn't matter
> anyway", the answer is instead that non-D0 devices already lack any
> mappings to access the device.  Thanks,

I agree that is not the right thing to say, for exactly that reason.
(For avoidance of any doubt, I didn't say that :) )

Thanks for confirming the behaviour.  I hope Praan and Kevin are
satisfied that this patch doesn't cause the issues they first worried
about (the changed order of the zap relative to the D0 transition
doesn't have a detrimental effect because of the existing inaccessibility).

Alex, I'll post v4 soon, but if you have any comments in the pipeline
please shout and I'll hold off awhile.


Thanks,


Matt

