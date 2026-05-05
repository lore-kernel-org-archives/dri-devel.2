Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AD0FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 10:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36F8510E11C;
	Tue,  5 May 2026 10:55:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="da+b6HqW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95D6410E11C
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 10:55:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 44A986012B;
 Tue,  5 May 2026 10:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F041BC2BCB9;
 Tue,  5 May 2026 10:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777978158;
 bh=VwbDdX36fjXj6/K+MlyisBmDaAMjjmJqPH15dknt6nM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=da+b6HqW0iC4iVIMeqmLLKKYUyCkC20+EKjgnNIOfhj0BOoavtxV+TYZnp+psCoog
 ymO7YYB0UB696539X9HSdwlZC4xNXn9or3FMBnkO+Ezj24w5unfS2tNhDb4JPYthH7
 10XIF+45HCSplMR5GAXyevwU4QS9hzTUZw+sVqny/1Ws3hfOayG6exEzqrviw3MwOi
 8VEzi0hOK1qw7W4YjDScYqzYNPAhDCx0WgFReAVnfrhZh8cZ7mlQBTiaKSLO9hDYVQ
 M+ZFZ1KZefRb35bruPCMTxi7eVWk3jawx4j45akPoDIHuqFWHNrli2mZo4tdvIDFvG
 6oDB5sN1PmQ1Q==
Date: Tue, 5 May 2026 13:49:11 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Matt Evans <mattev@meta.com>,
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
Message-ID: <20260505104911.GB11063@unreal>
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-5-mattev@meta.com>
 <20260501161915.75525c15@shazbot.org> <afhNeYS174EW7RYp@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afhNeYS174EW7RYp@nvidia.com>
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

On Mon, May 04, 2026 at 04:40:41AM -0300, Jason Gunthorpe wrote:
> On Fri, May 01, 2026 at 04:19:15PM -0600, Alex Williamson wrote:
> 
> > Exporting dma-bufs from vfio-pci is a feature, but mmap of MMIO BARs is
> > a legacy requirement.  That legacy requirement now depends on
> > PCI_P2PDMA, which depends on 64BIT and ZONE_DEVICE.
> 
> That should be split up now, Leon missed it when he added the new
> APIs that didn't require ZONE_DEVICE..

Sorry, what did I miss here?  
VFIO_DMABUF is an optional feature and is enabled only when P2P support is  
available. It does not affect legacy systems where P2P cannot be enabled.

Thanks
