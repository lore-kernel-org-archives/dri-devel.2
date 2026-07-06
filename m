Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD872C44506
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A71B810E889;
	Mon,  6 Jul 2026 10:16:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.b="AksVNzKt";
	dkim-atps=neutral
Received: from smtpout7.mo534.mail-out.ovh.net
 (smtpout7.mo534.mail-out.ovh.net [54.36.140.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3466010E889
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 10:16:46 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4gv0SP5p9qz6JMk;
 Mon,  6 Jul 2026 10:08:53 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.deucher@amd.com>; Mon,  6 Jul 2026 10:08:53 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.101.100])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gv0SP4j4Hz5vW1; Mon,  6 Jul 2026 10:08:53 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.11])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 720FA8E1900; 
 Mon,  6 Jul 2026 10:08:51 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R0053612b4bd-563f-4dd2-a97a-1dd228f6edc0,
 F224CF1D020274B13B21E639C91833BCDAC0997A) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
From: Natalie Vock <nat@pixelcluster.dev>
Date: Mon, 06 Jul 2026 12:07:49 +0200
Subject: [PATCH v2 07/10] drm/ttm: use ttm_bo_lru_for_each_reserved_guarded
 in evict_all
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260706-ttm_2_drm_exec-v2-7-4bf6bfc0d320@pixelcluster.dev>
References: <20260706-ttm_2_drm_exec-v2-0-4bf6bfc0d320@pixelcluster.dev>
In-Reply-To: <20260706-ttm_2_drm_exec-v2-0-4bf6bfc0d320@pixelcluster.dev>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
X-Mailer: b4 0.15.2
x-ovh-tracer-id: 9130203821519757628
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGrlNJ8ShesFc0BsmoWFi51A7F15j2IaCkSK7BVZBg/BM8MBdGhyqLZmkbZMHw/TdptOPm8sgahQti1Nc9RjBh0KMZiGtpja+p6qhts3jrWUso58aRKRrx2DXtHoeXDd8faKpktnEASA9l57md6lmCqaecpmqLv9KOaMd5Cxk2fFcLRCf7Y1jiwLpKZwWHOg5MLCHSu/c85HhHBD+9tK6DpmR22NTjUbN0dGZJB9cmuuQPGLboQ0v7ZPGbXkip9C+NIKd694im0qBCyEcUf/DwxdiDWy9o5iBQA1zQlg0Y75Jpr3La1ocQctyDO3tKJ1UAaq83N/bdymi3oIi31d22YfaQgISu8BkudkNFC83ngbYpyoXPrY/Vwp3yCL3PnclINqLD/Ub8JUuqwXOSMSABA03aSlmg66ZBy3Sw1AoZl0cbfxYbFgUrMuQ5w9Ie0kBtOepm9bcjMO5dT06DpOSISzEpb4nHUuZOLn58uU+JtJOgrdDnVoqmPC6PdSj55Vk5SYTs8UwgcSaeHr2CSZthjfr4yBQsL/aKXtt9PCLOnzDLnHJouvw8rHck6T6joSvckKUrkz851r+Ia8Q98SfNgLAMCT2D2Vxn3QZ9J2q0jYXaK1IJQ4/ztKOdgIcgdG5mbXApb4OdxAOKERgJpRRf7CU3QAmzr3U1TWnX3Rb40/w
DKIM-Signature: a=rsa-sha256; bh=2VTWirLQQEh5gYLd+gBFz1PjIG9wAxQUW7SNqFxNanM=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1783332534; v=1;
 b=AksVNzKt7iqsApTx11UxQ1+wT2z9FohXf8jrJQw0k2uOiEDHHLxh/SYaym1jaIUK7PK4e59t
 a0KslZGMqPN2PJCdVBnd5TwHu1odPKbx1CRo18we1QhBomAM3qQbtmsxPz6HZ5FRUayoYZC3sbJ
 Ycu8qzijfffAF1VHbqkjq/5b1uJwZvEqn/0vEPtFRomAKwAHNy0ONTOIumLSzL/cs0+TgX84oRk
 knFwazIXf5BjQlJbhM8iSz1giDd4Y747SNVXI5RV37fYNDAQb7j3iSPP3Dk/7vvH8fsivgy8xuF
 hweEuTeTS9oTt4C/zF+KRkkGBXzcxzK9DafXowBEWxjLA==
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

Use the for_each loop to evict all BOs of an resource manager as well.

