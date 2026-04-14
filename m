Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A38F9D0E8
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 17:34:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 159B310E640;
	Tue, 14 Apr 2026 17:34:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d99lLNat";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ED3610E640
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 17:34:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D34C64356F;
 Tue, 14 Apr 2026 17:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408C2C19425;
 Tue, 14 Apr 2026 17:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776188056;
 bh=bIYKUg6KM4B2jwA0U61DhG5RQJNqCIi7oMSl3PzaDqA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d99lLNat3zpmep1gV8Utf8/s8GvEKvRmD1JIrFdWoUlLy+SRr72tOv+ONZzBcdwo2
 r3Y0+CBIA+/SOEpyQpdl7GLlSx7LuWs5ZrQP+QQ8VKMTuH6vXmN1GrqawyyBSsqgli
 /iKWZbo+UQuapoELb+8sOji5Ed9TICOV+vYgyZTcEOrHXMPfTSyYZzIMbcTRsog6r0
 GRE1DrcqxyTnIUJp4SvqHFMGm7urtEDKS3rkC9h2uAJ5jdSvH2sB7m9sHQVUODrgyo
 QQqvlg8HhNaHUC93ntQl2YvEzHhBhBUr4DncCpFiGi8lKA3FrU19LKznpoZKvxwIAq
 wQqZxnWE/Xt7A==
Date: Tue, 14 Apr 2026 11:34:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
Message-ID: <ad56liSM4zI2SWWp@kbusch-mbp>
References: <acW2BwQKaUbS3eL9@kbusch-mbp> <20260331083758.GA814676@unreal>
 <acvFV8c5QVxnt3Em@kbusch-mbp> <20260331132942.GC814676@unreal>
 <acvNsvS5ShlQlrox@kbusch-mbp> <20260331140309.GH814676@unreal>
 <acvWplw67b3Gwlkc@kbusch-mbp> <20260331190220.GI814676@unreal>
 <acwkAo2k41xaxdTS@kbusch-mbp> <20260409120415.GF86584@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409120415.GF86584@unreal>
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

On Thu, Apr 09, 2026 at 03:04:15PM +0300, Leon Romanovsky wrote:
> Something like that, on top of this proposal:

...
  
> +struct vfio_region_dma_tph {
> +	u16 tag;
> +	u8 ph;
> +};
> +
>  struct vfio_region_dma_range {
> -	__u64 offset;
> -	__u64 length;
> +	union {
> +		__u64 offset;
> +		struct vfio_region_dma_tph tph;
> +	};
> +	union {
> +		__u64 length;
> +		__u64 reserved;
> +	};
> +};
> +
> +enum {
> +	VFIO_DMABUF_FLAG_TPH = 1 << 0,
>  };

Okay, so you have the hints as a separate action from the dmabuf
creation. I was trying to set it up in one shot, but this proposal may
be fine. We'll try this idea out internally.
