Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FE7606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=fZ6CPO7j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 284DA11211B;
	Thu, 12 Nov 2026 12:57:24 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22B9B112109
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 12:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=+DIJefjwUpKQdS8Hp+UBpmUWO8RYbixBIlSpsd8e9U4=; t=1794488234; x=2109848234; 
 b=fZ6CPO7jeM6iR4uMN628IFmIBNEYLZ6v2HhpG8FhxV5kJtiZqGrGkKRlPPO2OuPox9pr71YjQfq
 SMBDKQcauskHNxpBrPT37ZcZcQN0x3i+sOkO7wBnj1MdDAmzO6RyhYQQm+GOMFHciMzRizF9Id1Ge
 LG+umk7qLTJ3s6r1GXS3dgrfVSKBisJ5bnOpx7EWFa4Vmpu2KQgGRt5z0GF4LR8agqtCt0ke9m6fC
 /iqvX5cyd5RTIixtk0my/CxflEtpTNzlRkWkCJHs3JVFXuRk93jkxAcPxq6f3PXd20tx+qPWCoVQp
 Qph8G2rVImH0TbDV0KtjArVlSDUWoupoJbLA==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xRUMV-009Xxy-Oo; Thu, 12 Nov 2026 13:57:07 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Thu, 12 Nov 2026 09:56:55 -0300
Subject: [PATCH 1/2] drm/vc4: Drop BO usecnt before releasing the old FB
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261112-vc4-async-flip-fixes-v1-1-42449a703840@igalia.com>
References: <20261112-vc4-async-flip-fixes-v1-0-42449a703840@igalia.com>
In-Reply-To: <20261112-vc4-async-flip-fixes-v1-0-42449a703840@igalia.com>
To: Iago Toral <itoral@igalia.com>, Melissa Wen <mwen@igalia.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4409; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=Mhhdx3abS3XijWwmqjGsd076MAeg/l7+teHRLZS3X6o=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq9bedjX4DAe6whOU8Pua1KncGrTOyDh49nWhrq
 6KiiNf5JwCJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCavW3nQAKCRA/8w6Kdoj6
 qtP1B/4/c98UMJrZsjU5xNZWuuXYNxWWhHhkw5h8VnOyLN99o7rVzlXhx45ECUEX+YtPsQ9idSf
 Ql0ly5GUFD4dq1W7W/J5TxOWg1Wm6cEvoIio0SI0er8iSLN/eVY/oJpR2IROX3sF6O7P/RV9QLA
 WlWMuPsSjDHUjVrLJoAr8X4Vli8dnCxqsOoJfuYb6igXiCftIWs2bjnKm/l59KPveHovhx3ftjy
 HdumH5i7x2sa6JxEhfOD3tOdGv+OX6MvSyk0/z1riXIogKaAev8D1c0KBPfLbyuUeFloKCw3KxW
 MnFehN0CBjXVF3wyAU2q4kK3Sj6aRn9rHuz/VkkeddtVnkEj
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The async page flip completion drops the old FB reference before
decrementing its BO usecnt. If that was the last reference, the BO is
already freed or recycled into the BO cache when vc4_bo_dec_usecnt()
runs, leading to a use-after-free or a refcount underflow.

This could happen when userspace removes the old FB and closes its GEM
handle while the flip is still pending.

Decrement the BO usecnt before releasing the old FB reference. Do this
by unifying the two fence callbacks and only decrementing the BO usecnt
in VC4_GEN_4.

