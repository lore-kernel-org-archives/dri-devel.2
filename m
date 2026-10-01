Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66584CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6F8010F676;
	Thu,  1 Oct 2026 12:59:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JIF/B0EW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BC4210F676
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 12:59:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B41DA409EB;
 Thu,  1 Oct 2026 12:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB11F1F000FF;
 Thu,  1 Oct 2026 12:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790859589;
 bh=mWEhNC2bx28+yRg0dPmgwrk6vKK8w5OBcpeNy+gKRH4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=JIF/B0EWXJ0MDjxeLJZ7yO1RQlpIaMdKbKKNsSXNWszWPJ3PBB4IoBEyGD5DARCr6
 EghD/+7Ha3UjceHW9Y7A7cvC/XxmnNWI28uTVunnCjnAZhrBDv5jL1BQBGa3yejDd9
 8JtJ9TQEwE9J8Epe8QYSKPF+/imypf3aX6Ku8z3ojDryet26BK6wy/1B+aVsbYEP8A
 bCyy3I8sdeW1g+eTaXFkbJPLdBLEP9UbiViiSkgnH4LRiYzLb6taZ99aGK9yoG235C
 WMk4EwMOCwp9Tvw37ZZdHse/DBW/9OckkefvsDEBIG7Q+OIcogIXov6gHrykqeG8MO
 4GyhjSqX2XKAg==
Date: Thu, 1 Oct 2026 15:59:44 +0300
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 media-ci@linuxtv.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v9 16/18] PCI/P2PDMA: Let a client declare that it
 selects ATS per mapping
Message-ID: <20261001125944.GM3401365@unreal>
References: <20261001-fix-p2p-acs-v4-0-v9-0-1a8e0f50ddd9@nvidia.com>
 <20261001-fix-p2p-acs-v4-0-v9-16-1a8e0f50ddd9@nvidia.com>
 <20261001120807.8723F1F000FF@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261001120807.8723F1F000FF@smtp.kernel.org>
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

On Thu, Oct 01, 2026 at 12:08:07PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] pci/p2pdma: pure clients cannot set ats_per_mapping because pdev->p2pdma is NULL
> --
> 
> commit f332086fc4a4273d099c81fafb33298021d47d1a
> Author: Leon Romanovsky <leon@kernel.org>
> 
> PCI/P2PDMA: Let a client declare that it selects ATS per mapping
> 
> The PCIe ATS Enable bit covers the whole device, so P2PDMA cannot tell
> from it whether a client will translate a given address. Most devices
> translate any address once ATS is enabled, but some choose ATS per DMA
> mapping and can still use bus addresses for the rest.
> 
> Add pcim_p2pdma_set_ats_per_mapping() so the driver of such a device can
> declare that before P2PDMA starts treating clients with ATS enabled as
> translating everything.
> 
> > diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> > index cf190bd572d4a..6a63901c65fb6 100644
> > --- a/drivers/pci/p2pdma.c
> > +++ b/drivers/pci/p2pdma.c
> 
> [ ... ]
> 
> > @@ -1562,6 +1563,32 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
> >  
> > +/**
> > + * pcim_p2pdma_set_ats_per_mapping - Declare per-mapping ATS for a client
> > + * @pdev: PCI device that initiates peer-to-peer DMA
> > + *
> > + * Declare that @pdev issues Translated Requests only for the DMA mappings its
> > + * driver sets up to use ATS, rather than for any address once ATS is enabled.
> > + * P2PDMA then routes this client's Requests with the Address Type each query
> > + * asks about, rather than the one its ATS Enable bit implies.
> > + */
> > +void pcim_p2pdma_set_ats_per_mapping(struct pci_dev *pdev)
> > +{
> > +	struct pci_p2pdma *p2p;
> > +
> > +	p2p = rcu_dereference_protected(pdev->p2pdma, 1);
> > +	if (!p2p)
> > +		/*
> > +		 * ats_per_mapping is a performance optimization,
> > +		 * if pcim_p2pdma_init() didn't set pdev->p2pdma pointer
> > +		 * for some reason, let's simply use ATS global settings.
> > +		 */
> > +		return;
> 
> [Severity: Medium]
> Will this silently fail for pure P2PDMA clients?
> 
> It looks like pdev->p2pdma is only allocated when a device registers as a
> P2P memory provider via pcim_p2pdma_init():

Yes, this is exactly for them and no one else.

Thanks

> 
> drivers/pci/p2pdma.c:pcim_p2pdma_init() {
> 	...
> 	p2p = devm_kzalloc(&pdev->dev, sizeof(*p2p), GFP_KERNEL);
> 	...
> }
> 
> If a driver for a pure P2PDMA client (e.g., an NVMe initiator without CMB)
> calls pcim_p2pdma_set_ats_per_mapping() to declare its ATS behavior, won't
> pdev->p2pdma be NULL since it never called pcim_p2pdma_init()?

Only RDMA NICs support that per-mapping thing.

Thanks

> 
> If so, wouldn't this cause the client to silently fall back to suboptimal
> global ATS routing, as it can never successfully set the ats_per_mapping flag?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261001-fix-p2p-acs-v4-0-v9-0-1a8e0f50ddd9@nvidia.com?part=16
