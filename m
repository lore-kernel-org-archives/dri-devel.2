Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EE4606A327
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=X4lGo9CE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B73510F660;
	Tue, 20 Oct 2026 15:56:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id A507C10EBFF
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 15:55:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB36916F8;
 Tue, 20 Oct 2026 08:55:50 -0700 (PDT)
Received: from [10.0.137.15] (XHFQ2J9959-5.cambridge.arm.com [10.0.137.15])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16E3D3F7B4;
 Tue, 20 Oct 2026 08:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792511754; bh=RA7wOkYKzBDqak619Rsj+v/XerrUB1e1xwduoqIgrN8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=X4lGo9CEziSLBpzJ/wESFC5gv5b77FuUDrR0qNwD8V1L1mSKpYmzGUiAukpnL80d8
 P11iPoiXfYQuXADVOOxE6uyuYgs13RlDvy1BObGmrYbA1li5ZIbGLrEXmg2JIdJMIw
 rykl0k838v9Jemvp9bv+0a2Q8qDWplu00g6B3roE=
Message-ID: <3f49b39e-139f-45da-b646-dbb240b31776@arm.com>
Date: Tue, 20 Oct 2026 16:55:49 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 12/15] vfio: Support VFIO devices that access the
 CPU MMU
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jean-Philippe Brucker <jpb@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, kvm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
References: <20261015142552.4128028-1-ryan.roberts@arm.com>
 <20261015142552.4128028-13-ryan.roberts@arm.com>
 <20261015164421.GD13920@nvidia.com>
 <95e0f9bd-0203-4c7a-9d09-622593bb3d4c@arm.com>
 <20261020140944.GA3008132@nvidia.com>
 <c367caf3-d462-42ea-b482-bf9c51c47a63@arm.com>
 <20261020091323.3c51258e@shazbot.org>
From: Ryan Roberts <ryan.roberts@arm.com>
Content-Language: en-GB
In-Reply-To: <20261020091323.3c51258e@shazbot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20/10/2026 16:13, Alex Williamson wrote:
> On Tue, 20 Oct 2026 16:06:37 +0100
> Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
>> On 20/10/2026 15:09, Jason Gunthorpe wrote:
>>> On Tue, Oct 20, 2026 at 12:51:26PM +0100, Ryan Roberts wrote:  
>>>>> However.. you still have to affirm which single mm is the mm that the
>>>>> device is going to be doing DMA against. The process the opens the fd
>>>>> should not be forced to be the mm that it gets linked to.  
>>>>
>>>> What is the mm representing here? Ultimately we want to install the KVM
>>>> instance's stage2 pgtables and (pinned) VMID. We currently get that via the
>>>> bound KVM instance (which looks like it still works using the cdev interface?)
>>>>
>>>> The guest will then install the stage1 pgtables and (pinned) ASID associated
>>>> with the relevant (guest) mm_struct.
>>>>
>>>> Do we _need_ an mm association in the host?  
>>>
>>> Ah.. I see, I didn't quite follow that. OK.. Ah everyone else doing
>>> this is using iommufd with a viommu to establish their connection
>>> between device an KVM. eg Jacob Pan's series. That's a probably a
>>> better idea to stay aligned with the common path. Though your reasons
>>> are a little different..  
>>
>> Just to check, you're referring to [1]?
>>
>> I was under the impression that I could open the VFIO device through the cdev
>> interface, then bind it to the KVM instance via KVM_DEV_VFIO_FILE_ADD... Why do
>> I need an iommufd at all?
> 
> The cdev is not unlocked to actually access the device until it's bound
> to iommufd.  Thanks,

Ahh - got it! Thanks!

> 
> Alex

