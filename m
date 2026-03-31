Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C043F10F92F2
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 19:44:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 205B110E971;
	Tue, 31 Mar 2026 19:44:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q3/LFlfZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E324010E971
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 19:44:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 57F4444341;
 Tue, 31 Mar 2026 19:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F5EC2BCB2;
 Tue, 31 Mar 2026 19:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774986245;
 bh=jGGUJKYrNdV8MrZToA2w5hj3QV82YHccM4CmlfqrLZI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Q3/LFlfZuSyNzsTx+6YfPrMA8hjusRnQdSbDNm1uLtyw2tdOl0S/wuHE+sPFUrKHx
 vBNdpyBqm5EjQXRbJgCLoKwCwUAA15df0M2MJ4HLq0fsV83v8LW5RC2oDT7aAA8UJX
 8bwdTpDVolQoPS0sF48lnz0DXH2mUiVAMxuLpmkeg+L/uviUi4p2NGmHjqjTk1cKzT
 bHeWYYJNPnXHa7hhXi9pjF0M2I52ntniXF0Q2sYFxQHqZxfNtd+0ftCaxZ222xj++W
 XZDKarZ7rwu30MFv95BHt8xBnzedg3sCeHRf8SxbEAoBXu9PHr+rCW/ubZAfxD4z+g
 4RbgcSXcTlBRA==
Date: Tue, 31 Mar 2026 13:44:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
Message-ID: <acwkAo2k41xaxdTS@kbusch-mbp>
References: <20260324234615.3731237-2-zhipingz@meta.com>
 <20260325082534.GN814676@unreal> <acW2BwQKaUbS3eL9@kbusch-mbp>
 <20260331083758.GA814676@unreal> <acvFV8c5QVxnt3Em@kbusch-mbp>
 <20260331132942.GC814676@unreal> <acvNsvS5ShlQlrox@kbusch-mbp>
 <20260331140309.GH814676@unreal> <acvWplw67b3Gwlkc@kbusch-mbp>
 <20260331190220.GI814676@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331190220.GI814676@unreal>
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

On Tue, Mar 31, 2026 at 10:02:20PM +0300, Leon Romanovsky wrote:
> 
> Right, what about adding TPH fields to struct vfio_region_dma_range
> instead of struct vfio_device_feature_dma_buf?

You might have to show me with code what you're talking about because I
can't see any way we can add fields to any struct here without breaking
backward compatibility.

If we can't claim bits out of the unused "flags" field for this feature,
then my initial reply is the only sane approach: we can introduce a new
feature and struct for it that closely mirrors the existing one, but
with the extra hint fields.
