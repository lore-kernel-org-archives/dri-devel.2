Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A796109B46F
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 14:14:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7610010E9B0;
	Tue, 31 Mar 2026 14:14:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LzRtQzHM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA7A610E9B0
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 14:14:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B4D5661119;
 Tue, 31 Mar 2026 14:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E590CC19423;
 Tue, 31 Mar 2026 14:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774966440;
 bh=WuDTh1qvVfpreyA+FwkOQW5WOW/1M6AkJSQhmwhXYQk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LzRtQzHM+7ul0hm/xfo7NgRoHCrt2OsiKzgRPhjDXdWwcxZjjMA1P5HJP8+thKeSW
 dCZGnt2cfmJYCJbx98mUnoWzGgRzMfMJF2stE704IIgW7Tbjgn72daUYEYUry8Gmdy
 R8tCM+cdqhYylcd1eMFh+0+fIMAuEvhIYQC/4ADz7OL7uwS0JgIFfh9OJzC+/6zn/W
 VLoTaYI7N0MTfj5Gy52dDY/TJpv4+V4DS/SkF8E1cEIMSB4RKLDsZKgG39HAc4uk5P
 9MD72pRxxmuRylRmH+eDnH0Dyh7f1qRJkvRsUmOIpXJo9oT68WCv6AHCtRXSjeOilT
 nobVfwLzY6fow==
Date: Tue, 31 Mar 2026 08:13:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
Message-ID: <acvWplw67b3Gwlkc@kbusch-mbp>
References: <20260324234615.3731237-1-zhipingz@meta.com>
 <20260324234615.3731237-2-zhipingz@meta.com>
 <20260325082534.GN814676@unreal> <acW2BwQKaUbS3eL9@kbusch-mbp>
 <20260331083758.GA814676@unreal> <acvFV8c5QVxnt3Em@kbusch-mbp>
 <20260331132942.GC814676@unreal> <acvNsvS5ShlQlrox@kbusch-mbp>
 <20260331140309.GH814676@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331140309.GH814676@unreal>
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

On Tue, Mar 31, 2026 at 05:03:09PM +0300, Leon Romanovsky wrote:
> I understand, my proposal is always set TPH flag when new struct is
> used.

An existing application recompiled against the new kernel api implicitly
uses the new struct layout without setting the TPH flag, so kernel and
application are out of sync on where dma_ranges exists with your
proposal.
