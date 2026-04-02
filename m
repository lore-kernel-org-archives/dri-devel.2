Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3842CC6B00
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 04:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0964610EE9F;
	Thu,  2 Apr 2026 04:41:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tq4XUsxO";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0AC710EE9F
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 04:41:42 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso96841166b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 21:41:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775104901; cv=none;
 d=google.com; s=arc-20240605;
 b=JUFx+82yA891Yw0Yvd3R9N5HmMhcR5iWja79nNODd7vQPHcGJTA0uzbHbtKjAdk/1m
 7IZXbplV2C+mbKgXOB7x1e6j7W0zsCwgkHVDO44dQY3Q52G1NCR0YujroXG6m68hHP4i
 wk/ABXXUflAlAANY/PlSNqk/IeXbpcjAPsjbdq8FprXNkduDbUoDsU+WoGTOJzSPbm7G
 IVS3gGgwP07uhHisP1gnw/tAx7NfmHYPyQE864PK7arxwgHrC9ky93Rz3O7gRrTxz9hN
 ybwn/emVdyGEKlrFk+TVNllLsnj88oJKJP4oATth8AX4tEtA9cfICnLCp+LQcpDXLht2
 SRcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MsqizXttng34qJSYG1+nQy1RthHCf+vtWgekNCi7+qE=;
 fh=Rs2eI7Wz7c6QGDqYmOo9npHKQRQc9NynvZQmJmLe9iQ=;
 b=BkgHS2cQxxjaD/Q670iZSuzpE4jrm7igKGcAQ8XvIKGvBcBoBx+QfkJ9qyG7RxzIXp
 sVBiDqGmGQEasEQ6w1upvc3TgMpTW8fYfrxxcTvx7k5qcIaPMxutVZQ5mp/KQC1w0wrB
 vYMIpSFQ3su/RXOj5HC1RFvcP7DyCffWJeISV8QA3t/015NLr6AsbaC++/sMBi40+tEJ
 Q6w+h8QCWk9A4eh+4Tmsq7aCxP91FgYCUrQzwNZ2Ozwt7VJZdPokGIE3pQ3dzlpCYYfE
 ZP+C8K6hvoNoqucZ49VgQGT01RrFODr7cUPcu9UUM7cXNVw4pMZldmJ5IZL3Hu+ZcfAe
 uBZg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775104901; x=1775709701; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MsqizXttng34qJSYG1+nQy1RthHCf+vtWgekNCi7+qE=;
 b=tq4XUsxOWzXOFm891VvJpfDrSGS96htWRVKejA79JmDcuriHRRG+gW03PVgNA9l4fn
 9SecbAlPZBxdEx6vhaCw8tMGcAmmb6UDSJiUAqh3G1pJs5QKkyleG6tmvhpOU2GimULZ
 RjAhEIAmmpYGesxYWVqqZIps1hwjbygE6SbJeGjVYdRHNC9ToqHt8TkF4Wt1YBo2IWYa
 KSdRS22GcT3dwUdHUep+bOGPrl+IC2RwjmvVS43G168Qf2pEI7l2LoC9aECVFDjGS3u9
 qkxOxgPfKKOyPADiJTUD1qNVmTjCvAi6u+KtxqYYcI2vK9GZqnGb6ep+GLIM6Mtgb5/F
 2T/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775104901; x=1775709701;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MsqizXttng34qJSYG1+nQy1RthHCf+vtWgekNCi7+qE=;
 b=NxwHZyhEYQrC20wuj0tm2MXOb/an5t8QgQ+0y0wlRNkcZM7L+WCCP70wpEIKtHl0FZ
 jB/lDxGEz9JtmcuZXxU8ZSS2/kKCr1FB5mqCe2rq9Ze4ZrvmpRY3RI/9R8+NNZkMQ1Ti
 hOpCGebgKTLGR3lr27ajRalmhTwMbgnysQdTCZ6IT4pA7ZlUuso/LSmVOydLs7vuQ7lq
 mblcuXFmc+WTwf2p3V9gxHe+yBc/NMLIdnJp1tRde1TXiurhWxQkfebuGRte1CojaAWp
 T2G4hd7ZYxAWY+g2MMm0wkkKUJF7oDw62dFt8usMVAn2+wGSRx1qjdLV0hdaMbRbSO0S
 fm/Q==
X-Gm-Message-State: AOJu0YybRXO6WY+3uGOrhkTRgm+N+nBx75TU0XWF/rNhIpPgRDiEvKFC
 v3XLAP3B4XzlSzqdTODPfRR44nXxDGVd4ASkefgGUUQBRqS5RNhyGQ1fGEtWkkvrPqXX1+lr2ol
 JYpSAad824mFWqPFeR5Iq6XhmPlhtdaOImXjkGPWHbg==
