Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBF6CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 13:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CD5310E418;
	Wed, 20 May 2026 13:06:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="M2d9PLas";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F95110EC21
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:06:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779282338; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RqQAsJQ8D2bumAUvYuxVUgVyg6Ff+qHINjaOjhnNrjlSRUVN9RDiY17WAPsGfLZslvc7sLZj4zQ02oAS4u2ggoxoIMX9ymPOL4xj3b7mV9oNt1FDlKWV8RMwDNlUynGaCqUhSE0JakhiuaYqZxiMahQ+2vhndHSad+s/t5TShvg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779282338;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1+L0F6CYQyQIp80TpjfAI1kf74NLA/tfX/TS+7aDs38=; 
 b=RThqN702f8jPlTU1ZVD1R3SjrkfJ3OJeEIxv58iA5/GGvLwfG7DbHN6NcmsgU7OdWkhRfSElTdTvLICej+B7y5xP878G/2if23xVRbN0dV7dgZ1RRYc3/vbx/kjH3SCwuHpDD7C7tCUltlzGMbKvAMm5vzvM/wBozVFCwhs89AI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779282338; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=1+L0F6CYQyQIp80TpjfAI1kf74NLA/tfX/TS+7aDs38=;
 b=M2d9PLassir0IGGqslvqlFbjDaDeKip99ePtYbm6ePhss2wk8G2RKbNdWEqJLVIe
 b2NaKne8ZVxiyMgYXPlCCKYE9aX7Lpf6mYeTv0UVDQ93pIfYra9UJdVZy4mERDnFOnF
 sofphI8aAwaLNWL1oS1dkN2LFX/xevjvCIxbnTOM=
Received: by mx.zohomail.com with SMTPS id 1779282336185171.0853906309393;
 Wed, 20 May 2026 06:05:36 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 20 May 2026 15:04:49 +0200
Subject: [PATCH v4 2/3] drm/panthor: Implement evicted status for GEM objects
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-panthor-bo-reclaim-observability-v4-2-a47ab61cb80d@collabora.com>
References: <20260520-panthor-bo-reclaim-observability-v4-0-a47ab61cb80d@collabora.com>
In-Reply-To: <20260520-panthor-bo-reclaim-observability-v4-0-a47ab61cb80d@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, linux-doc@vger.kernel.org, 
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

For fdinfo to be able to fill its evicted counter with data, panthor
needs to keep track of whether a GEM object has ever been reclaimed.
Just checking whether the pages are resident isn't enough, as newly
allocated objects also won't be resident.

Do this with a new atomic_t member on panthor_gem_object. It's increased
when an object gets evicted by the shrinker, and saturates at INT_MAX.
This means that once an object has been evicted at least once, its
reclaim counter will never return to 0.

Due to this, it's possible to distinguish evicted non-resident pages
from newly allocated non-resident pages by checking whether
reclaimed_count is != 0

Use this new member to then set the appropriate DRM_GEM_OBJECT_EVICTED
status flag for fdinfo.

Also add a new column and status flag to the panthor gems debugfs: the
column is the number of times an object has been evicted, whereas the
flag indicates whether it currently is evicted.

Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_gem.c | 18 ++++++++++++++----
 drivers/gpu/drm/panthor/panthor_gem.h | 10 ++++++++++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 13295d7a593d..068aa935c8fc 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -687,6 +687,8 @@ static void panthor_gem_evict_locked(struct panthor_gem_object *bo)
 	if (drm_WARN_ON_ONCE(bo->base.dev, !bo->backing.pages))
 		return;
 
+	atomic_add_unless(&bo->reclaimed_count, 1, INT_MAX);
+
 	panthor_gem_dev_map_cleanup_locked(bo);
 	panthor_gem_backing_cleanup_locked(bo);
 	panthor_gem_update_reclaim_state_locked(bo, NULL);
@@ -788,6 +790,8 @@ static enum drm_gem_object_status panthor_gem_status(struct drm_gem_object *obj)
 
 	if (drm_gem_is_imported(&bo->base) || bo->backing.pages)
 		res |= DRM_GEM_OBJECT_RESIDENT;
+	else if (atomic_read(&bo->reclaimed_count))
+		res |= DRM_GEM_OBJECT_EVICTED;
 
 	return res;
 }
