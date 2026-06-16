Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E883BCD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:18:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93D7F10ECD5;
	Tue, 16 Jun 2026 18:18:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="by1gU48a";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6441910EA66
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 11:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1781610494;
 bh=qE69fQEJl9oZRRpURxmwt3lhJuiBveqs8mE/8tXoWvc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=by1gU48aGo9nqyknUPasVL3O8zwdmOHSX+6iTukXhGM4QwwbgMcmcBwDlt9FVkriL
 pauByJnAOozbCvQg3RBtEUD8n8RMBhTAKH8+sVOTJCrrI9VqYq52pvetzI+uTWTa2L
 tBBCwIb4mNYaVXhyLp2YszevLUpBDgVVwkYjgK7FqckdGH7AYklacjsIcWZtN2b7ns
 flSw3OZpkqy7dYIdGgPtzz8pT2RDWXIOG5Eu69Q6kKayjzEURagu2YcQjFLvLho/6r
 G6QAty/jyShc/7rIKOrNlG5rh8h+XQw5aEdNk5CvO8zMdM2hCXoGoYJFLgUj9F41KM
 kLYr4Gy13vzyQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4gflc75zjFz58bH;
 Tue, 16 Jun 2026 21:48:07 +1000 (AEST)
Message-ID: <20fb245b-2dc3-482a-8c2c-a3a6864a9005@ozlabs.org>
Date: Tue, 16 Jun 2026 12:48:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] vfio/pci: Add a helper to look up PFNs for DMABUFs
Content-Language: en-GB
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Pranjal Shrivastava <praan@google.com>, Alistair Popple
 <apopple@nvidia.com>, "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-3-matt@ozlabs.org>
 <DM6PR11MB369091A6F1E32054A95AB6788C182@DM6PR11MB3690.namprd11.prod.outlook.com>
 <4d75b948-3b74-4970-97f2-72e54f9c9694@ozlabs.org>
 <DM6PR11MB36903B0203CFFF97197676138CE52@DM6PR11MB3690.namprd11.prod.outlook.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <DM6PR11MB36903B0203CFFF97197676138CE52@DM6PR11MB3690.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Jun 2026 18:17:58 +0000
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

Hi Kevin,

On 16/06/2026 10:28, Tian, Kevin wrote:
>> From: Matt Evans <matt@ozlabs.org>
>> Sent: Tuesday, June 16, 2026 2:04 AM
>>
>> On 12/06/2026 09:42, Tian, Kevin wrote:
>>>> From: Matt Evans <matt@ozlabs.org>
>>>> Sent: Wednesday, June 10, 2026 11:43 PM
>>>>
>>>> +int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_buf *priv,
>>>> +			      struct vm_area_struct *vma,
>>>> +			      unsigned long address,
>>>> +			      unsigned int order,
>>>> +			      unsigned long *out_pfn)
>>>> +{
>>>> [...]
>>>> +	 *
>>>> +	 * It's suboptimal if DMABUFs are created with neigbouring
>>> s/neigbouring/neighboring/
>> Ah, not a typo. 🙂  That is en_GB and AFAIK is permitted.
> I guess you meant 'neighbouring' and 'neighboring' are both valid.
> 
> but here lacking a 'h' should be a typo? 🙂

:D Doh!  Sure enough, you're right and that very much _is_ a typo after
all. :)


Thanks,

Matt

