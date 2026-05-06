Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693E2CD3424
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 05:35:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BA8B10E116;
	Wed,  6 May 2026 05:35:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fbw6StrJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E440610E116
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 05:35:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 819084022B;
 Wed,  6 May 2026 05:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FDAC2BCB8;
 Wed,  6 May 2026 05:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778045718;
 bh=68FaERwoP8OX0MneSqPhcOfZCZKy6fGPcZy0kqgTRIg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fbw6StrJozjSOh/RfsDaKDjrUqTTKMeviPsHMsE7yDJsMstAK0fltNMQcmTMCowIq
 H9MWLt+zPLyCR3yu1Qfr/aMXgCOE/+5tqWJYaYijMS48bwDBpvn9rbDzCuCMO4wG9L
 +kSI8A5+2Xd/kGcjBKDJaSeKHgkCgrmj3WfRNsack+a8mxm1EzMAZ35fPxaviGTyxd
 E+ySw6OHqf1uDrjUMLOogK7cSTeMcnIWqk7jpco2ecg1/u8Hhg0QrAn3qd20xvqm5r
 HOn914KYUKbtZP3hs5VmCcpSTACAgcH9vxpGbvnddotXCj9DxSAAFgnaAOiAEDN8LX
 se7h+6gl7vrAg==
Date: Wed, 6 May 2026 08:35:11 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Matt Evans <mattev@meta.com>,
 Alex Mastro <amastro@fb.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Kevin Tian <kevin.tian@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Pranjal Shrivastava <praan@google.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH 4/9] vfio/pci: Convert BAR mmap() to use a DMABUF
Message-ID: <20260506053511.GG11063@unreal>
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-5-mattev@meta.com>
 <20260501161915.75525c15@shazbot.org> <afhNeYS174EW7RYp@nvidia.com>
 <20260505104911.GB11063@unreal>
 <20260505085058.74c34290@shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505085058.74c34290@shazbot.org>
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

On Tue, May 05, 2026 at 08:50:58AM -0600, Alex Williamson wrote:
> On Tue, 5 May 2026 13:49:11 +0300
> Leon Romanovsky <leon@kernel.org> wrote:
> 
> > On Mon, May 04, 2026 at 04:40:41AM -0300, Jason Gunthorpe wrote:
> > > On Fri, May 01, 2026 at 04:19:15PM -0600, Alex Williamson wrote:
> > >   
> > > > Exporting dma-bufs from vfio-pci is a feature, but mmap of MMIO BARs is
> > > > a legacy requirement.  That legacy requirement now depends on
> > > > PCI_P2PDMA, which depends on 64BIT and ZONE_DEVICE.  
> > > 
> > > That should be split up now, Leon missed it when he added the new
> > > APIs that didn't require ZONE_DEVICE..  
> > 
> > Sorry, what did I miss here?  
> > VFIO_DMABUF is an optional feature and is enabled only when P2P support is  
> > available. It does not affect legacy systems where P2P cannot be enabled.
> 
> If we look at the long term view of moving exclusively to cdev/iommufd,
> where VFIO_DMABUF becomes the mechanism for implementing P2P DMA
> mappings, VFIO_DMABUF may be optional, but it's highly desirable for
> legacy compatibility.  There's an argument though that providing P2P
> compatibility on platforms that support PCI_P2PDMA is probably
> sufficient.
> 
> However, in providing mmap of dmabufs as a feature, this series is
> wiring all mmaps through dmabufs and therefore that dependency becomes
> fundamental to the use of vfio-pci.  Thus the discussion whether the
> noted config requirements could be lifted.  Thanks,

Right, there was no need to remove ZONE_DEVICE when I added my code, and I
left the task of cleaning it out of is_pci_p2pdma_page() for another day.
Without ZONE_DEVICE, all pages are treated as non‑P2P.

> 
> Alex
> 
> PS - Please also weigh in on the dmabuf underflow[1]
> 
> [1]https://lore.kernel.org/all/20260501131236.278ac431@shazbot.org/

will do.

Thanks
