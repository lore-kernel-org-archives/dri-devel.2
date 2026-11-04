Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B5B606A330
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYR7aZGr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B63410E867;
	Wed,  4 Nov 2026 08:43:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5317110E867
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 08:43:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6B352602BE;
 Wed,  4 Nov 2026 08:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C38B1F000C1;
 Wed,  4 Nov 2026 08:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793781812;
 bh=Xigaf6imL+kX8Ty8pKWbPmcjBYxPKbcCFWKP/SbOV1w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SYR7aZGruhoHnrfiwYjxfz5dGJoVSDEEik/0zvtgRpyReS9Wbk26VTR5vN0qCQv9W
 y5RgeyQPrjeHzKvEKu3Nj6jBffjhDpTmnwyQGZXiRJo7gLVwI59jqv/i+zM+oj6vAv
 XCbuh4sq0+rIxSCKsxgyClZj/VKu/TMwKvhA+mlxcgS8e9HDpAfjHFF5N0ch2h4Tc0
 91rCYp2anJnZ1Hiuv0L5HqP32okJmg5j6P0tXnAVKH/eX/fag0H8xHDlOK0j49OtPC
 UPBAX3K5anx7jwggHKh+KlcKCY13k/bSK1Uxj2oAxM+0aLBf0g1XyGTX6dgAPwD0QJ
 dk69OhqIE6k4Q==
Date: Wed, 4 Nov 2026 10:43:28 +0200
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
Subject: Re: [PATCH v12 00/19] PCI/P2PDMA: Route peer-to-peer DMA by TLP class
Message-ID: <20261104084328.GP264423@unreal>
References: <20261103-fix-p2p-acs-v4-0-v12-0-912101f93517@nvidia.com>
 <20261103233742.GA1162403@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103233742.GA1162403@bhelgaas>
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

On Tue, Nov 03, 2026 at 05:37:42PM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 03, 2026 at 10:29:39AM +0200, Leon Romanovsky wrote:
> > PCI P2PDMA applies Request and Completion Redirect throughout both paths.
> > This misclassifies asymmetric and nested switches, and reports one answer
> > for every kind of TLP.
> > 
> > Three ACS controls act on TLP attributes the Requester chooses rather
> > than on the topology: Translation Blocking and Direct Translated P2P act on
> > a Request's Address Type, and Completion Redirect skips Completions carrying
> > Relaxed Ordering.
> > 
> > Evaluate each direction at the path divergence, decide every class from the
> > one walk, and treat a client with ATS enabled as translating unless its
> > driver declares per-mapping ATS.
> > 
> > This completes the P2PDMA side; dma-buf and mlx5 follow separately.
> 
> Is there a one- or two-sentence explainer of why we want this?  I'm
> thinking in terms of what Linus will want in the merge request: a fix
> for something that's broken or some new functionality.  It sounds like
> this is solving a problem, but I don't know enough to translate the
> nitty-gritty details to the higher-level user-visible problem or
> feature.

Not AI; these are my own words with grammar fixes from AI:

"The existing implementation of PCI peer-to-peer assumed that all PCI TLPs were
the same: ordered and carrying untranslated addresses. It did not account for
the variety of traffic types defined by the PCI specification. As a result,
only simple systems supported peer-to-peer transfers in the upstream kernel;
real-world systems required out-of-tree patches and careful platform design.

The new code will allow peer-to-peer transfers between any two devices, for all
types of PCI traffic, as long as the PCI path between them supports
peer-to-peer.

This paves the way for PCI peer-to-peer support in VMs, which the upstream
kernel does not currently support."

BTW:
1. The patch "PCI/P2PDMA: Document the TLP attribute assumptions" attempts to
   explain the current situation.
2. The change is too large to present as a fix.

Thanks