@@ -1595,6 +1599,7 @@ static void panthor_gem_debugfs_print_flag_names(struct seq_file *m)
 	static const char * const gem_state_flags_names[] = {
 		[PANTHOR_DEBUGFS_GEM_STATE_IMPORTED_BIT] = "imported",
 		[PANTHOR_DEBUGFS_GEM_STATE_EXPORTED_BIT] = "exported",
+		[PANTHOR_DEBUGFS_GEM_STATE_EVICTED_BIT] = "evicted",
 	};
 
 	static const char * const gem_usage_flags_names[] = {
@@ -1625,6 +1630,7 @@ static void panthor_gem_debugfs_bo_print(struct panthor_gem_object *bo,
 {
 	enum panthor_gem_reclaim_state reclaim_state = bo->reclaim_state;
 	unsigned int refcount = kref_read(&bo->base.refcount);
+	int reclaimed_count = atomic_read(&bo->reclaimed_count);
 	char creator_info[32] = {};
 	size_t resident_size;
 	u32 gem_usage_flags = bo->debugfs.flags;
@@ -1638,16 +1644,20 @@ static void panthor_gem_debugfs_bo_print(struct panthor_gem_object *bo,
 
 	snprintf(creator_info, sizeof(creator_info),
 		 "%s/%d", bo->debugfs.creator.process_name, bo->debugfs.creator.tgid);
-	seq_printf(m, "%-32s%-16d%-16d%-16zd%-16zd0x%-16lx",
+	seq_printf(m, "%-32s%-16d%-16d%-11d%-16zd%-16zd0x%-16lx",
 		   creator_info,
 		   bo->base.name,
 		   refcount,
+		   reclaimed_count,
 		   bo->base.size,
 		   resident_size,
 		   drm_vma_node_start(&bo->base.vma_node));
 
 	if (drm_gem_is_imported(&bo->base))
 		gem_state_flags |= PANTHOR_DEBUGFS_GEM_STATE_FLAG_IMPORTED;
+	else if (!resident_size && reclaimed_count)
+		gem_state_flags |= PANTHOR_DEBUGFS_GEM_STATE_FLAG_EVICTED;
+
 	if (bo->base.dma_buf)
 		gem_state_flags |= PANTHOR_DEBUGFS_GEM_STATE_FLAG_EXPORTED;
 
@@ -1671,8 +1681,8 @@ static void panthor_gem_debugfs_print_bos(struct panthor_device *ptdev,
 
 	panthor_gem_debugfs_print_flag_names(m);
 
-	seq_puts(m, "created-by                      global-name     refcount        size            resident-size   file-offset       state      usage       label\n");
-	seq_puts(m, "----------------------------------------------------------------------------------------------------------------------------------------------\n");
+	seq_puts(m, "created-by                      global-name     refcount        evictions  size            resident-size   file-offset       state      usage       label\n");
+	seq_puts(m, "---------------------------------------------------------------------------------------------------------------------------------------------------------\n");
 
 	scoped_guard(mutex, &ptdev->gems.lock) {
 		list_for_each_entry(bo, &ptdev->gems.node, debugfs.node) {
@@ -1680,7 +1690,7 @@ static void panthor_gem_debugfs_print_bos(struct panthor_device *ptdev,
 		}
 	}
 
-	seq_puts(m, "==============================================================================================================================================\n");
+	seq_puts(m, "=========================================================================================================================================================\n");
 	seq_printf(m, "Total size: %zd, Total resident: %zd, Total reclaimable: %zd\n",
 		   totals.size, totals.resident, totals.reclaimable);
 }
diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/panthor/panthor_gem.h
index ae0491d0b121..56d63137b4eb 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.h
+++ b/drivers/gpu/drm/panthor/panthor_gem.h
@@ -19,12 +19,16 @@ struct panthor_vm;
 enum panthor_debugfs_gem_state_flags {
 	PANTHOR_DEBUGFS_GEM_STATE_IMPORTED_BIT = 0,
 	PANTHOR_DEBUGFS_GEM_STATE_EXPORTED_BIT = 1,
+	PANTHOR_DEBUGFS_GEM_STATE_EVICTED_BIT = 2,
 
 	/** @PANTHOR_DEBUGFS_GEM_STATE_FLAG_IMPORTED: GEM BO is PRIME imported. */
 	PANTHOR_DEBUGFS_GEM_STATE_FLAG_IMPORTED = BIT(PANTHOR_DEBUGFS_GEM_STATE_IMPORTED_BIT),
 
 	/** @PANTHOR_DEBUGFS_GEM_STATE_FLAG_EXPORTED: GEM BO is PRIME exported. */
 	PANTHOR_DEBUGFS_GEM_STATE_FLAG_EXPORTED = BIT(PANTHOR_DEBUGFS_GEM_STATE_EXPORTED_BIT),
+
+	/** @PANTHOR_DEBUGFS_GEM_STATE_FLAG_EVICTED: GEM BO is evicted to swap. */
+	PANTHOR_DEBUGFS_GEM_STATE_FLAG_EVICTED = BIT(PANTHOR_DEBUGFS_GEM_STATE_EVICTED_BIT),
 };
 
 enum panthor_debugfs_gem_usage_flags {
@@ -172,6 +176,12 @@ struct panthor_gem_object {
 	/** @reclaim_state: Cached reclaim state */
 	enum panthor_gem_reclaim_state reclaim_state;
 
+	/**
+	 * @reclaimed_count: How many times object has been evicted to swap.
+	 * The count saturates at %INT_MAX and will never wrap around to 0.
+	 */
+	atomic_t reclaimed_count;
+
 	/**
 	 * @exclusive_vm_root_gem: Root GEM of the exclusive VM this GEM object
 	 * is attached to.

-- 
2.54.0

