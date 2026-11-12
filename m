Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0977606B24C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cfbpIhet
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1960D10FD84;
	Thu, 12 Nov 2026 08:48:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3555610FDBF
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:48:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A83B163DED;
 Thu, 12 Nov 2026 08:48:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794473318;
 b=iWv2KZtPFF+O51UMIgy3FtxzDcw9/u+caQWpv/1lTcCBRCgmrE+MFyXfRCl2WECb0vXE
 z6/6TsVCpW9wPrY3jGz9SrrWqGVF0ayGDQuy0MVCFrUk+HaDBUtHLUUGymRNGt+FbaBdw
 C+DMIRFoKmN/7FdHXRWJNBDU9+6udlKsK/+OrzzRwGyJMQp9HvTVmIek19Iw84VOxQp96
 ga8z1WsBpL865DNYnv6Le5BelKkmcKBkxy9iS5h5h0/NRiU6khL45QGL4RSqt7ZQVi4kB
 bRpZ1bgqqWo2l6hd2UsAnwn7UD0Y6khEkIUxLJnOOznNBZA9cyhKV42AvMDA473brBw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794473318;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=ziXFFYPLQvWFmN181rHfSXwimvjejnaTztC8l9DXINY=;
 b=OjKT/pMEQo8b0LUjWGHXBKb823G5vg8SCfH0SPhDaOlCbAJLnq9d6pbeSS820zzLaWRY
 EwgMwqAs7EAm8C4oPmT+5d5LhR2jhH0maUdhvy7PmBiW+tg/aSdOpaMRqk04L+ZSrVlAQ
 hIUlWzdMKn8J7Ko/3Au6p6tYLHhHYLwt6wRPPuEubFDhTb5GE2f39z5AcMKrH22ZVN2wZ
 3ao+5kHIY6QIwM9pxaezAFvs5HsHg/u6b63VCYkd9JMx51X/NuQjs4LM84ED5VCzLf7ot
 qi7oHBmKt4VzSXm5wNesXJTdlDMETaD/gdI4mqQEiW0sJxyVqdMGxnx0fpUvKDofa4w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id C1E161F00A0C;
 Thu, 12 Nov 2026 08:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794473318;
 bh=ziXFFYPLQvWFmN181rHfSXwimvjejnaTztC8l9DXINY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=cfbpIhet6HYPVFltQJG51hHK/vmHDGFlbxn878aVIdvO5kWJmtvyhrHcb8RVNzYjW
 u96tZAQLTR23zXfk7EtZGkpEJ+rTKeroJ6egszPNoNCgIACPuVpxmOHMoNEGc5/XRG
 JJzqCqJmlHd+qrJATylDIPrV8D5qz4+mXkTKAGbER5D/qbQ+df6ROO25AhewVBTf9x
 IPGfWef9DSI3qE/HFCaw1lLA96Yi+jvSoVKxrYA4f5zc09JB0f+4K43PDTB0Qfgb2G
 nWptLq5g0jJ1mq9mz+bE9jlODoXJ07i8s5t6GfBYaFYk2aFU5zOBgGqX9V0i3Y0skK
 JiEAMX5CQyQVg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 7B63F493F1;
 Thu, 12 Nov 2026 08:48:35 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 08:48:39 +0000
Subject: [PATCH v2 06/11] drm/panfrost: Give back the pages of a heap chunk
 that failed to map
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-panfrost-long-jobs-v2-6-a06830da3d99@gmail.com>
References: <20261112-panfrost-long-jobs-v2-0-a06830da3d99@gmail.com>
In-Reply-To: <20261112-panfrost-long-jobs-v2-0-a06830da3d99@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794473314; l=5223;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=GiYBojJEk+AerOOD5A3CeTX5sdW5+aVhVP91wLrsHZ0=;
 b=SqmKe/QDpdPcA2LHOYhq+Qw2NBDL+UFa9BasxWAG4b6ow0ePlb0TBj4RPgef8f/Av2MMot4r4
 n1zBWxzq4CqCjdf7NAtl5Kes67FpT8IxF5ZqigR8pcyFIoNGo24KxT6
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
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
entries, so that a later fault in it starts from an empty range. The
range to clear is the one the fill loop wrote, which is not always the
chunk: the loop aligns down to the start of each folio and fills the
whole folio, so a folio larger than 2 MB (PMD-sized folios with 16K or
64K pages) also fills entries of the neighbouring chunks, and a folio
whose pages the loop found already owned (by such a neighbour) is not
ours to put.

