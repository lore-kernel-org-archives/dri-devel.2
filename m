Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE50ECD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 12:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DB8D10ED23;
	Wed,  6 May 2026 12:16:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="JRYNrhtX";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2155710ED5B;
 Wed,  6 May 2026 12:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778069798;
 bh=bhfUdxskTM5eHiDMoxut02UxySr7YulKIsinhbB2loU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=JRYNrhtXdh4SwlO/Xo8DsGy0cQBsJ7IeNhNbRySUIf+QTa5++UQyExPC4jBNuzav1
 CUeZs6ENbRXUngd+Qj/7vFPjMGXIAXs13LwwHDWw4tlSMPZayWttzixd1h8CkN095e
 C+80RLVsMcZDhLL8acx+G5iBLDf9lMF29yv8DV4Z1NR9SUKdRzcwBYOXSDPUXLzLJi
 hGYz6L+Bg1bCKN9gUzrAxyPZJ+NH6XscC23rja2tmosTxxJXXKaMwl5xbRAYS08a94
 66ZPSbwg5uXNGVFE/0KnJn0mEyH9m99h76/XIdH2C8d6buDJms1uaSq2F5VUPhwnZW
 KWvxTI8S3Halw==
Received: from [100.64.0.11] (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9813C17E1525;
 Wed,  6 May 2026 14:16:37 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Wed, 06 May 2026 14:16:26 +0200
Subject: [PATCH 1/3] drm/panthor: Don't use the racy drm_gem_lru_remove()
 helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-panthor-shrinker-fixes-v1-1-e7721526de96@collabora.com>
References: <20260506-panthor-shrinker-fixes-v1-0-e7721526de96@collabora.com>
In-Reply-To: <20260506-panthor-shrinker-fixes-v1-0-e7721526de96@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Akash Goel <akash.goel@arm.com>, Chia-I Wu <olvaffe@gmail.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778069796; l=3557;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=bhfUdxskTM5eHiDMoxut02UxySr7YulKIsinhbB2loU=;
 b=O2/ZfA/x6LWTnFgb5+Ig3AX2o7bvW0n2h3REdsGABoRpd2SI/bK9XAjjbLg4lttbiP15FDzpD
 pRq2QwZDfTHCPTIVIbSWruFOpf5ncbHlZimE/LRtWgc6Gs4dTSN/wRI
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
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

drm_gem_lru_remove() dereference stores drm_gem_object::lru in a local
variable that's then dereferenced to acquire the LRU lock. Because this
assignment in done without the LRU lock held, it can race with
drm_gem_lru_scan() where drm_gem_object::lru is temporarily assigned
a stack-allcated LRU that goes away when leaving the function. By
the time we dereference this local lru variable, the object might already
be gone.

It feels like drm_gem_lru_move_tail() was never meant to be used this
way, because there's no easy way we can avoid this race unless we defer
the locking to the caller. Let's add an explicit LRU for unreclaimable
BOs instead, and have all BOs added to this LRU at creation time.

Fixes: fb42964e2a76 ("drm/panthor: Add a GEM shrinker")
Reported-by: Chia-I Wu <olvaffe@gmail.com>
Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/86
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_device.h | 10 ++++++++++
 drivers/gpu/drm/panthor/panthor_gem.c    |  5 ++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 4e4607bca7cc..45b71546f83c 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -190,6 +190,16 @@ struct panthor_device {
 		/** @reclaim.lock: Lock protecting all LRUs */
 		struct mutex lock;
 
+		/**
+		 * @reclaim.unreclaimable: unreclaimable BOs
+		 *
+		 * Either the BO is unreclaimable because it has no pages allocated,
+		 * or it's unreclaimable because pages are pinned.
+		 *
+		 * All BOs start in that list at creation time.
+		 */
+		struct drm_gem_lru unreclaimable;
+
 		/**
 		 * @reclaim.unused: BOs with unused pages
 		 *
diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 13295d7a593d..8e31740126e7 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -204,7 +204,7 @@ void panthor_gem_update_reclaim_state_locked(struct panthor_gem_object *bo,
 		drm_gem_lru_move_tail(&ptdev->reclaim.gpu_mapped_shared, &bo->base);
 		break;
 	case PANTHOR_GEM_UNRECLAIMABLE:
-		drm_gem_lru_remove(&bo->base);
+		drm_gem_lru_move_tail(&ptdev->reclaim.unreclaimable, &bo->base);
 		break;
 	default:
 		drm_WARN(&ptdev->base, true, "invalid GEM reclaim state (%d)\n", new_state);
@@ -994,6 +994,7 @@ static struct panthor_gem_object *
 panthor_gem_create(struct drm_device *dev, size_t size, uint32_t flags,
 		   struct panthor_vm *exclusive_vm, u32 usage_flags)
 {
+	struct panthor_device *ptdev = container_of(dev, struct panthor_device, base);
 	struct panthor_gem_object *bo;
 	int ret;
 
@@ -1026,6 +1027,7 @@ panthor_gem_create(struct drm_device *dev, size_t size, uint32_t flags,
 	}
 
 	panthor_gem_debugfs_set_usage_flags(bo, usage_flags);
+	drm_gem_lru_move_tail(&ptdev->reclaim.unreclaimable, &bo->base);
 	return bo;
 
 err_put:
@@ -1551,6 +1553,7 @@ int panthor_gem_shrinker_init(struct panthor_device *ptdev)
 		return ret;
 
 	INIT_LIST_HEAD(&ptdev->reclaim.vms);
+	drm_gem_lru_init(&ptdev->reclaim.unreclaimable, &ptdev->reclaim.lock);
 	drm_gem_lru_init(&ptdev->reclaim.unused, &ptdev->reclaim.lock);
 	drm_gem_lru_init(&ptdev->reclaim.mmapped, &ptdev->reclaim.lock);
 	drm_gem_lru_init(&ptdev->reclaim.gpu_mapped_shared, &ptdev->reclaim.lock);

-- 
2.54.0

