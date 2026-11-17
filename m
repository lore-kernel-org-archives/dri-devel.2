Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6C0606A331
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mdzett+m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AF4210E557;
	Tue, 17 Nov 2026 09:24:29 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED40C10E557
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=SX
 zizJh/I1z751B/WWLKsF4keqjuniSUyB3NsIxFwnE=; b=mdzett+mmztmgU3zIg
 ZPISE9LCttyKWPVrwTkKzUOF6+9dggo7GtRt8qzl8oNRJ9iJAONibAulthW1uGEd
 M/U+pPgKA1Zo0oB3aBsEISyQF74G3TADLn2WfcwZtPihuP3IZnBvz13pI14sTynF
 2mzGvQ3MzxZ7B2arvU17HKMhY=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id
 _____wD3fyIIHfxqgOjrIA--.26565S2; 
 Tue, 17 Nov 2026 17:23:22 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: ksinyuk@kernel.org, elbaz.koby@gmail.com, ogabbay@kernel.org,
 kees+treewide@kernel.org, haoxiang_li2024@163.com, oshpigelman@habana.ai
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] accel/habanalabs: add missing unmap in map_device_va()
Date: Tue, 17 Nov 2026 17:23:20 +0800
Message-Id: <20261117092320.1267136-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3fyIIHfxqgOjrIA--.26565S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArWUKFWfJw1fAF15Cw1xZrb_yoW8Zr1xpr
 WFga9rKw47WrZrXFWUJw48Z34rJ39YgrWxCFy7CasI9as3X342vF10yFWjqrW7CFyxC3Zx
 ArWUJw1kWayrAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEJPE7UUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7gojkWr8HQqU9gAA31
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If MMU cache invalidation or prefetch setup fails after
map_phys_pg_pack() succeeds, map_device_va() returns the VA range
to the free list without removing the device page table entries.

Unmap the page pack and invalidate the MMU cache under mmu_lock
before continuing with the existing cleanup.

Fixes: 8ff5f4fd40df ("habanalabs: handle MMU cache invalidation timeout")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/accel/habanalabs/common/memory.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/common/memory.c b/drivers/accel/habanalabs/common/memory.c
index 2f76776b4039..6269f9371426 100644
--- a/drivers/accel/habanalabs/common/memory.c
+++ b/drivers/accel/habanalabs/common/memory.c
@@ -1195,7 +1195,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args, u64 *device
 				ctx->asid, ret_vaddr, phys_pg_pack->total_size);
 	mutex_unlock(&hdev->mmu_lock);
 	if (rc)
-		goto map_err;
+		goto range_err;
 
 	/*
 	 * prefetch is done upon user's request. it is performed in WQ as and so can
@@ -1205,7 +1205,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args, u64 *device
 		rc = hl_mmu_prefetch_cache_range(ctx, *vm_type, ctx->asid, ret_vaddr,
 							phys_pg_pack->total_size);
 		if (rc)
-			goto map_err;
+			goto range_err;
 	}
 
 	ret_vaddr += phys_pg_pack->offset;
@@ -1225,6 +1225,14 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args, u64 *device
 
 	return rc;
 
+range_err:
+	mutex_lock(&hdev->mmu_lock);
+
+	unmap_phys_pg_pack(ctx, ret_vaddr, phys_pg_pack);
+	hl_mmu_invalidate_cache_range(hdev, true, *vm_type,
+			ctx->asid, ret_vaddr, phys_pg_pack->total_size);
+
+	mutex_unlock(&hdev->mmu_lock);
 map_err:
 	if (add_va_block(hdev, va_range, ret_vaddr,
 				ret_vaddr + phys_pg_pack->total_size - 1))
-- 
2.25.1

