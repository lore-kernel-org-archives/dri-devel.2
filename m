Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E28C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC99310EDED;
	Mon, 14 Sep 2026 12:06:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MsPzQKc5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1A4910EDED
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 12:06:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C928160120;
 Mon, 14 Sep 2026 12:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04121F00899;
 Mon, 14 Sep 2026 12:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789387581;
 bh=JJ32IByX+rTBKcwgaZZYDc1UEnnlzh2V0wTKpkwgrnY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MsPzQKc5dXfufDzuzryyW0/mnHC943MRxkWQ64H6J4fMnzDfqD3Sfv5/evutWeEeA
 yvNPqKMfOsxIXrEAL7Iwu40iNRA5Yv+Crz5cw85xFPL8WdsqgploBRJzdaUPq/2FuA
 nG8+YRbe97dV09LFkxELln+xhQnz5zh+iS3Op4//nRfR4CI6xkOFMeSe5FbLnFEtrV
 88ouWGz2BodlJdkCQYAMzojuzg++6HzLMlgaMvAVRnMQpd4GfFzO3QVMN3BL1BmAzp
 drmNCyfCX19Ukd+Evj2l8BFz7ZB3akEsy1dWoxJ3LrxJKdTBtU9XU5/Nrhsj0X1PV/
 mFLCqdiosBFdw==
Date: Mon, 14 Sep 2026 15:06:18 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>,
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
Message-ID: <20260914120618.GA13683@unreal>
References: <20260911214200.33793-1-matt@ozlabs.org>
 <20260911214200.33793-10-matt@ozlabs.org>
 <20260913165244.GW13683@unreal>
 <20260914113647.GL3968357@nvidia.com>
 <20260914115456.GY13683@unreal>
 <20260914115826.GM3968357@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914115826.GM3968357@nvidia.com>
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

On Mon, Sep 14, 2026 at 08:58:26AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 14, 2026 at 02:54:56PM +0300, Leon Romanovsky wrote:
> 
> > So I still think that "temporarily revoked" is closer to
> > invalidate_mappings, with some additional dma-buf documentation to lose
> > the expectation that the buffer will become available again.
> 
> It really isn't, there is no expectation her that the importer has to
> put things back like with move.

As we discussed with Christian, "move" doesn't have such expectation.
https://lore.kernel.org/all/afb19db0-4154-443c-9d39-f905e7d17806@amd.com/

Thanks

> 
> From a DMABUF API this is very much just plain revoke.
> 
> Jason