Tested with 4K pages, where the folios are at most 2 MB and never cross
a chunk; the larger-folio case is from reading the code.

Fixes: b49c35ba0ce1 ("drm/panfrost: Fix a page leak in panfrost_mmu_map_fault_addr() when THP is on")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 51 ++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 35fb86b6b..684735937 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -603,6 +603,32 @@ addr_to_mapping(struct panfrost_device *pfdev, int as, u64 addr)
 
 #define NUM_FAULT_PAGES (SZ_2M / PAGE_SIZE)
 
+/*
+ * Put the folios that a failed heap fault took and clear the page array
+ * entries it filled for them. [start, end) is what the fault filled: whole
+ * folios, since it fills the array a folio at a time, which can reach past
+ * the 2 MB chunk when a folio is larger than the chunk.
+ */
+static void panfrost_heap_put_pages(struct page **pages, pgoff_t start,
+				    pgoff_t end)
+{
+	while (start < end) {
+		struct folio *folio;
+
+		if (!pages[start]) {
+			start++;
+			continue;
+		}
+
+		folio = page_folio(pages[start]);
+		do {
+			pages[start++] = NULL;
+		} while (start < end && pages[start] &&
+			 page_folio(pages[start]) == folio);
+		folio_put(folio);
+	}
+}
+
 static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 				       u64 addr)
 {
@@ -611,7 +637,7 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 	struct panfrost_gem_object *bo;
 	struct address_space *mapping;
 	struct drm_gem_object *obj;
-	pgoff_t page_offset, nr_pages;
+	pgoff_t page_offset, nr_pages, got_start, got_end;
 	struct sg_table *sgt;
 	struct page **pages;
 
@@ -670,17 +696,23 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 	mapping = bo->base.base.filp->f_mapping;
 	mapping_set_unevictable(mapping);
 
+	/* The page array range whose folio references this fault takes. */
+	got_start = page_offset;
+	got_end = page_offset;
+
 	for (pgoff_t pg = page_offset; pg < page_offset + NUM_FAULT_PAGES;) {
 		bool already_owned = false;
 		struct folio *folio;
+		pgoff_t first;
 
 		folio = shmem_read_folio(mapping, pg);
 		if (IS_ERR(folio)) {
 			ret = PTR_ERR(folio);
-			goto err_unlock;
+			goto err_put_chunk;
 		}
 
 		pg &= ~(folio_nr_pages(folio) - 1);
+		first = pg;
 		for (u32 i = 0; i < folio_nr_pages(folio) && pg < nr_pages; i++) {
 			if (pages[pg])
 				already_owned = true;
@@ -692,14 +724,18 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 		 * there's no valid reason for a folio range to be partially
 		 * populated.
 		 */
-		if (drm_WARN_ON(&pfdev->base, already_owned))
+		if (drm_WARN_ON(&pfdev->base, already_owned)) {
 			folio_put(folio);
+		} else {
+			got_start = min(got_start, first);
+			got_end = max(got_end, pg);
+		}
 	}
 
 	ret = sg_alloc_table_from_pages(sgt, pages + page_offset,
 					NUM_FAULT_PAGES, 0, SZ_2M, GFP_KERNEL);
 	if (ret)
-		goto err_unlock;
+		goto err_put_chunk;
 
 	ret = dma_map_sgtable(pfdev->base.dev, sgt, DMA_BIDIRECTIONAL, 0);
 	if (ret)
@@ -726,6 +762,13 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 	dma_unmap_sgtable(pfdev->base.dev, sgt, DMA_BIDIRECTIONAL, 0);
 err_map:
 	sg_free_table(sgt);
+err_put_chunk:
+	/*
+	 * Give back the folios read for this chunk, so that the next fault in
+	 * it (the chunk has no sg table yet) starts from an empty page range
+	 * instead of finding it partly owned.
+	 */
+	panfrost_heap_put_pages(pages, got_start, got_end);
 err_unlock:
 	dma_resv_unlock(obj->resv);
 err_bo:

-- 
2.55.0


