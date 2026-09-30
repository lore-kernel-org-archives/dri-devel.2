Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B0ECA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:07:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F26EC10F397;
	Wed, 30 Sep 2026 19:07:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="JMb9xwod";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B93A10F397
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=950IaKQipsO7vWN2Auf9HVUwCBfFGZDJT9BKWI7S4fY=; b=JMb9xwodtB0AzW6VQkV1TGJ7Vs
 suyjMJCQeFi4pF4JhvhYLady0YENpxw8YCpgGgg+KhTReKX2EZAEuap+CdgLv+gsOVXiurhMqkBxp
 4cBthWqHWxBAoddOZJNHH7eRIpP3Sv7oYcI1OJDiO5K7O9XrCjF2HJAuKQfL5NEftpbXUa+c1vSWs
 5Zsa8Kg1er8xD9snyY0FH06DSscgKP5WAtJLHk1BAnkFqyEkNFWd6lWxL9iqwy2ti59Bz7Org1/x3
 Z6B2uYVMyEc7Y20/LWdhy+IEU+rVdheQ121lCurmeueAVDoROs3lpEaJkSQU1SZHSb6R+h/8zyMZT
 xVwT8Q1A==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xBzeU-009Zw6-72; Wed, 30 Sep 2026 21:07:38 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Iago Toral <itoral@igalia.com>,
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 2/2] drm/vc4: Use kvmalloc_objs() for the BO cache size list
Date: Wed, 30 Sep 2026 16:06:51 -0300
Message-ID: <20260930190721.1897264-2-mcanal@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930190721.1897264-1-mcanal@igalia.com>
References: <20260930190721.1897264-1-mcanal@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

The BO cache size list has one entry per BO page count, so its size
scales with the largest BO ever freed. A 64 MiB BO already needs at
least an order-6 allocation, which fails under fragmentation and
triggers a warn_alloc() splat on BO close:

  page allocation failure: order:7, mode:0x40cc0(GFP_KERNEL|__GFP_COMP)
  Call trace:
   ...
   warn_alloc+0x118/0x190
   __alloc_pages_slowpath+0x4a8/0x520
   ...
   __kmalloc_noprof+0x3ac/0x5d8
   vc4_free_object+0x128/0x370 [vc4]
   drm_gem_object_handle_put_unlocked+0xb8/0x158 [drm]
   drm_gem_object_release_handle+0x74/0xe8 [drm]
   drm_gem_handle_delete+0x6c/0xa8 [drm]
   drm_gem_close_ioctl+0x34/0x50 [drm]

The list doesn't need physically contiguous memory. Use kvmalloc_objs()
so large lists can fall back to vmalloc(), avoiding the allocation
failure.

Fixes: c826a6e10644 ("drm/vc4: Add a BO cache.")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_bo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index ea1be891ac78..7b8b3364000f 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -204,7 +204,7 @@ static struct list_head *vc4_get_cache_list_for_size(struct drm_device *dev,
 		struct list_head *new_list;
 		uint32_t i;
 
-		new_list = kmalloc_objs(struct list_head, new_size);
+		new_list = kvmalloc_objs(struct list_head, new_size);
 		if (!new_list)
 			return NULL;
 
@@ -224,7 +224,7 @@ static struct list_head *vc4_get_cache_list_for_size(struct drm_device *dev,
 		for (i = vc4->bo_cache.size_list_size; i < new_size; i++)
 			INIT_LIST_HEAD(&new_list[i]);
 
-		kfree(vc4->bo_cache.size_list);
+		kvfree(vc4->bo_cache.size_list);
 		vc4->bo_cache.size_list = new_list;
 		vc4->bo_cache.size_list_size = new_size;
 	}
@@ -1052,7 +1052,7 @@ static void vc4_bo_cache_destroy(struct drm_device *dev, void *unused)
 	cancel_work_sync(&vc4->bo_cache.time_work);
 
 	vc4_bo_cache_purge(dev);
-	kfree(vc4->bo_cache.size_list);
+	kvfree(vc4->bo_cache.size_list);
 
 	for (i = 0; i < vc4->num_labels; i++) {
 		if (vc4->bo_labels[i].num_allocated) {
-- 
2.55.0

