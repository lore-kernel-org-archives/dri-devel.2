Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED43ACD3436
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 12:16:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84C7910ED6F;
	Wed,  6 May 2026 12:16:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="HwIiRzUq";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A813710ED5B;
 Wed,  6 May 2026 12:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778069799;
 bh=u1rbbnIoyFZA7O2vs7QHol/yHibz7ircmGOOnRxEjGA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=HwIiRzUqisePGYSP+oQv8nut2BrQ2Y8Yz8rFZyvpXSXIu7PXyeQTv249ZYry8t5FR
 fFHvXPH6osctGucWoC4Py5gh+56RV9cb2cKqXg+xZxMlxkr1BU1nMaLmEF0dY/9bom
 8U6gtSxzpKQD4MJedEhlwrdzVZ9xguxercMdIKl5K/scxHlpTCCqd7FaDDtQBgib3s
 vrDk7euO9rvVmNaF3F94HWrpkFy9aQLBdySDTuFadoQ9f5BoQkUx07lfZBLQNclaNM
 bKNNVU/J5Dug5BJUUW8lL+kKmty/lAwn86wPo/uyg5ZwUoFWMMniXkivncb7UWOAzh
 uQPcjpPDJ4r0w==
Received: from [100.64.0.11] (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 94F7917E1537;
 Wed,  6 May 2026 14:16:38 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Wed, 06 May 2026 14:16:27 +0200
Subject: [PATCH 2/3] drm/gem: Fix a race between drm_gem_lru_scan() and
 drm_gem_object_release()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-panthor-shrinker-fixes-v1-2-e7721526de96@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778069796; l=2777;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=u1rbbnIoyFZA7O2vs7QHol/yHibz7ircmGOOnRxEjGA=;
 b=0Vn0g7A6fEq54VBM8lGGCLNX9mHH+iAkL1OkGKe/jCH9w71OWroJV8R46OeF5EN1tdfdBhZwI
 cmjDTvLf01KDnH2rNOTeUgKqGCKEDTXPmK0yMv53DqAjtz8gkdpAlyR
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

The following race can currently happen:

| Thread 0 in `drm_gem_lru_scan`               | Thread 1 in `drm_gem_object_release` |
| -                                            | -                                    |
| move obj1 with refcount==0 to `still_in_lru` |                                      |
| move obj2 with refcount!=0 to `still_in_lru` |                                      |
| mutex_unlock                                 |                                      |
| shrink obj2                                  |                                      |
|                                              | lru = obj1->lru; // `still_in_lru`   |
| mutex_lock                                   |                                      |
| move obj1 back to the original lru           |                                      |
| mutex_unlock                                 |                                      |
| return                                       |                                      |
|                                              | dereference `still_in_lru`           |

Move the drm_gem_lru_move_tail_locked() after the
kref_get_unless_zero() check so that we don't end up with a
vanishing LRU when we hit drm_gem_object_release(). We also need to
remove the skipped object from its LRU, otherwise we'll keep hitting
it on subsequent loop iterations until it's actually removed from the
list in the drm_gem_release().

Fixes: e7c2af13f811 ("drm/gem: Add LRU/shrinker helper")
Reported-by: Chia-I Wu <olvaffe@gmail.com>
Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/86
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/drm_gem.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index fca42949eb2b..97cf63de0112 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1660,15 +1660,19 @@ drm_gem_lru_scan(struct drm_gem_lru *lru,
 		if (!obj)
 			break;
 
-		drm_gem_lru_move_tail_locked(&still_in_lru, obj);
-
 		/*
 		 * If it's in the process of being freed, gem_object->free()
-		 * may be blocked on lock waiting to remove it.  So just
-		 * skip it.
+		 * may be blocked on lock waiting to remove it.  So just remove
+		 * it from its current LRU and skip it.
 		 */
-		if (!kref_get_unless_zero(&obj->refcount))
+		if (!kref_get_unless_zero(&obj->refcount)) {
+			if (obj->lru)
+				drm_gem_lru_remove_locked(obj);
+
 			continue;
+		}
+
+		drm_gem_lru_move_tail_locked(&still_in_lru, obj);
 
 		/*
 		 * Now that we own a reference, we can drop the lock for the

-- 
2.54.0

