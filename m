Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD2FC5CFCF
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E12110EE78;
	Wed, 12 Aug 2026 07:08:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="LA0Vpkb9";
	dkim-atps=neutral
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com
 [91.218.175.185])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D742B10E385
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 20:54:48 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaitmazov.com;
 s=key1; t=1786481213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zeACl+zbzOI1sHRsKncuRKubCD4eo5wsZ8YrzMDnp54=;
 b=LA0Vpkb9V6BwKppQAe5Vf043kHI9nBnd4pj3H3ewgL+LfQLRDFf1j4sOAG8y+TiDeDTIof
 hiLvsz6ovnK55FHDi4mPA2n2ziD5dqUc5zM19Cqp7jpuUKsQysiT6uUDWys2SmrYm9tiGc
 7asHcSnrLdrN88L1+V+rVNZ4ZoSalxn/w6djTW4y5j0rqELhitkTxHzP8lbDuBk2RF+heu
 P0QR7ES0grZs9jPpSztXIcKrBR74Lv5TWSYuf9gjtaDEMEH+SQJrCHw3CtiOYGpM/O7eUi
 vKSgSnPSSGkV7kF6giWHCuMhWk0w3LL+AtdFOKx5ywTOjD865lXXSFqckGBG+A==
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: mamin506@gmail.com,
	lizhi.hou@amd.com,
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
Subject: [PATCH 3/3] accel/amdxdna: flush only the requested range in
 amdxdna_flush_bo
Date: Tue, 11 Aug 2026 23:45:56 +0300
Message-ID: <20260811204556.875037-4-taimuraz@kaitmazov.com>
In-Reply-To: <20260811204556.875037-1-taimuraz@kaitmazov.com>
References: <20260811204556.875037-1-taimuraz@kaitmazov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Wed, 12 Aug 2026 07:08:20 +0000
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

SYNC_BO carries an offset and a size, but amdxdna_flush_bo() honours
them only on the vmap path: an imported BO is tested for first and
flushes its whole scatterlist, and the page-array fallback flushes every
page of the BO. A sync costs what the BO is worth rather than what the
caller asked to maintain.

amdxdna_gem_obj_vmap() maps an imported BO through dma_buf_vmap(), so
try the vmap path first and leave drm_clflush_sg() as the fallback for
an exporter that cannot serve one. Index the page-array fallback from
the requested offset. An imported BO now holds a kernel mapping from its
first sync until it is freed, as a shmem BO already does.

Measured on npu4, 64 MiB BO, pinned, minimum of 50 runs: an imported BO
cost 1056 us to sync at every size from 4 KiB up, and now tracks the
driver-owned BO at 0.7 us for 4 KiB, 17 us for 1 MiB and 1056 us for the
whole BO. The driver-owned column does not move.

An earlier version walked the scatterlist a page at a time instead. It
fixed the range case but cost about 179 ns per page of barrier and call
overhead, taking the whole-BO sync from 1056 to 3989 us, so this one
reuses the mapping instead.

This does not bracket the flush with dma_buf_begin_cpu_access() and
dma_buf_end_cpu_access(). The driver has never called them, here or
anywhere else, so the omission predates this change; what changes is that
the vmap path now serves an imported BO by default, which is where the
exporter's own coherency hook would matter most. Adding the bracket is
follow-up work rather than part of this one: the calls carry a direction
but no range, so pairing them with a ranged flush wants its own reasoning
and its own measurement.

Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index d0c846b02..4886f7c08 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -1234,6 +1234,8 @@ int amdxdna_drm_get_bo_info_ioctl(struct drm_device *dev, void *data, struct drm
 
 static int amdxdna_flush_bo(struct amdxdna_gem_obj *abo, u64 offset, u64 size)
 {
+	unsigned long first, nr_pages;
+	void *kva;
 	u64 end;
 
 	if (offset >= abo->mem.size)
@@ -1243,12 +1245,16 @@ static int amdxdna_flush_bo(struct amdxdna_gem_obj *abo, u64 offset, u64 size)
 		return -EINVAL;
 
 	size = min(abo->mem.size, end) - offset;
-	if (is_import_bo(abo))
+	first = offset >> PAGE_SHIFT;
+	nr_pages = (PAGE_ALIGN(offset + size) >> PAGE_SHIFT) - first;
+
+	kva = __amdxdna_gem_vmap(abo);
+	if (!IS_ERR(kva))
+		drm_clflush_virt_range(kva + offset, size);
+	else if (is_import_bo(abo))
 		drm_clflush_sg(abo->base.sgt);
-	else if (amdxdna_gem_vmap(abo))
-		drm_clflush_virt_range(amdxdna_gem_vmap(abo) + offset, size);
 	else if (abo->base.pages)
-		drm_clflush_pages(abo->base.pages, abo->mem.size >> PAGE_SHIFT);
+		drm_clflush_pages(&abo->base.pages[first], nr_pages);
 	else
 		return -EINVAL;
 
-- 
2.55.0

