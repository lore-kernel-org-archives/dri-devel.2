Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FF9CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC8BF10E42C;
	Mon, 12 Oct 2026 11:54:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 110D310E42C
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 11:54:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1604960A9F;
 Mon, 12 Oct 2026 11:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE711F0089C;
 Mon, 12 Oct 2026 11:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791806041;
 bh=L5F7alszsmDfB3EkWEEFqNG+2UIF92exyXNav5WLshs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YTjyZQxU5kgwLmeBS5kpBan2T0OOA/aNoilYZZYSeAEqPizzQWLlgzSj77PprWvPs
 goIZjR0RlaxlCm/U92AGxYW8AZF6PBaRLpm/SL2jDzzPXYLvA0jU3La6Rp1KwxQP+m
 FUCkWnCZMEmX/VrB08wLvgUE8BsqSH0+byuJlgyxC0KI7ERRMZUw0yVJbG8i4UtcqW
 1YQrEIhClieQiHct5I46908MxmS0TNkFXwqacorlvdxWI0WVHJiOwXomhx6Jx9wDYg
 MJSnd1gfkZsYPpIiO9tZT15vZuOdPGviwnrV0oHnLuIDFa+pp7VI4/xck3GiUHpmD7
 xt5cmmviCoeow==
Date: Mon, 12 Oct 2026 14:53:57 +0300
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
Subject: Re: [PATCH v9 10/18] PCI/P2PDMA: Route Translated Requests under
 Direct Translated P2P
Message-ID: <20261012115357.GE219304@unreal>
References: <20261001-fix-p2p-acs-v4-0-v9-10-1a8e0f50ddd9@nvidia.com>
 <20261006222845.GA720627@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006222845.GA720627@bhelgaas>
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

On Tue, Oct 06, 2026 at 05:28:45PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 01, 2026 at 02:55:18PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > A Downstream Port with ACS Direct Translated P2P enabled routes a Request
> > whose Address Type is Translated "to the peer Egress Port without
> > redirection, regardless of ACS P2P Request Redirect and ACS P2P Egress
> > Control", per PCIe r7.0 sec 6.12.3. P2PDMA assumes every Request carries an
> > Untranslated address, so it sends an ATS client through the host bridge
> > even where the fabric would route it straight to the peer.
> 
> "sends an ATS client through the host bridge" -- I assume this really
> means "we told the caller that Requests would be routed through the
> host bridge" when in reality they wouldn't?  I don't think this
> actually changes any routing in the fabric, does it?

I'd say it does. Before this patch, we didn't return `bus_address` here nor
took the P2P path.

Thanks

> 
> So essentially we told the caller that P2P between A and B was, e.g.,
> 5 hops when it was really only 2?
> 
> > Add PCI_P2PDMA_TLP_TRANSLATED and consult Direct Translated P2P for the
> > Requests it describes.
> > 
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > Tested-by: Tushar Dave <tdave@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/pci/p2pdma.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> > index 569a74de3b3a..3fd2cb8d16f0 100644
> > --- a/drivers/pci/p2pdma.c
> > +++ b/drivers/pci/p2pdma.c
> > @@ -548,6 +548,15 @@ pci_acs_p2pdma_request(u16 ctrl, unsigned int tlp_flags)
> >  		 */
> >  		if (ctrl & PCI_ACS_TB)
> >  			return PCI_ACS_P2PDMA_BLOCKED;
> > +
> > +		/*
> > +		 * PCIe r7.0 sec 6.12.3: ACS Direct Translated P2P routes a
> > +		 * Request carrying a Translated address to the peer "without
> > +		 * redirection, regardless of ACS P2P Request Redirect and ACS
> > +		 * P2P Egress Control settings".
> > +		 */
> > +		if (ctrl & PCI_ACS_DT)
> > +			return PCI_ACS_P2PDMA_DIRECT;
> >  	}
> >  
> >  	return ctrl & (PCI_ACS_RR | PCI_ACS_EC) ?
> > 
> > -- 
> > 2.55.0
> > 
