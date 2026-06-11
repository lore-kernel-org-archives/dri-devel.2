Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080B9CD98DC
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 07:46:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF8C010F2E4;
	Fri, 12 Jun 2026 07:45:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="Os9kV2Gx";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D507D10F09A
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 17:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1781199888;
 bh=bgyx4tuoR1VujLGJebtgmRpeK21Ky1z7/2zTZbfFLxY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Os9kV2GxCX6cgBB+jfIbx4Jk5aYyWKQ5X/ZXH+VDun8JRkKYtFv/ieIvA9GjW9BEP
 oCbiUOIm0Juecvy1as3nTJYV673czVuKakUU/AnOzg1YsHLcYDcCT6wfnXjOb4o5EF
 gGsD9u+TtAD6sXt5Fps0rxVzebnry3bpHhfB/x6aKrUvYTzMNZCxodqLKN4BSGZnoy
 7qlwpEUgQ//8IfsVc+0INo/af9xSHJs4pcUtFr/egZjryoz4iw5WPTWSpoUclLkJ9x
 MLyh0LmyKHrhyNGTv+5AcdgmuuA1QN8TdwwUbruNIB224zwt1Y0N8Pmt5FJFGTti/K
 pXV0X5964ySzw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4gbqlp6VBVz4wJk;
 Fri, 12 Jun 2026 03:44:38 +1000 (AEST)
Message-ID: <d38fc0ed-4e89-4eeb-b32d-06afba3157f6@ozlabs.org>
Date: Thu, 11 Jun 2026 18:44:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Content-Language: en-GB
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Kevin Tian <kevin.tian@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Pranjal Shrivastava <praan@google.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260611160749.GA469670@bhelgaas>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <20260611160749.GA469670@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 12 Jun 2026 07:45:54 +0000
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

Hi Bjorn,

On 11/06/2026 17:07, Bjorn Helgaas wrote:
> On Wed, Jun 10, 2026 at 04:43:15PM +0100, Matt Evans wrote:
>> The P2PDMA code currently provides two features under the same
>> CONFIG_PCI_P2PDMA option:
>>
>>  1.  Locate providers via pcim_p2pdma_provider()
>>  2.  Manage actual P2P DMA
>>
>> Some drivers (such as vfio-pci) depend on 1, without having a hard
>> dependency on 2.
>>
>> A future commit expands the use of DMABUF in vfio-pci for non-P2P
>> scenarios, relying on pcim_p2pdma_provider() always being present.  If
>> that depended on CONFIG_PCI_P2PDMA, it would make vfio-pci only
>> available if CONFIG_ZONE_DEVICE is present (e.g. 64-bit systems), even
>> when P2P is not needed.
>>
>> To resolve this, introduce CONFIG_PCI_P2PDMA_CORE and refactor the
>> basic provider functionality into a new p2pdma_core.c file.  This is
>> available even if the CONFIG_PCI_P2PDMA feature is disabled (or
>> unavailable due to !CONFIG_ZONE_DEVICE).  Then, drivers can enable any
>> additional P2P features with the original CONFIG_PCI_P2PDMA (available
>> when CONFIG_ZONE_DEVICE is set).
>>
>> Signed-off-by: Matt Evans <matt@ozlabs.org>
> 
> I thought this was going to be just a code move and new Kconfig
> option, but it involves a little more than that, e.g., adding
> pci_p2pdma_release_pool() and tweaking the RCU synchronization.
> 
> If possible, it would be nice to do that refactoring in a smaller
> preliminary patch so it's easier to review/bisect/etc and make this
> one a pure code move.

pci_p2pdma_release_pool() is really part of the split, not a functional
change, i.e. factoring the (P2P-only) pool handling out from the rest of
the pci_p2pdma_release() actions still needed for the _CORE case.

I guess .._release() could be split in place in a small patch, and then
moved alongside the rest in a second.

> I guess CONFIG_PCI_P2PDMA_CORE selects just part 1 ("Locate providers
> via pcim_p2pdma_provider()"), right?

Yes, I can reword that last paragraph of the commit message to make this
clearer.

>> +++ b/drivers/pci/p2pdma.h
>> @@ -0,0 +1,29 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * PCI Peer 2 Peer DMA support.
>> + */
>> +
>> +#ifndef _PCI_P2PDMA_H
>> +#define _PCI_P2PDMA_H
>> +
>> +#include <linux/genalloc.h>
>> +#include <linux/pci-p2pdma.h>
>> +#include <linux/xarray.h>
>> +
>> +struct pci_p2pdma {
>> +	struct gen_pool *pool;
>> +	bool p2pmem_published;
>> +	struct xarray map_types;
>> +	struct p2pdma_provider mem[PCI_STD_NUM_BARS];
>> +};
>> +
>> +#ifdef CONFIG_PCI_P2PDMA
>> +void pci_p2pdma_release_pool(struct pci_dev *pdev, struct pci_p2pdma *p2pdma);
>> +#else
>> +static inline void pci_p2pdma_release_pool(struct pci_dev *pdev, struct pci_p2pdma *p2pdma)
> 
> Wrap to fit in 80 columns like the rest of drivers/pci/

Fixed.

>> +{
>> +}
>> +#endif
>> +
>> +#endif
>> +
> 
> Spurious blank line at end.

Doh, fixed.

>> +++ b/drivers/pci/p2pdma_core.c
>> @@ -0,0 +1,118 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * PCI Peer 2 Peer DMA support core, providing a bare-bones
> 
> In this English text, I think I would spell out "Peer to Peer" instead
> of relying on the "2" homophone.  Same in p2pdma.h.

I would've preferred that too, it isn't correct; I was seeking to keep
the blurb here (and in p2pdma.h) as close to the original p2pdma.c as
possible.  I'll correct it in the new files (hyphenated "peer-to-peer"
in PCI-SIG language).


Thanks,


Matt