X-Gm-Gg: ATEYQzzZh8Iy7cBE2k/OomUawl+MpbVKDukEMvPREQjKyqJJluGm5ejuVPXDP7qtpW8
 dKbjXxOAvoaHFGdfMgRi0mGUTkJr/abRY8P5RbYENgQ8/aOm/yxzgzPZppsunn535g97dhtIr8E
 RRxUvFxWEWkprDPh48GV2zC0JIw+wu/dNSzZHpH458jL+FT8tFA5KKcInFNIdGf7QQwUnrz31jO
 KxvCXFDuJ/iy4We+BL9hnBcoN855od3Bo+5//T9YMBX0Wd5/cvx5e1vMSL3ZJN4rQmIc+iuyDuI
 6Sk4NY5jwa0M/tshm8kFZc1wDRKRMzDCu5YxqX4=
X-Received: by 2002:a17:907:8694:b0:b93:8275:795a with SMTP id
 a640c23a62f3a-b9c46fedc2cmr44691666b.15.1775104901064; Wed, 01 Apr 2026
 21:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260325192352.437608-1-jiri@resnulli.us>
In-Reply-To: <20260325192352.437608-1-jiri@resnulli.us>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 2 Apr 2026 10:11:29 +0530
X-Gm-Features: AQROBzCoqOVd8w8IT8q-wzhadg7W4rdnhn-HGLlu-Tm0fuk9WqMGP5WDrs9ZghY
Message-ID: <CAO_48GEUXpcFBiyJAMgTcGPSq56-mZ0qnO3FrFRM2LoGd8W6HA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] dma-buf: heaps: system: add an option to allocate
 explicitly shared/decrypted memory
To: Jiri Pirko <jiri@resnulli.us>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 iommu@lists.linux.dev, linux-media@vger.kernel.org, 
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com, 
 tjmercier@google.com, christian.koenig@amd.com, m.szyprowski@samsung.com, 
 robin.murphy@arm.com, jgg@ziepe.ca, leon@kernel.org, sean.anderson@linux.dev, 
 ptesarik@suse.com, catalin.marinas@arm.com, aneesh.kumar@kernel.org, 
 suzuki.poulose@arm.com, steven.price@arm.com, thomas.lendacky@amd.com, 
 john.allen@amd.com, ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, 
 linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
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

Hello Jiri,

On Thu, 26 Mar 2026 at 00:53, Jiri Pirko <jiri@resnulli.us> wrote:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> Confidential computing (CoCo) VMs/guests, such as AMD SEV and Intel TDX,
> run with private/encrypted memory which creates a challenge
> for devices that do not support DMA to it (no TDISP support).
>
> For kernel-only DMA operations, swiotlb bounce buffering provides a
> transparent solution by copying data through shared memory.
> However, the only way to get this memory into userspace is via the DMA
> API's dma_alloc_pages()/dma_mmap_pages() type interfaces which limits
> the use of the memory to a single DMA device, and is incompatible with
> pin_user_pages().
>
> These limitations are particularly problematic for the RDMA subsystem
> which makes heavy use of pin_user_pages() and expects flexible memory
> usage between many different DMA devices.
>
> This patch series enables userspace to explicitly request shared
> (decrypted) memory allocations from new dma-buf system_cc_shared heap.
> Userspace can mmap this memory and pass the dma-buf fd to other
> existing importers such as RDMA or DRM devices to access the
> memory. The DMA API is improved to allow the dma heap exporter to DMA
> map the shared memory to each importing device.

Thank you for the patch series, it looks good to me.

Marek, if you are ok, please could you take it through your tree, with my
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>

Best,
Sumit.
>
> Based on dma-mapping-for-next e7442a68cd1ee797b585f045d348781e9c0dde0d
>
> Jiri Pirko (2):
>   dma-mapping: introduce DMA_ATTR_CC_SHARED for shared memory
>   dma-buf: heaps: system: add system_cc_shared heap for explicitly
>     shared memory
>
>  drivers/dma-buf/heaps/system_heap.c | 103 ++++++++++++++++++++++++++--
>  include/linux/dma-mapping.h         |  10 +++
>  include/trace/events/dma.h          |   3 +-
>  kernel/dma/direct.h                 |  14 +++-
>  kernel/dma/mapping.c                |  13 +++-
>  5 files changed, 132 insertions(+), 11 deletions(-)
>
> --
> 2.51.1
>
