Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E88CC98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 16:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E8DD10E927;
	Wed, 23 Sep 2026 16:52:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SVbDUx6c";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D2110E927
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 16:52:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7DB4E424B3;
 Wed, 23 Sep 2026 16:52:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986881F000FF;
 Wed, 23 Sep 2026 16:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790182365;
 bh=Lhdy29oop/cw6c885Y7VJUb6i9ruLlFI44cMGP64UTg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SVbDUx6c81ndO6gXE/xhJeR6ja16/7cbyfPo4arV94b0qGQols+M5Q2iRSZIW0Acx
 6srUH5qtu9mhQa7OCqzHrqkZOR01iU4a8XSeRd/dNwoD1vMgktP/qA9GgJ1FSS9JV7
 8n5XXqzShIaA8e/BMbBq3kRfj8eg8y6aLja/aa604G8TFri5wNLyg9aQu+I3/AXW7K
 5L2fiq+Qqtp44l5FP7ZcAaDd5O4B30yWuKkj9jbili5TGVGwaVw7Kx3xFml8dKGy5Q
 eC+mfyFZ9j5EsoeDoJJmWfQm5Dr8VXNiVNRO6MF8KPIszLwvSWv+fFYhaDAEXzljvw
 1zAkWnPgGc1Fw==
Date: Wed, 23 Sep 2026 19:52:40 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Matt Evans <matt@ozlabs.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>,
 Longfang Liu <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 9/9] vfio/pci: Permanently revoke a DMABUF on request
Message-ID: <20260923165240.GS563127@unreal>
References: <20260921132208.GA1507824@nvidia.com>
 <fa5c7fd5-f24a-4ca1-89c3-9ccd9a728fb4@amd.com>
 <20260921134924.GB1507824@nvidia.com>
 <2d15cca5-0bbe-461a-baf3-56758e82cfb7@amd.com>
 <20260922124137.GD1507824@nvidia.com>
 <20260922124637.GG563127@unreal>
 <20260922125421.GE1507824@nvidia.com>
 <arMBqyI4XNfD+q1W@devgpu015.cco6.facebook.com>
 <20260922225747.GB2545495@nvidia.com>
 <e33f1d3a-1900-4bf3-9785-3af5447e7e54@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e33f1d3a-1900-4bf3-9785-3af5447e7e54@ozlabs.org>
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

On Wed, Sep 23, 2026 at 04:40:03PM +0100, Matt Evans wrote:
> Hi Jason, Alex,
> 
> On 22/09/2026 23:57, Jason Gunthorpe wrote:
> > On Tue, Sep 22, 2026 at 03:31:07PM -0700, Alex Mastro wrote:
> > 
> >> So I empathize with Matt's contention that the _existing_ behavior that the
> >> priv->revoked flag represents is actually "temporarily revoked": the importer
> >> can use the same dma-buf again, later, without having to re-import
> >> it!
> > 
> > mlx5 isn't a revoking importer, it is move capable. So the above
> > sequence isn't a revoke, it is a move with an unmapped placement for a
> > while.
> > 
> > This is why "temporarily revoked" is a confusing phrase.
> > 
> > The API is such that move and revoke importers can co-exist like this
> > but they experiance a different version of things..
> 
> Ahhhhh.  That was very helpful (esp. to contrast with the previous
> iommufd statement about invalidate_mappings being permanent), thank you!
> 
> So the worry was that the VFIO DMABUF's temp/perm state could be
> misconstrued as an implication/guarantee about the future availability
> of that DMABUF to importers, OK.  And we want the existing move(false)
> behaviour still, for dynamic importers that treat it as a move.

This is not a bug; the behavior is intentional. During review of the initial
versions of the revoke mechanism, it was pointed out that
`move_notify == invalidate_mappings == revoke`. The initial versions
introduced a separate function call for revocation, which we abandon in
favour of move semantics.

Thanks
