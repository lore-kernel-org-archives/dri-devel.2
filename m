Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFC9606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 20:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mPO7YXrP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D78910E26F;
	Fri, 23 Oct 2026 20:15:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB75E10E26F
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 20:15:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6FDD5601DE;
 Fri, 23 Oct 2026 20:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA2D1F01828;
 Fri, 23 Oct 2026 20:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792786533;
 bh=LjMfVQmjefsgN7ZWT6/c86G+DCQ8WdW7PyuBbuO1hbY=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=mPO7YXrPQDax1DVJaIP2e9sYo+5L9AvZwUjLGajvf2GIofMt70yNG+v4okfljv1m+
 mQ9t3fBfOxUy8XokMjCiZulcdMVqZJMkhN17KgAijggXLyAIzt2txfyoOorFbhdgZY
 M0HH0Zmg7aUpHB/dkniCeAZp3RCvD+NJgX4bVibtYuZymGAuzK3eknt1GeciJerA5h
 eoghJrtkv7LPEJeH462xdL+BTE6aAyt4oGHbjx7ZcpQ7YQlnZEa1MqgrbouO93JlWs
 PKNt0QIxbyhUD8AXe8WL90pp+qKtrhdJeg8fT8gzu9fGb7T3oe1c4G44BzKTLGEoCx
 Bap59M59hWzRQ==
Date: Fri, 23 Oct 2026 15:15:31 -0500
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
Message-ID: <20261023201531.GA2805244@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023190036.GL3977851@ziepe.ca>
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

On Fri, Oct 23, 2026 at 04:00:36PM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 23, 2026 at 01:27:15PM -0500, Bjorn Helgaas wrote:
> 
> > > Yes, the ACS combination is selected to avoid ordering issues
> > 
> > Does a user have any way to know whether the configuration is safe?
> 
> No, unfortunately in PCIe so much is really difficult when it comes to
> deployment :(
> 
> > I'm wondering whether users might use "pci=config_acs=" to configure
> > ACS so things appear to work as they prefer but may not provide the
> > ordering guarantees drivers depend on.
> 
> I imagine that could happen, but on most practical systems the root
> complex will blow up if you do asymmetric routing so there is an early
> indication.
> 
> I know this because I've help debug such configurations at
> customers. Some servers helpfully MCE if you do this. Lovely.

I'm still confused about this because earlier in this thread, I
thought Leon said you do asymmetric routing:

  Bjorn> And I guess asymmetric fabrics must mean fabrics where
  Bjorn> Request Redirect and Completion Redirect are not set the same
  Bjorn> way?

  Leon> Yes, in some of our systems, deviceA to deviceB is going
  Leon> through different route than deviceB to deviceA.

> > If that's a possibility, do we have any notes in dmesg that we are
> > depending on fabric behavior that the OS can't discover and verify?
> 
> Maybe, it could be interesting if the P2P logic found asymetric paths
> it refuses to permit it.

It seems like P2PDMA *could* check for asymmetric paths and at least
warn about it.  If it's practical to do so, it would make me feel a
lot better about this.
