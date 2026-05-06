Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1351CCD3436
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 10:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7463510ED44;
	Wed,  6 May 2026 10:46:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="IOA5/8Iw";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6349C10ED44
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 10:46:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1778064379; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IVWSXEZF3uZBLaxOj/wmmnUcU0sCjnQh+GzXRg16wFKOCLxfunm3huP0GPGuyxQ7ZFTwk3ZzrUAySsAvSmIrbKyRNziaAwLHowiTzEx/zx5Rq5S1YbIA2VI24xN9OByRuXiQ8XNODm2EYNVyYWH6Ywme+ArUCbKHYrtjL2mU77g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778064379;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=969bjndru/0e943CKf2AcnAwdyybQY7U20RliwhKKNA=; 
 b=ZXKPiv6m5lW6gONyDU+FP85ot6TfpdLvKSMXqH0XH7q3TSFPRszITAT+sbSttviXQnA0NctVOvc5DEGCXh+1AYPvmUJlskmwM4BmAxeOdsbTi1elVp7Zix6j3ip0SgoIViNcl6IBUl/p6xjjq9dKdtXknIqO4rxYhD4C4jpbUXs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778064379; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=969bjndru/0e943CKf2AcnAwdyybQY7U20RliwhKKNA=;
 b=IOA5/8IwcHx9uIpY7kBQjXFY6BE6bHyjlcapLhHf9H5qHrOtn1jhhTUmXe/V3ff6
 BmbQi2OH0yjc2vSD+DLn/Jxk8l5LY0yzs/uAwgcbDcoMJRGpUO2w5D6e/Fv9vcZ6o6v
 YIQD28ZaFGIg2VVltqm7lK6ytB7tzIBeOSTwVFB4=
Received: by mx.zohomail.com with SMTPS id 1778064377137162.00190677417413;
 Wed, 6 May 2026 03:46:17 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 06 May 2026 12:45:56 +0200
Subject: [PATCH 1/4] drm/panthor: Add freed_sz parameter to
 reclaim_priv_bos
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-panthor-explicit-reclaim-v1-1-44f82ac147ce@collabora.com>
References: <20260506-panthor-explicit-reclaim-v1-0-44f82ac147ce@collabora.com>
In-Reply-To: <20260506-panthor-explicit-reclaim-v1-0-44f82ac147ce@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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

panthor_mmu_reclaim_priv_bos returns the number of freed pages. However,
how many bytes of freed memory this translates to can't generally be
deduced from the number of pages, as the page size is a per-VM property.

It may be useful to know the exact number of bytes that have been freed
for observability and debugging purposes. To that end, add a new
parameter "freed_sz", which is a pointer to a size_t where this
information will be stored. It may be NULL, in which case the
information isn't stored at all.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_gem.c |  3 ++-
 drivers/gpu/drm/panthor/panthor_mmu.c | 12 ++++++++++--
 drivers/gpu/drm/panthor/panthor_mmu.h |  1 +
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 13295d7a593d..80e82238f3c5 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -1511,7 +1511,8 @@ panthor_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
 		goto out;
 
 	freed += panthor_mmu_reclaim_priv_bos(ptdev, sc->nr_to_scan - freed,
-					      &remaining, panthor_gem_try_evict);
+					      &remaining, NULL,
+					      panthor_gem_try_evict);
 	if (freed >= sc->nr_to_scan)
 		goto out;
 
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index a7ee14986849..b81388b35a58 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -3127,13 +3127,18 @@ int panthor_vm_prepare_mapped_bos_resvs(struct drm_exec *exec, struct panthor_vm
 unsigned long
 panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
 			     unsigned int nr_to_scan, unsigned long *remaining,
+			     size_t *freed_sz,
 			     bool (*shrink)(struct drm_gem_object *,
 					    struct ww_acquire_ctx *))
 {
+	unsigned long newly_freed;
 	unsigned long freed = 0;
 	LIST_HEAD(remaining_vms);
 	LIST_HEAD(vms);
 
+	if (freed_sz)
+		*freed_sz = 0;
+
 	mutex_lock(&ptdev->reclaim.lock);
 	list_splice_init(&ptdev->reclaim.vms, &vms);
 
@@ -3152,8 +3157,11 @@ panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
 
 		mutex_unlock(&ptdev->reclaim.lock);
 
-		freed += drm_gem_lru_scan(&vm->reclaim.lru, nr_to_scan - freed,
-					  remaining, shrink, NULL);
+		newly_freed = drm_gem_lru_scan(&vm->reclaim.lru, nr_to_scan - freed,
+					       remaining, shrink, NULL);
+		if (freed_sz)
+			*freed_sz += panthor_vm_page_size(vm) * newly_freed;
+		freed += newly_freed;
 
 		mutex_lock(&ptdev->reclaim.lock);
 
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
index 3522fbbce369..12b18b5f90e1 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.h
+++ b/drivers/gpu/drm/panthor/panthor_mmu.h
@@ -52,6 +52,7 @@ int panthor_vm_evict_bo_mappings_locked(struct panthor_gem_object *bo);
 unsigned long
 panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
 			     unsigned int nr_to_scan, unsigned long *remaining,
+			     size_t *freed_sz,
 			     bool (*shrink)(struct drm_gem_object *,
 					    struct ww_acquire_ctx *));
 int panthor_vm_prepare_mapped_bos_resvs(struct drm_exec *exec,

-- 
2.54.0

