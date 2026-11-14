Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E95A606A32E
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=m1iI9MmA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B99710E300;
	Sat, 14 Nov 2026 19:18:00 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07B4210E300
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 19:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=x08eFSJWECdpEB1+Nn1Ri1/1VsyIJ9XcTh8PmWDvozU=; t=1794683867; x=2110043867; 
 b=m1iI9MmAqmPfk8pfg822dsQxx81NKDT53gOP27OqlJjc+9W6DkOszYCAms47WtLAi8X/b+DtXoi
 3uicE966ZV+FCdePcvhd6qM/pi658RDKn93+3EGffnAMFjr/MXLguO9ufsUy3k4OWR7NfQmNWZ1ZJ
 ejYzOnJRZcrWbaBK7TI6+8ALGcDHDM7QBt5hMtjCIrgW0ku9N9RgcBWGL73yORvlTvmTCR67FkUVm
 jKTfBUqKASbe2ThRu1UMMD9wPC78ukBXLi/k0CP8RwA/eDDsaZuiXH8Ppp13VpofQRCj2jtm3wOL1
 vncbHZgihcEY/a5kfVMs7GsIcmtFKJrM09dQ==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xSJFu-00AgZ4-SQ; Sat, 14 Nov 2026 20:17:43 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sat, 14 Nov 2026 16:16:52 -0300
Subject: [PATCH v2 3/3] drm/vc4: Look up the async page flip fence before
 committing the flip
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261114-vc4-async-flip-fixes-v2-3-d33cbe99ed5d@igalia.com>
References: <20261114-vc4-async-flip-fixes-v2-0-d33cbe99ed5d@igalia.com>
In-Reply-To: <20261114-vc4-async-flip-fixes-v2-0-d33cbe99ed5d@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3015; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=iY87qOAF9o9B2cQ2c/WuwCK7gklnYq3GKs6xfJt0rec=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq+LPGFGQK+Ts+Q9W/z9l7YlnBkebPiiauWJvJ/
 NiY0fTuNYGJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCavizxgAKCRA/8w6Kdoj6
 qg/HCADavdu8w7AprOBdACwdQeIFfuLHReLgHNMoHGfGkF+UsJGJhaCBFfndDVZID19clXMY010
 c6T7IytB0RPZxxVSGem/ahNCfbLDWfpcSKxyFwk3lB8C78oUj5XhMQnP8Ld+4KrNzAuSCKF1Zub
 AvkMRbsp15uj0sIbyuWeVBZ5Cgey8lFmJvsZ7Fgtw3NaAX4LNdiSvq4mHV0xAU/YLnvF+FftsSb
 lrCB1hVlxubDg8+s40zLegCX90x87gy+sSKrdi+h6qE+kCtdtZV4a0nEF/pVy+P6yvlLhMTkiEI
 wfDR42RsGE+Wip/m2jdxoDnyNVaIUs6Zoa5dHP9m1jbj3iSy
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

vc4_async_page_flip_common() ignores dma_resv_get_singleton() failures.
By then the plane state already points at the new framebuffer, so the
flip is never completed. So, its state leaks, the vblank reference is
never dropped and the event is never sent.

Look up the fence before changing any state, so the error can be properly
returned to userspace.

Cc: stable@vger.kernel.org
Fixes: d19e00ee06a9 ("drm/vc4: crtc: Fix out of order frames during asynchronous page flips")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 177ee27ab6d1..4b6d4a5f7bc9 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -948,33 +948,22 @@ static void vc4_async_page_flip_fence_cb(struct dma_fence *fence,
 	queue_work(vc4_crtc->async_flip_wq, &flip_state->work);
 }
 
-static int vc4_async_set_fence_cb(struct drm_device *dev,
-				  struct vc4_async_flip_state *flip_state)
+static void vc4_async_set_fence_cb(struct vc4_async_flip_state *flip_state)
 {
-	struct drm_framebuffer *fb = flip_state->fb;
-	struct drm_gem_dma_object *dma_bo = drm_fb_dma_get_gem_obj(fb, 0);
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(flip_state->crtc);
-	int ret;
 
 	INIT_WORK(&flip_state->work, vc4_async_page_flip_work);
 
-	ret = dma_resv_get_singleton(dma_bo->base.resv, DMA_RESV_USAGE_READ,
-				     &flip_state->fence);
-	if (ret)
-		return ret;
-
 	if (flip_state->fence &&
 	    !dma_fence_add_callback(flip_state->fence, &flip_state->cb,
 				    vc4_async_page_flip_fence_cb))
-		return 0;
+		return;
 
 	/* No fence or the fence has already signaled. Complete the flip
 	 * immediately, after earlier queued flips.
 	 */
 	flush_workqueue(vc4_crtc->async_flip_wq);
 	vc4_async_page_flip_work(&flip_state->work);
-
-	return 0;
 }
 
 static int
@@ -983,14 +972,22 @@ vc4_async_page_flip_common(struct drm_crtc *crtc,
 			   struct drm_pending_vblank_event *event,
 			   uint32_t flags)
 {
-	struct drm_device *dev = crtc->dev;
+	struct drm_gem_dma_object *dma_bo = drm_fb_dma_get_gem_obj(fb, 0);
 	struct drm_plane *plane = crtc->primary;
 	struct vc4_async_flip_state *flip_state;
+	int ret;
 
 	flip_state = kzalloc_obj(*flip_state);
 	if (!flip_state)
 		return -ENOMEM;
 
+	ret = dma_resv_get_singleton(dma_bo->base.resv, DMA_RESV_USAGE_READ,
+				     &flip_state->fence);
+	if (ret) {
+		kfree(flip_state);
+		return ret;
+	}
+
 	drm_framebuffer_get(fb);
 	flip_state->fb = fb;
 	flip_state->crtc = crtc;
@@ -1016,7 +1013,7 @@ vc4_async_page_flip_common(struct drm_crtc *crtc,
 	 */
 	drm_atomic_set_fb_for_plane(plane->state, fb);
 
-	vc4_async_set_fence_cb(dev, flip_state);
+	vc4_async_set_fence_cb(flip_state);
 
 	/* Driver takes ownership of state on successful async commit. */
 	return 0;

-- 
2.56.0

