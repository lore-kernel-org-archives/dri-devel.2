Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB42C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAB6510E5BE;
	Tue, 28 Jul 2026 17:03:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DZ4pExMO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD8FB10E5BE
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 17:03:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7973742A32;
 Tue, 28 Jul 2026 17:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52771F000E9;
 Tue, 28 Jul 2026 17:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785258201;
 bh=u9pyGo/bX56GRdBwH3XeDez60k6oiGIzm/4ERQYMses=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=DZ4pExMOg1TE0BGLLjY/U2V0GXflmTbACqfxDmKcxeBh/LRCgbEFOp0z3LzviNade
 MQ6gsZWQGLann+LGWiBImO+3wlnDltSMpelAtyzkdYVPRdUfoZaN0j2b1q7h+9jQy6
 V4LbN7IafEFzmEibNaGn/+D2ATA8ZAmnZ0qrsf+7KBHE81RLbXd1tl4FM/7+cl2l3i
 WxsOSdysVNJeP1NDXyk2hzskb3Oumz0fabAp9sAW2LJiO8/RH/mGfxBLuzU9WSVOSm
 1ez7TuTYA5tq40aXRPR7rcyGr49hD61zwlRlFYZRstosjpdRxtXRCK8iU8wv6/oZ/G
 G2fz22yXxez9g==
Date: Tue, 28 Jul 2026 11:03:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Michael Guralnik <michaelgur@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v12 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <amjg1x6QuEHtGp4M@kbusch-mbp>
References: <20260715204008.3911275-1-zhipingz@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715204008.3911275-1-zhipingz@meta.com>
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

On Wed, Jul 15, 2026 at 01:39:55PM -0700, Zhiping Zhang wrote:
> This series adds TLP Processing Hints (TPH) support to the VFIO dma-buf
> export path, allowing importing drivers (e.g. mlx5) to use the
> exporter's steering tag when performing peer-to-peer DMA into a
> VFIO-owned device.

Thanks, Zhiping. This looks good to me.

Acked-by: Keith Busch <kbusch@kernel.org>
