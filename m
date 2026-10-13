Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF98ACC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9D4E10E1E9;
	Tue, 13 Oct 2026 11:46:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B51110E1E9
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 11:46:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8273B60A52;
 Tue, 13 Oct 2026 11:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8038F1F00893;
 Tue, 13 Oct 2026 11:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791891995;
 bh=AyME3jR7BKGEt07ty8V+1z5F5uRyjmv3ys/agNuvJak=;
 h=From:To:Cc:Subject:Date;
 b=oBf5KZ1c8p5kslshibazXIXYaJWMCXDB18z0RZoGLnWIja2RtDgsWi/diPYpiGhgU
 QAy0oJ2giJIoc1VZK92U9LKttxCdHgisyfu8esfOk93E4Hsdv1WQfelvt7jPf86e/d
 XwYjXkba8mKOm6PK4VkdC5xB0NG9lZxmtfIG6hL+s5n6jZWPMCnJ509tayXYq7ZriO
 zZDseqi+1wlBQREF3iqu1eBAHBcSb5puBDRzvAfW9fi6YdjAW64nwbgoWf2UrzZ53a
 HsHF/38c55xe++N7gwH5sNbLc0U+Q3/Ru5N5Iz6Kl8QvHNey40mEZIILim9B4N4IvF
 9icEfONSczQlQ==
From: Leon Romanovsky <leon@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Kevin Tian <kevin.tian@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
 Ankit Agrawal <ankita@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] dma-buf: Restore the scatterlist entry count before freeing
Date: Tue, 13 Oct 2026 14:46:24 +0300
Message-ID: <20261013-dma-buf-fixes-v1-1-0e2d9ca41f3a@nvidia.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20261013-dma-buf-fixes-99dd3fd00f48
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
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

From: Leon Romanovsky <leonro@nvidia.com>

dma_buf_phys_vec_to_sgt() clears orig_nents to mark the returned table
as DMA-only. Since sg_free_table() uses orig_nents to walk and free the
scatterlist, dma_buf_free_sgt() leaks the allocation on every successful
map/unmap cycle.

Restore orig_nents from nents before freeing the table. The helper
allocates the DMA list directly, so nents retains the allocation count,
including for chained scatterlists.


The reported kmemleak output was:

KMEMLEAK LEAK: 2 driver-related leak(s)
KMEMLEAK LEAK: unreferenced object 0xff11000125ceff00 (size 32):
KMEMLEAK LEAK:   comm dtr, pid 4432, jiffies 4295031027
KMEMLEAK LEAK:   hex dump (first 32 bytes):
KMEMLEAK LEAK:     02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
KMEMLEAK LEAK:     00 00 01 00 28 38 00 00 00 10 00 00 00 00 00 00  ....(8..........
KMEMLEAK LEAK:   backtrace (crc 4e8077f2):
KMEMLEAK LEAK:     __kmalloc_noprof+0x451/0x8b0
KMEMLEAK LEAK:     __sg_alloc_table+0x2a0/0x4d0
KMEMLEAK LEAK:     sg_alloc_table+0x24/0x170
KMEMLEAK LEAK:     dma_buf_phys_vec_to_sgt+0x84f/0xed0
KMEMLEAK LEAK:     0xffffffffa1ad21a8
KMEMLEAK LEAK:     dma_buf_map_attachment+0x138/0x690
KMEMLEAK LEAK:     ib_umem_dmabuf_map_pages+0x249/0xc90 [ib_core]
KMEMLEAK LEAK:     0xffffffffa138f8d2
KMEMLEAK LEAK:     0xffffffffa1396abe
KMEMLEAK LEAK:     0xffffffffa1331a5f
KMEMLEAK LEAK:     0xffffffffa13320dd
KMEMLEAK LEAK:     0xffffffffa1ad696d
KMEMLEAK LEAK:     0xffffffffa1acecc7
KMEMLEAK LEAK:     0xffffffffa1acfd17
KMEMLEAK LEAK:     __x64_sys_ioctl+0x72c/0x11f0
KMEMLEAK LEAK:     do_syscall_64+0xa1/0x4f0
KMEMLEAK LEAK: unreferenced object 0xff1100016dbf3a80 (size 32):
KMEMLEAK LEAK:   comm dtr, pid 4432, jiffies 4295034705
KMEMLEAK LEAK:   hex dump (first 32 bytes):
KMEMLEAK LEAK:     02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
KMEMLEAK LEAK:     00 20 10 00 28 38 00 00 00 10 00 00 00 00 00 00  . ..(8..........

Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/dma-buf/dma-buf-mapping.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 833be519e1e6..cbdf99cb0e05 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -251,6 +251,8 @@ void dma_buf_free_sgt(struct dma_buf_attachment *attach, struct sg_table *sgt,
 				       sg_dma_len(sgl), dir, DMA_ATTR_MMIO);
 	}
 
+	/* Restore the allocation count cleared for the DMA-only table. */
+	sgt->orig_nents = sgt->nents;
 	sg_free_table(sgt);
 	kfree(dma->state);
 	kfree(dma);

---
base-commit: 39d3758108bb0ef9da484062d65288bbe9cada0e
change-id: 20261013-dma-buf-fixes-99dd3fd00f48

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>