Greately simplifying the handling and finally allows us to
remove ttm_bo_evict_first().

Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Natalie Vock <nat@pixelcluster.dev>
---
 drivers/gpu/drm/ttm/ttm_bo.c       | 51 +-------------------------------------
 drivers/gpu/drm/ttm/ttm_resource.c | 21 ++++++++++------
 include/drm/ttm/ttm_bo.h           |  1 +
 3 files changed, 16 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 54f01611ec823..80933ba6aada9 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -351,8 +351,7 @@ static int ttm_bo_bounce_temp_buffer(struct ttm_buffer_object *bo,
 	return 0;
 }
 
-static int ttm_bo_evict(struct ttm_buffer_object *bo,
-			struct ttm_operation_ctx *ctx)
+int ttm_bo_evict(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx)
 {
 	struct ttm_resource *evict_mem;
 	struct ttm_placement placement;
@@ -437,54 +436,6 @@ bool ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 }
 EXPORT_SYMBOL(ttm_bo_eviction_valuable);
 
-/**
- * ttm_bo_evict_first() - Evict the first bo on the manager's LRU list.
- * @bdev: The ttm device.
- * @man: The manager whose bo to evict.
- * @ctx: The TTM operation ctx governing the eviction.
- *
- * Return: 0 if successful or the resource disappeared. Negative error code on error.
- */
-int ttm_bo_evict_first(struct ttm_device *bdev, struct ttm_resource_manager *man,
-		       struct ttm_operation_ctx *ctx)
-{
-	struct ttm_resource_cursor cursor;
-	struct ttm_buffer_object *bo;
-	struct ttm_resource *res;
-	unsigned int mem_type;
-	int ret = 0;
-
-	spin_lock(&bdev->lru_lock);
-	ttm_resource_cursor_init(&cursor, man);
-	res = ttm_resource_manager_first(&cursor);
-	ttm_resource_cursor_fini(&cursor);
-	if (!res) {
-		ret = -ENOENT;
-		goto out_no_ref;
-	}
-	bo = res->bo;
-	if (!ttm_bo_get_unless_zero(bo))
-		goto out_no_ref;
-	mem_type = res->mem_type;
-	spin_unlock(&bdev->lru_lock);
-	ret = ttm_bo_reserve(bo, ctx->interruptible, ctx->no_wait_gpu, NULL);
-	if (ret)
-		goto out_no_lock;
-	if (!bo->resource || bo->resource->mem_type != mem_type)
-		goto out_bo_moved;
-
-	ret = ttm_bo_evict(bo, ctx);
-out_bo_moved:
-	dma_resv_unlock(bo->base.resv);
-out_no_lock:
-	ttm_bo_put(bo);
-	return ret;
-
-out_no_ref:
-	spin_unlock(&bdev->lru_lock);
-	return ret;
-}
-
 /**
  * struct ttm_bo_evict_walk - Parameters for the evict walk.
  */
diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index 154d6739256f8..107b6cfea66b3 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -561,17 +561,24 @@ EXPORT_SYMBOL(ttm_resource_manager_init);
 int ttm_resource_manager_evict_all(struct ttm_device *bdev,
 				   struct ttm_resource_manager *man)
 {
-	struct ttm_operation_ctx ctx = { };
+	struct ttm_bo_lru_cursor cursor;
+	struct ttm_buffer_object *bo;
+	struct ttm_operation_ctx ctx = {
+		.interruptible = false,
+		.no_wait_gpu = false,
+	};
+	struct ttm_lru_walk_arg arg = {
+		.ctx = &ctx,
+	};
 	struct dma_fence *fence;
 	int ret, i;
 
-	do {
-		ret = ttm_bo_evict_first(bdev, man, &ctx);
+	ttm_bo_lru_for_each_reserved_guarded(&cursor, man, &arg, bo) {
+		ret = ttm_bo_evict(bo, &ctx);
+		if (ret)
+			return ret;
 		cond_resched();
-	} while (!ret);
-
-	if (ret && ret != -ENOENT)
-		return ret;
+	}
 
 	ret = 0;
 
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index bbed63064c9a9..a4060e44d23d0 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -389,6 +389,7 @@ int ttm_bo_validate(struct ttm_buffer_object *bo,
 void ttm_bo_fini(struct ttm_buffer_object *bo);
 void ttm_bo_set_bulk_move(struct ttm_buffer_object *bo,
 			  struct ttm_lru_bulk_move *bulk);
+int ttm_bo_evict(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx);
 bool ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 			      const struct ttm_place *place);
 int ttm_bo_init_reserved(struct ttm_device *bdev, struct ttm_buffer_object *bo,

-- 
2.55.0

