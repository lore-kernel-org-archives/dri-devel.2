Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA5D606A8AE
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Al8XrrSs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9826E10E4C4;
	Thu, 12 Nov 2026 09:23:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20C9410E4C4
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 09:23:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1762C61827;
 Thu, 12 Nov 2026 09:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11CC1F00A05;
 Thu, 12 Nov 2026 09:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794475411;
 bh=Yt4A8NZadS0W5LYvptZOhNRvoJ7zuxm37iF0wtrvYzQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Al8XrrSs8SlF0Ee63VyaB5C5G3Uo5XX4ccMBtcpNj1/nlgPcep7aeKERTSWgnucOp
 MfDI/asrfWa/3CEmg6pEOW0iwUBXTbrstHK+aT1k/N2rH9Ze++0BQyE3m5E+Bsvhla
 Li75qTYXiN8XuLzDwXR8iTaIguGAuDTQE2CzXwvzHiWzxEQE/Ee8NN8ZEee7hLNl61
 N4HHHSK9uoj65Dbf4ioWvuiLsqurNOmaBgvsD1iZXXvUzX8srVURqbXYCpIx3J/ZGz
 +ThyHkvnZ3z8Ki/YNSmcFC2kOCj7mKH9R4pbLysLKP+MoYmyyEJ9f00YCJEhD/InKP
 yDI53+WDSqvfg==
Date: Thu, 12 Nov 2026 11:23:26 +0200
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
Subject: Re: [PATCH v13 00/19] PCI/P2PDMA: Route peer-to-peer DMA by TLP class
Message-ID: <20261112092326.GU8635@unreal>
References: <20261111121602.GQ8635@unreal> <20261111224136.GA754433@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261111224136.GA754433@bhelgaas>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 04:41:36PM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 11, 2026 at 02:16:02PM +0200, Leon Romanovsky wrote:
> > On Thu, Nov 05, 2026 at 12:04:31PM +0200, Leon Romanovsky wrote:
> > > Punch line for Linus from Jason:
> > > "Enhance detecting if the PCI fabric can support a peer to peer path
> > > by evaluating the full bi-directional fabric path over each of the
> > > three traffic type ACS controls. Expand the number of fabric
> > > configurations where the P2P algorithm makes the correct determination
> > > of support to include non-uniform ACS and situations where translated
> > > takes different routes from untranslated."
> > 
> > Bjorn,
> > 
> > Just a friendly reminder.
> 
> Thanks for the reminder.  I put this on pci/p2pdma for build testing
> (no issues expected; I always try to get build testing before merging
> into linux-next).
> 
> I'm still struggling to describe this in a way that connects to the
> code changes and is accessible to non-experts, so please correct
> things I get wrong here.

When asked to explain what I’m working on during hallway conversations, I usually
start with a top-down view:

“In order to support P2P in VMs, the virtual PCI topology needs to know whether
P2P is possible. However, the guest OS cannot see the physical topology because
it is hidden by the hypervisor. Since the VM and hypervisor run the same OS, we
need a generic way to report whether P2P is supported, rather than relying on a
CPU-supported whitelist. This is why we need ACPI HMAT [1].

However, HMAT alone is not enough: it is static and comes from firmware, the
BIOS, or the platform. We also need to account for ACS registers and different
traffic types.

This series provides the ACS, traffic piece of the puzzle.”

[1] https://lore.kernel.org/linux-pci/20260812-hmat-p2p-v1-0-75ac41380585@nvidia.com/

> 
> I had the impression that this series helps VMs by making P2PDMA work
> with passthrough devices in cases where it currently doesn't, but
> maybe that's not the case; I don't see any mention of that in the
> series.

It is a fundamental building block (see my explanation above), but it is also
useful on its own. Even without VMs or HMAT, ACS and routing are important
(see the removed patch [2]): they allow us to dynamically enable or disable
ATS for each DMA mapping, support asymmetric PCI topologies, and more broadly
enable P2P by checking every PCI route.

This is why I didn't mention VM to the cover letter.

[2] https://lore.kernel.org/all/20260920-fix-p2p-acs-v4-0-v7-19-ca0828ab697c@nvidia.com/

> 
> IIUC the P2PDMA core doesn't actually *control* any TLP routing, i.e.,
> it doesn't change any ACS controls or change any TLP attributes that
> affect how TLPs are routed, so to me, these subject lines suggest more
> than is actually happening:
> 
>   Route Relaxed Ordering Completions directly
>   Reject Translated Requests blocked by Translation Blocking
>   Route Translated Requests under Direct Translated P2P
> 
> It seems like we're just *learning* whether RO Completions will be
> routed directly, whether Translated Requests will be rejected, etc?

Right, the path and these bits are static.

> 
> I think the core basically looks at the ACS controls on the path
> between two devices and decides whether:
> 
>   (a) the devices can do P2P DMA directly (PCI_P2PDMA_MAP_BUS_ADDR),
> 
>   (b) they can do P2P DMA but only through host bridges on the
>   allowlist (PCI_P2PDMA_MAP_THRU_HOST_BRIDGE),
> 
>   (c) no P2P DMA is possible (PCI_P2PDMA_MAP_NOT_SUPPORTED),

This is equivalent to returning -EOPNOTSUPP when the functionality is
unavailable.

> 
>   (d) PCI_P2PDMA_MAP_NONE -- I don't understand this one; the comment
>   says "not a P2PDMA transfer", and pci_p2pdma_state() returns it when
>   the page is not a p2pdma_page, I guess because
>   pci_p2pdma_add_resource() has not set MEMORY_DEVICE_PCI_P2PDMA?
>   Not sure how this is used.

This means that this is regular DMA transfer which involves CPU.

> 
> I guess one benefit of this series is that a path where P2P Completion
> Redirect is set used to mean that pci_p2pdma_map_type() would return
> PCI_P2PDMA_MAP_NOT_SUPPORTED (unless the RC was allow-listed), and now
> it might return PCI_P2PDMA_MAP_BUS_ADDR because if P2P Request
> Redirect is clear, Requests can be routed directly?

I'm not sure the first part (return PCI_P2PDMA_MAP_NOT_SUPPORTED) is correct,
since callers have so far ensured that P2P is supported before calling this
function. The second part is correct.

> 
> That sounds great as long as the Request uses Relaxed Ordering, so the
> Completion won't be affected by P2P Completion Redirect.  But devices
> aren't *required* to use RO even if enabled, and I'm doubtful that a
> non-RO Completion redirected to the RC is going to work.  So I don't
> understand how p2pdma.c can guarantee safety.
> 
> Translated Requests seems similar -- are we assuming that if ACS
> Direct Translated P2P is set and ATS Enable is set, the device
> *always* generates Translated Requests?

PCI spec allows "A Function is permitted to intermix translated
and untranslated requests" and p2p doesn't decide anything except
if routing is possible or not.

Thanks

> 
> Bjorn
