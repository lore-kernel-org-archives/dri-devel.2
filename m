Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B382606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G9n9PYHm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B25BA10E5EB;
	Fri, 23 Oct 2026 18:27:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E59B010E5EB
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 18:27:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6C75842EB5;
 Fri, 23 Oct 2026 18:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259B01F01825;
 Fri, 23 Oct 2026 18:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792780037;
 bh=OMMk0FY0QXXjJrMUkrwply/6bMqx0VFwmW8asWdCFJQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=G9n9PYHmDL6cgVGQNgXtNMCyVym07kIyyjM2nGMF3bsN0888XQNZ4UlZQ5VXpvrwH
 jSs376aScTw45oN1ocyIVZKX/rCW4ZO5vpA7KQKBkWB39rIEmJYmQcsPSwwAT2QsdX
 QlpB3wcDy7WH2w8//1hJ4V+fstquvb8vfORjJrtI6GR3ls85ONhfDpEaffIfXk8Jwi
 oNQ5WeXNpwNKMCS4ISCn2rDsxme+3kpE+h1SicZs+5Cs95krMsAUUNZZKkmPNCAOPi
 KCuzxbEt2ogrM7EFOAVrSYEN/4rsnKGSM8ZaL9iYZ86rJ+FagondpXmymu1fiSUUbk
 RXgCab24TbNrw==
Date: Fri, 23 Oct 2026 13:27:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
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
Message-ID: <20261023182715.GA2798722@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023155914.GK3977851@ziepe.ca>
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 12:59:14PM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 09, 2026 at 08:43:01PM +0300, Leon Romanovsky wrote:
> > On Wed, Oct 07, 2026 at 03:40:45PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Oct 07, 2026 at 09:32:27AM +0300, Leon Romanovsky wrote:
> > > > On Tue, Oct 06, 2026 at 03:49:47PM -0500, Bjorn Helgaas wrote:
> > > > > On Thu, Oct 01, 2026 at 02:55:10PM +0300, Leon Romanovsky wrote:
> > > > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > > > 
> > > > > > pci_bridge_has_acs_redir() treats Request and Completion Redirect as
> > > > > > interchangeable. On asymmetric fabrics, a control for only the reverse TLP
> > > > > > direction can unnecessarily force P2PDMA through the host bridge.
> > > > > 
> > > > > Does "the reverse TLP direction" refer to Completions?
> > > > 
> > > > In general, the P2P code treats TLPs flowing from device A to device B the
> > > > same as TLPs flowing from device B to device A.
> > > > 
> > > > However, in the context of this commit message, yes: completions flow in the
> > > > opposite direction from the device's perspective.
> > > 
> > > And I guess asymmetric fabrics must mean fabrics where Request
> > > Redirect and Completion Redirect are not set the same way?
> > 
> > Yes, in some of our systems, deviceA to deviceB is going through
> > different route than deviceB to deviceA.
> 
> It is a little more subtle, I think practical systems try very hard to
> avoid that since many host bridges do not like seeing only half of an
> exchange.
> 
> What we end up with is Relaxed Ordering and Strict Ordering take
> different flows in the fabric.
> 
> > > But I asked about ordering because it sounds like this patch expects
> > > to encounter asymmetric fabrics where Request Redirect and Completion
> > > Redirect may not be set the same way, and the spec implies that
> > > asymmetry may result in ordering violations.
> > 
> > My guess is that the hardware and system architects have ensured this
> > doesn't happen. At least, I haven't received any complaints about this
> > series during internal testing.
> 
> Yes, the ACS combination is selected to avoid ordering issues

Does a user have any way to know whether the configuration is safe?

I'm wondering whether users might use "pci=config_acs=" to configure
ACS so things appear to work as they prefer but may not provide the
ordering guarantees drivers depend on.

If that's a possibility, do we have any notes in dmesg that we are
depending on fabric behavior that the OS can't discover and verify?

Bjorn
