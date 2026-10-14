Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156A4CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2301010E06B;
	Wed, 14 Oct 2026 06:47:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 490A910FB4B
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 06:46:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2AE1A60213;
 Wed, 14 Oct 2026 06:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486491F000FF;
 Wed, 14 Oct 2026 06:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791960417;
 bh=j8H0NoEXZnVe8rGJVifKPpZGEuefBe+Pz5xO0QIVr0I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=gFTX6Ntxaax3HpDdnJEqgzvZFPRgjas53WK98vDIqzhm1UPXFlZfgiJLI+UFizKym
 mzRe1ELAzr/6yp6GwQycX4feklE7pujtlHPXnezGoCTQ0GA5E/j6MMTXpRjkEPJCnD
 WAWUvtH+z9KtQaBxwt2Y1dkoUO3thjterApS1b0UpngvYErooh4lTKMtM4zx9VxQ3/
 Hp9pcaMzrbSTogPgKIz5XiWtSNDze4uoyXUHHJtBxzO4isSFFHGOtL1KUtdanEeeBw
 hVWB+3MaPWbukUdvhIJ2jgupe4/cJIk5mtbJ82xxyJ/IQ4YRF2xY2RQubi7/vpLqiP
 iotkrBwrhKqFA==
Date: Wed, 14 Oct 2026 09:46:53 +0300
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org, media-ci@linuxtv.org
Subject: Re: [PATCH v11 09/19] PCI/P2PDMA: Route Relaxed Ordering Completions
 directly
Message-ID: <20261014064653.GT219304@unreal>
References: <20261013-fix-p2p-acs-v4-0-v11-0-72cf8c96e617@nvidia.com>
 <20261013-fix-p2p-acs-v4-0-v11-9-72cf8c96e617@nvidia.com>
 <sashiko-outbox-169923@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-169923@kernel.org>
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

On Tue, Oct 13, 2026 at 02:37:38PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] pci/p2pdma: false positive warning if Relaxed Ordering route succeeds
> --
> 
> commit e6e15dbbdb2b5d6dee258b1197f71025a221015f
> Author: Leon Romanovsky <leon@kernel.org>
> 
> PCI/P2PDMA: Route Relaxed Ordering Completions directly
> 
> ACS P2P Completion Redirect leaves Completions carrying Relaxed Ordering
> alone, per PCIe r7.0 sec 6.12.1.1. A Completion copies that attribute from
> its Request, so a client setting it on Non-Posted Requests need not use the
> host bridge solely because Completion Redirect is enabled.
> 
> Route Completions directly for PCI_P2PDMA_TLP_RELAXED_CPL unless a device
> quirk redirects them or the Completer lacks an internal route to its
> sibling. Neither restriction promises a Relaxed Ordering exception. No
> caller selects these classes yet.
> 
> > diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> > index 9d416329aa4b8..785e4668a2af5 100644
> > --- a/drivers/pci/p2pdma.c
> > +++ b/drivers/pci/p2pdma.c
> > @@ -580,11 +580,15 @@ pci_acs_p2pdma_request(u16 ctrl, unsigned int tlp_flags)
> >  /*
> >   * Decide how a peer-to-peer Completion at an ACS-capable ingress port routes.
> >   * PCIe r7.0 sec 6.12.1.1: no ACS control other than P2P Completion Redirect
> > - * affects a Completion.
> > + * affects a Completion, and that one leaves Completions carrying the Relaxed
> > + * Ordering attribute alone.
> >   */
> >  static enum pci_acs_p2pdma_state
> >  pci_acs_p2pdma_completion(u16 ctrl, unsigned int tlp_flags)
> >  {
> > +	if (tlp_flags & PCI_P2PDMA_TLP_RELAXED_CPL)
> > +		return PCI_ACS_P2PDMA_DIRECT;
> > +
> 
> [Severity: Low]
> Now that Relaxed Ordering completions can route directly while strict ordering
> might still redirect, does this cause a false positive warning in
> calc_map_type_and_dist() in drivers/pci/p2pdma.c?

There are no in-kernel callers that selects RO.

In current code, this flow is impossible.

Thanks
