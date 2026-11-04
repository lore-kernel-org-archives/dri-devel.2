Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8368606A328
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MegOdnKy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01FE710FD7D;
	Wed,  4 Nov 2026 17:14:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49F6710FD89
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 17:14:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 01E2D43A35;
 Wed,  4 Nov 2026 17:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8F31F00A02;
 Wed,  4 Nov 2026 17:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793812453;
 bh=yRj5WHRR9aenXyRIm39ayvCyj4WS0PCwSsf2eEii3y4=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=MegOdnKydykexyvjNSUghj/PsKL4AWwXsoL9hALI5tejJXpkO/xsHyu21RDFBo2Ap
 g/+z8Huc0yO/L+WHUj72LxQyh5okcc08FsQ10yoO3Px95mA6OktbE6mnVmy/4Cky1L
 aAF3DhJr/zKFC01irxMQjmK7n4EaAXSBeDxvk2tN51bMgRg8z2vFkBPB4ub/+Cnthi
 lzwlssUrRXqQCCtsPPsnFsuZZ46nLtg4wdEFrdJo+zgdmcl6ju7ExhulS8CBIQJ2xD
 Pru/TDbrbCwwj2+/8zZEQZ3tL9L52LeO+6dA4kUjeOk+LIGxfJct3Kt33lcTF9zMcj
 /Z/vjBicYWD7Q==
Date: Wed, 4 Nov 2026 11:14:12 -0600
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
Subject: Re: [PATCH v12 00/19] PCI/P2PDMA: Route peer-to-peer DMA by TLP class
Message-ID: <20261104171412.GA1247928@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104084328.GP264423@unreal>
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

On Wed, Nov 04, 2026 at 10:43:28AM +0200, Leon Romanovsky wrote:
> On Tue, Nov 03, 2026 at 05:37:42PM -0600, Bjorn Helgaas wrote:
> > On Tue, Nov 03, 2026 at 10:29:39AM +0200, Leon Romanovsky wrote:
> > > PCI P2PDMA applies Request and Completion Redirect throughout
> > > both paths.  This misclassifies asymmetric and nested switches,
> > > and reports one answer for every kind of TLP.
> > > 
> > > Three ACS controls act on TLP attributes the Requester chooses
> > > rather than on the topology: Translation Blocking and Direct
> > > Translated P2P act on a Request's Address Type, and Completion
> > > Redirect skips Completions carrying Relaxed Ordering.
> > > 
> > > Evaluate each direction at the path divergence, decide every
> > > class from the one walk, and treat a client with ATS enabled as
> > > translating unless its driver declares per-mapping ATS.
> > > 
> > > This completes the P2PDMA side; dma-buf and mlx5 follow
> > > separately.
> > 
> > Is there a one- or two-sentence explainer of why we want this?
> > I'm thinking in terms of what Linus will want in the merge
> > request: a fix for something that's broken or some new
> > functionality.  It sounds like this is solving a problem, but I
> > don't know enough to translate the nitty-gritty details to the
> > higher-level user-visible problem or feature.
> 
> Not AI; these are my own words with grammar fixes from AI:
> 
> "The existing implementation of PCI peer-to-peer assumed that all
> PCI TLPs were the same: ordered and carrying untranslated addresses.
> It did not account for the variety of traffic types defined by the
> PCI specification. As a result, only simple systems supported
> peer-to-peer transfers in the upstream kernel; real-world systems
> required out-of-tree patches and careful platform design.

Can we be any more specific?  E.g., what makes real-world systems
different from simple ones?  What does careful platform design mean?
Something about ordering beyond what PCIe requires?

ACS P2P Completion Redirect affects Relaxed Ordering (RO) Completions.
Translation Blocking and Direct Translated P2P affect Requests with
Translated addresses.

So I assume the existing P2P implementation breaks somehow when RO or
Translated addresses are used?  How does it break?

> The new code will allow peer-to-peer transfers between any two
> devices, for all types of PCI traffic, as long as the PCI path
> between them supports peer-to-peer.
> 
> This paves the way for PCI peer-to-peer support in VMs, which the
> upstream kernel does not currently support."
> 
> BTW:
> 1. The patch "PCI/P2PDMA: Document the TLP attribute assumptions"
>    attempts to explain the current situation.
> 2. The change is too large to present as a fix.
