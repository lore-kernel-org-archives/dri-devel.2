Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CBFC61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 07:39:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD3810F03A;
	Wed,  2 Sep 2026 07:39:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SVevXqP8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29B6E10F03A
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 07:39:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EAE0F43ECF;
 Wed,  2 Sep 2026 07:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CDF1F000E9;
 Wed,  2 Sep 2026 07:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788334780;
 bh=Zmj6Pl4DI8aaARUoVXtREi8xmgkB7kHiiAcvl0t361M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SVevXqP8uk4G2qfUr4fRwo9Xv9i/jYjJ+Hift6ITqhh0R31kK+7v5WOiOo9/0ie7j
 4sOXgFXmks/B/0h/21DcWitUMKDWxZYTLiyRsIbbyZZZpO+nouiDx+4eAKL3bch964
 Z0ITjST2BqJve2jB5bjPfpMiqhwbV+7s5F4A2fofmPN494nOQZjDhr0n7HKxZeRvBB
 yfEtheDm5PrO5mtXXpRM3Bx6CPq/6gY14VOKrtpn77K0Fbgi6LM5j3nbK0pUgMpnnU
 2tbzJBXwpgQ2gxvoVNI2PhV6fP7prCxJ05MvzwtMjBEiZwd+CPTJ5WYN4VsnP3/wkq
 UWLcYuhjXx0uQ==
Date: Wed, 2 Sep 2026 10:39:36 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: David Hu <dhu@x6u.co>, sumit.semwal@linaro.org, alex@shazbot.org,
 ankita@nvidia.com, chriscli@google.com,
 david.laight.linux@gmail.com, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, jgg@ziepe.ca, jmoroni@google.com,
 kevin.tian@intel.com, kpberry@google.com,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, nicolinc@nvidia.com, praan@google.com,
 sashiko-bot@kernel.org, stable@vger.kernel.org,
 viursachi@google.com, xuehaohu@google.com
Subject: Re: [PATCH v8 0/2] dma-buf: Fix silent overflow and alignment
Message-ID: <20260902073936.GR24140@unreal>
References: <20260901170849.4052816-1-dhu@x6u.co>
 <2bf581db-7cc5-4f38-a075-1b988c332f3c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2bf581db-7cc5-4f38-a075-1b988c332f3c@amd.com>
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

On Wed, Sep 02, 2026 at 09:00:46AM +0200, Christian König wrote:
> On 9/1/26 19:08, David Hu wrote:
> > From: David Hu <xuehaohu@google.com>
> > 
> > This series address two related issues in scatter-gather mapping,
> > specifically for the MMIO based dma-buf mapping. The fixes ensure
> > sgt mapping is correct, and proper for large MMIO regions.
> > 
> > Patch 1 fixes a silent integer overflow for mapping length exceeding 4G
> > (Previously submitted as [PATCH v7] dma-buf: Fix silent overflow for
> > phys vec to sgt)
> > https://lore.kernel.org/all/20260609164047.486227-1-xuehaohu@google.com/
> > 
> > Patch 2 Splits sgl by largest page aligned chunk
> > (Previously submitted as [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk)
> > https://lore.kernel.org/all/20260722233806.3922093-1-dhu@x6u.co/
> 
> *sigh* such issues are exactly the reason why I didn't wanted the dma-mapping stuff inside DMA-buf. That clearly doesn't belong here.

And this is why so many in the kernel community want to get rid of SG
lists. It would be great if DMA-BUF could also eliminate the need to
convert to an SGL, like Jason proposed.

The DMA layer no longer needs SGL. These bugs belong to the DMA-BUF layer,
which is the one that depends on it.

Thanks
