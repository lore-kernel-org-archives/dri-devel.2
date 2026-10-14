Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818E0CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 13:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8CB510E56D;
	Wed, 14 Oct 2026 13:24:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43BC810E56D
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 13:23:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D57E64451B;
 Wed, 14 Oct 2026 13:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885C91F000FF;
 Wed, 14 Oct 2026 13:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791984234;
 bh=zh7/Ug58+Id/pjTRVFnSqm3xMVxCch1on+6+IzYcFOo=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=VY1TVQtlH3RX+/ZXBgKvz5jDQWSl87MupN8zI9hC24rJvxTxwxBJ4XPc3k8kRNP73
 BJUQ8gOni1xH2vxvOF7XI7TKoskBT6qkRLbiR7u5xhazxbzMIlK/RpjbBC6lBp+AVj
 gkt6iyd/HWLGsXX5bI3inKNXCzcuB81i3Bi01jNQ2FMCvJRHv6Po/8i3vEZIo63f9g
 TaU5SxADJQiyj42AB8bP1vly6Wa+mrd/1/KIY4SwlLHCs93QU/imKD1M2mJndebfi4
 n+1QmTBNHvqDZ51qsxO3RDQuiAZXeMnp0pXpWcRVh8cP4p/5V/LPvX7YZ/pScmF3an
 4AflKGZkey73g==
Date: Wed, 14 Oct 2026 08:23:53 -0500
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
Subject: Re: [PATCH v11 00/19] PCI/P2PDMA: Route peer-to-peer DMA by TLP class
Message-ID: <20261014132353.GA1625948@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014065347.GW219304@unreal>
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

On Wed, Oct 14, 2026 at 09:53:47AM +0300, Leon Romanovsky wrote:
> On Tue, Oct 13, 2026 at 05:25:08PM +0300, Leon Romanovsky wrote:
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
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> > Changes in v11:
> 
> 
> Bjorn,
> 
> Could you please save me from the AI-bot attack? Every rebase seems to
> uncover another bizarre pre-existing issue. It never ends.

Can you elaborate?  I'm not sure what you'd like me to do here.  I
don't control the Sashiko reviews, and I thought Sashiko was recently
changed to put pre-existing issues in a database but not in the email
responses.

Bjorn
