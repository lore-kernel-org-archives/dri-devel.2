Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E644C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A19FE10E867;
	Mon,  6 Jul 2026 10:09:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.b="l1/6bP/4";
	dkim-atps=neutral
X-Greylist: delayed 53847 seconds by postgrey-1.36 at gabe;
 Mon, 06 Jul 2026 10:08:59 UTC
Received: from 5.mo533.mail-out.ovh.net (5.mo533.mail-out.ovh.net
 [54.36.140.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D24B10E869
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 10:08:59 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [57.128.106.70])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4gv0ST2Cddz5wl1;
 Mon,  6 Jul 2026 10:08:57 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.deucher@amd.com>; Mon,  6 Jul 2026 10:08:57 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.101.74])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gv0SS66cJz7tDb; Mon,  6 Jul 2026 10:08:56 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.11])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id D61E18E1900; 
 Mon,  6 Jul 2026 10:08:54 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R005c709a69b-a109-4538-9cff-6c3a708b05f4,
 F224CF1D020274B13B21E639C91833BCDAC0997A) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
From: Natalie Vock <nat@pixelcluster.dev>
Date: Mon, 06 Jul 2026 12:07:51 +0200
Subject: [PATCH v2 09/10] drm/ttm: support using drm_exec during eviction
 v4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260706-ttm_2_drm_exec-v2-9-4bf6bfc0d320@pixelcluster.dev>
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
x-ovh-tracer-id: 9131329723485086012
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGrlNJ8ShesFc0BsmoWFi51A7F15j2IaCkSK7BVZBg/BM8MBdGhyqLZmkbZMHw/TdptOPm8sgahQti1Nc9RjBh0KMZiGtpja+p6qhts3jrWUso58aRKRrx2DXtHoeXDd8faKpktnEASA9l57md6lmCqaecpmqLv9KOaMd5Cxk2fFcLRCf7Y1jiwLpKZwWHOg5MLCHSu/c85HhHBD+9tK6DpmR22NTjUbN0dGZJB9cmuuQPGLboQ0v7ZPGbXkip9C+NIKd694im0qBCyEcUf/DwxdiDWy9o5iBQA1zQlg0Y75Jpr3La1ocQctyDO3tKJ1UAaq83N/bdymi3oIi31d22YcqdsW9ZNQHTTK/79SgisJRymKcxBCdmwktBdbden4e5FLdP+Lhu7A5YEPpVUkxChL6uXk8f3HYvWtEFfCPL8PHLp285RU28A15yGPPMBLrnwq6JofiQJCGhFJABVkw7vkHAThSDyuTLzAqFkTXZB7I6jq6b1mIkUr8cXdjikSlf3Ht6j+hGADOsrQSqCJa7pQU3z7q+8p4fspIYHa3wBG5efm2YdAsLrm3GHg8uSsMoBmqrv0mKaiIbDNgysI5BlTKu39FBIqASN7pFGVwZKHnYJd1ewaRDXiA8/eB7TrpPNFYg9s2lzsq2oP1jYytEU6bMDYfjjmUJDY4eCCd5ftA
DKIM-Signature: a=rsa-sha256; bh=7A5T2b3M6vYyGePnmU0aS80euo+xNigllqLOoN06jgU=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1783332537; v=1;
 b=l1/6bP/4SOaB40nSpStPbcl1+964adLq07F29uP6SN43ZiTaSgv48zxA0ghb4bYre0z6BAhx
 WsPOZOPi9o+mq/1CBWnVJWEBDGx4ydb3Y9bAIz6qpgnWCYym2gz5mP9s5VapoUrdC+Yh/c4FmYR
 h9SFsVYAY2U/YUBOv1tptOAm5RQr8uMnGAqelp1CbAJrZi2AYuUWNjd/n4ERST5C4yVw5AsQ+6H
 aYP0+13/AyJYEo0lJkLNVa4hkQ2xqOKD0svH+HFoZZvIqt62fAhtY1AIRdDvUa/Gzf0VHNpIqeq
 wpuePx+j5UDXJmWIALbhoES5Ru+8lTc59gC6p1c1ShcPA==
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

