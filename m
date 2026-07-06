Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C55C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91F6010E868;
	Mon,  6 Jul 2026 10:08:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.b="eUJyg/Kh";
	dkim-atps=neutral
X-Greylist: delayed 56242 seconds by postgrey-1.36 at gabe;
 Mon, 06 Jul 2026 10:08:54 UTC
Received: from 11.mo533.mail-out.ovh.net (11.mo533.mail-out.ovh.net
 [87.98.181.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84B2710E868
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 10:08:54 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [57.128.106.70])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4gv0SN34SFz64D7;
 Mon,  6 Jul 2026 10:08:52 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.deucher@amd.com>; Mon,  6 Jul 2026 10:08:52 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.113.205])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gv0SM6Kn7z7tDb; Mon,  6 Jul 2026 10:08:51 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.11])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id C3DC88E18F1; 
 Mon,  6 Jul 2026 10:08:49 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R005a42a97b5-83e6-4135-bf5a-4167f33e25d6,
 F224CF1D020274B13B21E639C91833BCDAC0997A) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
From: Natalie Vock <nat@pixelcluster.dev>
Date: Mon, 06 Jul 2026 12:07:48 +0200
Subject: [PATCH v2 06/10] drm/ttm: move zombie handling into ttm_bo_evict
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260706-ttm_2_drm_exec-v2-6-4bf6bfc0d320@pixelcluster.dev>
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
x-ovh-tracer-id: 9129922348778611004
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF2rMupFDtSz5VGJXaGrwYUaRUbsc9Nn7nc8ghpwc35VyZFauYARogcas+VOSD8wf0IhZl41F2o83TSTJEqn1M70AEfTiU3uOfrR34AN46Y0JjeW4xo6cV+rH2TUD4SE1NDtof+377HjW5jUw1vYYddQq9f46CIv1pXDMg+OvLcv0mAeBq8idZd3/oeDOqFYW+mp/D/hf65ucF8pcrq4BoeAZT2yueghykMKcN1pOaBvVNRQXaTXALuE+8w2Owws5LoK70lx9jAX+i5vFCotZFddZWqe5L2MI0ywEcZRGnxLB/PRWCfMsAV61ff3CxEAEQBj4aCGHb8mrffVRaINrHzSOGJlXIUmJVwzUoH3BiotNBdeFHV2G71DUEencJEovZdqlMYUuhIAKjA+DfgjS3epEpEQNrzwPCKX2QgC5ldjdmvqjhO6m/WaW7AUu/ZUELhH43surbBI3DIUpdGLhRX8JNLcXwghofbs+01qhIeZxb1zkmYRQBbWo2Y8ozysScI3nlhIZDDntC275P1NiineIUI2cuFBMTmng7YcvOds0YdN9LWNMpWToi3AmaiWuIpn2hvQ6l7CMyrbKhV1zhntLZPe8aW3YFAGk3mXEHHaKn2q35sh1wDwOoxfvgLRxWhNns49UdPIv7G3QOsm+QGLosyNGvX9QaQMuvduSQGLQ
DKIM-Signature: a=rsa-sha256; bh=e8QHyuDL2skEkQjNtYLhoBSaqvz+SM6k98JVY9giwR0=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1783332532; v=1;
 b=eUJyg/KhLJxqzbeR8X8fv308CF/T3a0hdfG/bBr+nFr+3YsuvxnMub7QzWMolJwsdEYmMj6n
 327Wv7hJcXwAMJdmbIRQTFF2jj/PcMin2O8QErzsN39K/kg/rfpoTsykFg7T8sIovxbHEIJjV0n
 T+OrsnDJiOruY/AxvbhYplnG4EmY7ZcLgxfLJ1gWDytfi/qsJGqzf82QmxOUEr3hRU8vWvQqliR
 0xGisukUHwaIpYRgZhNMTlJqLQn+VSiA2glo7arWxyl/GSLCu2Rol/Kb7JX1B5ogMLTvwg6BKhP
 7iHCL8Od0xVKOb+1OS7Guc6CG/VjTtuYMCowegzj6+eQA==
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

Both callers do the same thing, so we can trivially unify that.

Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Natalie Vock <nat@pixelcluster.dev>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 24c52df169ac8..54f01611ec823 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -359,6 +359,13 @@ static int ttm_bo_evict(struct ttm_buffer_object *bo,
 	struct ttm_place hop;
 	int ret = 0;
 
+	if (ttm_bo_is_zombie(bo)) {
+		ret = ttm_bo_wait_ctx(bo, ctx);
+		if (!ret)
+			ttm_bo_cleanup_memtype_use(bo);
+		return ret;
+	}
+
 	memset(&hop, 0, sizeof(hop));
 
 	dma_resv_assert_held(bo->base.resv);
@@ -466,13 +473,7 @@ int ttm_bo_evict_first(struct ttm_device *bdev, struct ttm_resource_manager *man
 	if (!bo->resource || bo->resource->mem_type != mem_type)
 		goto out_bo_moved;
 
-	if (ttm_bo_is_zombie(bo)) {
-		ret = ttm_bo_wait_ctx(bo, ctx);
-		if (!ret)
-			ttm_bo_cleanup_memtype_use(bo);
-	} else {
-		ret = ttm_bo_evict(bo, ctx);
-	}
+	ret = ttm_bo_evict(bo, ctx);
 out_bo_moved:
 	dma_resv_unlock(bo->base.resv);
 out_no_lock:
@@ -520,14 +521,7 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *
 	if (bo->pin_count || !bo->bdev->funcs->eviction_valuable(bo, evict_walk->place))
 		return 0;
 
-	if (ttm_bo_is_zombie(bo)) {
-		lret = ttm_bo_wait_ctx(bo, walk->arg.ctx);
-		if (!lret)
-			ttm_bo_cleanup_memtype_use(bo);
-	} else {
-		lret = ttm_bo_evict(bo, walk->arg.ctx);
-	}
-
+	lret = ttm_bo_evict(bo, walk->arg.ctx);
 	if (lret)
 		goto out;
 

-- 
2.55.0

