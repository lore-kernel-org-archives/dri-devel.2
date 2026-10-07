Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F0FCA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:50:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 838AE10E5DD;
	Wed,  7 Oct 2026 13:50:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HjQgmPnt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F74410E5B9
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 13:50:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3ABCF41882;
 Wed,  7 Oct 2026 13:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A4D1F0089B;
 Wed,  7 Oct 2026 13:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791381049;
 bh=1shPG4ZK7PMcDI/u1JoCLyyFAzztG3l8pUDkDi8PnMA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=HjQgmPntYWukekS4isKgEoaEI0YgYaa+J7dSy2VcyfslrCHoyEYXOCAlgLlz19NcR
 ItQy6KmofW1ILo8FWaD7RFVo9zAI1pwHbZIUosTXgq4byEJDlJHVHzkkTn3TJjmMig
 KqVJJOlrLwzl4Y7f1cx27EEnYhlhRt47oKViVGP7tDY6fYohcFbX6onxkx3PY2ZxNj
 Z9FJXVDIW94u9C85e+KA3u75zw28NZ/T8uh8qXWvvQ4FW8exvmsz1+CdJp1ThtK53N
 uInKu6uJmJfx/aJf0tsqrOwriH7LYFLxfrKSLqOloLlMATybqcP8bTMTaB4ef1yX9i
 F+nbmWETw9JaA==
Date: Wed, 7 Oct 2026 16:50:44 +0300
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
Subject: Re: [PATCH v9 06/18] PCI/P2PDMA: Collect the path's ACS controls
 before deciding
Message-ID: <20261007135044.GG7822@unreal>
References: <20261001-fix-p2p-acs-v4-0-v9-6-1a8e0f50ddd9@nvidia.com>
 <20261006214858.GA717151@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006214858.GA717151@bhelgaas>
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

On Tue, Oct 06, 2026 at 04:48:58PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 01, 2026 at 02:55:14PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > calc_map_type_and_dist() reads each divergence port's ACS Control register
> > and folds the result into running counters as it goes. Any routing property
> > that depends on the kind of TLP being routed would have to be threaded
> > through that code, so there is nowhere to put one without reading the
> > registers again for each kind.
> 
> What is the "one" that there's nowhere to put?  I guess the routing
> property?  So this is an optimization to avoid some config reads?

Right, cache the ACS bits, since we need to query them for both devices
whenever we calculate routing.

Thanks
