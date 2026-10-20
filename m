Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC11260A2612
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lguxzf8Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5632910EBA4;
	Tue, 20 Oct 2026 10:25:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5821010EBA4
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 10:25:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8173B60DA5;
 Tue, 20 Oct 2026 10:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A819C1F000C4;
 Tue, 20 Oct 2026 10:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792491915;
 bh=GmgvE7biHiDHJAgyZpIMu3iqBMY4bU18LDyGcOQMk4g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Lguxzf8ZkSVPiujCO3yHX9RyjwaBzTk20uTEzjFrJiN0TZqi4fB+bCu0Y04iDSvHw
 dyo+dunY5RFPtvt4z5gbQgc5c31+1wikH2oM+R2A8/9CmcWOCa/DujSVSn8P1Jiy5O
 IkMGGDOk8VQqJlgDFCMIgIr1GYaj0gVoOQgJSBM8pOf5XItP41xBc0W6hhUtqbWfKS
 GmYr+B3T+hLhpI4/Q+wr8TYB8Q9ErStEBUwgL3YlmwntUJUiBnNXnidK/nAcYrgCvT
 E3e8iZ7vB5loeWynl9dd7Vq2QfVKRPC/ECeBnyG1PUM/lSztdK1tJB3H2dRMTvg+ed
 fC7b+st9MDTpQ==
Date: Tue, 20 Oct 2026 13:25:10 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
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
Subject: Re: [PATCH v11 00/19] PCI/P2PDMA: Route peer-to-peer DMA by TLP class
Message-ID: <20261020102510.GL64621@unreal>
References: <20261019183537.GI64621@unreal> <20261019191845.GA2219127@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019191845.GA2219127@bhelgaas>
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 02:18:45PM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 19, 2026 at 09:35:37PM +0300, Leon Romanovsky wrote:
> > On Wed, Oct 14, 2026 at 05:49:53PM +0300, Leon Romanovsky wrote:
> > > On Wed, Oct 14, 2026, at 16:23, Bjorn Helgaas wrote:
> > > > On Wed, Oct 14, 2026 at 09:53:47AM +0300, Leon Romanovsky wrote:
> > > >> On Tue, Oct 13, 2026 at 05:25:08PM +0300, Leon Romanovsky wrote:
> > > >> > PCI P2PDMA applies Request and Completion Redirect throughout both paths.
> > > >> > This misclassifies asymmetric and nested switches, and reports one answer
> > > >> > for every kind of TLP.
> > > >> > 
> > > >> > Three ACS controls act on TLP attributes the Requester chooses rather
> > > >> > than on the topology: Translation Blocking and Direct Translated P2P act on
> > > >> > a Request's Address Type, and Completion Redirect skips Completions carrying
> > > >> > Relaxed Ordering.
> > > >> > 
> > > >> > Evaluate each direction at the path divergence, decide every class from the
> > > >> > one walk, and treat a client with ATS enabled as translating unless its
> > > >> > driver declares per-mapping ATS.
> > > >> > 
> > > >> > This completes the P2PDMA side; dma-buf and mlx5 follow separately.
> > > >> > 
> > > >> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > >> > ---
> > > >> > Changes in v11:
> > > >> 
> > > >> 
> > > >> Bjorn,
> > > >> 
> > > >> Could you please save me from the AI-bot attack? Every rebase seems to
> > > >> uncover another bizarre pre-existing issue. It never ends.
> > > >
> > > > Can you elaborate?  I'm not sure what you'd like me to do here.  I
> > > > don't control the Sashiko reviews, and I thought Sashiko was recently
> > > > changed to put pre-existing issues in a database but not in the email
> > > > responses.
> > > 
> > > AI reviews are not deterministic and every resubmission gives us slightly different result, which is in this phase of submission is  full of hallucinated flows not applicable to the upstream.
> > > 
> > > In addition to upstream Sashiko, i run everything through local one with slightly better models which hallucinating even more.
> > > 
> > > I would ask you to merge the series so it gets real exposure in addition to my kunit and specific hw setup.
> > 
> > Bjorn,
> > 
> > We're in the merge window now, so I don't expect such a large series to be
> > merged. What about the next cycle? Should I send v12 after -rc1, or wait?
> 
> After -rc1 would be good.

Thanks
