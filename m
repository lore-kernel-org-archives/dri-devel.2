Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB96CD3447
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 10:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 227F310F435;
	Fri,  8 May 2026 10:41:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="LS4wB9Ow";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85FCC10E333;
 Fri,  8 May 2026 10:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778236873;
 bh=CCjbAOv+AUfwV71P61bambB9KPgJkBGpAkVfSqu3IzE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=LS4wB9OwTbq8MAUejBMyJj3E3GtQ9Qa9GzIbZZAv3gl5VxR5tJ5/k2BeAF+VWaLFY
 7skauOxzS+4Vfo8bYcwjriU9GTtP/DDH0OXJ8zQ/9NOjTpkQ9B0d+YxDVGkMAqXycC
 5nPiIKp1zWIA9XG5tulH8huQZDVTSppp2wq36r1yAcIhrO4j6DmNKWrA6/UbVC+yqz
 BISTiKWXkiZcsMBmxLEA7BEf3ImfH/qcNDXQ5HFO0MeWgrKXqI2N8sMme9c9X0VlIY
 /JbXlVnI7eGXAxuC7zPSatJR5Ho0ZFpE45pUewJt1h5aj+vIYMcKuyIBQmG1pY7xRP
 X6s1DmrUqW3JA==
Received: from [100.64.0.11] (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 8A3B717E138B;
 Fri,  8 May 2026 12:41:12 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Fri, 08 May 2026 12:40:47 +0200
Subject: [PATCH v2 1/4] drm/panthor: Don't use the racy
 drm_gem_lru_remove() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-panthor-shrinker-fixes-v2-1-39cdb7d577c9@collabora.com>
References: <20260508-panthor-shrinker-fixes-v2-0-39cdb7d577c9@collabora.com>
In-Reply-To: <20260508-panthor-shrinker-fixes-v2-0-39cdb7d577c9@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778236871; l=3640;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=CCjbAOv+AUfwV71P61bambB9KPgJkBGpAkVfSqu3IzE=;
 b=S+kY1FBPu22WvLC7UmxPfpUmHF0PXd4jJKCwO+GBDLneBrvYhv2/fwn+tybBr1jVPdusToIko
 rYY2lkNnIDrDklIlf8CddnL8TyJks/V1TNctT6p+avkhkliKvorufOQ
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

drm_gem_lru_remove() stores drm_gem_object::lru in a local variable
that's then dereferenced to acquire the LRU lock. Because this
assignment is done without the LRU lock held, it can race with
drm_gem_lru_scan() where drm_gem_object::lru is temporarily assigned
a stack-allcated LRU that goes away when leaving the function. By
the time we dereference this local lru variable, the object might
already be gone.

It feels like drm_gem_lru_remove() was never meant to be used this
way, because there's no easy way we can avoid this race unless we defer
the locking to the caller. Let's add an explicit LRU for unreclaimable
BOs instead, and have all BOs added to this LRU at creation time.

Fixes: fb42964e2a76 ("drm/panthor: Add a GEM shrinker")
Reported-by: Chia-I Wu <olvaffe@gmail.com>
Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/86
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.h | 10 ++++++++++
 drivers/gpu/drm/panthor/panthor_gem.c    |  5 ++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 4e4607bca7cc..dcdce75b683b 100644
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
+		 * All BOs start in this list at creation time.
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

