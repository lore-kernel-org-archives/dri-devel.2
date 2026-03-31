Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4FC10F92EB
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 19:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CFEF10EA39;
	Tue, 31 Mar 2026 19:02:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HotHbz1V";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE3510EA39
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 19:02:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B3712600AD;
 Tue, 31 Mar 2026 19:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A1DC19423;
 Tue, 31 Mar 2026 19:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774983747;
 bh=R94WVshWogD2v4hXHETq37YTuAedBBrvIpKh2CGxklY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HotHbz1VpN+dUNKQYC7KDVOBp2EtyGMtsxbWiR4UaZdlPXa08F1P+GYNo8X0Y+PPq
 ISowxrEU6fREnIPbKnvZjP5om8QNQpMUADWipKo8TsAkRHMai/75MFcTYP1JCN89Mg
 NQVZTkO4VWfilvnfBAUIrauuZXubwNw17NP+GPHrPQAn3FUu4mFiDyR228UirXOhJl
 0NY7OWzfD+3DlAUcC8ASJuQIbvKNwv2nDDIJ3cCJDhWH0ROsKcnLwAsyiUv9FPNqrU
 yhNr8p3UYkImGirMJoJkt6oDzxbkZNOXiJ3PM7DYGtmpdUZfeXb71HdYdNrN1RMutv
 OggMmxcQa/t9w==
Date: Tue, 31 Mar 2026 22:02:20 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
Message-ID: <20260331190220.GI814676@unreal>
References: <20260324234615.3731237-1-zhipingz@meta.com>
 <20260324234615.3731237-2-zhipingz@meta.com>
 <20260325082534.GN814676@unreal> <acW2BwQKaUbS3eL9@kbusch-mbp>
 <20260331083758.GA814676@unreal> <acvFV8c5QVxnt3Em@kbusch-mbp>
 <20260331132942.GC814676@unreal> <acvNsvS5ShlQlrox@kbusch-mbp>
 <20260331140309.GH814676@unreal> <acvWplw67b3Gwlkc@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acvWplw67b3Gwlkc@kbusch-mbp>
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

On Tue, Mar 31, 2026 at 08:13:58AM -0600, Keith Busch wrote:
> On Tue, Mar 31, 2026 at 05:03:09PM +0300, Leon Romanovsky wrote:
> > I understand, my proposal is always set TPH flag when new struct is
> > used.
> 
> An existing application recompiled against the new kernel api implicitly
> uses the new struct layout without setting the TPH flag, so kernel and
> application are out of sync on where dma_ranges exists with your
> proposal.

Right, what about adding TPH fields to struct vfio_region_dma_range
instead of struct vfio_device_feature_dma_buf?

Thanks
