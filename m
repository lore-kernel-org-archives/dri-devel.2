Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFC1C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:20:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0870C10E6E5;
	Tue, 15 Sep 2026 07:20:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nJiy3DqL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 032AE10E6E5
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 07:20:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A70C3433EE;
 Tue, 15 Sep 2026 07:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007891F00893;
 Tue, 15 Sep 2026 07:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789456806;
 bh=FyM/uDm+tnR187tEWbfUP/Wv8cyeaRWJrXszC+FigbU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nJiy3DqLOR9LIWKPRLB9D9eWUn97WaZOJ8op7wFd99Yjcl4KFfO8U5JOCrXrXYAL1
 aWChcdtMGUmMM9FrbK4CHXb+jZe9+G0ao4v5+j7o3ov8uimqC8EycWedLkLC+pAEmK
 vQMAj18D9bZI1Uqld3M+rnJEx386vPjzNyPMyxSTTkRI9BTOncHKEaLQ/KKdhFKdy4
 ieLssqmLe7eKnp9YcAU6xWR/RsIiMgRLEhHsorUmNOmRoATOW7KnYBLHxZtUGGkk0F
 8tjXhSk03syKMpeTz1SohHhI9gy+gC03RtGmc05DpZ6y6LPecYCab15k2u7h5kKcMx
 Rdfe7jZW0zBVw==
Date: Tue, 15 Sep 2026 10:20:02 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Matt Evans <matt@ozlabs.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 Alex Mastro <amastro@fb.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>,
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
Message-ID: <20260915072002.GD13683@unreal>
References: <20260911214200.33793-1-matt@ozlabs.org>
 <20260911214200.33793-10-matt@ozlabs.org>
 <20260913165244.GW13683@unreal>
 <20260914113647.GL3968357@nvidia.com>
 <20260914115456.GY13683@unreal>
 <f21c409d-5675-4c87-8b16-850bcb9474df@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f21c409d-5675-4c87-8b16-850bcb9474df@ozlabs.org>
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

On Mon, Sep 14, 2026 at 01:13:36PM +0100, Matt Evans wrote:
> Hi Leon,
> 
> On 14/09/2026 12:54, Leon Romanovsky wrote:
> > On Mon, Sep 14, 2026 at 08:36:47AM -0300, Jason Gunthorpe wrote:
> > > On Sun, Sep 13, 2026 at 07:52:44PM +0300, Leon Romanovsky wrote:
> > > > On Fri, Sep 11, 2026 at 10:41:57PM +0100, Matt Evans wrote:
> > > > > Expand the VFIO DMABUF revocation state to three states:
> > > > > Not revoked, temporarily revoked, and permanently revoked.
> > > > 
> > > > The thing is that "temporarily revoked" is actually the standard
> > > > invalidate_mappings/move_notify mechanism of DMABUF, which wasn't good
> > > > for VFIO.
> > > 
> > > I think temporarily revokes here means it is revoked from a dmabuf
> > > perspective
> > 
> > My guess is that this is more of a "change owner" operation than a
> > revoke operation.
> > 
> > The main issue here is that we have to guess the semantics instead of
> > having a properly named and documented operation.
> 
> Apologies if the cover letter for the series and patch commit message (which
> cover this) are unclear about the motivations and semantics.  On the commit
> message, can you suggest clarifications:
> 
> "This is useful for lifecycle management, to reclaim VFIO PCI BAR
> ranges previously delegated to a subordinate client process: by
> revoking, the driver process can ensure that the loaned resources are
> made inaccessible when the client is deemed "done".  The original
> DMABUF is defunct, and BAR resources can then be safely re-exported
> for use by new clients."
> 
> Given what I'll explain below, do give suggestions please.  There is more
> context in the cover letter (the volume of which I didn't think appropriate
> for the commit message).

1. Do not mix "driver" and "client" in the same description. For a
non-native English speaker, "driver" has a very specific meaning in the
context of the Linux kernel.

2. Explain the lifecycle in the commit message, and why "revoke", which
is effectively what the importer does, is not sufficient.

3. The more you put in the cover letter, the less likely people are to
read it.

4. Commit messages should describe the patches themselves, since they
are what remains visible in the git log, unlike the cover letter.

5. I would call what you describe as "temporarily revoke" is actually "reclaim".

Thanks
