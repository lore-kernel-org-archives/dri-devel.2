Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938F1606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RrQyEIhv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0AF610E645;
	Thu, 12 Nov 2026 19:17:04 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 332B410E656
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 19:16:58 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso1124355e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 11:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794511016; x=1795115816; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QifT63FLPlBaRBfMwdlPD9GRxtpIvQpF5WAaBnQtQ4E=;
 b=RrQyEIhvUfqJaWHE0lKO9XZiAmDou8MdssKv7hGXfmXybSztqoIpIVg5lkoyeoyGHC
 11sZwxhoiMvgcRX1VCBFpchIBeZxCz8BrgGhEqnmlSIUewMDvsyO1+j5BsL/HNQJnNBg
 PPFtWDh2iBO2ExJNj8b0AvOsg04YI7xowBN+C7qbQIZb1GLwMsqJc/elreA2ZUV5rQ+E
 aV8SPOJCkyZzDnoeD5FgEePI2No/+yeiUmwLQh+rextmnxzfBniCbiz2lvoO7Whn2g8f
 X0Ka5iWlx3o1lTqt4lfDeVHOzAjFscpO11j7Dm05kTPAGJRYNOn+xVBS0y3ND7/XK98K
 pPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794511016; x=1795115816;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QifT63FLPlBaRBfMwdlPD9GRxtpIvQpF5WAaBnQtQ4E=;
 b=jm6OLbmlCscQH2p4zpF18+8xDPPMbTcbZONe/U6FVbMARhzy64mlHvO8zg8cGRRzZL
 Lf4aLXRs9j/h/9GBuuHINxCNes39AtFxlQIiJkskI54RaBzWKYf4EKMckPtW6lQpPzaP
 6wuHHDKO/OsBBBm0cLapM1phCftkqC91WsaovlQ5aMNLL6IybmGZ+L3AGCmO9ttOTqUZ
 7lQXTBVGHvRDNgDLF/X8pygEGtGYKabvEeRESs7VF7s4FCOZGdidtbBOslCtHhrZDfiO
 kdH6q0TC/3CV364YmeEhz1fhhcwM3VJ4DHe3WzS89+OvwHtsakIcyhDEBwgAsBd9vuYR
 4PHw==
X-Forwarded-Encrypted: i=1;
 AL+hErHV/hXyeQu6yeX7qlTaarw3BzKrkadW6jb/ZCCCAE3nA9ecYC0pDlbNFHuxJXnUQFlJQ08IshgHIZ4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9g6L0cRG/GjVLv1dk1s4Mxu5TodoYwMMBen/IkzMxtw9zycFwN
 fn5D4v5qKbO5X1hAmHFQBiULuiZBOOshVY1EhQgYSqVTNwFNSmUawRZZ
X-Gm-Gg: AYBFou0kV83htVfChf1XFeOWNztXGnragXJ4f+U550qLJc5DBJ7rw3fLV/ubMqoKx08
 96Hia7eop2dI0wdYl5MbduSYL8Pukhxtksz2R1mo/IgQlL0Mi+Nazcxb0UjlGem1aM9ZqRx6dIk
 OklERHBYFoeKKF4WMwxAitkQHH5oqNe/DvF6WfZmfZIk2f7GCzpPD9JaCq51wRJ4KCnapUEJU7z
 HUWi1/Xq3/sJJCijDs/wRZETEnfHCXdPukHSJGsit6JTMK7JHcW97v8flu4q9Evnk4xiY0TdpNh
 gOS2PcX8v2COf14aD4yjA33Hkdh4ph/puUbM001aZ2r0bWOWCa9C8vzIQIBudlFL8ejjG9x2jyK
 3uq11DQIi5sKHYoza+mmrJfzLvHjQBSOgu3wVfqrZ8cpi5NBrX1YaviE6Hh1oGQYRWVGB2irUMw
 qo0uFqyRkdWNQ39pfAl39WNiOPdF8ByBvzRznEGShhfekGTsFtrhENEOrCT89mYazLdWLNDgcaS
 ANAnD5Kwgv7op26/2wSGW2pTeI/SrZxTaOAotuAEOPLSOE7Q+ZIN/gbqxop00rI1OgBrpKpNNi0
 2bmijQBtV8tImUWoMxcPodepVHGMz9poVl8yQcyd+2CgWBlm+CxkHtBurMtNgkA=
X-Received: by 2002:a05:600c:1d03:b0:4b1:4017:c4f4 with SMTP id
 5b1f17b1804b1-4bb55a58e1amr4456295e9.20.1794511016325; 
 Thu, 12 Nov 2026 11:16:56 -0800 (PST)