Allow specifying a drm_exec object in TTMs operation context which is
used to lock objects during eviction.

This allows to handle deadlocks much more gracefully and with that
avoid returning -ENOMEM on heavily contended domains.

v2: rebased on top of Thomas work
v3: rebased again
v4: rebased, fixed locks of already-reserved buffers being dropped

Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Natalie Vock <nat@pixelcluster.dev>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 30 ++++++++++++++++++++++--------
 include/drm/ttm/ttm_bo.h          |  5 +++++
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index a53b25e8c2967..96699532817c2 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -38,6 +38,7 @@
 #include <drm/ttm/ttm_tt.h>
 
 #include <drm/drm_cache.h>
+#include <drm/drm_exec.h>
 
 #include "ttm_bo_internal.h"
 
@@ -837,6 +838,8 @@ static bool ttm_lru_walk_trylock(struct ttm_bo_lru_cursor *curs,
 	struct ttm_operation_ctx *ctx = curs->arg->ctx;
 
 	curs->needs_unlock = false;
+	if (ctx->exec)
+		return false;
 
 	if (dma_resv_trylock(bo->base.resv)) {
 		curs->needs_unlock = true;
@@ -857,7 +860,9 @@ static int ttm_lru_walk_ticketlock(struct ttm_bo_lru_cursor *curs,
 	struct ttm_lru_walk_arg *arg = curs->arg;
 	int ret;
 
-	if (arg->ctx->interruptible)
+	if (arg->ctx->exec)
+		ret = drm_exec_lock_obj_report_dup(arg->ctx->exec, &bo->base);
+	else if (arg->ctx->interruptible)
 		ret = dma_resv_lock_interruptible(bo->base.resv, arg->ticket);
 	else
 		ret = dma_resv_lock(bo->base.resv, arg->ticket);
@@ -871,7 +876,11 @@ static int ttm_lru_walk_ticketlock(struct ttm_bo_lru_cursor *curs,
 		 * trylocking for this walk.
 		 */
 		arg->ticket = NULL;
-	} else if (ret == -EDEADLK) {
+
+	} else if (arg->ctx->exec && arg->ctx->allow_res_evict &&
+		   ret == -EALREADY) {
+		ret = 0;
+	} else if (!arg->ctx->exec && ret == -EDEADLK) {
 		/* Caller needs to exit the ww transaction. */
 		ret = -ENOSPC;
 	}
@@ -937,12 +946,17 @@ static void ttm_bo_lru_cursor_cleanup_bo(struct ttm_bo_lru_cursor *curs)
 {
 	struct ttm_buffer_object *bo = curs->bo;
 
-	if (bo) {
-		if (curs->needs_unlock)
+	if (!bo)
+		return;
+
+	if (curs->needs_unlock) {
+		if (curs->arg->ctx->exec)
+			drm_exec_unlock_obj(curs->arg->ctx->exec, &bo->base);
+		else
 			dma_resv_unlock(bo->base.resv);
-		ttm_bo_put(bo);
-		curs->bo = NULL;
 	}
+	ttm_bo_put(bo);
+	curs->bo = NULL;
 }
 
 /**
@@ -1016,8 +1030,8 @@ __ttm_bo_lru_cursor_next(struct ttm_bo_lru_cursor *curs)
 		if (ttm_lru_walk_trylock(curs, bo)) {
 			bo_locked = true;
 
-		} else if (!arg->ticket || arg->ctx->no_wait_gpu ||
-			   arg->trylock_only) {
+		} else if ((!arg->ticket || arg->ctx->no_wait_gpu ||
+			    arg->trylock_only) && !arg->ctx->exec) {
 			spin_unlock(lru_lock);
 			ttm_bo_put(bo);
 			spin_lock(lru_lock);
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index a4060e44d23d0..156444b5e85d8 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -187,6 +187,11 @@ struct ttm_operation_ctx {
 	 * @bytes_moved: Statistics on how many bytes have been moved.
 	 */
 	uint64_t bytes_moved;
+	/**
+	 * @exec: optional drm_exec object to use for locking BOs and
+	 * tracking which are locked.
+	 */
+	struct drm_exec *exec;
 };
 
 /**

-- 
2.55.0

