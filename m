Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7EC60725B7
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A3jkEXpO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B654210EE64;
	Tue, 10 Nov 2026 07:45:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A66AC10EE6E
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 07:44:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0289F63783;
 Tue, 10 Nov 2026 07:44:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794296698;
 b=OrZY2k1zQHXIvY2pIs9sfS7M3I4igLhkPaog+OWoY+fupoIqBdq/DCv95IPtn0HWeu+N
 bb6Pq2AuGvK4lm63BM0fSlsP3UHBh3h4yz6lZlVRz/eMBDYj2YOnNoVw5pO3Bk5gSQO/H
 fPl1DwwEaTRGmhzxqTq4ddRF9VDIAPaBTPWyHmEKz4c4LJa3HTtoDL21bApz0EhYuS5xS
 AwhDXxZNJzLwSop/rhGjoI7tfUhLCwb4n4ZpWoupt9l9twIOQgOmsBvvoLsJ0qQPpj/1U
 BCZccfdZf5/Tb0Ki11QqPKabHPkz1rvHhYcvnbKsWkl9JONBHaxUOJMSVyPSnDhn6EQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794296698;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=bL0W2Z4JP6LW6reZ8aAiCPCa3mYcnz2C1bt6K2RjlIU=;
 b=KtNAzuQErzK6/jvzz/uKMstquW+UUKON5jvapqdGTOPsVpodPAfsQHQD/i5MnmlfltiY
 dopz6bFRCU6p1BAHINiTG+OblpfrHphlhtMK4dfeaNL4DCtQaW2HbHooqpuxfkcApUGvs
 4GQPtVDh9ydtF0w+wSyUfs0sOaLfyjfgG9ZdgFmtvMUUGSOJx8qL/4IzZATU2P7vAIh9X
 iFD6pK9+60xxi99vBxJUgdsBEi1VKFqNhLru9+Mm4fbtUzNm3mPN54gfEuXKcxfgYKcm1
 Y5iVTaJ9C4AKiX2c0KPx99yafG+Aeh4jyvkbkPp6hkyVM9IT+bd++HAc9MJAcUz0LnA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id CDAD41F00904;
 Tue, 10 Nov 2026 07:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794296698;
 bh=bL0W2Z4JP6LW6reZ8aAiCPCa3mYcnz2C1bt6K2RjlIU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=A3jkEXpOiRdLMm3T2j4oYUyLd1e6eTJ6fjZ682NxUSqVdUQ8EMXXq16NQ+/1nKLe7
 YYcUoFASQujQUmTTDrb4g1gfOnmWNI5XeolYD9O+BV23NUjdyE1MrDIYwrYEZ9frM6
 I7D80ou3ysvFvEZOA/Lx9cil3EiwRE/f3jgmZ4c6BGMl+SP4dP38Z0/Gy24U7+Sb3W
 BQQoeGu+r9sg7MK9qOEbiY6BCfEkLeiM116RLVT+ca+u8HkIeh9VfnBL14O/mMcfnv
 3dhDKzGe02KlGTZ+zKutT5O1ZUFpoXt4izPs5rVIKm2whVyFzPrC2oKOO7Qil9ytWv
 f8lYjI+F2ftug==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 5A67548A16;
 Tue, 10 Nov 2026 07:44:56 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:44:58 +0000
Subject: [PATCH 3/7] drm/panfrost: Give back the pages of a heap chunk that
 failed to map
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-panfrost-long-jobs-v1-3-24508939ae8d@gmail.com>
References: <20261110-panfrost-long-jobs-v1-0-24508939ae8d@gmail.com>
In-Reply-To: <20261110-panfrost-long-jobs-v1-0-24508939ae8d@gmail.com>
To: David Airlie <airlied@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Maxime Ripard <mripard@kernel.org>, 
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794296695; l=3323;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=oQpWmLCqf1iAHBCQa+93x7LSuBekHjA6s9/N4mAhsDQ=;
 b=q8FxM+RVA8I02+Ov5R2YmLbImHVeteBSHQilAwpzNNl3kdGphbWOGLak3vslgyHAysQdOCuyP
 qafHNoVHmzECdLI1FfCNx6b0eBsKqBMZ0VgOtJ9nefilrj9qgUeY6uS
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

panfrost_mmu_map_fault_addr() grows a heap BO by one 2 MB chunk per
fault. If reading the chunk's folios, building its sg table, DMA mapping
it or mapping it on the GPU fails, the folios that were already read stay
in bo->base.pages, while the chunk's sg table stays empty. The next fault
in that chunk reads the same folios again and finds their pages already
owned:

  if (drm_WARN_ON(&pfdev->base, already_owned))
          folio_put(folio);

Before commit b49c35ba0ce1 ("drm/panfrost: Fix a page leak in
panfrost_mmu_map_fault_addr() when THP is on") the fault path skipped
pages that were already filled in; since then the array is filled a
folio at a time and an already filled page is treated as a bug.

On those error paths, put the folios read for the chunk and clear their
entries, so that a later fault in it starts from an empty range.

Fixes: b49c35ba0ce1 ("drm/panfrost: Fix a page leak in panfrost_mmu_map_fault_addr() when THP is on")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 34 +++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index ba37da499..13728b0c4 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -597,6 +597,28 @@ addr_to_mapping(struct panfrost_device *pfdev, int as, u64 addr)
 
 #define NUM_FAULT_PAGES (SZ_2M / PAGE_SIZE)
 
+static void panfrost_heap_put_chunk(struct page **pages, pgoff_t start,
+				    pgoff_t end)
+{
+	pgoff_t pg = start;
+
+	while (pg < end) {
+		struct folio *folio;
+		pgoff_t n;
+
+		if (!pages[pg]) {
+			pg++;
+			continue;
+		}
+
+		folio = page_folio(pages[pg]);
+		n = folio_nr_pages(folio);
+		for (pgoff_t i = 0; i < n && pg < end; i++)
+			pages[pg++] = NULL;
+		folio_put(folio);
+	}
+}
+
 static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 				       u64 addr)
 {
@@ -671,7 +693,7 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 		folio = shmem_read_folio(mapping, pg);
 		if (IS_ERR(folio)) {
 			ret = PTR_ERR(folio);
-			goto err_unlock;
+			goto err_put_chunk;
 		}
 
 		pg &= ~(folio_nr_pages(folio) - 1);
@@ -693,7 +715,7 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 	ret = sg_alloc_table_from_pages(sgt, pages + page_offset,
 					NUM_FAULT_PAGES, 0, SZ_2M, GFP_KERNEL);
 	if (ret)
-		goto err_unlock;
+		goto err_put_chunk;
 
 	ret = dma_map_sgtable(pfdev->base.dev, sgt, DMA_BIDIRECTIONAL, 0);
 	if (ret)
@@ -720,6 +742,14 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 	dma_unmap_sgtable(pfdev->base.dev, sgt, DMA_BIDIRECTIONAL, 0);
 err_map:
 	sg_free_table(sgt);
+err_put_chunk:
+	/*
+	 * Give back the folios read for this chunk, so that the next fault in
+	 * it (the chunk has no sg table yet) starts from an empty page range
+	 * instead of finding it partly owned.
+	 */
+	panfrost_heap_put_chunk(pages, page_offset,
+				min_t(pgoff_t, page_offset + NUM_FAULT_PAGES, nr_pages));
 err_unlock:
 	dma_resv_unlock(obj->resv);
 err_bo:

-- 
2.55.0


