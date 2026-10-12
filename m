Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1103CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24B0C10E374;
	Mon, 12 Oct 2026 10:57:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD44310E57A
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 10:57:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 865B2601FE;
 Mon, 12 Oct 2026 10:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758B41F0089B;
 Mon, 12 Oct 2026 10:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791802635;
 bh=xbC+yf7W/9NgxGXA244OT/ptq9frA+41G9nWB1s/IoE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Ww/TM8pWebbCbnXF049H+rr5GcvdFwXDLefJVHvquehv7bwCLS/7dsU0TF1GAQprI
 kmiiNk3wePjVKitVm/2wqe197cD5bjwFPdUYRAU0uF+4MjEE6xXnVdOtI+sJbSATqU
 /C3h/1fbIAo+n9oQyWo7GBNM7AjgcRJ8cInlz/0OjhJ6H56qbu9/ypRlanmOgv8nXe
 OWFb6JuIa8226F5DYNHSHKcSrbpm/PZSWWwOLPdsqyDnQtywvzGe+0KGu9YmjWuNSF
 jSslVmt2y4vuW7csg5UndDYBd4bih4gOYdg/sIHzpcsx0nXuK46DBipQkgS2kTxkPr
 CREpK16ec3WLQ==
Date: Mon, 12 Oct 2026 13:57:10 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
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
Subject: Re: [PATCH v9 08/18] PCI/P2PDMA: Route Relaxed Ordering Completions
 directly
Message-ID: <20261012105710.GC219304@unreal>
References: <20261001-fix-p2p-acs-v4-0-v9-8-1a8e0f50ddd9@nvidia.com>
 <20261006222109.GA719055@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006222109.GA719055@bhelgaas>
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

On Tue, Oct 06, 2026 at 05:21:09PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 01, 2026 at 02:55:16PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > ACS P2P Completion Redirect leaves Completions carrying the Relaxed
> > Ordering attribute alone. PCIe r7.0 sec 6.12.1.1 redirects only those "that
> > do not have the Relaxed Ordering Attribute bit set", and sec 7.7.12.5
> > describes the enable bit as "applicable only to Completions whose Relaxed
> > Ordering Attribute is clear". P2PDMA reports one answer for every kind of
> > TLP, so a client whose provider returns such Completions is sent through
> > the host bridge for a redirect that never happens to it.
> 
> I guess pci_acs_p2pdma_completion() returned PCI_ACS_P2PDMA_REDIRECT
> even for RO Completions?  But that didn't change the hardware
> behavior -- maybe the caller *thought* Completions were routed through
> the host bridge, but they actually weren't.
> 
> I kind of lost the plot here.  What does the caller do with this
> information?  I don't think a device is *required* to set RO even when
> it is enabled, and it may set RO on some transactions but not others.

The mlx5 patch, which is currently on hold, uses the
PCI_P2PDMA_TLP_RELAXED_CPL TLP flag to dynamically enable or
disable ATS.

https://lore.kernel.org/all/20260920-fix-p2p-acs-v4-0-v7-19-ca0828ab697c@nvidia.com/

Thanks

> 
> > Add enum pci_p2pdma_tlp_flags and let a caller state that property.
> > 
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > Tested-by: Tushar Dave <tdave@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/pci/p2pdma.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> > index 43e225cc5735..1fadef6d0609 100644
> > --- a/drivers/pci/p2pdma.c
> > +++ b/drivers/pci/p2pdma.c
> > @@ -544,11 +544,15 @@ pci_acs_p2pdma_request(u16 ctrl, unsigned int tlp_flags)
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
> >  	return ctrl & PCI_ACS_CR ? PCI_ACS_P2PDMA_REDIRECT :
> >  				   PCI_ACS_P2PDMA_DIRECT;
> >  }
> > 
> > -- 
> > 2.55.0
> > 
