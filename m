Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB54CF588E7
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 15:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AD5310E6CF;
	Mon, 20 Apr 2026 15:47:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Uu4t6lAt";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E515610E6CF
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 15:47:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776700049; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MZlgf72qDO1sFAnt+UMlfn85QcalahqCYTr9vT40uSPEcT191yN3yT4Av8C+w57Zq0UX98SxMP7WTsR+mU7nfcI5HvcV3aKPt2uZOgapCh6qo26VulDyY9sy4KRcYn978XpgxsBC1B3oVYKQFEzGys3hCUFYLuGgOf1K3C/jIhQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776700049;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=xQpRGvw6MVSzQc3l2J0bETsoimh+LbDNTxaGkXZ6Cow=; 
 b=R8aPGEZ3YwuH8lWLNFD7rqnJC+f5cWnfmvNhM/LWcmdyqtw7lYATPV+848nxw8lIvDMSdiO/nPdRyWNeMpMQ17lZMwoTd5kR6mu/7bfGb+BC4mUGPDSRy6YuH8kMKigUJI62JyM1qEvZ3w5kN6ShmOHNpDEnwBU0WymyOTVvJG8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776700049; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=xQpRGvw6MVSzQc3l2J0bETsoimh+LbDNTxaGkXZ6Cow=;
 b=Uu4t6lAtvypDVcn1eEL2yMFxGTa/pTemM3syGT7N85PZ9+8E45F9OA376a+8GITq
 5JtLtbIdGapS0OA0ZQgYy6YDcaw3sqJTWZ+0eD9gYXcxaRX1hjx05T3KcTZW5Fyvdb1
 zDFfOzn2qEI/m2uLtWRq+GZnvIk0PGUusCK45uRs=
Received: by mx.zohomail.com with SMTPS id 1776700047497556.3638450179424;
 Mon, 20 Apr 2026 08:47:27 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 20 Apr 2026 17:47:00 +0200
Subject: [PATCH 2/2] drm/panthor: Implement evicted status for GEM objects
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-panthor-bo-reclaim-observability-v1-2-a4d1a36ee84f@collabora.com>
References: <20260420-panthor-bo-reclaim-observability-v1-0-a4d1a36ee84f@collabora.com>
In-Reply-To: <20260420-panthor-bo-reclaim-observability-v1-0-a4d1a36ee84f@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
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
when an object gets evicted by the shrinker. While it's allowed to wrap
around to below zero and assume a value less than a previous observed
value, the reclaim counter will never return to 0 for any particular
object once it's been reclaimed at least once.

Use this new member to then set the appropriate DRM_GEM_OBJECT_EVICTED
status flag for fdinfo, and use it in the gems debugfs. It's possible to
distinguish evicted non-resident pages from newly allocated non-resident
pages by checking whether reclaimed_count is != 0.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_gem.c | 10 ++++++++++
 drivers/gpu/drm/panthor/panthor_gem.h | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 69cef05b6ef7..4b761b39565d 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -687,6 +687,10 @@ static void panthor_gem_evict_locked(struct panthor_gem_object *bo)
 	if (drm_WARN_ON_ONCE(bo->base.dev, !bo->backing.pages))
 		return;
 
+	/* Don't ever wrap around as far as 0, jump from INT_MIN to 1 */
+	if (!atomic_inc_unless_negative(&bo->reclaimed_count))
+		atomic_set(&bo->reclaimed_count, 1);
+
 	panthor_gem_dev_map_cleanup_locked(bo);
 	panthor_gem_backing_cleanup_locked(bo);
 	panthor_gem_update_reclaim_state_locked(bo, NULL);
@@ -788,6 +792,8 @@ static enum drm_gem_object_status panthor_gem_status(struct drm_gem_object *obj)
 
 	if (drm_gem_is_imported(&bo->base) || bo->backing.pages)
 		res |= DRM_GEM_OBJECT_RESIDENT;
+	else if (atomic_read(&bo->reclaimed_count))
+		res |= DRM_GEM_OBJECT_EVICTED;
 
 	return res;
 }
@@ -1595,6 +1601,7 @@ static void panthor_gem_debugfs_print_flag_names(struct seq_file *m)
 	static const char * const gem_state_flags_names[] = {
 		[PANTHOR_DEBUGFS_GEM_STATE_IMPORTED_BIT] = "imported",
 		[PANTHOR_DEBUGFS_GEM_STATE_EXPORTED_BIT] = "exported",
+		[PANTHOR_DEBUGFS_GEM_STATE_EVICTED_BIT] = "evicted",
 	};
 
 	static const char * const gem_usage_flags_names[] = {
@@ -1648,6 +1655,9 @@ static void panthor_gem_debugfs_bo_print(struct panthor_gem_object *bo,
 
 	if (drm_gem_is_imported(&bo->base))
 		gem_state_flags |= PANTHOR_DEBUGFS_GEM_STATE_FLAG_IMPORTED;
+	else if (!resident_size && atomic_read(&bo->reclaimed_count))
+		gem_state_flags |= PANTHOR_DEBUGFS_GEM_STATE_FLAG_EVICTED;
+
 	if (bo->base.dma_buf)
 		gem_state_flags |= PANTHOR_DEBUGFS_GEM_STATE_FLAG_EXPORTED;
 
diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/panthor/panthor_gem.h
index ae0491d0b121..1ab573f03330 100644
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
@@ -172,6 +176,13 @@ struct panthor_gem_object {
 	/** @reclaim_state: Cached reclaim state */
 	enum panthor_gem_reclaim_state reclaim_state;
 
+	/**
+	 * @reclaimed_count: How many times object has been evicted to swap.
+	 * Never returns to 0 once incremented even on wrap-around, but may
+	 * become < 0 and < the previous value if wrap-around occurs.
+	 */
+	atomic_t reclaimed_count;
+
 	/**
 	 * @exclusive_vm_root_gem: Root GEM of the exclusive VM this GEM object
 	 * is attached to.

-- 
2.53.0

