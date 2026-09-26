Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF86C98332
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 12:30:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A191510E142;
	Sat, 26 Sep 2026 12:30:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NDMdvgN7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6799B10E142
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 12:30:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1EAF5406E7;
 Sat, 26 Sep 2026 12:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B9C1F000FF;
 Sat, 26 Sep 2026 12:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790425843;
 bh=jWmnr7J4qu50XLlqlwEJX9uF3ohuEh01l7hkZBw4udg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NDMdvgN7zdsJbrPGGtgUlpHSWa5X+tCBjwkOiPPwqzVmEKLh+962MTZSKBrOvDue+
 5iTUQf9MIUFFPmqsCqYENm1fmR4RGguYYt2Pna5Q2+VBZhcfJK26o9tSA+bkecJb+A
 9yeJOcMBXTHmDICCgWYeI1hxmvCZMpV+iiN0a+qtL7XNdpaetzaAPHENZT0vLYkS9v
 25KxuZ1UT8j9ue5eBfNDEdMfWbczlTtoJb4WoZjh2KdFDjrf75vZHUXjuWaF6sxGuB
 /2qET4s5/yNTNLAR+vFMfXdxUORDfAcZ9elhECTSR7o/39v648u2tQCQXyPhMtuysA
 icoq9f3dz92RA==
Date: Sat, 26 Sep 2026 15:30:38 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yili Zhang <zhangyili01@baidu.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Ankit Agrawal <ankita@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dma-buf: Fix IOVA offset when linking phys vecs to sgt
Message-ID: <20260926123038.GT563127@unreal>
References: <20260924065508.27245-1-zhangyili01@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924065508.27245-1-zhangyili01@baidu.com>
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

On Thu, Sep 24, 2026 at 02:55:08PM +0800, Yili Zhang wrote:
> The dma_buf_phys_vec_to_sgt() routine links every physical range into
> the allocated IOVA space at offset zero instead of advancing the offset
> by the already mapped length. This breaks the THRU_HOST_BRIDGE flow
> whenever phys_vec contains more than one entry: the second and
> subsequent dma_iova_link() calls try to install mappings on top of
> PTEs that already exist, which fails and makes the whole conversion
> return an error.
> 
> Fix it by passing the accumulated mapped_len as the IOVA offset. This
> matches the pattern used by all other dma_iova_link() callers and is
> consistent with the rest of the function: dma_iova_sync() and the
> error path in dma_iova_destroy() both operate on the [0, mapped_len)
> prefix of the IOVA space, which assumes that the ranges were linked
> contiguously starting at offset 0.
> 
> Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yili Zhang <zhangyili01@baidu.com>
> ---
>  drivers/dma-buf/dma-buf-mapping.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leon@kernel.org>
