Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889E2CA6004
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2A5110E6AF;
	Wed,  7 Oct 2026 20:40:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bEztegUJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE3CF10E6AF
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 20:40:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C940760A6D;
 Wed,  7 Oct 2026 20:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579791F000FF;
 Wed,  7 Oct 2026 20:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791405646;
 bh=kIL0379uMErOZpka3nNnDXupdVWzslK/iRT392K2mcA=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=bEztegUJ/jb06V3m54mJa5QV70JRbLqwFFy/J1Am+YZAcn2k7in4nR26lMmiRI5Zq
 gG2wK3B4Ut42R5EN3wVjxX/fcf6oV9bcGWAd0UzcnHiYL3nD+5e6NHL9xz4oH47LNN
 Amt3mcBaOCVozGi6JgNqVVIu3IIWUbB2TKF0tKCz40Bi/GdfVIaRbFKjUlc/BxZFDY
 WPCMCm9f14u2jUPtmeEPJFGtg4nS7N0xxRnnPMBCozMnEqFWoha81lPtWKP9R1qv6w
 BlyxrtR1QIIKC3szXlEwBb6e7+Czdrq2weWjI3H+CvK3+nTIt3GZAp4Tm/WyyeO9B6
 Rekr3PkxtSULw==
Date: Wed, 7 Oct 2026 15:40:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
 Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v9 02/18] PCI/P2PDMA: Derive routing from directional ACS
 controls
Message-ID: <20261007204045.GA783967@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007063227.GC7822@unreal>
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

On Wed, Oct 07, 2026 at 09:32:27AM +0300, Leon Romanovsky wrote:
> On Tue, Oct 06, 2026 at 03:49:47PM -0500, Bjorn Helgaas wrote:
> > On Thu, Oct 01, 2026 at 02:55:10PM +0300, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > pci_bridge_has_acs_redir() treats Request and Completion Redirect as
> > > interchangeable. On asymmetric fabrics, a control for only the reverse TLP
> > > direction can unnecessarily force P2PDMA through the host bridge.
> > 
> > Does "the reverse TLP direction" refer to Completions?
> 
> In general, the P2P code treats TLPs flowing from device A to device B the
> same as TLPs flowing from device B to device A.
> 
> However, in the context of this commit message, yes: completions flow in the
> opposite direction from the device's perspective.

And I guess asymmetric fabrics must mean fabrics where Request
Redirect and Completion Redirect are not set the same way?

> > > Evaluate Request Redirect for client Requests and Completion Redirect for
> > > provider read Completions. Continue treating enabled Egress Control
> > > conservatively as a Request redirect.
> > 
> > Completion Redirect is intended to avoid ordering rule violations
> > between Completions and Requests when Requests are redirected (PCIe
> > r7.0, sec 6.12.1.1).  I assume this patch preserves the ordering rule,
> > but does the commit log need to say something about that?  I don't
> > know enough about P2P DMA for it to be obvious to me.
> 
> I don't think so, i didn't change anything related to ordering.

I don't think there's anything in this whole series that changes any
ACS settings, so I shouldn't have wondered about *preserving* the
ordering rule.

But I asked about ordering because it sounds like this patch expects
to encounter asymmetric fabrics where Request Redirect and Completion
Redirect may not be set the same way, and the spec implies that
asymmetry may result in ordering violations.

> > Not really a question for this series, but p2pdma.c and p2pdma.rst
> > refer to "clients" and "providers", neither of which are mentioned in
> > the PCIe spec.  In this case it sounds like a client is a Requester
> > and a provider is a Completer in spec terms.  Is that always the case?
> > If so, "client" and "provider" in this paragraph are not adding any
> > information.
> > 
> > If "client" is not the same concept as "Requester" and "provider" not
> > the same as "Completer", maybe p2pdma.rst could explain the
> > difference?
> 
> Client vs. provider are actual target vs. initiator. They express the
> device role in the flow.

I'd rather use "Requester" and "Completer" when possible because they
have specific meanings in the PCI spec and they correspond to the ACS
control bits.  Client, provider, target, initiator are all from the
outer world that makes use of PCIe constructs, but they don't mean
anything inside the PCIe world.

Bjorn
