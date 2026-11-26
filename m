Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD83C606A33C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYqBBdEW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CABE7112245;
	Thu, 26 Nov 2026 09:38:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7182C112245
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 09:37:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 59FC7464F2;
 Thu, 26 Nov 2026 09:37:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795685854;
 b=siSQ8eCplKL5yHqf09jlqA+K/GWDlsAUcVyBWtIYxq//kcVxN+QUcWgQ7Sj0AC5+o8Um
 42OSdIH2qS3U8NNVPoavsKAEqPHtOux+tbV/C7AV1nfGOxHvxFxr7YX/3ibJCf4TG9lOK
 BJ9vtumPeGrHCfVCaLj2wgmW+HrTIOgnXex6NEfe9juuBak1igXhYybQXDUKX/UlSJKyw
 aG+2EsH19Rvly4T7OUFpsfT6Z/FrGB7lyaDR9VjflA2K/M3CiWXbolZVIFjjDFAvfF4wO
 qUwXSO2y+WWaBAREAS4njbWDCdjtndok7kjUeFLlD2io3gPcOJVuBQRgPLNoPSgMjSQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795685854;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=sFyU/cN2Q5RenfrWgsXIweIzF4ZLorkSF1vWKpU3g/M=;
 b=emsOBW2pnl9BQW127Wg/PV1KW8MllUWFbfCEv6ouOlhZVyn0idhmjT21xXUxkVQgpMev
 EXZXI3HvJUl8P9LKRzxqHc7Ggt0hERDPJsmYWH/6J0tX1O+S+XbyE6r62cHwe8UnDozFT
 F+RH75SJ4PLI1Opt+bjeU8K0gfqAsLTg/CWMaM4UNxSSx4615TnmcoperIJ+Y07w91NXU
 T1KWeKWnoVjHhZOhEFf49MvBaIM2Kp09vwMzVWy3jVYeI8ajt9NoRc70nD8cPvjz4AmyC
 HAZo88Y2IERhSv18cEwfXaJ15Pizs0SQdiUh3ZZbUV+tqjR0IJNzozw8Qg1uB9MgHuA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 82E321F000EB;
 Thu, 26 Nov 2026 09:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795685854;
 bh=sFyU/cN2Q5RenfrWgsXIweIzF4ZLorkSF1vWKpU3g/M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=SYqBBdEWvK4xe1+bimNounlnXXMw8X1eIUaK/j94OviLxtYMfmp5tTk8uJMqXt3J6
 sxUew9u+NZKvXYtB5mZYUglTiL3Or3EaRxsf3xFfT0+5u6zUbYKg+okAgI4gS1k4lD
 iGV3ltOsPN/q6nRsAgCKPC7wQKqHBeDc47JiGQdSTD5T2ILaLSQnuoY/XD3hj03+hm
 CcbNEIrn/UXWNTNUVPvjYe7e6nc415TJNoXs378wz/T9ltV2nxKk4i6ZgyJDhcqjbC
 6pdyhWl7fxyop18fXMFKkZLN3JV9eK+514XFf+Eo22uxutZ0lc1al9jXuGyeT26Yf9
 dug19OvO3Cf7Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 169244D388;
 Thu, 26 Nov 2026 09:36:48 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 09:36:50 +0000
Subject: [PATCH v4 07/17] drm/panfrost: Give back the pages of a heap chunk
 that failed to map
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-panfrost-long-jobs-v4-7-23579629ceca@gmail.com>
References: <20261126-panfrost-long-jobs-v4-0-23579629ceca@gmail.com>
In-Reply-To: <20261126-panfrost-long-jobs-v4-0-23579629ceca@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795685806; l=3977;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=Fy4hIaYtMsYqP1o6pifRn+AqW6XSoeC4gWPuvrzKAb8=;
 b=l3a+kl2lRde1uNeVfvl4CkCvf4V9oB0C0SgeOOCGcsddIEJ2OrJKdG/zxWGeRZyjESLUPuFhQ
 SuMtsAIxIh4Dw2qjUhHcROCdi31J3OsBeWUi3WFZG1EjOuqegVLqVCB
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

If growing a heap BO by a 2 MB chunk fails after the chunk's folios
were read, they stay in bo->base.pages without an sg table. The next
fault in the chunk finds them owned and hits the drm_WARN_ON() that
commit b49c35ba0ce1 added.

On those error paths, put the folios read and clear their entries:
whole folios, as the fill loop wrote them, except those a neighbouring
chunk owns.

Tested with a test-only failure after the read: before, the next fault
WARNed for each of the 512 pages; after, none. Folios larger than a
chunk (16K/64K pages) are from reading the code.

Fixes: b49c35ba0ce1 ("drm/panfrost: Fix a page leak in panfrost_mmu_map_fault_addr() when THP is on")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
v4: test result added; no code change.
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 40 +++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index e59a16b68..9edf66f6e 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -592,6 +592,27 @@ addr_to_mapping(struct panfrost_device *pfdev, int as, u64 addr)
 
 #define NUM_FAULT_PAGES (SZ_2M / PAGE_SIZE)
 
+/* [start, end) is whole folios: it can reach past the 2 MB chunk. */
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
@@ -600,7 +621,7 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 	struct panfrost_gem_object *bo;
 	struct address_space *mapping;
 	struct drm_gem_object *obj;
-	pgoff_t page_offset, nr_pages;
+	pgoff_t page_offset, nr_pages, got_start, got_end;
 	struct sg_table *sgt;
 	struct page **pages;
 
@@ -659,17 +680,22 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 	mapping = bo->base.base.filp->f_mapping;
 	mapping_set_unevictable(mapping);
 
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
@@ -681,14 +707,18 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
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
@@ -715,6 +745,8 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 	dma_unmap_sgtable(pfdev->base.dev, sgt, DMA_BIDIRECTIONAL, 0);
 err_map:
 	sg_free_table(sgt);
+err_put_chunk:
+	panfrost_heap_put_pages(pages, got_start, got_end);
 err_unlock:
 	dma_resv_unlock(obj->resv);
 err_bo:

-- 
2.55.0