Cc: stable@vger.kernel.org
Fixes: 4d12c36fb73b ("drm/vc4: crtc: Move the BO handling out of common page-flip callback")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 62 +++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index f42cd5353230..c558b527c7e6 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -895,6 +895,7 @@ vc4_async_page_flip_complete(struct vc4_async_flip_state *flip_state)
 {
 	struct drm_crtc *crtc = flip_state->crtc;
 	struct drm_device *dev = crtc->dev;
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct drm_plane *plane = crtc->primary;
 
 	vc4_plane_async_set_fb(plane, flip_state->fb);
@@ -909,39 +910,27 @@ vc4_async_page_flip_complete(struct vc4_async_flip_state *flip_state)
 	drm_crtc_vblank_put(crtc);
 	drm_framebuffer_put(flip_state->fb);
 
-	if (flip_state->old_fb)
-		drm_framebuffer_put(flip_state->old_fb);
-
-	kfree(flip_state);
-}
-
-static void vc4_async_page_flip_complete_with_cleanup(struct dma_fence *fence,
-						      struct dma_fence_cb *cb)
-{
-	struct vc4_async_flip_state *flip_state =
-		container_of(cb, struct vc4_async_flip_state, cb);
-	struct vc4_bo *bo = NULL;
-
 	if (flip_state->old_fb) {
-		struct drm_gem_dma_object *dma_bo =
-			drm_fb_dma_get_gem_obj(flip_state->old_fb, 0);
-		bo = to_vc4_bo(&dma_bo->base);
+		/*
+		 * Decrement the BO usecnt in order to keep the inc/dec
+		 * calls balanced when the planes are updated through
+		 * the async update path.
+		 *
+		 * FIXME: we should move to generic async-page-flip when
+		 * it's available, so that we can get rid of this
+		 * hand-made cleanup_fb() logic.
+		 */
+		if (vc4->gen == VC4_GEN_4) {
+			struct drm_gem_dma_object *dma_bo =
+				drm_fb_dma_get_gem_obj(flip_state->old_fb, 0);
+
+			vc4_bo_dec_usecnt(to_vc4_bo(&dma_bo->base));
+		}
+
+		drm_framebuffer_put(flip_state->old_fb);
 	}
 
-	vc4_async_page_flip_complete(flip_state);
-	dma_fence_put(fence);
-
-	/*
-	 * Decrement the BO usecnt in order to keep the inc/dec
-	 * calls balanced when the planes are updated through
-	 * the async update path.
-	 *
-	 * FIXME: we should move to generic async-page-flip when
-	 * it's available, so that we can get rid of this
-	 * hand-made cleanup_fb() logic.
-	 */
-	if (bo)
-		vc4_bo_dec_usecnt(bo);
+	kfree(flip_state);
 }
 
 static void vc4_async_page_flip_fence_complete(struct dma_fence *fence,
@@ -959,30 +948,23 @@ static int vc4_async_set_fence_cb(struct drm_device *dev,
 {
 	struct drm_framebuffer *fb = flip_state->fb;
 	struct drm_gem_dma_object *dma_bo = drm_fb_dma_get_gem_obj(fb, 0);
-	dma_fence_func_t async_page_flip_complete_function;
-	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct dma_fence *fence;
 	int ret;
 
-	if (vc4->gen == VC4_GEN_4)
-		async_page_flip_complete_function = vc4_async_page_flip_complete_with_cleanup;
-	else
-		async_page_flip_complete_function = vc4_async_page_flip_fence_complete;
-
 	ret = dma_resv_get_singleton(dma_bo->base.resv, DMA_RESV_USAGE_READ, &fence);
 	if (ret)
 		return ret;
 
 	/* If there's no fence, complete the page flip immediately */
 	if (!fence) {
-		async_page_flip_complete_function(fence, &flip_state->cb);
+		vc4_async_page_flip_fence_complete(fence, &flip_state->cb);
 		return 0;
 	}
 
 	/* If the fence has already been completed, complete the page flip */
 	if (dma_fence_add_callback(fence, &flip_state->cb,
-				   async_page_flip_complete_function))
-		async_page_flip_complete_function(fence, &flip_state->cb);
+				   vc4_async_page_flip_fence_complete))
+		vc4_async_page_flip_fence_complete(fence, &flip_state->cb);
 
 	return 0;
 }

-- 
2.56.0

