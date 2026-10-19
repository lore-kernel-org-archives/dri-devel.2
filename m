Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B5C606A320
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 18:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MwmrRe58
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16C0E10EA88;
	Mon, 19 Oct 2026 18:31:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6081A10EA88
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 18:31:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ECB0040B99;
 Mon, 19 Oct 2026 18:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4155E1F000C4;
 Mon, 19 Oct 2026 18:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792434709;
 bh=4rAOC3LWU4D+fpQNfeaCciHvlznoy08mvb2nzwLCzJo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MwmrRe58qW5gCgNkDhEpNQo/Yx+4ojBXVll0Hyk2CndarxFJqPFTFeGH4qZb1TsXS
 KhKMozcdUezt4bP7B+WmMFDFOLZZ55yLKEQ3PjuuPtc9s8PbxHzUsfIPa8JFkpkRHq
 /DXTtrLoXtJiudJ4JtiJ1iP7LJNmLfMvnWCfUoJ+GofFK3fPnWO7sP8Na6qA0G1AQ1
 10S+4R1PMie5upWKasbG1GMCiYlveGNywqtt+ARhDDvDvJWX/gdNeih5Wh5zMY1VLl
 TFfzJlWteWb8hGT130uyLs6yvR7LcFEVY8GNc84iaio3CQmwMiGDjrbCB/1ZpLndiQ
 CmtpcX0zrz88Q==
Date: Mon, 19 Oct 2026 21:31:46 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Nicolin Chen <nicolinc@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-buf: Restore the scatterlist entry count before
 freeing
Message-ID: <20261019183146.GH64621@unreal>
References: <20261013-dma-buf-fixes-v1-1-0e2d9ca41f3a@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013-dma-buf-fixes-v1-1-0e2d9ca41f3a@nvidia.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 13, 2026 at 02:46:24PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> dma_buf_phys_vec_to_sgt() clears orig_nents to mark the returned table
> as DMA-only. Since sg_free_table() uses orig_nents to walk and free the
> scatterlist, dma_buf_free_sgt() leaks the allocation on every successful
> map/unmap cycle.
> 
> Restore orig_nents from nents before freeing the table. The helper
> allocates the DMA list directly, so nents retains the allocation count,
> including for chained scatterlists.
> 
> 
> The reported kmemleak output was:
> 
> KMEMLEAK LEAK: 2 driver-related leak(s)
> KMEMLEAK LEAK: unreferenced object 0xff11000125ceff00 (size 32):
> KMEMLEAK LEAK:   comm dtr, pid 4432, jiffies 4295031027
> KMEMLEAK LEAK:   hex dump (first 32 bytes):
> KMEMLEAK LEAK:     02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> KMEMLEAK LEAK:     00 00 01 00 28 38 00 00 00 10 00 00 00 00 00 00  ....(8..........
> KMEMLEAK LEAK:   backtrace (crc 4e8077f2):
> KMEMLEAK LEAK:     __kmalloc_noprof+0x451/0x8b0
> KMEMLEAK LEAK:     __sg_alloc_table+0x2a0/0x4d0
> KMEMLEAK LEAK:     sg_alloc_table+0x24/0x170
> KMEMLEAK LEAK:     dma_buf_phys_vec_to_sgt+0x84f/0xed0
> KMEMLEAK LEAK:     0xffffffffa1ad21a8
> KMEMLEAK LEAK:     dma_buf_map_attachment+0x138/0x690
> KMEMLEAK LEAK:     ib_umem_dmabuf_map_pages+0x249/0xc90 [ib_core]
> KMEMLEAK LEAK:     0xffffffffa138f8d2
> KMEMLEAK LEAK:     0xffffffffa1396abe
> KMEMLEAK LEAK:     0xffffffffa1331a5f
> KMEMLEAK LEAK:     0xffffffffa13320dd
> KMEMLEAK LEAK:     0xffffffffa1ad696d
> KMEMLEAK LEAK:     0xffffffffa1acecc7
> KMEMLEAK LEAK:     0xffffffffa1acfd17
> KMEMLEAK LEAK:     __x64_sys_ioctl+0x72c/0x11f0
> KMEMLEAK LEAK:     do_syscall_64+0xa1/0x4f0
> KMEMLEAK LEAK: unreferenced object 0xff1100016dbf3a80 (size 32):
> KMEMLEAK LEAK:   comm dtr, pid 4432, jiffies 4295034705
> KMEMLEAK LEAK:   hex dump (first 32 bytes):
> KMEMLEAK LEAK:     02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> KMEMLEAK LEAK:     00 20 10 00 28 38 00 00 00 10 00 00 00 00 00 00  . ..(8..........
> 
> Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/dma-buf/dma-buf-mapping.c | 2 ++
>  1 file changed, 2 insertions(+)

Reminder, thanks
