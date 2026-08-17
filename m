Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F16C5DF74
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 21:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32B0210E3D9;
	Mon, 17 Aug 2026 21:36:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="msHpgQmQ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82F7F10E3D9
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 21:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=mDtI+KRD9GYTHqW+CtkJ5LkZHCknM50k9+DwNYXj7OA=; b=msHpgQmQQ0efLcccm4TYuLcVOe
 y1zK9iwDPOrn6su51M83MfVwZPpc/NQ2AJKi32wm9TuIkBKOmw2M2Yy41lVTH+2SkPPLJW3wTpbzK
 R6B04WxplrB4APUYpf38vgfSzswo5zmNZicKeG12bl3zfsYVM1lIqr8a0lbfdjB+9O3reTE9gCCwR
 tw3qx7HbS18G6/+lDFLUiOtY/CEQ/+Jn9f5Y5c6Qu76Tgahe5xCDKWZFVhLWjC9dr/KOZUXYVmpvh
 njl3Tu0wdXIz2EyB8wbeXjWpQVvIpC2d+QOL1FKbgxCFsmoDV7Stx7nCBldB913MQoOH8KnnNeoUU
 5fv7PUcQ==;
Received: from 179-125-92-196-dinamico.pombonet.net.br ([179.125.92.196]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1ww50U-0052VL-Fp; Mon, 17 Aug 2026 23:36:34 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Mon, 17 Aug 2026 18:36:18 -0300
Subject: [PATCH v3] drm: Fix drm_pending_vblank_event leak in error path
 for out_fence_ptr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-drm_pending_vblank_event_leak-v3-1-7582b24447d0@igalia.com>
X-B4-Tracking: v=1; b=H4sIANN+g2oC/43OzQ6CMBAE4FcxPVtTCvLjyfcwhmzpAitQSIuNh
 vDuAl70pMdJJt/MxBxaQsdOu4lZ9OSoN0sI9ztW1GAq5KSXzKSQsUhkyrXt8gGNJlPlXrVgmhw
 9mjFvERoOYVygVjKLFbDFGCyW9Nj8y/Wd3V3dsBhXdG3U5MbePrcDPlh7/275gAdcpJHMVCaFC
 uIzVdASHIq+Y+uYl59c9ouTCwdHkUQAKBJdfnHzPL8A9pVK1ywBAAA=
X-Change-ID: 20260728-drm_pending_vblank_event_leak-a36cedb296ba
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Melissa Wen <mwen@igalia.com>, kernel-dev@igalia.com, 
 sashiko-bot@kernel.org, Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
X-Mailer: b4 0.16-dev-62088
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

When an out_fence_ptr is provided but DRM_MODE_PAGE_FLIP_EVENT is not
set, a drm_pending_vblank_event will be allocated. If later, there is an
allocation failure or another failure at setup_out_fence(), that event
will not have base.fence set and it will not be released at
complete_signaling().

Release the event and set crtc_state->event to NULL just like in the
DRM_MODE_PAGE_FLIP_EVENT case when there is a failure at
drm_event_reserve_init(). That is, prepare_signaling() releases the
event and there is nothing to be done at complete_signaling(). Use
drm_event_cancel_free() as that will also undo drm_event_reserve_init()
in case it has been called.

Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260727-drm_crtc_atomic_commit_leak-v1-1-23d9948a9d7c@igalia.com?part=1
Fixes: 92c715fca907 ("drm/atomic: Fix double free in drm_atomic_state_default_clear")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
Changes in v3:
- Use a label for the common exit pattern.
- Link to v2: https://patch.msgid.link/20260729-drm_pending_vblank_event_leak-v2-1-a5074aae07df@igalia.com

Changes in v2:
- Fix UAF when DRM_MODE_PAGE_FLIP_EVENT is used.
- Link to v1: https://patch.msgid.link/20260728-drm_pending_vblank_event_leak-v1-1-08429b920b16@igalia.com
---
 drivers/gpu/drm/drm_atomic_uapi.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 1050dddadb17..0aba33824595 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1426,6 +1426,7 @@ static int prepare_signaling(struct drm_device *dev,
 	struct drm_crtc_state *crtc_state;
 	struct drm_connector *conn;
 	struct drm_connector_state *conn_state;
+	struct drm_pending_vblank_event *e;
 	int i, c = 0, ret;
 
 	if (arg->flags & DRM_MODE_ATOMIC_TEST_ONLY)
@@ -1437,8 +1438,6 @@ static int prepare_signaling(struct drm_device *dev,
 		fence_ptr = get_out_fence_for_crtc(crtc_state->state, crtc);
 
 		if (arg->flags & DRM_MODE_PAGE_FLIP_EVENT || fence_ptr) {
-			struct drm_pending_vblank_event *e;
-
 			e = create_vblank_event(crtc, arg->user_data);
 			if (!e)
 				return -ENOMEM;
@@ -1447,7 +1446,7 @@ static int prepare_signaling(struct drm_device *dev,
 		}
 
 		if (arg->flags & DRM_MODE_PAGE_FLIP_EVENT) {
-			struct drm_pending_vblank_event *e = crtc_state->event;
+			e = crtc_state->event;
 
 			if (!file_priv)
 				continue;
@@ -1464,11 +1463,14 @@ static int prepare_signaling(struct drm_device *dev,
 		if (fence_ptr) {
 			struct dma_fence *fence;
 			struct drm_out_fence_state *f;
+			e = crtc_state->event;
+
+			ret = -ENOMEM;
 
 			f = krealloc(*fence_state, sizeof(**fence_state) *
 				     (*num_fences + 1), GFP_KERNEL);
 			if (!f)
-				return -ENOMEM;
+				goto error;
 
 			memset(&f[*num_fences], 0, sizeof(*f));
 
@@ -1477,12 +1479,12 @@ static int prepare_signaling(struct drm_device *dev,
 
 			fence = drm_crtc_create_fence(crtc);
 			if (!fence)
-				return -ENOMEM;
+				goto error;
 
 			ret = setup_out_fence(&f[(*num_fences)++], fence);
 			if (ret) {
 				dma_fence_put(fence);
-				return ret;
+				goto error;
 			}
 
 			crtc_state->event->base.fence = fence;
@@ -1538,6 +1540,11 @@ static int prepare_signaling(struct drm_device *dev,
 	}
 
 	return 0;
+
+error:
+	drm_event_cancel_free(dev, &e->base);
+	crtc_state->event = NULL;
+	return ret;
 }
 
 static void complete_signaling(struct drm_device *dev,

---
base-commit: 5d2584e2ffaabf2d420edcb2d120209e151f8dce
change-id: 20260728-drm_pending_vblank_event_leak-a36cedb296ba

Best regards,
--  
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