Received: from osama ([2a02:908:186:df80:da60:20d5:2c9a:fdcd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55afb6absm2821045e9.15.2026.11.12.11.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 11:16:55 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Akash Goel <akash.goel@arm.com>, Karunika Choo <karunika.choo@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panthor: Fix race when retrieving the new chunk in
 panthor_heap_grow()
Date: Thu, 12 Nov 2026 20:16:50 +0100
Message-ID: <20261112191650.735850-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

panthor_heap_grow() allocates a new chunk with panthor_alloc_heap_chunk(),
which adds the chunk at the head of heap->chunks under heap->lock, and
then drops the lock. panthor_heap_grow() then assumes the head of the
list is the chunk it just added, and reads its GPU VA through
list_first_entry() without holding heap->lock.

panthor_heap_grow() and panthor_heap_return_chunk() only take pool->lock
in read mode, and tiler OOM events of different groups are processed in
parallel on the unbound heap_alloc_wq. If two groups use the same heap
context, they can modify the chunk list concurrently:

  group A OOM work                     group B OOM work
  alloc C_A, list_add()
                                       alloc C_B, list_add()
  list_first_entry() -> C_B
                                       group scheduled out:
                                       panthor_heap_return_chunk(C_B)
                                         list_del(), destroy BO, kfree()
  C_B->bo                              <- use-after-free

Even without the free, both groups end up being handed the same chunk,
and the chunk allocated by group A is never linked to the heap context.

Fix this by having panthor_alloc_heap_chunk() return the GPU VA of the
chunk it allocated, retrieved before the chunk is published in the list,
instead of looking it up afterwards.

Fixes: 9cca48fa4f89 ("drm/panthor: Add the heap logical block")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_heap.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
index 99311abdf1e9..d80f514366fd 100644
--- a/drivers/gpu/drm/panthor/panthor_heap.c
+++ b/drivers/gpu/drm/panthor/panthor_heap.c
@@ -139,7 +139,8 @@ static void panthor_free_heap_chunk(struct panthor_heap_pool *pool,
 
 static int panthor_alloc_heap_chunk(struct panthor_heap_pool *pool,
 				    struct panthor_heap *heap,
-				    bool initial_chunk)
+				    bool initial_chunk,
+				    u64 *chunk_gpu_va)
 {
 	struct panthor_heap_chunk *chunk;
 	struct panthor_heap_chunk_header *hdr;
@@ -181,6 +182,15 @@ static int panthor_alloc_heap_chunk(struct panthor_heap_pool *pool,
 
 	panthor_kernel_bo_vunmap(chunk->bo);
 
+	/*
+	 * Retrieve the GPU VA before the chunk becomes visible in the heap
+	 * chunk list: once heap->lock is released, a concurrent grow or
+	 * return_chunk on the same heap can modify the list, and the chunk
+	 * can be freed.
+	 */
+	if (chunk_gpu_va)
+		*chunk_gpu_va = panthor_kernel_bo_gpuva(chunk->bo);
+
 	mutex_lock(&heap->lock);
 	list_add(&chunk->node, &heap->chunks);
 	heap->chunk_count++;
@@ -216,7 +226,7 @@ static int panthor_alloc_heap_chunks(struct panthor_heap_pool *pool,
 	u32 i;
 
 	for (i = 0; i < chunk_count; i++) {
-		ret = panthor_alloc_heap_chunk(pool, heap, true);
+		ret = panthor_alloc_heap_chunk(pool, heap, true, NULL);
 		if (ret)
 			return ret;
 	}
@@ -437,8 +447,8 @@ int panthor_heap_grow(struct panthor_heap_pool *pool,
 {
 	u64 offset = heap_gpu_va - panthor_kernel_bo_gpuva(pool->gpu_contexts);
 	u32 heap_id = (u32)offset / panthor_heap_ctx_stride(pool->ptdev);
-	struct panthor_heap_chunk *chunk;
 	struct panthor_heap *heap;
+	u64 chunk_gpu_va;
 	int ret;
 
 	if (offset > U32_MAX || heap_id >= MAX_HEAPS_PER_POOL)
@@ -473,14 +483,11 @@ int panthor_heap_grow(struct panthor_heap_pool *pool,
 	 * further jobs in this queue fail immediately instead of having to
 	 * wait for the job timeout.
 	 */
-	ret = panthor_alloc_heap_chunk(pool, heap, false);
+	ret = panthor_alloc_heap_chunk(pool, heap, false, &chunk_gpu_va);
 	if (ret)
 		goto out_unlock;
 
-	chunk = list_first_entry(&heap->chunks,
-				 struct panthor_heap_chunk,
-				 node);
-	*new_chunk_gpu_va = (panthor_kernel_bo_gpuva(chunk->bo) & GENMASK_ULL(63, 12)) |
+	*new_chunk_gpu_va = (chunk_gpu_va & GENMASK_ULL(63, 12)) |
 			    (heap->chunk_size >> 12);
 	ret = 0;
 
-- 
2.53.0

