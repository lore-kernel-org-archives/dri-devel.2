Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6241109B46D
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 14:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 205D810E262;
	Tue, 31 Mar 2026 14:03:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DTxfuMQN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B305710E262
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 14:03:14 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BD38E6024D;
 Tue, 31 Mar 2026 14:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1EFC19424;
 Tue, 31 Mar 2026 14:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774965793;
 bh=IL6FrHP3uHz8//ln3rvV3AwE9xShRnaGlba1Swd/CcU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DTxfuMQNcKnBOZV95n5BWavkoaGlKAWWfExhRT+itzUFx5gqCaXswy6i02Gq73KjI
 Q2IOghUst9Rx7ZdlOj9a3+Yj+GV9iSozAtDTP8PoHt9qa2MrX1RvEIsMbdGTwhd0R1
 ps0sQQ/kfn+Pjmk+pwd970gylvPJW8FBSVzDD8ZaFefaI2BMXgPwcnOdiQEXGK7WII
 AtzvVT2u9PcGxSOiIRMbs9DkNzB5Dmm2SK+2vEpVZPYRRXn+n5oGdU/JuF0PJqddAc
 VW81dIkzz3F2ZAQtqeFBjWifnIQgDFyQuD0x4jf51t8xqI+vo+RPCbk1GA6ii4yPCN
 OmwfmJsz6icIg==
Date: Tue, 31 Mar 2026 17:03:09 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
Message-ID: <20260331140309.GH814676@unreal>
References: <20260324234615.3731237-1-zhipingz@meta.com>
 <20260324234615.3731237-2-zhipingz@meta.com>
 <20260325082534.GN814676@unreal> <acW2BwQKaUbS3eL9@kbusch-mbp>
 <20260331083758.GA814676@unreal> <acvFV8c5QVxnt3Em@kbusch-mbp>
 <20260331132942.GC814676@unreal> <acvNsvS5ShlQlrox@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acvNsvS5ShlQlrox@kbusch-mbp>
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

On Tue, Mar 31, 2026 at 07:35:46AM -0600, Keith Busch wrote:
> On Tue, Mar 31, 2026 at 04:29:42PM +0300, Leon Romanovsky wrote:
> > On Tue, Mar 31, 2026 at 07:00:07AM -0600, Keith Busch wrote:
> > > On Tue, Mar 31, 2026 at 11:37:58AM +0300, Leon Romanovsky wrote:
> > > > On Thu, Mar 26, 2026 at 04:41:11PM -0600, Keith Busch wrote:
> > > > > 
> > > > > You're suggesting that Ziping append the new fields to the end of this
> > > > > struct? I don't think we can modify the layout of a uapi.
> > > > 
> > > > He needs to add before flex array. This struct is submitted by the user
> > > > and kernel can easily calculate the position of that array.
> > > 
> > > No, you can't just do that. Existing applications would break when they
> > > compile against the updated kernel header. They don't know about this
> > > new "tph" supplied flag, but they'll all accidently use the new
> > > dma_ranges offset. 
> > 
> > So we need to always pass TPH flag and treat 0 as do-nothing-field.
> 
> I don't think you're understanding the implications. If Zhiping appends
> new fields in front of the flex array dma_ranges, then existing
> applications will implicitly use the new offset if they are recompiled
> against the new kernel header. But if the binary was compiled against
> the older kernel header, then that application would use the previous
> offset. Both applications have the TPH flag cleared to 0. How is the
> kernel supposed to know which offset the application used?

I understand, my proposal is always set TPH flag when new struct is
used. Everything will be much easier if we can add fields after flex
array.

Thanks
