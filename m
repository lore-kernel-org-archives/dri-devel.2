Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAABACD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 13:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28F9310E636;
	Wed, 20 May 2026 13:06:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="QJnZbjHR";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F07A10EC21
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:06:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779282334; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=m3EMSwy3hSG11zvKoGUa5VtCwBhBtp0/qi8DiDM28PEnXHzSWGUs+ffOkR3d38qj/hr6wT5t/7fOWlzSQitNbLvk9bMy/oRcNdyiluAOZaiOGoPF7qbiG7f7YaLzTMzA4fpzKyVR4U9n8UaMqWNytRZ3mOrHY7fzBbtmSrJPJTs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779282334;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=31m7nkmQYDUOGoFy9g3jc9NCzZLMGg3gT01Xnk9NImU=; 
 b=mOKUX14oU36Wrnlnuxg6rLtcCmEHPK6sPGz5hfLQe4izt5TRGjf/JufD+NBD2Sg4jfXbQhF+rBIsCm7uiJcYf53RlCb5GQvoHye9jd17w8y/gbMPP231iZew3UQesazWnfy/Do8P434yI/jlJrcuUwJzv2UK4dC0GACKijcYLyE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779282334; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=31m7nkmQYDUOGoFy9g3jc9NCzZLMGg3gT01Xnk9NImU=;
 b=QJnZbjHRh77umjzDUihSVj9GSlI81hfjWkgSJOJ7SfZ/LVCApNVKcpIkH/Ap8+Fo
 iB1ErZIFoOrlJ9YdtuSI6kYeitdPjk0UrJWeouXi6YIKL+GP2OLyfUWoSO9oVuT/cFz
 tVhSF8D1hwghYkuuiUabeiz7jw7wTeTD7RiTYxIQ=
Received: by mx.zohomail.com with SMTPS id 177928233219299.95530128510529;
 Wed, 20 May 2026 06:05:32 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 20 May 2026 15:04:48 +0200
Subject: [PATCH v4 1/3] drm/fdinfo: Add "evicted" memory accounting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-panthor-bo-reclaim-observability-v4-1-a47ab61cb80d@collabora.com>
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

Currently, there's no way to know for certain how much GPU memory was
swapped out. The difference between total and resident memory would
include newly allocated pages, which are not resident, but also aren't
swapped out.

Add a new drm_gem_object_status so drivers can signal when an object has
been evicted to swap, and add a new "evicted" counter to
drm_memory_stats.

Due to how the supported_flags bitmask is determined, the "evicted"
count won't be printed to fdinfo if there's no swapped out pages.

Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 Documentation/gpu/drm-usage-stats.rst | 6 ++++++
 drivers/gpu/drm/drm_file.c            | 8 ++++++++
 include/drm/drm_file.h                | 2 ++
 include/drm/drm_gem.h                 | 2 ++
 4 files changed, 18 insertions(+)

diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
index 70b7cfcc194f..ac1dbf52d96d 100644
--- a/Documentation/gpu/drm-usage-stats.rst
+++ b/Documentation/gpu/drm-usage-stats.rst
@@ -202,6 +202,12 @@ One practical example of this could be the presence of unsignaled fences in a
 GEM buffer reservation object. Therefore, the active category is a subset of the
 resident category.
 
+- drm-evicted-<region>: <uint> [KiB|MiB]
+
+The total size of buffers that have been evicted and are no longer pinned by the
+device. Only present if there are buffers that are currently evicted, and if the
+driver implements reporting of this type of memory.
+
 Implementation Details
 ======================
 
diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index ec820686b302..5078172976c0 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -868,6 +868,7 @@ int drm_memory_stats_is_zero(const struct drm_memory_stats *stats)
 		stats->private == 0 &&
 		stats->resident == 0 &&
 		stats->purgeable == 0 &&
+		stats->evicted == 0 &&
 		stats->active == 0);
 }
 EXPORT_SYMBOL(drm_memory_stats_is_zero);
@@ -901,6 +902,10 @@ void drm_print_memory_stats(struct drm_printer *p,
 	if (supported_status & DRM_GEM_OBJECT_PURGEABLE)
 		drm_fdinfo_print_size(p, prefix, "purgeable", region,
 				      stats->purgeable);
+
+	if (supported_status & DRM_GEM_OBJECT_EVICTED)
+		drm_fdinfo_print_size(p, prefix, "evicted", region,
+				      stats->evicted);
 }
 EXPORT_SYMBOL(drm_print_memory_stats);
 
@@ -954,6 +959,9 @@ void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file)
 
 		if (s & DRM_GEM_OBJECT_PURGEABLE)
 			status.purgeable += add_size;
+
+		if (s & DRM_GEM_OBJECT_EVICTED)
+			status.evicted += add_size;
 	}
 	spin_unlock(&file->table_lock);
 
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 6ee70ad65e1f..7e4cb45a52c3 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -500,6 +500,7 @@ void drm_send_event_timestamp_locked(struct drm_device *dev,
  * @resident: Total size of GEM objects backing pages
  * @purgeable: Total size of GEM objects that can be purged (resident and not active)
  * @active: Total size of GEM objects active on one or more engines
+ * @evicted: Total size of GEM objects that have been evicted
  *
  * Used by drm_print_memory_stats()
  */
@@ -509,6 +510,7 @@ struct drm_memory_stats {
 	u64 resident;
 	u64 purgeable;
 	u64 active;
+	u64 evicted;
 };
 
 enum drm_gem_object_status;
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 86f5846154f7..799588a2762a 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -53,6 +53,7 @@ struct drm_gem_object;
  * @DRM_GEM_OBJECT_RESIDENT: object is resident in memory (ie. not unpinned)
  * @DRM_GEM_OBJECT_PURGEABLE: object marked as purgeable by userspace
  * @DRM_GEM_OBJECT_ACTIVE: object is currently used by an active submission
+ * @DRM_GEM_OBJECT_EVICTED: object is evicted and no longer pinned by driver
  *
  * Bitmask of status used for fdinfo memory stats, see &drm_gem_object_funcs.status
  * and drm_show_fdinfo().  Note that an object can report DRM_GEM_OBJECT_PURGEABLE
@@ -67,6 +68,7 @@ enum drm_gem_object_status {
 	DRM_GEM_OBJECT_RESIDENT  = BIT(0),
 	DRM_GEM_OBJECT_PURGEABLE = BIT(1),
 	DRM_GEM_OBJECT_ACTIVE    = BIT(2),
+	DRM_GEM_OBJECT_EVICTED   = BIT(3),
 };
 
 /**

-- 
2.54.0

